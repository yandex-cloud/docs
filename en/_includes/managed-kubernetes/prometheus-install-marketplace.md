{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder.
   1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Select the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
   1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
   1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [{{ prometheus-name }} Operator with {{ monitoring-name }}](/marketplace/products/yc/prometheus-operator) support and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
   1. Configure the application:

      * **Namespace**: Create a new [namespace](../../managed-kubernetes/concepts/index.md#namespace), e.g., `prometheus-operator-space`. If you leave the default namespace, {{ prometheus-name }} Operator may work incorrectly.
      * **Application name**: Specify the application name.
      * **{{ prometheus-name }} Workspace**: Select a {{ prometheus-name }} workspace.
      * **API key**: Specify the contents of the `sa-key.json` file.

   1. Click **Install**.
   1. Wait for the application to change its status to `Deployed`.  

{% endlist %}