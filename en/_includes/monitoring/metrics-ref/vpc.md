The `name` label contains the metric name.

## Service connection metrics {#vpc-pe-metrics}

All service connection related metrics share the `service=private-endpoint` label.

Labels shared by all service connection metrics:

Label | Value
--- | ---
direction | Traffic direction through the service connection. `Ingress` for incoming traffic to the service connection from the VPC, `Egress` for outgoing traffic from the service connection to the VPC.
network_id | ID of the VPC the service connection was created in.
private_endpoint_id | Service connection ID

Metric name<br>Type, units | Description<br>Labels
--- | ---
`processed_bytes`<br>`RATE`, bytes | Outgoing and incoming traffic through the service connection, in bytes. IP headers included.
`processed_packets`<br>`RATE`, packets | Outgoing and incoming traffic through the service connection, in packets. IP headers included.
