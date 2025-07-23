Backend parameters:
* `name`: Backend name.
* `port`: Backend port.
* `weight`: Backend weight.
* `target_group_ids`: [Target group](../../application-load-balancer/concepts/target-group.md) ID. To get a list of available target groups, run the `yc alb target-group list` [CLI](../../cli/) command.
* `load_balancing_config`: Balancing parameters:
  * `panic_threshold`: Panic mode threshold.
* `enable_proxy_protocol`: With this option enabled, the load balancer will send its client connection metadata, e.g. its IP address, to the backend via [HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt) protocol. If you do not set specific values for this option, the load balancer will only send its IP address to the backend. This option is only available for `Stream` type backends.
* `healthcheck`: Health check settings:
  * `timeout`: Maximum connection request timeout.
  * `interval`: Interval.
  * `healthy_threshold`: Healthy threshold.
  * `unhealthy_threshold`: Unhealthy threshold.
  * `keep_connections_on_host_health_failure`: This option maintains connections open even if the target host status changes to `Unhealthy`.
  * `http_healthcheck`: `HTTP` health check settings:
    * `path`: Path, e.g., `/health`.
    * `host`: Host address, e.g., `example.com`.
    * `expected_statuses`: List of HTTP status codes corresponding to the `Healthy` status, e.g., `[200, 201, 202]`.
  * `grpc_healthcheck`: `gRPC` health check settings:
    * `service_name`: Name of the gRPC service you want to check. If no service is specified, the system will check the backend overall health.
  * `stream_healthcheck`: `Stream` health check settings:
    * `send`: Data sent to the endpoint for a health check.
    * `receive`: Data the endpoint must return to pass the health check.

  {% include [backend-healthcheck](./backend-healthcheck.md) %}