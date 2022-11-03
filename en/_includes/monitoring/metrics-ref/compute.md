## {{ compute-full-name }} {#compute}

All {{ compute-full-name }} metrics share the `service=compute` label.

### Virtual machine and disk metrics {#vm-disk-metrics}

Metric name<br>Type, units of measurement | Description<br>Labels
--- | ---
`cpu_usage`<br>`DGAUGE`, % | VM processor utilization as a percentage. The value can exceed 100% if a VM consumes more resources than the guaranteed amount.>Labels:<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`cpu_utilization`<br>`DGAUGE`, % | VM processor core (vCPU) utilization as a percentage. Ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md).<br>Labels:<br>- *cpu_name*: The CPU core ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_read_bytes`<br>`DGAUGE`, bytes/s | Number of bytes per second read from a VM disk.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_read_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram for the processing times of VM disk read requests.<br>Labels:<br>- *bin*: The histogram buckets.<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_read_ops`<br>`DGAUGE`, operations/s | Number of VM disk reads per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_read_ops_failed`<br>`DGAUGE`, operations/s | Number of failed VM disk reads per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_read_ops_in_flight`<br>`DGAUGE`, operations/s | Number of concurrent VM disk reads per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_write_bytes`<br>`DGAUGE`, bytes/s | Number of bytes per second written to a VM disk.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_write_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram for the processing times of VM disk write requests.<br>Labels:<br>- *bin*: The histogram buckets.<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_write_ops`<br>`DGAUGE`, operations/s | Number of bytes per second written to a VM disk.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_write_ops_failed`<br>`DGAUGE`, operations/s | Number of VM disk writes per second.<br>Labels:<br>- *device*: The device.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`disk_write_ops_in_flight`<br>`DGAUGE`, operations/s | Number of concurrent VM disk writes per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`network_connections.quota_utilization`<br>`DGAUGE`, % | VM network connection [quota]({{ link-console-quotas }}) utilization, from 0% to 100%.<br>Labels:<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`network_received_bytes`<br>`DGAUGE`, bytes/s | Number of bytes per second received on a VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`network_received_packets`<br>`DGAUGE`, packets/s | Number of packets per second received on a VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`network_sent_bytes`<br>`DGAUGE`, bytes/s | Number of bytes per second sent over a VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.
`network_sent_packets`<br>`DGAUGE`, packets/s | Number of packets per second sent over a VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`.

Read more about the service in the [{{ compute-name }}](../../../compute) documentation.