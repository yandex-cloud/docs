The name of the metric is written to the `name` label.

All {{ compute-name }} metrics share the `service=compute` label.

{% note info %}

If the resource name is set, it will be returned in a response from {{ compute-name }}. Otherwise, the response will return the resource ID.

{% endnote %}

## VM and disk metrics {#vm-disk-metrics}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`cpu_usage`<br>`DGAUGE`, % | VM CPU usage as a percentage. This value can exceed 100% if the VM consumes available process resources in excess of its guaranteed allocation.<br>Labels:<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.
`cpu_utilization`<br>`DGAUGE`, % | Utilization of vCPUs as a percentage. It ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md).<br>Labels:<br>- *cpu_name*: vCPU ID.<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.
`disk.io_quota_utilization_percentage`<br>`RATE`, % | Average percentage of disk quota usage.<br>Labels:<br>- *disk*: Disk name or ID.
`disk.io_quota_utilization_percentage_burst`<br>`RATE`, % | Maximum percentage of disk quota usage.<br>Labels:<br>- *disk*: Disk name or ID.
`disk.read_bytes`<br>`RATE`, bytes per second | Average number of bytes read from the VM disk.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_bytes_burst`<br>`RATE`, bytes per second | Maximum number of bytes read from the VM disk.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_bytes_in_flight`<br>`DGAUGE`, bytes per second | Average number of bytes being read from the VM disk at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_bytes_in_flight_burst`<br>`DGAUGE`, bytes per second | Maximum number of bytes being read from the VM disk at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_errors`<br>`RATE`, operations per second | Number of failed VM disk reads.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram for VM disk read request latency.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_ops`<br>`RATE`, operations per second | Average number of VM disk read operations.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_ops_burst`<br>`RATE`, operations per second | Maximum number of VM disk read operations.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_ops_in_flight`<br>`DGAUGE`, operations per second | Average number of VM disk read operations at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_ops_in_flight_burst`<br>`DGAUGE`, operations per second | Maximum number of VM disk read operations at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.read_throttler_delay`<br>`HIST_RATE`, milliseconds | Histogram of read latency due to exceeding the VM disk quota.<br>Labels:<br>- *disk*: Disk name or ID.
`disk.write_bytes`<br>`RATE`, bytes per second | Average number of bytes written to the VM disk.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_bytes_burst`<br>`RATE`, bytes per second | Maximum number of bytes written to the VM disk.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_bytes_in_flight`<br>`DGAUGE`, bytes per second | Average number of bytes being written to the VM disk at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_bytes_in_flight_burst`<br>`DGAUGE`, bytes per second | Maximum number of bytes being written to the VM disk at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_errors`<br>`RATE`, operations per second | Number of failed VM disk writes.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_latency`<br>`HIST_RATE`, milliseconds | Distribution histogram for VM disk write request latency.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_ops`<br>`RATE`, operations per second | Average number of VM disk write operations.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_ops_burst`<br>`RATE`, operations per second | Maximum number of VM disk write operations.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_ops_in_flight`<br>`DGAUGE`, operations per second | Average number of VM disk write operations at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_ops_in_flight_burst`<br>`DGAUGE`, operations per second | Maximum number of VM disk write operations at the current point in time.<br>Labels:<br>- *disk*: Disk name or ID.<br>- *instance*: VM name or ID.
`disk.write_throttler_delay`<br>`HIST_RATE`, milliseconds | Histogram of write latency due to exceeding the VM disk quota.<br>Labels:<br>- *disk*: Disk name or ID.
`maintenance_event` | It is set to `1` if a [maintenance event](../../../compute/concepts/vm-policies.md) is active on the VM.<br>Labels:<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.<br>- *type*: Maintenance event type, either `migrate` or `restart`.
`network_connections.quota_utilization`<br>`DGAUGE`, % | Used [quota]({{ link-console-quotas }}) on VM network connections, 0% to 100%.<br>Labels:<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.
`network_connections.interface_quota_utilization`<br>`DGAUGE`, % | Used [quota]({{ link-console-quotas }}) on VM network interface connections, 0% to 100%.<br>Labels:<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.<br>- *interface_number*: VM network interface ID.
`network_received_bytes`<br>`DGAUGE`, bytes per second | Number of bytes per second received on the VM network interface.<br>Labels:<br>- *interface_number*: VM network interface ID.<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.
`network_received_packets`<br>`DGAUGE`, packets per second | Number of packets per second received on the VM network interface.<br>Labels:<br>- *interface_number*: VM network interface ID.<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.
`network_sent_bytes`<br>`DGAUGE`, bytes per second | Number of bytes per second sent via the VM network interface.<br>Labels:<br>- *interface_number*: VM network interface ID.<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.
`network_sent_packets`<br>`DGAUGE`, packets per second | Number of packets per second sent via the VM network interface.<br>Labels:<br>- *interface_number*: VM network interface ID.<br>- *resource_id*: VM name or ID.<br>- *resource_type*: Resource type. The only available value is `vm`.

