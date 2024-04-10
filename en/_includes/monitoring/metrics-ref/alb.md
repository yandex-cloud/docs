The name of the metric is written in the `name` label.

All {{ alb-name }} metrics share the `service=application-load-balancer` label.

## HTTP metrics {#http-metrics}

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
| `load_balancer.request_bytes_per_second`<br>`DGAUGE`, bytes/s | Total amount of load balancer requests per second.<br>When combined with the *zone* label, only requests from a specific availability zone will be counted. |
| `load_balancer.requests_count_per_second`<br>`DGAUGE`, requests/s | Number of load balancer requests per second.<br>When combined with the *zone* label, only requests from a specific availability zone will be counted.<br>A special label named *code* indicates the code of a response, e.g., `200` or `grpc:CANCELLED`. |
| `load_balancer.requests_latency_milliseconds`<br>`IGUAGE`, milliseconds | Distribution histogram of the response latency (time between the load balancer receiving the first byte of request to sending the last byte of response), 50th to 99th percentiles, in milliseconds.<br>When combined with the *zone* label, only responses in a specific availability zone will be counted.<br>A special label named *bin* indicates histogram buckets. |
| `load_balancer.response_bytes_per_second`<br>`DGAUGE`, bytes/s | Total amount of load balancer responses per second.<br>When combined with the *zone* label, only responses in a specific availability zone will be counted. |

## Scaling metrics {#scaling-metrics}

| Metric name<br>Type, units of measurement | Description<br>Labels |
| --- | --- |
| `load_balancer.scaling.active_connections`<br>`DGAUGE`, pieces | Number of active connections |
| `load_balancer.scaling.bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data processed per second |
| `load_balancer.scaling.connections_per_second`<br>`DGAUGE`, connections/s | Number of connections per second |
| `load_balancer.scaling.http_received_bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data received per second |
| `load_balancer.scaling.http_transmitted_bytes_per_second`<br>`DGAUGE`, bytes/s | Amount of data transmitted per second |
| `load_balancer.scaling.requests_per_second`<br>`DGAUGE`, requests/s | Number of requests per second |

## {{ sws-name }} metrics {#sws-metrics}

{% include [alb-sws](alb-sws.md) %}