* `--target-group`: Target group parameters and [health check](../../network-load-balancer/concepts/health-check.md) settings:
    * `target-group-id`: Target group ID.

      {% include [get-target-group-id](get-target-group-id.md) %}

    * `healthcheck-name`: Health check name.
    * `healthcheck-interval`: Health check interval in seconds. The possible values range from `1s` to `60s`. The interval must be at least 1 second longer than the response timeout. 
    * `healthcheck-timeout`: Response timeout in seconds. The possible values range from `1s` to `60s`.
    * `healthcheck-unhealthythreshold`: Number of failed checks before traffic is no longer routed to the VM. The possible values range from `2` to `10`.
    * `healthcheck-healthythreshold`: Number of successful checks required to consider the VM ready to receive traffic. The possible values range from `2` to `10`.
    * `healthcheck-tcp-port`: Port for TCP health checks. The possible values range from `1` to `32,767`.
    * `healthcheck-http-port`: Port for HTTP health checks. The possible values range from `1` to `32,767`.
    * `healthcheck-http-path`: URL for HTTP health checks.

    You cannot specify both `healthcheck-tcp-port` and `healthcheck-http-port` at the same time.

    {% note warning %}
    
    Use the `<time_in_seconds>s` format, e.g., `20s`, for the `healthcheck-interval` and `healthcheck-timeout` values.
    
    {% endnote %}
