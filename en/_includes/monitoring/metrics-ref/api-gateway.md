The `name` label contains the metric name.

## API metrics {#api-gw-api-metrics}

Labels shared by all API gateway metrics:

Label | Value
--- | ---
gateway | API gateway ID
path | Request path
release | API gateway [version](../../../api-gateway/concepts/extensions/canary.md)
operation | Request method, e.g., `GET` or `POST`
service | Service label, always `serverless-apigateway`

Metric name<br>Type, units | Description<br>Labels
--- | ---
`api_gateway.errors_count_per_second`<br>`DGAUGE`, requests per second | Number of error requests per second.<br>This metric features the `code` label containing the response code, e.g., `200`, `404`, or `502`.
`api_gateway.requests_count_per_second`<br>`DGAUGE`, requests per second | Number of requests per second.<br>This metric features the `code` label containing the response code, e.g., `200`, `404`, or `502`.
`api_gateway.requests_latency_milliseconds`<br>`DGAUGE`, milliseconds | Response latency distribution histogram (API gateway response latency is the time span between it receiving the request's first byte and sending the response's last byte.)<br>This metric features the `bin` label containing histogram buckets for latencies in milliseconds.
`api_gateway.requests_latency_milliseconds_count`<br>`DGAUGE`, requests | Total requests with measured latency
`api_gateway.requests_latency_milliseconds_sum`<br>`DGAUGE`, milliseconds | Total request processing latency

## WebSocket metrics {#api-gw-websocket-metrics}

Labels shared by all WebSocket metrics:

Label | Value
--- | ---
gateway | API gateway ID
path | Request path
service | Service label, always `serverless-apigateway`

Metric name<br>Type, units | Description<br>Labels
--- | ---
`api_gateway.websocket_connections_count`<br>`DGAUGE`, count | Number of active [WebSocket connections](../../../api-gateway/concepts/extensions/websocket.md)
`api_gateway.websocket_disconnections_count_per_second`<br>`DGAUGE`, units per second | Number of WebSocket disconnections per second.<br>This metric features the `code` label containing the response code, e.g., `200`, `404`, or `502`.
`api_gateway.websocket_messages_bytes_per_second`<br>`DGAUGE`, bytes per second | Size of data (in bytes) sent over WebSocket connections per second.<br>Labels:<ul><li>`type`: Message type, e.g., `text`.</li><li>`direction`: Message direction, `incoming` or `outcoming`.</li></ul>
`api_gateway.websocket_messages_count_per_second`<br>`DGAUGE`, units per second | Number of messages sent over WebSocket connections per second.<br>Labels:<ul><li>`type`: Message type, e.g., `text`.</li><li>`direction`: Message direction, `incoming` or `outcoming`.</li></ul>

## Trigger metrics {#api-gw-triggers-metrics}

Labels shared by all [trigger](../../../api-gateway/concepts/trigger/index.md) metrics:

Label | Value
----|----
trigger | Trigger ID
type | Entity type.
service | Service label, always `serverless-functions`

Metric name<br/>Type, unit | Entity type. | Description<br/>Labels
--- | --- | ---
`serverless.triggers.access_error_per_second`<br/>`DGAUGE`, errors per second | <ul><li>`request`: Message distribution.</li><li>`message_queue`: Accesses to {{ message-queue-full-name }}.</li></ul> | Frequency of access errors during message distribution.
`serverless.triggers.error_per_second`<br/>`DGAUGE`, errors per second | <ul><li>`request`: Message distribution.</li><li>`message_queue`: Accesses to {{ message-queue-full-name }}.</li></ul> | Frequency of message distribution errors.
`serverless.triggers.execution_time_milliseconds`<br/>`IGAUGE`, invocations per millisecond | <ul><li>`request`: Message distribution.</li></ul> | Distribution histogram of messaging frequency over request processing time.<br/>Request processing intervals are stored in the `bin` label.
`serverless.triggers.inflight`<br/>`DGAUGE`, invocations | <ul><li>`request`: Message distribution.</li></ul> | Number of concurrent message distributions.
`serverless.triggers.read_events_per_second`<br/>`DGAUGE`, units per second | <ul><li>`incoming`: Events that have set off any trigger other than a trigger for {{ message-queue-full-name }}.</li><li>`message_queue`: Events that have set off a trigger for {{ message-queue-full-name }}.</li></ul> | Frequency of events that set off a trigger.
