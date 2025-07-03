Имя метрики пишется в метку `name`.

## Метрики контейнеров {#containers-metrics}

Общие метки для всех метрик [контейнеров](../../../serverless-containers/concepts/container.md):

Метка | Значение
----|----
container | Идентификатор контейнера
revision | Идентификатор [ревизии контейнера](../../../serverless-containers/concepts/container.md#revision)
service | Метка сервиса, значение всегда `serverless-containers`

Метрики сервиса:

Имя<br/>Тип, единицы измерения | Описание<br/>Метка
----|----
`serverless.containers.errors_per_second`<br/>`DGAUGE`, ошибки/с | Частота возникновения ошибок при обработке вызовов контейнера.
`serverless.containers.execution_time_milliseconds`<br/>`IGAUGE`, вызовы/мс | Гистограмма распределения частоты вызова контейнера по времени обработки запроса.</br>Метка `bin` — бакеты гистограммы.
`serverless.containers.execution_time_milliseconds_count`<br/>`COUNTER`, вызовы | Общее количество вызовов контейнера, учтенных в гистограмме времени обработки запроса.
`serverless.containers.execution_time_milliseconds_sum`<br/>`COUNTER`, миллисекунды | Суммарное время обработки всех вызовов контейнера, учтенных в гистограмме.
`serverless.containers.finished_per_second`<br/>`DGAUGE`, вызовы/с | Частота завершения обработки вызовов контейнера.
`serverless.containers.inflight`<br/>`DGAUGE`, вызовы | Количество одновременно выполняющихся вызовов контейнера.
`serverless.containers.started_per_second`<br/>`DGAUGE`, вызовы/с | Частота вызова контейнера.
`serverless.containers.used_memory_bytes`<br/>`IGAUGE`, байты | Гистограмма распределения частоты вызова контейнера по количеству использованной памяти.</br>Метка `bin` — бакеты гистограммы.
`serverless.containers.used_memory_bytes_count`<br/>`COUNTER`, вызовы | Общее количество вызовов контейнера, учтенных в гистограмме использованной памяти.
`serverless.containers.used_memory_bytes_sum`<br/>`COUNTER`, байты | Суммарное количество памяти, использованное всеми вызовами контейнера, учтенными в гистограмме.

## Метрики триггеров {#triggers-metrics}

Общие метки для всех метрик [триггеров](../../../serverless-containers/concepts/trigger/index.md):

Метка | Значение
----|----
trigger | Идентификатор триггера
type | Тип сущности
service | Метка сервиса, значение всегда `serverless-functions`

Имя метрики<br/>Тип, единицы измерения | Тип сущности | Описание<br/>Метки
--- | --- | ---
`serverless.triggers.access_error_per_second`<br/>`DGAUGE`, ошибки/с | <ul><li>`request` — вызовы контейнера.</li><li>`message_queue` — обращения к {{ message-queue-full-name }}.</li><li>`dlq` — обращения к Dead Letter Queue.</li></ul> | Частота возникновения ошибок доступа при обработке вызовов контейнера.
`serverless.triggers.error_per_second`<br/>`DGAUGE`, ошибки/с | <ul><li>`request` — вызовы контейнера.</li><li>`message_queue` — обращения к {{ message-queue-full-name }}.</li><li>`dlq` — обращения к Dead Letter Queue.</li></ul> | Частота возникновения ошибок при обработке вызовов контейнера.
`serverless.triggers.execution_time_milliseconds`<br/>`IGAUGE`, вызовы/мс | <ul><li>`request` — вызовы контейнера.</li></ul> | Гистограмма распределения частоты вызова контейнера по времени обработки запроса.<br/>Интервалы времени обработки запроса представлены в метке `bin`.
`serverless.triggers.inflight`<br/>`DGAUGE`, вызовы | <ul><li>`request` — вызовы контейнера.</li></ul> | Количество одновременно выполняющихся вызовов контейнера.
`serverless.triggers.read_events_per_second`<br/>`DGAUGE`, штуки/с | <ul><li>`incoming` — события, после которых сработал любой триггер, кроме триггера для {{ message-queue-full-name }}.</li><li>`message_queue` — события, после которых сработал триггер для {{ message-queue-full-name }}.</li></ul> | Частота возникновения событий, после которых срабатывает триггер.
