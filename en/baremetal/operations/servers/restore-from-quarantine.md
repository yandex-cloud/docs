---
title: Restoring a server from quarantine in {{ baremetal-full-name }}
description: Follow this guide to restore a server from quarantine in {{ baremetal-full-name }}.
---

# Restoring a server from quarantine

{% note info %}

Restoring from quarantine is only available in the {{ yandex-cloud }} management console.

{% endnote %}

You have 72 hours to restore a quarantined server for further use. Upon restoration, the the server’s quarantine time will be included into the paid rental period. For more information about quarantine, see [{#T}](../../concepts/servers.md#quarantine).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.baremetal.action_server-prolongate-ended-rent }}**.
  1. In the confirmation window that opens, review the message: `{{ ui-key.yacloud.baremetal.message_confirm-server-prolongate-ended-rent }}`. Click **{{ ui-key.yacloud.baremetal.action_server-prolongate-ended-rent }}**.

{% endlist %}
