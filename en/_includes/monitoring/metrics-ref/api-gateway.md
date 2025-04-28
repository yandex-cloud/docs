The `name` label contains the metric name.

All {{ api-gw-name }} metrics share the following labels:

Label | Value
--- | ---
gateway | API gateway ID
path | Request path
service | Service label, always `serverless-apigateway`

## API metrics {#api-gw-api-metrics}

Labels shared by all API gateway metrics:

Label | Value
--- | ---
release | API gateway [version](../../../api-gateway/concepts/extensions/canary.md)
operation | Request method, e.g., `GET` and `POST`

Metric name<br>Type, units | Description<br>Labels
--- | ---
`api_gateway.errors_count_per_second`<br>`DGAUGE`, requests per second | Number of error requests per second.<br>This metric features the `code` label containing the response code, e.g., `200`, `404`, or `502`.
`api_gateway.requests_count_per_second`<br>`DGAUGE`, requests per second | Number of requests per second.<br>This metric features the `code` label containing the response code, e.g., `200`, `404`, or `502`.
`api_gateway.requests_latency_milliseconds`<br>`DGAUGE`, milliseconds | Response latency distribution histogram (API gateway response latency is the time span between it receiving the request's first byte and sending the response's last byte.)<br>This metric features the `bin` label containing histogram buckets for latencies in milliseconds.
`api_gateway.requests_latency_milliseconds_count`<br>`DGAUGE`, requests | Total requests with measured latency
`api_gateway.requests_latency_milliseconds_sum`<br>`DGAUGE`, milliseconds | Total request processing latency

## WebSocket metrics {#api-gw-websocket-metrics}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`api_gateway.websocket_connections_count`<br>`DGAUGE`, count | Number of active [WebSocket connections](../../../api-gateway/concepts/extensions/websocket.md)
`api_gateway.websocket_disconnections_count_per_second`<br>`DGAUGE`, units per second | Number of WebSocket disconnections per second.<br>This metric features the `code` label containing the response code, e.g., `200`, `404`, or `502`.
`api_gateway.websocket_messages_bytes_per_second`<br>`DGAUGE`, bytes per second | Size of data (in bytes) sent over WebSocket connections per second.<br>Labels:<ul><li>`type`: Message type, e.g., `text`.</li><li>`direction`: Message direction, `incoming` or `outcoming`.</li></ul>
`api_gateway.websocket_messages_count_per_second`<br>`DGAUGE`, units per second | Number of messages sent over WebSocket connections per second.<br>Labels:<ul><li>`type`: Message type, e.g., `text`.</li><li>`direction`: Message direction, `incoming` or `outcoming`.</li></ul>