---
title: How to manage instance labels in {{ foundation-models-name }}
description: Follow this guide to manage instance labels in {{ foundation-models-name }} in the management console.
---

# Managing instance labels

## Adding a label {#add-label}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. In the [instance](../../concepts/generation/dedicated-instance.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Specify the key and press **Enter**.
  1. Specify the value and press **Enter**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Deleting a label {#add-label}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. In the [instance](../../concepts/generation/dedicated-instance.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **Labels** field, select the label. Click ![image](../../../_assets/console-icons/xmark.svg) to the right of its name.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}