# Creating an alias

You can distribute the load across [nodes](../../concepts/deploy/index.md#node) and update the deployed services on the fly using [aliases](../../concepts/resource-model.md#resources).

To create an alias:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Specify the alias parameters:
   * In the **{{ ui-key.yc-ui-datasphere.common.name }}** field, enter a name for the alias.
   * In the **{{ ui-key.yc-ui-datasphere.common.prefix }}** field, select an available alias prefix.
   * Under **{{ ui-key.yc-ui-datasphere.new-alias.field.label-nodes }}**, select the node to redirect alias requests to. Specify the percentage of requests to redirect to the node. To add another node, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-alias.add-new }}**.
   * (Optional) Under **{{ ui-key.yc-ui-datasphere.new-alias.field.label-metadata }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-alias.add-new }}** and specify the alias metadata in key-value format.
   * Under **{{ ui-key.yc-ui-datasphere.common.folder }}**, select the folder to create new resources in.
   * Under **{{ ui-key.yc-ui-datasphere.new-alias.field.label-acl }}**, select **{{ ui-key.yc-ui-datasphere.common.type }}**: **{{ ui-key.yc-ui-datasphere.alias.public }}** or **{{ ui-key.yc-ui-datasphere.alias.private }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

To view all created aliases:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.common.alias }}**.

#### What's next {#what-is-next}

* [{#T}](alias-update.md)
* [{#T}](alias-delete.md)