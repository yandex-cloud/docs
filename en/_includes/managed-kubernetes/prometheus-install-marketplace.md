{% list tabs group=instructions %}

- Management console {#console}

   1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the name of the {{ k8s }} cluster you need and select the ![image](../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [{{ prometheus-name }} Operator with {{ monitoring-name }}](/marketplace/products/yc/prometheus-operator) support and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
   1. Configure the application:

      * **Namespace**: Create a new [namespace](../../managed-kubernetes/concepts/index.md#namespace), e.g., `prometheus-operator-space`. If you leave the default namespace, {{ prometheus-name }} Operator may work incorrectly.
      * **Application name**: Specify the application name.
      * **{{ prometheus-name }} Workspace**: Select a {{ prometheus-name }} workspace.
      * **API key**: Specify the contents of the `sa-key.json` file.

   1. Click **Install**.
   1. Wait for the application to change its status to `Deployed`.  

{% endlist %}