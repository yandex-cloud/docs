---
title: How to delete a virtual router in {{ cr-name }}
description: Follow this guide to delete a virtual router in {{ cr-name }}.
---

# Deleting a virtual router

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [virtual router](../concepts/routing-instance.md).
  1. [Navigate]({{ link-console-main }}/link/cloud-router) to **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. In the virtual router row, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  1. Make sure that the virtual router you want to delete has no other child objects, e.g., private connections:
  
      ```bash
      yc cloudrouter routing-instance get c3l87**********1dpin
      ```

  1. See the description of the CLI command for deleting a [virtual router](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance delete --help
      ```

  1. Delete the virtual router:

      ```bash
      yc cloudrouter routing-instance delete c3l87**********1dpin --async
      ```

{% endlist %}
