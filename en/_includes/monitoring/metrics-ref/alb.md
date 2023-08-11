All {{ alb-name }} metrics share the `service=application-load-balancer` label.

### HTTP metrics {#http-metrics}

Labels shared by all HTTP metrics:

| Label | Value |
| --- | --- |
| backend | Backend name |
| backend_group | [Backend group](../../../application-load-balancer/concepts/backend-group.md) name |
| http-router | [HTTP router](../../../application-load-balancer/concepts/http-router.md) name |
| load_balancer | [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) name |
| route | Name of the [route](../../../application-load-balancer/concepts/http-router.md#routes) |
| virtual_host | Name of the [virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host) |
| zone | [Availability zone](../../../overview/concepts/geo-scope.md) |

HTTP metrics:

| Metric name<br>Type, units of measurement | Description<br>Labels |
| --- | --- |
| `load_balancer.request_bytes_per_second`<br>`DGAUGE`, bytes/s | Total volume of load balancer requests per second. |
| `load_balancer.requests_count_per_second`<br>`DGAUGE`, requests/s | Number of load balancer requests per second.<br>A special label named *code* indicates the code of a response, such as `200` or `grpc:CANCELLED`. |
| `load_balancer.requests_latency_milliseconds`<br>`HIST`, milliseconds | Distribution histogram of the response latency (the time between the load balancer receiving the first byte of a request to sending the last byte of the response), 50th to 99th percentiles, in milliseconds.<br>A special label named *bin* indicates histogram buckets. |
| `load_balancer.response_bytes_per_second`<br>`DGAUGE`, bytes/s | Total volume of load balancer responses per second. |

### Scaling metrics {#scaling-metrics}

| Metric name<br>Type, units of measurement | Description<br>Labels |
| --- | --- |
| `load_balancer.scaling.active_connections`<br>`DGAUGE`, pieces | Number of active connections. |
| `load_balancer.scaling.bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data processed per second. |
| `load_balancer.scaling.connections_per_second`<br>`DGAUGE`, connections/s | Number of connections per second. |
| `load_balancer.scaling.http_received_bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data received per second. |
| `load_balancer.scaling.http_transmitted_bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data transmitted per second. |
| `load_balancer.scaling.requests_per_second`<br>`DGAUGE`, requests/s | Number of requests per second. |
