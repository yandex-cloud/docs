The `name` label contains the metric name.

All {{ network-load-balancer-name }} metrics share the `service=network-load-balancer` label.

## Network metrics {#nlb-net-metrics}

Labels shared by all network metrics:

Label | Value
--- | ---
downstream_port | Inbound traffic port number
instance | Instance ID
downstream_ip | Inbound traffic IP address
balancer_type | Load balancer type, `internal` or `external`
protocol | Protocol: `TCP` or `UDP`
network_load_balancer | Load balancer ID
upstream_ip | Outbound traffic IP address
direction | Traffic direction: `ingress` or `egress`
upstream_port | Outbound traffic port number

Metric name<br>Type, units | Description<br>Labels
--- | ---
`processed_bytes`<br>`RATE`, bytes | Inbound and outbound traffic in bytes routed through the load balancer, including IP headers and excluding health check traffic.
`processed_packets`<br>`RATE`, packets | Inbound and outbound traffic in packets routed through the load balancer, including IP headers and excluding health check traffic.