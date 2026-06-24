---
title: How to move a private connection to another folder
description: Follow this guide to move a private connection in a {{ interconnect-name }} trunk to another folder.
---

# Moving a private connection to another folder

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role in the current and new folders to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**.
  1. In the row with the private connection, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![folder-arrow-right.svg](../../_assets/console-icons/folder-arrow-right.svg) **{{ ui-key.yacloud.common.move }}**.
  1. In the window that opens, select the folder you want to move the selected private connection to and click **{{ ui-key.yacloud.common.move }}**.

- CLI {#cli}

  1. See the description of the CLI command for moving a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection move --help
      ```

  1. Move a private connection to another folder by specifying the connection ID and the new folder name:

      ```bash
      yc cic private-connection move cf3dcodot14p******** \
        --destination-folder-name new-folder \
        --async
      ```

{% endlist %}
