---
title: How to delete an instance in {{ foundation-models-name }}
description: Follow this guide to delete an instance in {{ foundation-models-name }} from the management console.
---

# Deleting an instance

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. In the [instance](../../concepts/generation/dedicated-instance.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, enter the instance name and click **{{ ui-key.yacloud.common.delete }}**.

      Wait for the operation to complete.

{% endlist %}