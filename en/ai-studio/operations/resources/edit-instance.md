---
title: How to update an instance in {{ foundation-models-name }}
description: Follow this guide to update an instance in {{ foundation-models-name }} using the management console.
---

# Updating an instance

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. In the [instance](../../concepts/generation/dedicated-instance.md) row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Update the instance settings.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}