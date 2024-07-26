Имя метрики пишется в метку `name`.

Все метрики сервиса {{ api-gw-name }} имеют общие метки:

Метка | Значение
--- | ---
gateway | Идентификатор API-шлюза.
path | Путь запроса.
service | Метка сервиса, значение всегда `serverless-apigateway`.

## Метрики API {#api-gw-api-metrics}

Общие метки для всех метрик API-шлюза:

Метка | Значение
--- | ---
release | [Версия](../../../api-gateway/concepts/extensions/canary.md) API-шлюза.
operation | Метод запроса, например `GET`, `POST`.

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`api_gateway.errors_count_per_second`<br>`DGAUGE`, запросы/с | Количество ошибочных запросов в секунду.<br>Метка `code` — код ответа, например `200`, `404`, `502`.
`api_gateway.requests_count_per_second`<br>`DGAUGE`, запросы/с | Количество запросов в секунду.<br>Метка `code` — код ответа, например `200`, `404`, `502`.
`api_gateway.requests_latency_milliseconds`<br>`DGAUGE`, миллисекунды | Гистограмма распределения задержки ответа (времени от получения API-шлюзом первого байта запроса до отправки последнего байта ответа).<br>Метка `bin` — бакеты гистограммы задержек в миллисекундах.
`api_gateway.requests_latency_milliseconds_count`<br>`DGAUGE`, запросы | Общее количество запросов, для которых измерялась задержка.
`api_gateway.requests_latency_milliseconds_sum`<br>`DGAUGE`, миллисекунды | Суммарная задержка при обработке запросов.

## Метрики веб-сокетов {#api-gw-websocket-metrics}

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`api_gateway.websocket_connections_count`<br>`DGAUGE`, штуки | Количество активных [WebSocket-соединений](../../../api-gateway/concepts/extensions/websocket.md).
`api_gateway.websocket_disconnections_count_per_second`<br>`DGAUGE`, штуки/с | Количество разрывов WebSocket-соединений в секунду.<br>Метка `code` — код ответа, например `200`, `404`, `502`.
`api_gateway.websocket_messages_bytes_per_second`<br>`DGAUGE`, байты/с | Объем данных, передаваемых через WebSocket-соединения в байтах в секунду.<br>Метки:<ul><li>`type` — тип сообщения, например `text`.</li><li>`direction` — направление сообщения: `incoming`, `outcoming`.</li></ul>
`api_gateway.websocket_messages_count_per_second`<br>`DGAUGE`, штуки/с | Количество сообщений, передаваемых через WebSocket-соединения в секунду.<br>Метки:<ul><li>`type` — тип сообщения, например `text`.</li><li>`direction` — направление сообщения: `incoming`, `outcoming`.</li></ul>
