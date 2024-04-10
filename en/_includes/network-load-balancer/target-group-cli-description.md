* `--target-group`: Target group parameters and settings of its [resource health checks](../../network-load-balancer/concepts/health-check.md):
   * `target-group-id`: Target group ID.
   * `healthcheck-name`: Resource health check name.
   * `healthcheck-interval`: Health check interval in seconds. Possible values: `1s` to `60s`. The interval must be at least 1 second longer than the waiting time.
   * `healthcheck-timeout`: Response timeout in seconds. Possible values: `1s` to `60s`.
   * `healthcheck-unhealthythreshold`: Number of failed checks after which no traffic will be routed to a virtual machine. Possible values: `2` to `10`.
   * `healthcheck-healthythreshold`: Number of successful checks required to consider a virtual machine ready to receive traffic. Possible values: `2` to `10`.
   * `healthcheck-tcp-port`: Port for health checks via TCP. The acceptable values are from `1` to `32767`.
   * `healthcheck-http-port`: Port for health checks via HTTP. The acceptable values are from `1` to `32767`.
   * `healthcheck-http-path`: URL to perform health checks via HTTP.

   You cannot specify `healthcheck-tcp-port` and `healthcheck-http-port` at the same time.

   {% note warning %}

   The `healthcheck-interval` and `healthcheck-timeout` parameter values must be in `<time_in_seconds>s` format, e.g., `20s`.

   {% endnote %}

