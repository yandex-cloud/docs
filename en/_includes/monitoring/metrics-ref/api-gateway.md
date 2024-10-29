The metric name is written to the `name` label.

All {{ api-gw-name }} metrics have common labels:

| Label | Value |
--- | ---
| gateway | API gateway ID |
| path | Request path |
| service | Service label, always `serverless-apigateway` |

## API metrics {#api-gw-api-metrics}

Common labels for all API gateway metrics:

| Label | Value |
--- | ---
| release | API gateway [version](../../../api-gateway/concepts/extensions/canary.md) |
| operation | Request method, e.g., `GET`, `POST` |

| Metric name<br>Type, unit | Description<br>Labels |
--- | ---
| `api_gateway.errors_count_per_second`<br>`DGAUGE`, requests/s | Number of invalid requests per second.<br>`code` label: Response code, e.g., `200`, `404`, `502`. |
| `api_gateway.requests_count_per_second`<br>`DGAUGE`, requests/s | Number of requests per second.<br>`code` label: Response code, e.g., `200`, `404`, `502`. |
| `api_gateway.requests_latency_milliseconds`<br>`DGAUGE`, milliseconds | Histogram of response latency distribution (time between the API gateway receiving the first request byte and sending the last response byte).<br>`bin` label: Latency histogram buckets in milliseconds. |
| `api_gateway.requests_latency_milliseconds_count`<br>`DGAUGE`, requests | Total number of requests for which latency was measured. |
| `api_gateway.requests_latency_milliseconds_sum`<br>`DGAUGE`, milliseconds | Overall latency |

## WebSocket metrics {#api-gw-websocket-metrics}

| Metric name<br>Type, unit | Description<br>Labels |
--- | ---
| `api_gateway.websocket_connections_count`<br>`DGAUGE`, number | Number of active [WebSocket connections](../../../api-gateway/concepts/extensions/websocket.md) |
| `api_gateway.websocket_disconnections_count_per_second`<br>`DGAUGE`, number/s | Number of broken WebSocket connections per second.<br>`code` label: Response code, e.g., `200`, `404`, `502`. |
| `api_gateway.websocket_messages_bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data sent through WebSocket connections in bytes per second.<br>Labels:<ul><li>`type`: Message type, e.g., `text`</li><li>`direction`: Message direction, `incoming` or `outcoming`</li></ul> |
| `api_gateway.websocket_messages_count_per_second`<br>`DGAUGE`, number/s | Number of messages sent through WebSocket connections per second.<br>Labels:<ul><li>`type`: Message type, e.g., `text`</li><li>`direction`: Message direction, `incoming` or `outcoming`</li></ul> |
