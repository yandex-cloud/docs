## Service: {{ compute-full-name }} {#compute}

All {{ compute-name }} metrics share the `service=compute` label.

### Virtual machine and disk metrics {#vm-disk-metrics}

| Metric name<br>Type, units of measurement | Description<br>Labels |
--- | ---
| `cpu_usage`<br>`DGAUGE`, % | The VM processor utilization percentage. The value can exceed 100% if the VM consumes more resources than the guaranteed amount.<br>Labels:<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `cpu_utilization`<br>`DGAUGE`, % | The VM processor core (vCPU) utilization percentage. Ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md).<br>Labels:<br>- *cpu_name*: The CPU core ID.<br>- *resource_id*The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk.io_quota_utilization_percentage`<br>`RATE`, % | The disk quota utilization percentage.<br>Labels:<br>- *disk*: The disk ID. |
| `disk.read_bytes`<br>`RATE`, bytes/s | The number of bytes read from the VM disk.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.read_bytes_in_flight`<br>`DGAUGE`, bytes/s | The number of bytes in flight being read from the VM disk.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.read_errors`<br>`RATE`, operations/s | The number of failed VM disk read operations.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.read_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram of the VM disk read requests latency.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.read_ops`<br>`RATE`, operations/s | The number of VM disk read operations.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.read_ops_in_flight`<br>`DGAUGE`, operations/s | The number of in flight VM disk read operations.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.read_throttler_delay`<br>`HIST_RATE`, milliseconds | Histogram of the read operations latency caused by the VM disk quota excess.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_bytes`<br>`RATE`, bytes/s | The number of bytes written to the VM disk.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_bytes_in_flight`<br>`DGAUGE`, bytes/s | The number of bytes in flight being written to the VM disk.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_errors`<br>`RATE`, operations/s | The number of failed VM disk write operations.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram of the VM disk write requests latency.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_ops`<br>`RATE`, operations/s | The number of VM disk write operations.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_ops_in_flight`<br>`DGAUGE`, operations/s | The number of in flight VM disk write operations.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk.write_throttler_delay`<br>`HIST_RATE`, milliseconds | Histogram of the write operations latency caused by the VM disk quota excess.<br>Labels:<br>- *disk*: The disk ID.<br>- *instance*: The VM ID. |
| `disk_read_bytes`<br>`DGAUGE`, bytes/s | The number of bytes per second read from the VM disk.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_read_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram for the latencies of VM disk read requests.<br>Labels:<br>- *bin*: The histogram buckets.<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_read_ops`<br>`DGAUGE`, operations/s | The number of VM disk reads per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_read_ops_failed`<br>`DGAUGE`, operations/s | The number of failed VM disk reads per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_read_ops_in_flight`<br>`DGAUGE`, operations/s | The number of concurrent VM disk reads per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_write_bytes`<br>`DGAUGE`, bytes/s | The number of bytes per second written to the VM disk.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_write_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram for the latencies of VM disk write requests.<br>Labels:<br>- *bin*: The histogram buckets.<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_write_ops`<br>`DGAUGE`, operations/s | The number of VM disk write operations per second. <br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_write_ops_failed`<br>`DGAUGE`, operations/s | The number of failed VM disk write operations per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `disk_write_ops_in_flight`<br>`DGAUGE`, operations/s | The number of concurrent VM disk writes per second.<br>Labels:<br>- *device*: The disk ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `network_connections.quota_utilization`<br>`DGAUGE`, % | VM network connection [quota]({{ link-console-quotas }}) utilization, from 0% to 100%. <br>Labels:<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `network_received_bytes`<br>`DGAUGE`, bytes/s | The number of bytes per second received on the VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br> - *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `network_received_packets`<br>`DGAUGE`, packets/s | The number of packets per second received on the VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br> - *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `network_sent_bytes`<br>`DGAUGE`, bytes/s | The number of bytes per second sent over the VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br> - *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |
| `network_sent_packets`<br>`DGAUGE`, packets/s | The number of packets per second sent over the VM network interface.<br>Labels:<br>- *interface_number*: The VM network interface ID.<br>- *resource_id*: The VM ID.<br>- *resource_type*: The resource type. The only value is `vm`. |


### Instance group metrics {#ig-metrics}

| Metric name<br>Type, units of measurement | Description<br>Labels |
--- | ---                                                                
| `instances_count`<br>`IGAUGE`, pcs | Number of instances in the group.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`. |
| `target_instances_count`<br>`IGAUGE`, pcs | Target number of instances in the group.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`. |
| `target_utilization`<br>`DGAUGE` | Target utilization of resources per VM instance.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *source_metric*: Metric name. |
| `summary_capacity`<br>`DGAUGE` | Total utilization of resources for all instances, which causes an increase in the group size.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *source_metric*: Metric name. |
| `summary_utilization`<br>`DGAUGE` | Total utilization of resources for all instances.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *source_metric*: Metric name. |
| `average_utilization`<br>`DGAUGE` | Average utilization of resources for all instances.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *source_metric*: Metric name. |
| `target_workload`<br>`DGAUGE` | Target workload on a VM instance in the group or availability zone.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *source_metric*: Metric name. |
| `instances_count_in_zone`<br>`IGAUGE`, pcs | Number of VM instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *zone_id*: Availability zone ID. |
| `target_instances_count_in_zone`<br>`IGAUGE`, pcs | Target number of VM instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *zone_id*: Availability zone ID. |
| `average_utilization_in_zone`<br>`DGAUGE` | Average utilization of resources for all instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name. |
| `utilization_in_zone`<br>`DGAUGE` | Total utilization of resources for all instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name. |
| `summary_capacity_in_zone`<br>`DGAUGE` | Total utilization of resources for all instances in the availability zone, which causes an increase in the group size.<br>Labels<br>:- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name. |
| `zone_workload`<br>`DGAUGE` | Workload on a VM instance in the availability zone.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name. |
| `region_workload`<br>`DGAUGE` | Workload on a VM instance in the group.<br>Labels:<br>- *resource_id*: Instance group ID.<br>- *resource_type*: Resource type. The only value is `instance_group`.<br>- *source_metric*: Metric name. |

Read more about the service in the [{{ compute-name }}](../../../compute/) documentation.
