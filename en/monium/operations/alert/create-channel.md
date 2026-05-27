---
title: How to create a notification channel in {{ monium-name }}
description: Follow this guide to create a notification channel and start sending email and messenger notifications to users.
---

# Creating a notification channel with recipients

1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-methods.title }}** on the left.
1. At the top right, click **Create** → **Notification channel**.
1. Specify the channel settings:
    * **{{ ui-key.yacloud_monitoring.channel.field_name }}**: Name the channel.
    * **ID**: Set a unique channel ID.
    * Select the alert severity levels for notifications.
    * **{{ ui-key.yacloud_monitoring.channel.field_method }}**: Specify the notification method.
    * **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**: List notification recipients.

        {% note info %}

        {% include [notifications-requirements](../../../_includes/monium/notifications-requirements.md) %}

        {% endnote %}

        To specify a Telegram account or group:

        1. Add the [@{{ cloud-notify-bot }}](https://t.me/{{ cloud-notify-bot }}) Telegram bot:

            * To your contacts to send notifications in private messages.
            * To a group to send notifications to that group.

        1. Run `/start` and copy the authorization code the bot generates in response.
        1. In the management console [settings]({{ link-console-main }}/settings), click **{{ ui-key.yacloud_components.settings.label_telegram }}** in the **{{ ui-key.yacloud_components.settings.button_add-empty-telegram }}** field.
        1. Paste the authorization code and click **{{ ui-key.yacloud_components.settings.button_submit }}**.

            When sending notifications via Telegram, alert statuses are additionally [color-coded](../../concepts/alerting/alert.md#alert-statuses).

        To specify [{{ messenger-full-name }}](https://360.yandex.ru/business/messenger/):

        1. In the management console [settings]({{ link-console-main }}/settings), next to **{{ ui-key.yacloud_monitoring.monitoring-alerts-channels.method.ya-chats }}**, click **Configure**.
        1. Click **{{ ui-key.yacloud_components.settings.label_yandexMessenger-link }}**.
        1. Add the **Yandex Cloud Notify** bot:

            * To your contacts to send notifications in private messages.
            * To your chat to send notifications in chats.

        1. Run `/start` and copy the authorization code the bot generates in response.
        1. In the management console settings, paste the authorization code and click **{{ ui-key.yacloud_components.settings.button_submit }}**.

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**. The channel will appear in the list.
