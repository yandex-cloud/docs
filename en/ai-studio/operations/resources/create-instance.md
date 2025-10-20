---
title: How to create an instance in {{ foundation-models-name }}
description: Follow this guide to create an instance in {{ foundation-models-name }} using the management console.
---

# Creating an instance

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. Click **{{ ui-key.yacloud.yagpt.YaGPT.create-instance_3Ltog }}**.
  1. Specify the name of the [instance](../../concepts/generation/dedicated-instance.md). Follow these naming requirements:

      {% include [name-format-3](../../../_includes/name-format-3.md) %}

  1. Optionally, provide a description of the instance.
  1. Optionally, you add labels.
  1. Select a [model](../../concepts/generation/dedicated-instance.md#models).
  1. Select the instance [configuration](../../concepts/generation/dedicated-instance.md#config).
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}