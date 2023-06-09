# Updating an alias

To update an [alias](../../concepts/deploy/index.md#alias):
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Click ![Options](../../../_assets/options.svg) next to the appropriate alias and select ![Edit](../../../_assets/datasphere/edit.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Edit the alias parameters:
   * [Nodes](../../concepts/deploy/index.md#node) the alias requests will be redirected to.
   * Percentage of requests to be redirected to each node.
   * Alias metadata.
   * Access control list with the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) that you can connect to the alias from.
   * Folder where new resources are created.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### What's next {#what-is-next}

* [{#T}](alias-delete.md)