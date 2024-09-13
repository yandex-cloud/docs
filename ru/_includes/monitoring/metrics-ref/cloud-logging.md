Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ cloud-logging-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `logging`
group | Имя [лог-группы](../../../logging/concepts/log-group.md)

Метрики сервиса:

Имя метрики<br/>Тип, единицы измерения | Описание
--- | ---
`group.bytes`<br/>`IGAUGE`, байты | Размер данных логов в лог-группе.
`group.ingest_requests_duration_ms`<br/>`IGAUGE`, миллисекунды | Среднее время обработки запросов на запись логов. Метка `bin` — бакеты гистограммы.
`group.ingest_requests_duration_ms_count`<br/>`COUNTER`, запросы | Общее количество запросов на запись логов.
`group.ingest_requests_duration_ms_sum`<br/>`COUNTER`, миллисекунды | Суммарное время обработки запросов на запись логов.
`group.ingest_requests_per_second`<br/>`DGAUGE`, запросы/с | Частота запросов на запись логов в секунду. Метка `status` — статус запросов:<ul><li>`OK`</li><li>`ERROR`</li></ul>
`group.ingested_records_per_second`<br/>`DGAUGE`, записи/с | Частота записи логов в секунду. Метка `status` — статус запросов.
`group.read_records_per_second`<br/>`DGAUGE`, записи/с | Частота чтения логов в секунду.
`group.record_save_lag_milliseconds`<br/>`IGAUGE`, миллисекунды | Среднее время задержки записи логов. Метка `bin` — бакеты гистограммы.
`group.record_save_lag_milliseconds_count`<br/>`COUNTER`, запросы | Общее количество задержек записи логов.
`group.record_save_lag_milliseconds_sum`<br/>`COUNTER`, миллисекунды | Суммарное время задержки записи логов.
`group.rows`<br/>`IGAUGE`, записи | Текущее количество логов в группе.
`group.saved_records_per_second`<br/>`DGAUGE`, записи/с | Количество сохраненных записей в секунду. Метка `level` — уровень логирования:<ul><li>`TRACE`</li><li>`DEBUG`</li><li>`INFO`</li><li>`WARN`</li><li>`ERROR`</li><li>`FATAL`</li><li>`LEVEL_UNSPECIFIED`</li><li>`total`</li></ul>
`group.service.ingest_requests_duration_ms`<br/>`IGAUGE`, миллисекунды | Среднее время обработки запросов на запись логов на уровне сервиса. Метка `bin` — бакеты гистограммы.
`group.service.ingest_requests_duration_ms_count`<br/>`COUNTER`, запросы | Общее количество запросов на запись логов на уровне сервиса.
`group.service.ingest_requests_duration_ms_sum`<br/>`COUNTER`, миллисекунды | Суммарное время обработки запросов на запись логов на уровне сервиса.
`group.service.ingest_requests_per_second`<br/>`DGAUGE`, запросы/с | Частота запросов на запись логов в секунду на уровне сервиса. Метка `status` — статус запросов.
`group.service.ingested_records_per_second`<br/>`DGAUGE`, записи/с | Частота записи логов в секунду на уровне сервиса. Метка `status` — статус запросов.
