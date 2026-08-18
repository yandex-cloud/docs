[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > Serverless Integrations

# Метрики Yandex Serverless Integrations

В этом разделе описаны метрики сервиса [Serverless Integrations](../../serverless-integrations/index.md), поставляемые в Monium Metrics.

Имя метрики пишется в метку `name`.


## Метрики Yandex EventRouter {#eventrouter}

Все метрики EventRouter имеют общую метку `bus` — идентификатор [шины](../../serverless-integrations/concepts/eventrouter/bus.md).


### Метрики шин {#er-buses}

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`serverless_eventrouter_bus_put_event_per_second`<br>`DGAUGE`, сообщения/с | Частота отправки сообщений с помощью вызова gRPC API [EventService/Put](../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md).
`serverless_eventrouter_bus_sent_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок в шине.<br>Метки:<ul><li>`code` — код ошибки. Возможные значения:<ul><li>`EVENTROUTER_BUS_SEND_ERROR`</li><li>`EVENTROUTER_EVENT_SIZE_EXCEEDED`</li></ul></li><li>`source` — источник.</li></ul>
`serverless_eventrouter_put_event_latency_milliseconds`<br>`DGAUGE`, миллисекунды | Время от получения сообщения, отправленного с помощью вызова gRPC API [EventService/Put](../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md), до записи в шину.


### Метрики коннекторов {#er-connectors}

Все метрики [коннекторов](../../serverless-integrations/concepts/eventrouter/connector.md) имеют общую метку `connector` — идентификатор коннектора.


Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`serverless_eventrouter_connector_access_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок доступа к ресурсам коннектора.
`serverless_eventrouter_connector_error_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок в коннекторе.
`serverless_eventrouter_connector_event_per_second`<br>`DGAUGE`, события/с | Скорость чтения событий коннектором.
`serverless_eventrouter_connector_event_size_exceeded_per_second`<br>`DGAUGE`, ошибки/с | Частота возникновения ошибок превышения максимального размера сообщений, полученных коннектором.


### Метрики правил {#er-rules}

Все метрики [правил](../../serverless-integrations/concepts/eventrouter/rule.md) имеют общие метки:

Метка | Значение
--- | ---
matched | Соответствие условиям, заданным в [фильтре](../../serverless-integrations/concepts/eventrouter/rule.md#filter).
rule | Идентификатор правила.

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`serverless_eventrouter_rule_event_per_second`<br>`DGAUGE`, события/с | Скорость обработки правил.


### Метрики приемников {#er-targets}

Все метрики [приемников](../../serverless-integrations/concepts/eventrouter/rule.md#target) имеют общие метки:

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
`serverless_eventrouter_target_throttled_per_second`<br>`DGAUGE`, сообщения/с | Частота возникновения сообщений, не обработанных из-за превышения [квоты или лимита](../../serverless-integrations/concepts/limits.md#event-router).