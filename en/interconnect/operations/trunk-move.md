---
title: How to move a {{ interconnect-full-name }} trunk to another folder
description: Follow this guide to move a {{ interconnect-full-name }} trunk to another folder.
---

# Moving a trunk to another folder

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role in the current and new folders to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**.
  1. In the trunk row, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![folder-arrow-right.svg](../../_assets/console-icons/folder-arrow-right.svg) **{{ ui-key.yacloud.common.move }}**.
  1. In the window that opens, select the folder you want to move the selected trunk to and click **{{ ui-key.yacloud.common.move }}**.

- CLI {#cli}

  1. View the description of the CLI command for moving a [trunk](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection move --help
      ```

  1. Move a trunk to another folder by specifying the trunk ID and the new folder name:

      ```bash
      yc cic trunk-connection move cf3dcodot14p******** \
        --destination-folder-name new-folder \
        --async
      ```

{% endlist %}
