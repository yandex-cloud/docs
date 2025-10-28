---
title: How to get information about an instance in {{ foundation-models-name }}
description: Follow this guide to get information about an instance in {{ foundation-models-name }} using the management console.
---

# Getting instance info

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.models.editor` [role](../../security/index.md#ai-models-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**.
  1. Select the [instance](../../concepts/generation/dedicated-instance.md) you need.

      The **{{ ui-key.yacloud.common.overview }}** page will display information about the instance.

      To get the instance request code, click ![image](../../../_assets/console-icons/code.svg) **View code**.

{% endlist %}