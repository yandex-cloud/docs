Optionally, under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. In the window that opens, specify the [resource health check](../../network-load-balancer/concepts/health-check.md) settings:

1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**. The naming requirements are as follows:

    {% include [name-format](../name-format.md) %}

1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_http }}`, `{{ ui-key.yacloud.common.label_tcp }}`, `{{ ui-key.yacloud.common.label_http2 }}`, `{{ ui-key.yacloud.common.label_https }}`, or `{{ ui-key.yacloud.common.label_grpc }}`.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}**: Specify a URL for health checks (for the `{{ ui-key.yacloud.common.label_http }}`, `{{ ui-key.yacloud.common.label_http2 }}`, `{{ ui-key.yacloud.common.label_https }}`, and `{{ ui-key.yacloud.common.label_grpc }}` types).
1. **{{ ui-key.yacloud.compute.group.overview.label_host }}**: Specify a host (for the `{{ ui-key.yacloud.common.label_http2 }}`, `{{ ui-key.yacloud.common.label_https }}`, and `{{ ui-key.yacloud.common.label_grpc }}` types).
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** for health checks. The possible values range from `1` to `32767`.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}**: Response timeout in seconds. The possible values range from `1` to `60`. The interval must be at least 1 second longer than the response timeout.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}**: Health check interval in seconds. The possible values range from `1` to `60`.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}**: Number of successful checks required to consider a VM instance ready to receive traffic.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}**: Number of failed checks before traffic is no longer routed to the VM.
1. Click **{{ ui-key.yacloud.common.apply }}**.