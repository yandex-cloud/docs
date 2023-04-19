* `--target-group`: Target group parameters and settings of its [resource health checks](../../network-load-balancer/concepts/health-check.md):
   * `target-group-id`: Target group ID.
   * `healthcheck-name`: Resource health check name.
   * `healthcheck-interval`: Health check interval in seconds.
   * `healthcheck-timeout`: Response timeout in seconds.
   * `healthcheck-unhealthythreshold`: Number of successful checks required to consider a VM instance ready to receive traffic.
   * `healthcheck-healthythreshold`: Number of failed checks after which no traffic will be routed to a VM instance.
   * `healthcheck-tcp-port`: Port for health checks via TCP. The acceptable values are from `1` to `32767`.
   * `healthcheck-http-port`: Port for health checks via HTTP. The acceptable values are from `1` to `32767`.
   * `healthcheck-http-path`: URL to perform health checks via HTTP.

   You cannot specify `healthcheck-tcp-port` and `healthcheck-http-port` at the same time.

   Please note: `healthcheck-interval` and `healthcheck-timeout` parameter values must be in `<time in seconds>s` format, e.g., `20s`.