## File storage metrics {#fs-metrics}

Labels shared by all file storage metrics:

Label | Value
----|----
filestore | [File storage](../../../compute/concepts/filesystem.md) ID
instance | [VM](../../../compute/concepts/vm.md) name

| Metric name<br>Type, units | Description<br>Labels
--- | ---
`filestore.index_errors`<br>`RATE`, operations per second | Number of failed indexing operations in the file storage
`filestore.index_ops`<br>`RATE`, operations per second | Average number of indexing operations in the file storage
`filestore.read_bytes`<br>`RATE`, bytes per second | Average number of bytes read from the file storage
`filestore.read_bytes_burst`<br>`DGAUGE`, bytes per second | Maximum number of bytes read from the file storage
`filestore.read_errors`<br>`RATE`, operations per second | Number of failed reads from the file storage
`filestore.read_latency`<br>`RATE`, milliseconds | Distribution histogram for file storage read request latency. Special `bin` label: Histogram buckets.
`filestore.read_ops`<br>`RATE`, operations per second | Average number of reads from the file storage
`filestore.read_ops_burst`<br>`DGAUGE`, operations per second | Maximum number of reads from the file storage
`filestore.write_bytes`<br>`RATE`, bytes per second | Average number of bytes written to the file storage
`filestore.write_bytes_burst`<br>`DGAUGE`, bytes per second | Maximum number of bytes written to the file storage
`filestore.write_errors`<br>`RATE`, operations per second | Number of failed writes to the file storage
`filestore.write_latency`<br>`RATE`, milliseconds | Distribution histogram for file storage write request latency. Special `bin` label: Histogram buckets.
`filestore.write_ops`<br>`RATE`, operations per second | Average number of writes to the file storage
`filestore.write_ops_burst`<br>`DGAUGE`, operations per second | Maximum number of writes to the file storage

## Instance group metrics {#ig-metrics}

| Metric name<br>Type, units | Description<br>Labels
--- | ---
`average_utilization_in_zone`<br>`DGAUGE` | Average resource usage for all VM instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name.
`average_utilization`<br>`DGAUGE` | Average resource usage for all VM instances.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *source_metric*: Metric name.
`instances_count_in_zone`<br>`IGAUGE`, number | Number of VM instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.
`instances_count`<br>`IGAUGE`, number | Number of VM instances in the group.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.
`measured_percent_in_zone`<br>`DGAUGE`, % | Percentage of VM CPU utilization in the availability zone. This value can exceed 100% if the VM consumes available process resources in excess of its guaranteed allocation.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name.
`summary_capacity_in_zone`<br>`DGAUGE` | Total resource usage for all VM instances in the availability zone, which causes an increase in the instance group size.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name.
`summary_capacity`<br>`DGAUGE` | Total resource usage for all VM instances, which causes an increase in the instance group size.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *source_metric*: Metric name.
`summary_utilization`<br>`DGAUGE` | Total resource usage for all VM instances.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *source_metric*: Metric name.
`target_instances_count_in_zone`<br>`IGAUGE`, number | Target number of VM instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.
`target_instances_count`<br>`IGAUGE`, number | Target number of VM instances in the group.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.
`target_utilization`<br>`DGAUGE` | Target resource usage per VM.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *source_metric*: Metric name.
`test_autoscale_target_instances_count_in_zone`<br>`IGAUGE` | Number of target VM instances in the availability zone as set by the autoscaling policy.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.
`test_autoscale_target_instances_count`<br>`IGAUGE` | Number of target VM instances in the group as set by the autoscaling policy.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.
`utilization_in_zone`<br>`DGAUGE` | Total resource usage for all VM instances in the availability zone.<br>Labels:<br>- *resource_id*: Instance group name or ID.<br>- *resource_type*: Resource type. The only available value is `instance_group`.<br>- *zone_id*: Availability zone ID.<br>- *source_metric*: Metric name.
