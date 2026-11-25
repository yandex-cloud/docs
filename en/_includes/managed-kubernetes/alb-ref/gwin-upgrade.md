# Updating a Gwin controller

To upgrade a [{{ yandex-cloud }} Gwin](../../../managed-kubernetes/alb-ref/gwin-index.md) controller to a new version, follow these steps:

1. [Create a backup of your Gwin resources](#backup).
1. [Update the CRDs (Custom Resource Definitions)](#update-crd).
1. [Update the controller](#update-controller).

{% note warning %}

First update the [CRDs](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/), then the controller itself. The new Gwin version may expect new fields or CRD schema updates which are not provided in earlier versions. If you update the controller before the CRDs, it may go `CrashLoopBackOff` or stop processing resources: The {{ k8s }} API server will be declining requests with unknown fields.

{% endnote %}

## Getting started {#before-you-begin}

To find out the current Gwin version, see the [{{ yandex-cloud }} Gwin product card](/marketplace/products/yc/gwin) in {{ marketplace-name }}.

To find out which Gwin version is currently installed in the cluster, run this command:

```bash
helm list --all-namespaces
```

Compare your current Gwin version with the version in {{ marketplace-name }}. If a newer Gwin is available in {{ marketplace-name }}, go through the following steps to upgrade.

## Create a backup of your Gwin resources {#backup}

Before the upgrade, save the current configuration of Gwin resources and related [Ingress](../../../managed-kubernetes/alb-ref/ingress.md) and [Gateway API](../../../application-load-balancer/tools/k8s-gateway-api/index.md) resources:

```bash
kubectl get all,ingress,gateway,httproute,yccertificate \
  -n <namespace> \
  -o yaml > gwin-backup.yaml
```

Where `<namespace>` is the {{ k8s }} namespace the Gwin controller is installed in.

{% cut "How to learn the namespace" %}

{% list tabs group=instructions %}

- Management console {#marketplace-namespace}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select a [{{ managed-k8s-name }} cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. In the **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** section, open the {{ yandex-cloud }} Gwin application card.
  1. On the **{{ ui-key.yacloud.k8s.cluster.marketplace.label_tab-general }}** tab, find the **{{ ui-key.yacloud.k8s.cluster.marketplace.label_app-namespace }}** field value in the **{{ ui-key.yacloud.k8s.cluster.marketplace.label_product-settings }}** section.

- Helm {#helm-namespace}

  Execute this command to display releases in all the namespaces:

  ```bash
  helm list --all-namespaces
  ```

  Find a string where the `CHART` field's value starts with `gwin-chart`. The namespace is specified in the `NAMESPACE` field; release name, in the `NAME` field.

{% endlist %}

{% endcut %}

## Update the CRDs {#update-crd}

The `helm upgrade` command does not automatically update existing CRDs from `crds/`. Update the CRDs manually using the `kubectl apply` command.

1. Download and unpack the Helm chart for the new Gwin version:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gwin.helmChart.name }} \
     --version <new_gwin_version> \
     --untar
   ```

   Where `<new_gwin_version>` is your target Gwin version for the controller, e.g., `v1.11.0`.

   {% include [Support OCI](../note-helm-experimental-oci.md) %}

1. Apply the CRDs from the downloaded chart:

   ```bash
   kubectl apply --server-side --force-conflicts -f ./gwin-chart/crds
   ```

   Result:

   ```text
   customresourcedefinition.apiextensions.k8s.io/backendtlspolicies.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/gatewayclasses.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/gateways.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/grpcroutes.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io serverside-applied
   ...
   customresourcedefinition.apiextensions.k8s.io/yccertificates.gwin.yandex.cloud serverside-applied
   customresourcedefinition.apiextensions.k8s.io/ycstoragebuckets.gwin.yandex.cloud serverside-applied
   ```

## Update the controller {#update-controller}

Depending on how you installed Gwin, update the controller using either Helm or the management console:

{% list tabs group=instructions %}

- Helm {#helm}

  Run the `helm upgrade` command using the same values in the parameters as were used when installing the controller. Use [parameter --reuse-values](https://helm.sh/docs/helm/helm_upgrade/) not to specify them again:

  ```bash
  helm upgrade <gwin_release_name> ./gwin-chart \
    --namespace <namespace> \
    --reuse-values
  ```

  Where:
  * `<gwin_release_name>` is the name set when installing Gwin. It is in the `NAME` field in the `helm list -n <namespace>` output.
  * `<namespace>` is the {{ k8s }} namespace the Gwin controller is installed in.

  Result:

  ```text
  Release "gwin" has been upgraded. Happy Helming!
  NAME: gwin
  LAST DEPLOYED: Mon Aug 10 13:59:45 2026
  NAMESPACE: gwin-space
  STATUS: deployed
  REVISION: 2
  DESCRIPTION: Upgrade complete
  ```

- Management console {#marketplace}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select a [{{ managed-k8s-name }} cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. In the **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** section, find the installed {{ yandex-cloud }} Gwin application. If a new Gwin version is available, **{{ ui-key.yacloud.k8s.cluster.marketplace.label_new-version-available }}** will be displayed.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the {{ yandex-cloud }} Gwin application row and select **{{ ui-key.yacloud.common.edit }}**.
  1. Select the new Gwin version and click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Check the result {#check-result}

1. Check the Gwin version. The version is specified in the `VERSION` field of the command output:

   ```bash
   helm list --all-namespaces
   ```

1. Make sure the Gwin controller's [pod](../../../managed-kubernetes/concepts/index.md#pod) is now `Running`:

   ```bash
   kubectl get pods -n <namespace>
   ```

   Where `<namespace>` is the {{ k8s }} namespace the Gwin controller is installed in.

   Result:

   ```text
   NAME                    READY   STATUS    RESTARTS   AGE
   gwin-5f58847bdc-tzfnw   1/1     Running   0          12m
   nodecheck-4sgb4         1/1     Running   0          12m
   nodecheck-bbh57         1/1     Running   0          12m
   nodecheck-rzvtc         1/1     Running   0          12m
   ```

1. Make sure the Ingress or Gateway API resources continue to be processed and {{ alb-name }} is available.

   {% list tabs group=instructions %}

   - Gateway API {#gw}

     Run this command:

     ```bash
     kubectl get gateway,httproute -n <namespace>
     ```

     Where `<namespace>` is the {{ k8s }} namespace the Gwin controller is installed in.

     Result:

     ```text
     NAME                                                   CLASS          ADDRESS      PROGRAMMED   AGE
     gateway.gateway.networking.k8s.io/example-gateway      gwin-default   <IP_address>                32h

     NAME                                                             HOSTNAMES         AGE
     httproute.gateway.networking.k8s.io/example-httproute            ["example.com"]   32h
     httproute.gateway.networking.k8s.io/example-redirect-httproute   ["example.com"]   6m56s
     ```

   - Ingress {#ingress}

     Run this command:

     ```bash
     kubectl get ingress -n <namespace>
     ```

     Result:

     ```text
     NAME              CLASS          HOSTS         ADDRESS      PORTS     AGE
     example-ingress   gwin-default   example.com   <IP_address>   80, 443   31h
     ```

   {% endlist %}

   The `ADDRESS` field should specify the IP address of the {{ alb-name }}.
