---
title: How to delete a private connection from a {{ interconnect-name }} trunk
description: Follow this guide to delete a private connection from a {{ interconnect-name }} trunk.
---

# Deleting a private connection

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**.
  1. In the row with the private connection, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  1. See the description of the CLI command for deleting a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection delete --help
      ```

  1. Delete a private connection:

      ```bash
      yc cic private-connection delete cf3dcodot14p******** --async
      ```

{% endlist %}
