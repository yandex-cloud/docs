---
title: Quotas in {{ ca-full-name }}
description: '{{ ca-full-name }} is subject to quotas. For more information about the service limitations, read this article.'
editable: false
---

# Quotas in {{ ca-full-name }}

{{ ca-name }} is subject to _quotas_, i.e., organizational constraints that [our support team]({{ link-console-support }}) can change upon request.

{% note warning %}

The {{ yandex-cloud }} [management console]({{ link-console-quotas }}) does not display {{ ca-name }} quotas. You can view your current quota usage in the [{{ ca-name }} plugin interface](#utilization).

{% endnote %}

{% include [ca-limits](../../_includes/ca-limits.md) %}

## Viewing quota usage {#utilization}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  When you run the plugin, it automatically checks quota usage and displays the value in a pop-up notification.

  To look up quota usage after running the plugin, click ![image](../../_assets/code-assistant/vsc-icon-small.svg) in the editor bottom panel. In the list that opens, look for **Quota usage**.

- JetBrains IDE {#jb}

  When you run the plugin, it automatically checks quota usage and displays the value in a pop-up notification.

  To look up quota usage after running the plugin:
  1. In the top-right corner, click ![image](../../_assets/console-icons/gear.svg) and select **Settings...**.
  1. In the left column, select **{{ ca-full-name }}**.
  1. Click **Update Quota usage**.

{% endlist %}