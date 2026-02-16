The `name` label contains the metric name.

All {{ compute-name }} metrics share the `service=compute` label.

{% note info %}

If the resource name is set, it will be returned in a response from {{ compute-name }}. Otherwise, the response will return the resource ID.

{% endnote %}

## VM and disk metrics {#vm-disk-metrics}

#|
|| **Metric name**
**Type, units**
|
**Description**
**Labels** ||
|| `cpu_usage`
`DGAUGE`, %
|
VM CPU usage as a percentage. This value can exceed 100% if the VM consumes available process resources in excess of its guaranteed allocation.
Labels:
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|| `cpu_utilization`
`DGAUGE`, %
|
Utilization of vCPUs as a percentage. It ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md).
Labels:
- *cpu_name*: vCPU ID.
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|| `disk.io_quota_utilization_percentage`
`RATE`, %
|
Average percentage of disk quota usage.
Labels:
- *disk*: Disk name or ID. ||
|| `disk.io_quota_utilization_percentage_burst`
`RATE`, %
|
Maximum percentage of disk quota usage.
Labels:
- *disk*: Disk name or ID. ||
|| `disk.read_bytes`
`RATE`, bytes per second
|
Average number of bytes read from the VM disk.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_bytes_burst`
`RATE`, bytes per second
|
Maximum number of bytes read from the VM disk.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_bytes_in_flight`
`DGAUGE`, bytes per second
|
Average number of bytes being read from the VM disk at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_bytes_in_flight_burst`
`DGAUGE`, bytes per second
|
Maximum number of bytes being read from the VM disk at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_errors`
`RATE`, operations per second
|
Number of failed VM disk reads.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_latency`
`HIST_RATE`, milliseconds
|
Distribution histogram for VM disk read request latency.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_ops`
`RATE`, operations per second
|
Average number of VM disk read operations.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_ops_burst`
`RATE`, operations per second
|
Maximum number of VM disk read operations.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_ops_in_flight`
`DGAUGE`, operations per second
|
Average number of VM disk read operations at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_ops_in_flight_burst`
`DGAUGE`, operations per second
|
Maximum number of VM disk read operations at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.read_throttler_delay`
`HIST_RATE`, milliseconds
|
Histogram of read latency due to exceeded VM disk quota.
Labels:
- *disk*: Disk name or ID. ||
|| `disk.write_bytes`
`RATE`, bytes per second
|
Average number of bytes written to the VM disk.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_bytes_burst`
`RATE`, bytes per second
|
Maximum number of bytes written to the VM disk.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_bytes_in_flight`
`DGAUGE`, bytes per second
|
Average number of bytes being written to the VM disk at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_bytes_in_flight_burst`
`DGAUGE`, bytes per second
|
Maximum number of bytes being written to the VM disk at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_errors`
`RATE`, operations per second
|
Number of failed VM disk writes.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_latency`
`HIST_RATE`, milliseconds
|
Distribution histogram for VM disk write request latency.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_ops`
`RATE`, operations per second
|
Average number of VM disk write operations.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_ops_burst`
`RATE`, operations per second
|
Maximum number of VM disk write operations.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_ops_in_flight`
`DGAUGE`, operations per second
|
Average number of VM disk write operations at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_ops_in_flight_burst`
`DGAUGE`, operations per second
|
Maximum number of VM disk write operations at the current point in time.
Labels:
- *disk*: Disk name or ID.
- *instance*: VM name or ID. ||
|| `disk.write_throttler_delay`
`HIST_RATE`, milliseconds
|
Histogram of write latency due to exceeded VM disk quota.
Labels:
- *disk*: Disk name or ID. ||
|| `maintenance_event`
|
It is set to `1` if a [maintenance event](../../../compute/concepts/maintenance-policies.md) is active on the VM.
Labels:
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`.
- *type*: Maintenance event type. Possible values: `migrate` or `restart`. ||
|| `network_connections.quota_utilization`
`DGAUGE`, %
|
Used [quota]({{ link-console-quotas }}) on VM network connections, 0% to 100%.
Labels:
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|| `network_connections.interface_quota_utilization`
`DGAUGE`, %
|
Used [quota]({{ link-console-quotas }}) on VM network interface connections, 0% to 100%.
Labels:
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`.
- *interface_number*: VM network interface ID. ||
|| `network_received_bytes`
`DGAUGE`, bytes per second
|
Number of bytes per second received on the VM network interface.
Labels:
- *interface_number*: VM network interface ID.
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|| `network_received_packets`
`DGAUGE`, packets per second
|
Number of packets per second received on the VM network interface.
Labels:
- *interface_number*: VM network interface ID.
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|| `network_sent_bytes`
`DGAUGE`, bytes per second
|
Number of bytes per second sent via the VM network interface.
Labels:
- *interface_number*: VM network interface ID.
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|| `network_sent_packets`
`DGAUGE`, packets per second
|
Number of packets per second sent via the VM network interface.
Labels:
- *interface_number*: VM network interface ID.
- *resource_id*: VM name or ID.
- *resource_type*: Resource type. The only available value is `vm`. ||
|#

## File storage metrics {#fs-metrics}

Labels shared by all file storage metrics:

Label | Value
----|----
filestore | [File storage](../../../compute/concepts/filesystem.md) ID
instance | [VM](../../../compute/concepts/vm.md) name

#|
|| **Metric name**
**Type, units**
|
**Description**
**Labels** ||
--- | ---
|| `filestore.index_cumulative_time`
`RATE`, milliseconds
|
Total time of indexing operations in the file storage. The *request* special label represents the operation type. ||
|| `filestore.index_errors`
`RATE`, operations per second
|
Number of failed indexing operations in the file storage ||
|| `filestore.index_latency`
`RATE`, milliseconds
|
Delay when performing indexing operations in the file storage.
Special labels:
* *request*: Operation type.
* *bin*: Histogram buckets. ||
|| `filestore.index_ops`
`RATE`, operations per second
|
Average number of indexing operations in the file storage ||
|| `filestore.read_bytes`
`RATE`, bytes per second
|
Average number of bytes read from the file storage ||
|| `filestore.read_bytes_burst`
`DGAUGE`, bytes per second
|
Maximum number of bytes read from the file storage ||
|| `filestore.read_errors`
`RATE`, operations per second
|
Number of failed reads from the file storage. The *request* special label represents the operation type. ||
|| `filestore.read_latency`
`RATE`, milliseconds
|
Distribution histogram for file storage read request latency. Special *bin* label: Histogram buckets. ||
|| `filestore.read_ops`
`RATE`, operations per second
|
Average number of reads from the file storage ||
|| `filestore.read_ops_burst`
`DGAUGE`, operations per second
|
Maximum number of reads from the file storage ||
|| `filestore.write_bytes`
`RATE`, bytes per second
|
Average number of bytes written to the file storage ||
|| `filestore.write_bytes_burst`
`DGAUGE`, bytes per second
|
Maximum number of bytes written to the file storage ||
|| `filestore.write_errors`
`RATE`, operations per second
|
Number of failed writes to the file storage ||
|| `filestore.write_latency`
`RATE`, milliseconds
|
Distribution histogram for file storage write request latency. Special *bin* label: Histogram buckets. ||
|| `filestore.write_ops`
`RATE`, operations per second
|
Average number of writes to the file storage ||
|| `filestore.write_ops_burst`
`DGAUGE`, operations per second
|
Maximum number of writes to the file storage ||
|#

## Instance group metrics {#ig-metrics}

The available metrics are specific to the instance group [scaling type](../../../compute/concepts/instance-groups/scale.md).

#|
|| **Metric name**
**Type, units**
|
**Description**
**Labels**
|
**Scaling type** ||
|| `average_utilization`
`DGAUGE`
|
Average resource usage for all VM instances.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|| `average_utilization_in_zone`
`DGAUGE`
|
Average resource usage for all VM instances in the availability zone.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|| `instances_count`
`IGAUGE`, count
|
Number of VM instances in the group.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
|
- Automatic
- Fixed, but tested as automatic
- Fixed. ||
|| `instances_count_in_zone`
`IGAUGE`, count
|
Number of VM instances in the availability zone.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
|
- Automatic
- Fixed, but tested as automatic
- Fixed. ||
|| `measured_percent_in_zone`
`DGAUGE`, %
|
Percentage of VM CPU utilization in the availability zone. This value can exceed 100% if the VM consumes available process resources in excess of its guaranteed allocation.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
- *source_metric*: Metric name.
|
- Fixed, but tested as automatic ||
|| `summary_capacity`
`DGAUGE`
|
Total resource usage for all VM instances, which causes an increase in the instance group size.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|| `summary_capacity_in_zone`
`DGAUGE`
|
Total resource usage for all VM instances in the availability zone, which causes an increase in the instance group size.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|| `summary_utilization`
`DGAUGE`
|
Total resource usage for all VM instances.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|| `target_instances_count`
`IGAUGE`, count
|
Target number of VM instances in the group.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
|
- Automatic
- Fixed, but tested as automatic
- Fixed. ||
|| `target_instances_count_in_zone`
`IGAUGE`, count
|
Target number of VM instances in the availability zone.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
|
- Automatic
- Fixed, but tested as automatic
- Fixed. ||
|| `test_autoscale_target_instances_count`
`IGAUGE`
|
Number of target VM instances in the group as set by the autoscaling policy.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
|
- Fixed, but tested as automatic ||
|| `test_autoscale_target_instances_count_in_zone`
`IGAUGE`
|
Number of target VM instances in the availability zone as set by the autoscaling policy.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
|
- Fixed, but tested as automatic ||
|| `target_utilization`
`DGAUGE`
|
Target resource usage per VM.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|| `utilization_in_zone`
`DGAUGE`
|
Total resource usage for all VM instances in the availability zone.
Labels:
- *resource_id*: Instance group name or ID.
- *resource_type*: Resource type. The only available value is `instance_group`.
- *zone_id*: Availability zone ID.
- *source_metric*: Metric name.
|
- Automatic
- Fixed, but tested as automatic ||
|#
