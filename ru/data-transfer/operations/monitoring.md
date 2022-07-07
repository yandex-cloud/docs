# Мониторинг состояния трансфера

Данные о состоянии трансфера доступны в консоли управления. Их можно посмотреть на вкладке **Мониторинг** страницы управления трансфером  или в сервисе [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

Диагностическая информация о состоянии трансфера представлена в виде графиков.


Вы можете [настроить алерты](#monitoring-integration) в сервисе {{ monitoring-full-name }} для получения уведомлений о сбоях в работе трансфера. В {{ monitoring-full-name }} используются два порога срабатывания алерта: `Warning` и `Alarm`. При превышении заданного порога вы получите оповещения через настроенные [каналы уведомлений](../../monitoring/concepts/alerting.md#notification-channel).


## Мониторинг состояния трансфера {#monitoring}

Для просмотра информации о состоянии трансфера:

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **Трансферы**.
  1. Нажмите на имя нужного трансфера и выберите вкладку **Мониторинг**.
  1. Чтобы перейти к работе с метриками, дашбордами или алертами в сервисе {{ monitoring-full-name }}, нажмите кнопку **Открыть в мониторинге** на панели сверху.

{% endlist %}

На странице появятся графики:

### Data upload lag (histogram by seconds) {sinker.pusher.time.row_lag_sec}
`sinker.pusher.time.row_lag_sec`

Разница во времени между появлением записей на приемнике и их появлением на источнике (в секундах). Гистограмма разбита на диапазоны (`bin`). Допустим, в выбранный момент времени на гистограмме представлены два диапазона `bin` 45 и 60, со значением в 50% каждый. Это означает, что половина переносимых в этот момент записей имела задержку передачи от 30 до 45 секунд, а половина — от 45 до 60 секунд.

### Successfully pushed rows {sinker.pusher.data.row_events_pushed}
`sinker.pusher.data.row_events_pushed`

Скорость добавления строк в таблицы для табличных СУБД. Для нереляционных СУБД это скорость переноса объектов, хранящихся в коллекциях (в количестве объектов в секунду).

### Maximum lag on delivery {sinker.pusher.time.row_max_lag_sec}
`sinker.pusher.time.row_max_lag_sec`

Максимальное отставание данных (в секундах).

### Successfully pushed rows by tables (top-50 tables) {sinker.table.rows}
`sinker.table.rows`

50 таблиц с максимальным количеством записанных в приемник строк.

### Read buffer size {publisher.consumer.log_usage_bytes}
`publisher.consumer.log_usage_bytes`

Объем буфера или журнала опережающей записи (там, где он поддерживается) в источнике (в байтах).

### Read bytes from source (top-50 workers) {`publisher.data.bytes`}
`publisher.data.bytes`

Объем считанных из источника данных (в байтах).

### Sink response time (histogram by seconds) {sinker.pusher.time.batch_push_distribution_sec}
`sinker.pusher.time.batch_push_distribution_sec`

Время выполнения полного переноса данных с учетом предварительной обработки (в секундах).

### Read rows (parsed/unparsed) {publisher.data.*parsed_rows}
`publisher.data.*parsed_rows`

Количество считанных из источника строк.

### Snapshot task progress (top-50 tables) {task.snapshot.remainder.table}
`task.snapshot.remainder.table`

Количество строк, ожидающих переноса.

### Snapshot task status {task.status}
`task.status`

Тип выполняющейся операции: `0` — репликация, `1` — копирование.

## Интеграция с {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния трансфера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с трансфером, для которого нужно настроить алерты.
  1. В списке сервисов выберите **Monitoring**.
  1. В блоке **Сервисные дашборды** выберите **{{ data-transfer-name }}**.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.
  1. Если на графике больше одного показателя, создайте запрос данных для формирования метрики. Подробнее о языке запросов [см. в документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `Alarm` и `Warning` для оповещения.
  1. Нажмите **Создать алерт**.

{% endlist %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                               | Обозначение                          | `Alarm` | `Warning`                                                                             |
|---------------------------------------|:------------------------------------:|:-------:|:-------------------------------------------------------------------------------------:|
| Максимальная задержка передачи данных | `sinker.pusher.time.row_max_lag_sec` | `15`    | —                                                                                     |
| Объем буфера в источнике              | `publisher.consumer.log_usage_bytes` | —       | Не ниже максимального объема данных, поступающих в источник в рамках одной транзакции |
|                                       |                                      |         |                                                                                       |
