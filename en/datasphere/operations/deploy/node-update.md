---
title: "How to update a node in {{ ml-platform-full-name }}"
description: "Follow this guide to update a node."
---

# Updating a node

To update a [node](../../concepts/deploy/index.md#node):
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. In the line with the appropriate node, click ![Options](../../../_assets/console-icons/ellipsis.svg) and select ![Edit](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Edit the node parameters:
   * Node name.
   * Node description.
   * Folder where new resources are created.
   * [Configuration](../../concepts/configurations.md) of the computing resources of the [instance](../../concepts/deploy/index.md) where the node is deployed.
   * [Availability zones](../../../overview/concepts/geo-scope.md) where the instance is hosted.
   * [Subnets](../../../vpc/concepts/network.md#subnet) where the instance is hosted.
   * [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) that node connections are allowed from (the **ACL** section).
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### See also {#see-also}

* [{#T}](node-delete.md)
