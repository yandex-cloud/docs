[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Cloud Notification Service

# Метрики Yandex Cloud Notification Service


В этом разделе описаны метрики сервиса [Cloud Notification Service](../../notifications/index.md), поставляемые в Monium Metrics.

Метрики сервиса Cloud Notification Service автоматически передаются в [Monium](../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находятся ресурсы сервиса.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы создаете запрос в Monium в [разделе метрик](../../monium/metrics/metric-explorer.md#add-graph) или в редакторе алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.


Имя метрики пишется в метку `name`.

Общие метки для всех метрик Cloud Notification Service:

#|
|| **Метка** | **Значение**||

|| service | Идентификатор сервиса: `notifications`.||

|| status | Статус отправки сообщения. Возможные значения:
* `conveyed` — успешно отправлено.
* `filtered` — отклонено фильтром.
* `expired` — истек TTL сообщения.
* `client_error` — не удалось отправить сообщение. Ошибка в запросе или данных, смотрите метку `error`.
* `server_error` — не удалось отправить сообщение. Ошибка на сервере.||
|#

Метрики сервиса:

#|
|| **Имя метрики**
**Тип, единицы измерения** | **Описание**||

|| `application.notifications.count`
`IGAUGE`, штуки | Количество [мобильных Push-уведомлений](../../notifications/concepts/push.md), отправленных за 1 минуту.
Метки:
* `app` — имя канала (приложения).
* `platform` — название платформы мобильных уведомлений.||

|| `application.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки мобильных Push-уведомлений за 1 минуту.
Метки:
* `app` — имя канала (приложения).
* `platform` — название платформы мобильных уведомлений.
* `error` — расшифровка статуса `client_error` при отправке сообщения. Возможные значения:
  * `rate_limit` — слишком много запросов на отправку сообщений на устройство.
  * `misconfigured_channel` — неправильно сконфигурирован [канал](../../notifications/concepts/index.md#channels), например загружен неправильный секрет мобильного приложения.
  * `invalid_or_revoked_endpoint` — эндпоинт некорректен или инвалидирован платформой.
  * `invalid_message_or_endpoint` — некорректное сообщение, параметры отправки или эндпоинта.
  * `total` — агрегат.||

|| `sms_channel.notifications.count`
`IGAUGE`, штуки | Количество [SMS](../../notifications/concepts/sms.md), отправленных за 1 минуту.
Метка `sender_id` — идентификатор канала.||

|| `sms_channel.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки SMS за 1 минуту.
Метки:
* `sender_id` — идентификатор канала.
* `error` — расшифровка статуса `client_error` при отправке сообщения.||

|| `webpush_channel.notifications.count`
`IGAUGE`, штуки | Количество [Push-уведомлений в браузере](../../notifications/concepts/browser.md), отправленных за 1 минуту.<br/>Метка `channel_name` — имя канала.||

|| `webpush_channel.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки Push-уведомлений в браузере за 1 минуту.
Метки:
* `channel_name` — имя канала.
* `error` — расшифровка статуса `client_error` при отправке сообщения.||

|| `sqs.notifications.count`
`IGAUGE`, штуки | Количество сообщений, отправленных за 1 минуту в очередь Yandex Message Queue.<br/>Метка `topic_name` — имя топика.||

|| `sqs.notifications.errors.count`
`IGAUGE`, штуки | Количество ошибок отправки сообщений в очередь Yandex Message Queue за 1 минуту.
Метки:
* `topic_name` — имя топика.
* `error` — расшифровка статуса `client_error` при отправке сообщения.||
|#

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.