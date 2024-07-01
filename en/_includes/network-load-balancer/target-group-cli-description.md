* `--target-group`: Target group parameters and settings of its [resource health checks](../../network-load-balancer/concepts/health-check.md):
   * `target-group-id`: Target group ID.

      {% include [get-target-group-id](get-target-group-id.md) %}

   * `healthcheck-name`: Resource health check name.
   * `healthcheck-interval`: Health check interval in seconds. The possible values are from `1s` to `60s`. The interval must be at least 1 second longer than the waiting time.
   * `healthcheck-timeout`: Response timeout in seconds. The possible values are from `1s` to `60s`.
   * `healthcheck-unhealthythreshold`: Number of failed checks after which no traffic will be routed to a virtual machine. The possible values are from `2` to `10`.
   * `healthcheck-healthythreshold`: Number of successful checks required to consider a virtual machine ready to receive traffic. The possible values are from `2` to `10`.
   * `healthcheck-tcp-port`: Port for health checks via TCP. The possible values are from `1` to `32,767`.
   * `healthcheck-http-port`: Port for health checks via HTTP. The possible values are from `1` to `32,767`.
   * `healthcheck-http-path`: URL to perform health checks via HTTP.

   You cannot specify `healthcheck-tcp-port` and `healthcheck-http-port` at the same time.

   {% note warning %}

   The `healthcheck-interval` and `healthcheck-timeout` parameter values must be in `<time_in_seconds>s` format, e.g., `20s`.

   {% endnote %}

