Backend parameters:
* `name`: Backend name.
* `port`: Backend port.
* `weight`: Backend weight.
* `target_group_ids`: [Target group](../../application-load-balancer/concepts/target-group.md) ID. To get a list of available target groups, run the following [CLI](../../cli/) command: `yc alb target-group list`.
* `load_balancing_config`: Balancing parameters:
  * `panic_threshold`: Panic mode threshold.
* `enable_proxy_protocol`: With this option enabled, the load balancer will send metadata about its connection to the client, including its IP, to the backend over the [PROXY protocol from HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt). If the option is not specified, only the load balancer's IP address will be provided to the backend. This parameter is only available for `Stream` type backends.
* `healthcheck`: Health check parameters:
  * `timeout`: Maximum period for which a connection can be established.
  * `interval`: Interval.
  * `healthy_threshold`: Healthy threshold.
  * `unhealthy_threshold`: Unhealthy threshold.
  * `http_healthcheck`: `HTTP` health check parameters:
    * `path`: Path.
    * `host`: Host address.
  * `grpc_healthcheck`: `gRPC` health check parameters:
    * `service_name`: Name of the gRPC service to check. If no service is specified, the backend general health is checked.
  * `stream_healthcheck`: `Stream` health check parameters:
    * `send`: Data to send to the endpoint for a health check.
    * `receive`: Data to receive from the endpoint for it to pass the health check.

  {% include [backend-healthcheck](./backend-healthcheck.md) %}