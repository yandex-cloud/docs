# Installing Kruise


[Kruise](https://openkruise.io/) features [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) resources in {{ k8s }} that you can use to automate app deployment and updates. Kruise tools work in Kubernetes clusters without installing any other dependencies.

Kruise advantages include:

* Advanced sidecar container management.
* High app availability.
* Updating apps without deleting pods.
* Advanced configuration for distributing load across the cluster nodes.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Kruise](/marketplace/products/yc/kruise) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:

   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Kruise.
   * **Application name**: Enter a name for the application.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Kruise, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_kruise.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_kruise.helmChart.tag }} \
      --untar && \
   helm install \
      --namespace <namespace> \
      --create-namespace \
      kruise ./kruise/
   ```

You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/kruise#docker-images).

## See also {#see-also}

* [Kruise documentation](https://openkruise.io/docs/)
