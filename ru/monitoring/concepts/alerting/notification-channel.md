# Канал уведомлений

Чтобы получать уведомления о переходе алерта в другой статус, необходимо указать канал уведомлений. Канал содержит информацию о получателях и методах отправки.

Один канал можно использовать повторно для других алертов.

## Параметры канала уведомлений {#channel-parameters}

* **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**. Список пользователей, которые должны получить уведомление в случае выполнения функции алерта.

  {% note info %}

  {% include [account-info](../../../_includes/monitoring/account-info.md) %}

  {% include [notifications-requirements](../../../_includes/monitoring/notifications-requirements.md) %}

  {% endnote %}

* **{{ ui-key.yacloud_monitoring.channel.field_method }}**. Метод, с помощью которого пользователи получат уведомление. Поддерживаются следующие методы уведомлений:

  {% include [channels](../../../_includes/monitoring/channels.md) %}

После создания канала доступны дополнительные параметры:

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.sent-notify-statuses }}**. Выберите список статусов алерта, о которых нужно слать уведомление в канал.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.repeat }}**. Выберите период, с которым {{ monitoring-short-name }} будет отправлять повторные уведомления о том, что алерт находится в том же статусе.

## Статусы отправки {#dispatch-statuses}

Каждая отправка может находится в одном из следующих статусов:

Статус | Описание
----- | -----
`{{ ui-key.yacloud_monitoring.channel.status-description_success }}` | Уведомление успешно отправлено.
`{{ ui-key.yacloud_monitoring.channel.status-description_error }}` | Не удалось отправить уведомление из-за ошибки.
`{{ ui-key.yacloud_monitoring.channel.status-description_resource_exhausted }}` | Не удалось отправить уведомление из-за ограничения метода отправки.

## См. также

* [Создание канала уведомлений](../../operations/alert/create-channel.md)
