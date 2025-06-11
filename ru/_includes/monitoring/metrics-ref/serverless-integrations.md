Имя метрики пишется в метку `name`.


## Метрики {{ sw-full-name }} {#workflows}

Общая метка для всех метрик {{ sw-name }}: `workflow` — идентификатор рабочего процесса.

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`step_completed_per_second`<br>`DGAUGE`, шаги/с | Количество завершенных шагов в секунду.<br>Метка `step` — имя шага.
`step_failed_per_second`<br>`DGAUGE`, шаги/с | Количество шагов в секунду, завершившихся с ошибкой.<br>Метки:<ul><li>`step` — имя шага.</li><li>`error_code` — код ошибки.</li></ul>
`step_inflight_count`<br>`DGAUGE`, шаги | Количество шагов в процессе выполнения в данный момент.<br>Метка `step` — имя шага.
`step_started_per_second`<br>`DGAUGE`, шаги/с | Количество запущенных шагов в секунду.<br>Метка `step` — имя шага.
`step_time_milliseconds`<br>`DGAUGE`, миллисекунды | Время выполнения шага.<br>Метки:<ul><li>`bin` — бакеты гистограммы.</li><li>`step` — имя шага.</li></ul>
`step_time_milliseconds_count`<br>`DGAUGE`, количество шагов | Общее количество измерений времени выполнения шагов.<br>Метка `step` — имя шага.
`step_time_milliseconds_sum`<br>`DGAUGE`, миллисекунды | Суммарное время выполнения всех шагов.<br>Метка `step` — имя шага.
`workflow_completed_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество завершенных рабочих процессов в секунду.
`workflow_failed_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество рабочих процессов в секунду, завершившихся с ошибкой.<br>Метка `error_code` — код ошибки.
`workflow_inflight_count`<br>`DGAUGE`, рабочие процессы | Количество рабочих процессов в процессе выполнения в данный момент.
`workflow_scheduled_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество рабочих процессов, запланированных в секунду.
`workflow_started_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество рабочих процессов, начатых в секунду.
`workflow_time_milliseconds`<br>`DGAUGE`, миллисекунды | Время выполнения одного рабочего процесса.<br>Метка `bin` — бакеты гистограммы.
`workflow_time_milliseconds_count`<br>`DGAUGE`, штуки | Общее количество измерений времени выполнения рабочих процессов.
`workflow_time_milliseconds_sum`<br>`DGAUGE`, миллисекунды | Суммарное время выполнения всех рабочих процессов.


## Метрики {{ er-full-name }} {#eventrouter}

Все метрики {{ er-name }} имеют общую метку `bus` — идентификатор [шины](../../../serverless-integrations/concepts/eventrouter/bus.md).


### Метрики шин {#er-buses}

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`serverless_eventrouter_bus_put_event_per_second`<br>`DGAUGE`, сообщения/с | Частота отправки сообщений с помощью вызова gRPC API [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md).
`serverless_eventrouter_bus_sent_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок в шине.<br>Метки:<ul><li>`code` — код ошибки. Возможные значения:<ul><li>`EVENTROUTER_BUS_SEND_ERROR`</li><li>`EVENTROUTER_EVENT_SIZE_EXCEEDED`</li></ul></li><li>`source` — источник.</li></ul>
`serverless_eventrouter_put_event_latency_milliseconds`<br>`DGAUGE`, миллисекунды | Время от получения сообщения, отправленного с помощью вызова gRPC API [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md), до записи в шину.


### Метрики коннекторов {#er-connectors}

Все метрики [коннекторов](../../../serverless-integrations/concepts/eventrouter/connector.md) имеют общую метку `connector` — идентификатор коннектора.


Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`serverless_eventrouter_connector_access_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок доступа к ресурсам коннектора.
`serverless_eventrouter_connector_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок в коннекторе.
`serverless_eventrouter_connector_event_per_second`<br>`DGAUGE`, события/с | Скорость чтения событий коннектором.
`serverless_eventrouter_connector_event_size_exceeded_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок превышения максимального размера сообщений, полученных коннектором.


### Метрики правил {#er-rules}

Все метрики [правил](../../../serverless-integrations/concepts/eventrouter/rule.md) имеют общие метки:

Метка | Значение
--- | ---
matched | Соответствие условиям, заданным в [фильтре](../../../serverless-integrations/concepts/eventrouter/rule.md#filter).
rule | Идентификатор правила.

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`serverless_eventrouter_rule_event_per_second`<br>`DGAUGE`, события/с | Скорость обработки правил.


### Метрики приемников {#er-targets}

Все метрики [приемников](../../../serverless-integrations/concepts/eventrouter/rule.md#target) имеют общие метки:

Метка | Значение
--- | ---
rule | Идентификатор правила.
type | Тип приемника.

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`serverless_eventrouter_event_delivery_time_milliseconds`<br>`DGAUGE`, миллисекунды | Время от получения события коннектором до доставки в приемник.
`serverless_eventrouter_target_access_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок доступа в приемнике.
`serverless_eventrouter_target_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок в приемнике.
`serverless_eventrouter_target_event_size_exceeded_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок превышения максимального размера сообщений, полученных приемником.
`serverless_eventrouter_target_execution_time_milliseconds`<br>`DGAUGE`, миллисекунды | Время обработки сообщения.
`serverless_eventrouter_target_inflight`<br>`DGAUGE`, штуки | Количество приемников, занятых в данный момент.
`serverless_eventrouter_target_retry_per_second`<br>`DGAUGE`, отправки/с | Частота повторных отправок сообщений в приемник.
`serverless_eventrouter_target_throttled_per_second`<br>`DGAUGE`, сообщения/с | Частота возникновения сообщений, не обработанных из-за превышения [квоты или лимита](../../../serverless-integrations/concepts/limits.md#event-router).