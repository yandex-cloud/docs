# Updating a node

To update a node:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **Resources**, select **Node**.
1. Select the node to update.
1. In the upper-right corner, click ![Edit](../../../_assets/datasphere/edit.svg) **Edit**.
1. Edit the node parameters:
   * Node name.
   * Node description.
   * Folder where new resources are created.
   * [Configuration](../../concepts/configurations.md) of the instance where the node is deployed.
   * [Availability zones](../../../overview/concepts/geo-scope.md) where the instance is hosted.
   * [Subnets](../../../vpc/concepts/network.md#subnet) where the instance is hosted.
   * [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) that node connections are allowed from (the **ACL** section).
1. Click **Save**.

#### What's next {#what-is-next}

* [{#T}](node-delete.md)
