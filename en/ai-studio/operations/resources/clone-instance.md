---
title: How to clone an instance in {{ foundation-models-name }}
description: Follow this guide to clone an instance in {{ foundation-models-name }} using the management console.
---

# Cloning an instance

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. In the [instance](../../concepts/generation/dedicated-instance.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.common.clone }}**.
  1. Specify the name of the [instance](../../concepts/generation/dedicated-instance.md). Follow these naming requirements:

      {% include [name-format-3](../../../_includes/name-format-3.md) %}

  1. Optionally, provide a description of the instance.
  1. Optionally, you add labels.
  1. Select a [model](../../concepts/generation/dedicated-instance.md#models).
  1. Select the instance [configuration](../../concepts/generation/dedicated-instance.md#config).
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}