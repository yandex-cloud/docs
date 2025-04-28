The `name` label contains the metric name.

All {{ alb-name }} metrics share the `service=application-load-balancer` label.

## HTTP metrics {#http-metrics}

Labels shared by all HTTP metrics:

| Label | Value |
| --- | --- |
| backend | Backend name |
| backend_group | [Backend group](../../../application-load-balancer/concepts/backend-group.md) name |
| http_router | [HTTP router](../../../application-load-balancer/concepts/http-router.md) name |
| load_balancer | [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) name |
| route | [Route](../../../application-load-balancer/concepts/http-router.md#routes) name |
| virtual_host | [Virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host) name |
| zone | [Availability zone](../../../overview/concepts/geo-scope.md) |

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
| `load_balancer.request_bytes_per_second`<br>`DGAUGE`, bytes per second | Total size of load balancer requests per second.<br>With the `zone` label added, the system will only count requests from the specified availability zone. |
| `load_balancer.requests_count_per_second`<br>`DGAUGE`, requests per second | Number of load balancer requests per second.<br>With the `zone` label added, the system will only count requests from the specified availability zone.<br>This metric features the `code` special label containing the response code, e.g., `200` or `grpc:CANCELLED`. |
| `load_balancer.requests_latency_milliseconds`<br>`IGUAGE`, milliseconds | Response latency distribution histogram, 50th to 99th percentiles, in milliseconds. (Load balancer response latency is the time span between it receiving the request's first byte and sending the response's last byte.)<br>With the `zone` label added, the system will only count responses in the specified availability zone.<br>This metric features the `bin` special label containing histogram buckets. |
| `load_balancer.response_bytes_per_second`<br>`DGAUGE`, bytes per second  | Total size of load balancer responses per second.<br>With the `zone` label added, the system will only count responses in the specified availability zone. |

## Scaling metrics {#scaling-metrics}

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
| `load_balancer.scaling.active_connections`<br>`DGAUGE`, count | Number of active connections |
| `load_balancer.scaling.bytes_per_second`<br>`DGAUGE`, bytes per second | Amount of data processed per second |
| `load_balancer.scaling.connections_per_second`<br>`DGAUGE`, connections per second | Number of connections per second |
| `load_balancer.scaling.http_received_bytes_per_second`<br>`DGAUGE`, bytes per second | Amount of data received per second |
| `load_balancer.scaling.http_transmitted_bytes_per_second`<br>`DGAUGE`, bytes per second | Amount of data transmitted per second |
| `load_balancer.scaling.requests_per_second`<br>`DGAUGE`, requests per second | Number of requests per second |

## {{ sws-name }} metrics {#sws-metrics}

{% include [alb-sws](alb-sws.md) %}