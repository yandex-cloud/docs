# Creating an alias

You can distribute the load across nodes and update the deployed services on the fly using [aliases](../../concepts/resource-model.md#resources).

To create an alias:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the upper-right corner, click **Create resource**. In the window that appears, select **Alias**.
1. Specify the alias parameters:
   * In the **Name** field, enter a name for the alias.
   * In the **Prefix** field, select an available alias prefix.
   * Under **Nodes**, select the node to redirect alias requests to. Specify the percentage of requests to be redirected to the node. To add another node, click ![Add](../../../_assets/plus.svg) **Add**.
   * (Optional) Under **Metadata**, click ![Add](../../../_assets/plus.svg) **Add** and specify the alias metadata in key-value format.
   * Under **Access control list**, click ![Add](../../../_assets/plus.svg) **Add** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the alias from.
   * Under **Folder**, select the folder to create new resources in.
1. Click **Save**.

To view all created aliases:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **Resources**, select **Alias**.

#### What's next {#what-is-next}

* [{#T}](alias-update.md)
* [{#T}](alias-delete.md)