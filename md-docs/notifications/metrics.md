# Справочник метрик Yandex Monitoring

В этом разделе описаны метрики сервиса Cloud Notification Service, поставляемые в [Monitoring](../monitoring/index.md).

Имя метрики пишется в метку `name`.

Общие метки для всех метрик Cloud Notification Service:

#|
|| **Метка** | **Значение**||

|| service | Идентификатор сервиса: `notifications`.||

|| status | Статус отправки сообщения. Возможные значения:
* `conveyed` — успешно отправлено.
* `filtered` — отклонено фильтром.
* `expired` — истек TTL сообщения.
* `client_error` — не удалось отправить сообщение. Ошибка в запросе или данных, см. метку `error`.
* `server_error` — не удалось отправить сообщение. Ошибка на сервере.||
|#

Метрики сервиса:

#|
|| **Имя метрики**
**Тип, единицы измерения** | **Описание**||

|| `application.notifications.count`
`IGAUGE`, штуки | Количество [мобильных Push-уведомлений](concepts/push.md), отправленных за 1 минуту.
Метки:
* `app` — имя канала (приложения).
* `platform` — название платформы мобильных уведомлений.||

|| `application.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки мобильных Push-уведомлений за 1 минуту.
Метки:
* `app` — имя канала (приложения).
* `platform` — название платформы мобильных уведомлений.
* `error` — расшифровка статуса `client_error` при отправке сообщения. Возможные значения:
  * `rate_limit` — слишком много запросов отправки в устройство.
  * `misconfigured_channel` — неправильно сконфигурирован [канал](concepts/index.md#channels), например загружен неправильный секрет мобильного приложения.
  * `invalid_or_revoked_endpoint` — эндпоинт некорректен или инвалидирован платформой.
  * `invalid_message_or_endpoint` — некорректное сообщение, параметры отправки или эндпоинта.
  * `total` — агрегат.||

|| `sms_channel.notifications.count`
`IGAUGE`, штуки | Количество [SMS](concepts/sms.md), отправленных за 1 минуту.
Метка `sender_id` — идентификатор канала.||

|| `sms_channel.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки SMS за 1 минуту.
Метки:
* `sender_id` — идентификатор канала.
* `error` — расшифровка статуса `client_error` при отправке сообщения.||

|| `webpush_channel.notifications.count`
`IGAUGE`, штуки | Количество [Push-уведомлений в браузере](concepts/browser.md), отправленных за 1 минуту.<br/>Метка `channel_name` — имя канала.||

|| `webpush_channel.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки Push-уведомлений в браузере за 1 минуту.
Метки:
* `channel_name` — имя канала.
* `error` — расшифровка статуса `client_error` при отправке сообщения.||
|#