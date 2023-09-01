# Monitoring

The network load balancer sends the following metrics to [{{ monitoring-full-name }}](../../monitoring/concepts/index.md):
* `processed_bytes`: Traffic in bytes that passed through the load balancer, both egress and ingress. The traffic includes IP headers. The traffic excludes health checks.
* `processed_packets`: Traffic in packets passed through the load balancer, both egress and ingress. The traffic includes IP headers. The traffic excludes health checks.

{% note info %}

Remember that you will only see the metrics in the monitoring service after the observed object sends them. Thus, the above metrics will only be sent by the network load balancer when network traffic passes through it.

{% endnote %}
