# Канал уведомлений

Чтобы получать уведомления о переходе алерта в другой статус, необходимо указать канал уведомлений. Канал содержит информацию о получателях и методах отправки. В качестве метода отправки также можно указать эскалацию (последовательность уведомлений).

Один канал можно использовать повторно для других алертов.

## Параметры канала уведомлений {#channel-parameters}

* **{{ ui-key.yacloud_monitoring.channel.field_recipients }}**. Список пользователей, которые должны получить уведомление в случае выполнения функции алерта.

  {% note info %}

  В качестве получателя почтовых уведомлений нужно указать аккаунт в {{ yandex-cloud }}. Это может быть аккаунт владельца или специально добавленный для этих целей [дополнительный аккаунт](../../../iam/concepts/index.md#accounts), например федеративный аккаунт или Яндекс ID.

  Чтобы получать уведомления, пользователь должен:
  
  * иметь роль `monitoring.viewer` на каталог, в котором настроен алерт.
  * в [настройках]({{ link-console-main }}/settings) консоли управления:
      * включить опцию **{{ ui-key.yacloud_components.settings.label_monitoring-name }}**;
      * указать адрес электронной почты, номер телефона и Telegram-аккаунт или группу.

  {% endnote %}

* **{{ ui-key.yacloud_monitoring.channel.field_method }}**. Метод, с помощью которого пользователи получат уведомление. Поддерживаются следующие методы уведомлений:

  * `{{ ui-key.yacloud_monitoring.channel.title_method-email }}`.
  * `{{ ui-key.yacloud_monitoring.channel.title_method-sms }}`.
  * `{{ ui-key.yacloud_monitoring.channel.title_method-push }}` (в [мобильном приложении](../../../overview/mobile-app/index.md) {{ yandex-cloud }}).
  * `Telegram`.
  * `{{ sf-name }}`.

После создания канала доступны дополнительные параметры:

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.sent-notify-statuses }}**. Выберите статусы алерта, при которых будет отправляться уведомление.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.repeat }}**. Выберите время, через которое {{ monitoring-short-name }} будет отправлять повторные уведомления о статусе алерта. Не действует для статуса `OK`.

## Статусы отправки {#dispatch-statuses}

Каждая отправка может находится в одном из следующих статусов:

Статус | Описание
----- | -----
`{{ ui-key.yacloud_monitoring.channel.status-description_success }}` | Уведомление успешно отправлено.
`{{ ui-key.yacloud_monitoring.channel.status-description_error }}` | Не удалось отправить уведомление из-за ошибки.
`{{ ui-key.yacloud_monitoring.channel.status-description_resource_exhausted }}` | Не удалось отправить уведомление из-за ограничения метода отправки.

## См. также

* [Создание канала уведомлений](../../operations/alert/create-channel.md)