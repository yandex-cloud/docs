The name of the metric is written in the `name` label.

All {{ network-load-balancer-name }} metrics share the `service=network-load-balancer` label.

## Network metrics {#nlb-net-metrics}

Common labels for all network metrics:

Label | Value
--- | ---
downstream_port | Incoming traffic port number.
instance | Instance ID.
downstream_ip | Incoming traffic IP address.
balancer_type | Load balancer type, `internal` or `external`.
protocol | Protocol: `TCP`, `UDP`.
network_load_balancer | ID of the network load balancer.
upstream_ip | Outgoing traffic IP address.
direction | Traffic direction: `ingress`, `egress`.
upstream_port | Outgoing traffic port number.

Metric name<br>Type, units | Description<br>Labels
--- | ---
`processed_bytes`<br>`RATE`, bytes | Traffic in bytes routed through the load balancer in the outgoing and incoming directions. This includes IP headers. This excludes traffic for health checks.
`processed_packets`<br>`RATE`, packages | Traffic in packages routed through the load balancer in the outgoing and incoming directions. This includes IP headers. This excludes traffic for health checks.