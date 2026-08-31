# Upgrading a cluster

Upgrade your {{ stackland-name }} cluster version using the `TargetInstallationState` Kubernetes resource. Perform a rolling update with incremental load evacuation and node reboot.

## Getting started {#before-you-begin}

1. Make sure you have admin access to the cluster.
1. Check the current version of your cluster:

    ```bash
    kubectl get targetinstallationstate main -o jsonpath='{.status.currentVersion}'
    ```

1. Find out which versions you can upgrade to. The available versions vary based on whether your cluster has internet access:

    * **Cluster with internet access**: Available versions are pulled automatically from the {{ stackland-name }} container registry.
    * **Air-gapped cluster**: Available versions are limited to the images manually imported into your local registry.

## Selecting the release channel {#release-channel}

The release channel determines which {{ stackland-name }} versions are available for the upgrade. The default channel is `stable`.

Available channels:

* `stable`: Stable releases for use in production environments. This channel is available to all customers by default.
* `alpha`: Channel with early releases for testing new features. You can access it upon request.

To switch channels, update the `PlatformConfig` resource:

```bash
kubectl edit platformconfig main
```

Indicate your preferred channel in the specification:

```yaml
spec:
  releaseChannel: "stable"  # or "alpha"
```

## Before upgrading to 27.x {#pre-upgrade-27}

{{ stackland-name }} 26.2 introduced a new Contour-based Ingress controller deprecating the legacy implementation based on ingress-nginx. {{ stackland-name }} 27 will completely remove ingress-nginx from the distribution, and this serves as prior notice of these plans. In {{ stackland-name }} 26 releases, ingress-nginx remains available for custom workloads, but you must migrate to the new controller before upgrading to {{ stackland-name }} 27.

