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

    To upgrade images of separately licensed components, such as {{ speechsense-name }}, run the command again with `--image-bundle speechsense`. For more information, see [{#T}](speechsense/install-images.md).

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
kubectl logs -n stackland-system job/<job_name>
```

You can get the job name from the `status.jobName` field in the `TargetInstallationState` resource.
