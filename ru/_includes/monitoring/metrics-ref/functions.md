Имя метрики пишется в метку `name`.

Все метрики сервиса {{ sf-name }} имеют общую метку `service=serverless-functions`.

## Метрики гистограммы {#histogram}

Общие метки для всех метрик гистограммы:

Метка | Значение
----|----
resource_id | Идентификатор [функции](../../../functions/concepts/function.md)
version_id | Идентификатор [версии функции](../../../functions/concepts/function.md#version)

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
--- | ---
`duration_ms_histogram`<br/>`IGAUGE`, миллисекунды | Гистограмма распределения времени выполнения функции.<br/>Метка `bin` — бакеты гистограммы.

## Метрики производительности функций {#functions-exec}

Общие метки для всех метрик производительности функций:

Метка | Значение
----|----
resource_id | Идентификатор функции
version_id | Идентификатор версии функции
resource_type | Тип ресурса. Значение всегда `function`

Имя метрики<br/>Тип, единицы измерения | Описание
--- | ---
`functions_avg_duration`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения функции.
`functions_avg_init_duration`<br/>`DGAUGE`, миллисекунды | Среднее время инициализации функции.
`functions_avg_memory`<br/>`DGAUGE`, байты | Средний размер памяти, используемой функцией.
`functions_avg_queue_duration`<br/>`DGAUGE`, миллисекунды | Среднее время ожидания выполнения функции в очереди.
`functions_errors`<br/>`DGAUGE`, ошибки | Количество ошибок, произошедших при выполнении функции.
`functions_finished`<br/>`DGAUGE`, штуки | Количество завершенных выполнений функции.
`functions_inflight`<br/>`DGAUGE`, вызовы | Количество одновременно выполняющихся вызовов функции.
`functions_inits`<br/>`DGAUGE`, инициализации | Количество инициализаций функции.
`functions_max_duration`<br/>`DGAUGE`, миллисекунды | Максимальное время выполнения функции.
`functions_max_init_duration`<br/>`DGAUGE`, миллисекунды | Максимальное время инициализации функции.
`functions_max_memory`<br/>`DGAUGE`, байты | Максимальный размер памяти, используемой функцией.
`functions_max_queue_duration`<br/>`DGAUGE`, миллисекунды | Максимальное время ожидания выполнения функции в очереди.
`functions_min_duration`<br/>`DGAUGE`, миллисекунды | Минимальное время выполнения функции.
`functions_min_init_duration`<br/>`DGAUGE`, миллисекунды | Минимальное время инициализации функции.
`functions_min_memory`<br/>`DGAUGE`, байты | Минимальный размер памяти, используемой функцией.
`functions_min_queue_duration`<br/>`DGAUGE`, миллисекунды | Минимальное время ожидания выполнения функции в очереди.
`functions_started`<br/>`DGAUGE`, штуки | Количество запусков функции.
`functions_sum_duration`<br/>`DGAUGE`, миллисекунды | Суммарное время выполнения функции.
`functions_sum_init_duration`<br/>`DGAUGE`, миллисекунды | Суммарное время инициализации функции.
`functions_sum_memory`<br/>`DGAUGE`, байты | Суммарный размер памяти, используемой функцией.
`functions_sum_queue_duration`<br/>`DGAUGE`, миллисекунды | Суммарное время ожидания выполнения функции в очереди.
`functions_throttles`<br/>`DGAUGE`, штуки | Количество случаев ограничения запуска функции.

## Метрики функций {#functions}

Общие метки для всех метрик [функций](../../../functions/concepts/function.md):

Метка | Значение
----|----
function | Идентификатор функции
version | Идентификатор версии функции

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
--- | ---
`serverless.functions.errors_per_second`<br/>`DGAUGE`, ошибки/с | Частота возникновения ошибок при обработке вызовов функции.
`serverless.functions.execution_time_milliseconds`<br/>`IGAUGE`, вызовы/мс | Гистограмма распределения частоты вызова функции по времени обработки запроса.<br/>Интервалы времени обработки запроса представлены в метке `bin`.
`serverless.functions.finished_per_second`<br/>`DGAUGE`, вызовы/с | Частота завершения обработки вызовов функции.
`serverless.functions.inflight`<br/>`DGAUGE`, вызовы | Количество одновременно выполняющихся вызовов функции.
`serverless.functions.initializations_per_second`<br/>`DGAUGE`, инициализации/с | Частота инициализации новых экземпляров функции.
`serverless.functions.started_per_second`<br/>`DGAUGE`, вызовы/с | Частота вызова функции.
`serverless.functions.used_memory_bytes`<br/>`IGAUGE`, вызовы/с | Гистограмма распределения частоты вызова функции по количеству использованной памяти в байтах.<br/>Интервалы количества использованной запросом памяти представлены в метке `bin`.

## Метрики триггеров {#triggers}

Общие метки для всех метрик [триггеров](../../../functions/concepts/trigger/index.md):

Метка | Значение
----|----
trigger | Идентификатор триггера
type | Тип сущности

Имя метрики<br/>Тип, единицы измерения | Тип сущности | Описание<br/>Метки
--- | --- | ---
`serverless.triggers.access_error_per_second`<br/>`DGAUGE`, ошибки/с | <ul><li>`request` — вызовы функции.</li><li>`message_queue` — обращения к {{ message-queue-full-name }}.</li><li>`dlq` — обращения к Dead Letter Queue.</li></ul> | Частота возникновения ошибок доступа при обработке вызовов функции.
`serverless.triggers.error_per_second`<br/>`DGAUGE`, ошибки/с | <ul><li>`request` — вызовы функции.</li><li>`message_queue` — обращения к {{ message-queue-full-name }}.</li><li>`dlq` — обращения к Dead Letter Queue.</li></ul> | Частота возникновения ошибок при обработке вызовов функции.
`serverless.triggers.execution_time_milliseconds`<br/>`IGAUGE`, вызовы/мс | <ul><li>`request` — вызовы функции.</li></ul> | Гистограмма распределения частоты вызова функции по времени обработки запроса.<br/>Интервалы времени обработки запроса представлены в метке `bin`.
`serverless.triggers.inflight`<br/>`DGAUGE`, вызовы | <ul><li>`request` — вызовы функции.</li></ul> | Количество одновременно выполняющихся вызовов функции.
`serverless.triggers.read_events_per_second`<br/>`DGAUGE`, штуки/с | <ul><li>`incoming` — события, после которых сработал любой триггер, кроме триггера для {{ message-queue-full-name }}.</li><li>`message_queue` — события, после которых сработал триггер для {{ message-queue-full-name }}.</li></ul> | Частота возникновения событий, после которых срабатывает триггер.

## Метрики подключений к БД {#db-connections}

Общие метки для всех метрик [подключений к БД](../../../functions/operations/database-connection.md):

Метка | Значение
----|----
mdbproxy | Идентификатор подключения к БД

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
--- | ---
`serverless.mdbproxy.connections_inflight`<br/>`DGAUGE`, штуки | Количество одновременных активных подключений к БД.
`serverless.mdbproxy.query_execution_time_milliseconds`<br/>`IGAUGE`, штуки/мс | Гистограмма распределения выполнения запросов к БД.<br/>Метка `bin` — бакеты гистограммы.