In most cases, custom `Ingress` manifests with the `stackland-default` class will remain operational, but the new controller does not support `nginx.ingress.kubernetes.io/*` annotations, which are specific to ingress-nginx. Make sure to remove or replace them. For more information, see [{#T}](#check-user-ingress).

Also note that operator action is required: the upgrade to version `>= 27.0.0` will fail to initialize unless you explicitly disable the legacy Ingress controller.

### Checking custom Ingress resources {#check-user-ingress}

If your cluster contains custom `Ingress` resources:

1. Locate custom `Ingress` resources:

    ```bash
    kubectl get ingress -A
    ```

1. Check that they specify `spec.ingressClassName: stackland-default` or have no such field. In the latter case, the default class is used.
1. Make sure resource annotations do not contain nginx-specific `nginx.ingress.kubernetes.io/*` keys. If you find any such annotations, remove or replace them with the new Ingress controller alternatives, or the rules will fail to apply after the upgrade.

### Testing the application before the upgrade {#test-before-upgrade}

While your cluster is still on version 26.x, you can proactively verify that your custom `Ingress` is compatible with the new Ingress controller.

{% note warning %}

When changing `spec.ingressClassName` to `stackland-system`, remember that `stackland-system` has its own external IP address that does not match the legacy Ingress controller IP address. If the DNS zone is delegated to the platform, the domain record will update automatically to point to the new LoadBalancer. However, during the standard DNS propagation delay, some client traffic will still be routed to the legacy Ingress controller IP address. A similar delay occurs after you change the class back to `stackland-default`.

Perform this test within a maintenance window or on a non-critical host.

{% endnote %}

1. In a temporary copy of the manifest, replace `spec.ingressClassName: stackland-default` with `spec.ingressClassName: stackland-system` and apply the manifest:

    ```bash
    kubectl apply -f <file_name>.yaml
    ```

1. Check application availability. There are two ways to do this:

    * Direct IP verification without DNS. This method works independently of DNS propagation or your application domain's DNS zone hosting.

        1. Get the external IP of the LoadBalancer serving the `stackland-system` class:

            ```bash
            kubectl get svc -A \
              -l app.kubernetes.io/name=contour,app.kubernetes.io/component=envoy
            ```

            If the selector does not work for your setup, manually locate the `LoadBalancer` service within your Contour namespace.

        1. Send a request to the application using the retrieved IP:

            ```bash
            curl --resolve <domain>:443:<Envoy_external_IP> https://<domain>/
            ```

    * Domain-based verification. You can only use this method if your DNS zone is delegated: the domain record will automatically migrate to the `stackland-system` LoadBalancer. Keep in mind there is a DNS propagation delay. If you manage a custom DNS, the domain will continue to point to the legacy LoadBalancer, i.e., you will get a false negative result. Use `curl --resolve` instead.

1. After verification, change the `spec.ingressClassName` value back to `stackland-default` or remove this field.

You can skip this step on version 27.x: the new Ingress controller serves the `stackland-default` class by default.

{% note warning %}

`stackland-system`: Service class. Do not use it for production `Ingress` resources: this is a temporary class designed exclusively for compatibility tests prior to the upgrade.

{% endnote %}

### Disabling the legacy Ingress implementation {#disable-legacy-ingress}

1. Disable the legacy Ingress implementation within the `IngressConfig` resource:

    ```bash
    kubectl patch ingressconfig main --type=merge \
      -p '{"spec":{"settings":{"nginx":{"enabled":false}}}}'
    ```

  Disabling ingress-nginx automatically restarts existing Ingress controllers on top of Contour.

1. Wait until the platform migrates to a single Ingress Controller. Check the current state:

    ```bash
    kubectl get ingressconfig main -o jsonpath='{.status.ingress.observedIngress}'
    ```

{% list tabs group=instructions %}

- Management console {#console}
  
  If the cluster has no internet access, you must first pull the new version images to your local registry using the [CLI](#push-images).

  1. In the left-hand menu, select **Settings**.
  1. In the submenu, select **Upgrade**.
  1. Click the **Upgrade** link to open the cluster upgrade page.
  1. On the **Cluster update** page, check the **Current upgrade status**:

      * **Target version**: Version to upgrade to.
      * **Phase**: Upgrade stage.
      * **Message**: Current state message.

  1. Under **Available updates**, specify the version to upgrade to.
  1. Click **Start update**.


- CLI {#cli}

  The CLI steps depend on whether your cluster has internet access.

    ### Cluster with internet access {#online-cluster}

    For clusters with internet access, new version images are automatically pulled from the {{ stackland-name }} container registry.

    #### Setting up an upgrade {#prepare-online}

    Wait for the new release to appear in the `AvailableReleases` resource. To check for available releases, run this command:

    ```bash
    kubectl get availablereleases main -o yaml
    ```

    Here is an example of the command output:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: AvailableReleases
    metadata:
      name: main
    status:
      releases:
        - version: "26.1.0"
          ready: true
        - version: "26.1.1"
          ready: true
    ```

    As soon as the list displays the target version with the `ready: true` status, you can start the upgrade.

    #### Starting the upgrade {#start-upgrade-online}

    1. Create the manifest file, e.g., using the `touch upgrade.yaml` command.
    1. Open the file and paste the configuration:

        ```yaml
        apiVersion: stackland.yandex.cloud/v1alpha1
        kind: TargetInstallationState
        metadata:
          name: main
        spec:
          targetVersion: "<version>"
          installationTimeout: "2h"
        ```

        Where:
        * `targetVersion`: Target version for the upgrade. Specify the value from `availablereleases[main].status.releases[<preferred_release>].version`.
        * `installationTimeout`: Upgrade timeout.

    1. Apply the manifest:

        ```bash
        kubectl apply -f upgrade.yaml
        ```

  ### Air-gapped cluster {#airgapped-cluster}

    If the cluster has no internet access, you must first pull the new version images to your local registry.

    #### Downloading SLADM {#download-sladm}

    On an internet-connected machine, download the latest `sladm` version in the same way as during its initial installation.

    #### Pulling images on an internet-connected machine {#download-images}

    On an internet-connected machine, run this command:

    ```bash
    sladm pull --image-bundle full
    ```

    Where:
    * `--image-bundle`: Image bundle type, `full` to get all images.

    {% note info %}

    To upgrade images of separately licensed components, such as {{ speechsense-name }}, run the command again with `--image-bundle speechsense`. For more information, see [{#T}](../speechsense/install-images.md).

    {% endnote %}

    #### Transferring artifacts into the internal infrastructure {#transfer-artifacts}

    Transfer the following to a machine with access to the local cluster registry:

    * `sladm` binary file
    * `release.yaml`
    * `<release_name>-oci` folder

    #### Pushing images to the local registry {#push-images}

    On a machine with cluster access, run this command:

    ```bash
    sladm push --local-registry --kubeconfig=<kubeconfig_path> --image-bundle-folder <directory_name>-oci
    ```

    Where:

    * `--local-registry`: Indicates the use of the cluster's local registry.
    * `--kubeconfig`: Path to the `kubeconfig` file for access to the cluster.
    * `--image-bundle-folder`: Path to the folder with images.

    #### Verifying release availability {#wait-for-release}

    After pushing the images, wait until the new release appears in the `AvailableReleases` resource.

    ```bash
    kubectl get availablereleases main -o yaml
    ```

    As soon as the list displays the target version with the `ready: true` status, you can start the upgrade.

    #### Starting the upgrade {#start-upgrade-offline}

    1. Create the manifest file, e.g., using the `touch upgrade.yaml` command.
    1. Open the file and paste the configuration:

        ```yaml
        apiVersion: stackland.yandex.cloud/v1alpha1
        kind: TargetInstallationState
        metadata:
          name: main
        spec:
          targetVersion: "<version>"
          installationTimeout: "2h"
        ```

        Where:
        * `targetVersion`: Target version for the upgrade. Specify the value from `availablereleases[main].status.releases[<preferred_release>].version`.
        * `installationTimeout`: Upgrade timeout.

    1. Apply the manifest:

        ```bash
        kubectl apply -f upgrade.yaml
        ```

{% endlist %}

## Checking the upgrade status {#check-status}

After applying the manifest, you can monitor the upgrade status:

```bash
kubectl get targetinstallationstate main
```

Here is an example of the command output:

```text
NAME   TARGET VERSION   CURRENT VERSION   PHASE     MESSAGE                           AGE
main   26.1.1           26.1.0            Running   Running upgrade to version 26.1.1 5m
```

## Getting detailed information {#get-details}

Run this command:

```bash
kubectl describe targetinstallationstate main
```

The `status` field displays:

* `currentVersion`: Currently installed version.
* `phase`: Upgrade stage:
    * `Pending`: Upgrade awaiting start.
    * `Running`: Upgrade in progress.
    * `Completed`: Upgrade completed.
    * `Failed`: Upgrade failed.
* `message`: Current state message.
* `jobName`: Name of the Kubernetes upgrade job.
* `lastUpdateTime`: Status last update time.

## Viewing upgrade logs {#view-logs}

To read logs of the upgrade job, run this command:

```bash
kubectl logs -n stackland-install job/<job_name>
```

You can get the job name from the `status.jobName` field in the `TargetInstallationState` resource.
