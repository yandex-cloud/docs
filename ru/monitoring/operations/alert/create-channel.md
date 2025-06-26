---
title: Как создать канал уведомлений в {{ monitoring-full-name }}
description: Следуя данной инструкции, вы сможете создать канал уведомлений и отправлять сообщения получателям на почту и в мессенджеры.
---

# Создание канала уведомлений с получателями

1. В левой части окна выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
1. В правой части страницы нажмите **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
1. Укажите параметры канала:
    * **{{ ui-key.yacloud_monitoring.channel.field_name }}**. Задайте имя канала.
    * **{{ ui-key.yacloud_monitoring.channel.field_method }}**. Укажите метод уведомлений.
    * **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**. Перечислите получателей уведомлений.

        {% note info %}

        {% include [notifications-requirements](../../../_includes/monitoring/notifications-requirements.md) %}

        {% endnote %}

        Чтобы указать Telegram-аккаунт или группу:

        1. Добавьте Telegram-бота [@{{ cloud-notify-bot }}](https://t.me/{{ cloud-notify-bot }}):

            * в контакты, чтобы отправлять уведомления в личные сообщения;
            * в группу, чтобы отправлять уведомления в группу.

        1. Выполните команду `/start` и скопируйте код авторизации, сгенерированный ботом в ответ.
        1. В [настройках]({{ link-console-main }}/settings) консоли управления, в поле **{{ ui-key.yacloud_components.settings.label_telegram }}**, нажмите **{{ ui-key.yacloud_components.settings.button_add-empty-telegram }}**.
        1. Вставьте код авторизации и нажмите **{{ ui-key.yacloud_components.settings.button_submit }}**.

            При отправке уведомления через Telegram статусы алерта дополнительно [обозначаются цветом](../../concepts/alerting/alert.md#alert-statuses).

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Канал появится в списке.
