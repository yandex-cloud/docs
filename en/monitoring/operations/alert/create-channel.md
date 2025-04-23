---
title: How to create a notification channel in {{ monitoring-full-name }}
description: Follow this guide to create a notification channel and start sending email and messenger notifications to users.
---

# Creating a notification channel with users

1. On the left side of the window, select the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}** section.
1. Click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}** on the right of the page.
1. Specify the channel parameters:
    * **{{ ui-key.yacloud_monitoring.channel.field_name }}**. Enter a name for the channel.
    * **{{ ui-key.yacloud_monitoring.channel.field_method }}**. Specify the notification method.
    * **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**. List notification recipients.

        {% note info %}

        {% include [notifications-requirements](../../../_includes/monitoring/notifications-requirements.md) %}

        {% endnote %}

        To specify a Telegram account or group:

        1. Add the [@{{ cloud-notify-bot }}](https://t.me/{{ cloud-notify-bot }}) Telegram bot:

            * To contacts to send notifications in private messages
            * To a group to send notifications to that group

        1. Execute the `/start` command and copy the authorization code the bot generates in response.
        1. In the management console [settings]({{ link-console-main }}/settings), click **{{ ui-key.yacloud_components.settings.button_add-empty-telegram }}** in the **{{ ui-key.yacloud_components.settings.label_telegram }}** field.
        1. Paste the authentication code and click **{{ ui-key.yacloud_components.settings.button_submit }}**.

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The channel will appear in the list.
