---
subcategory: Compute Cloud
---

# yandex_compute_instance_group (DataSource)

Get information about a Yandex Compute instance group.

## Example usage

```terraform
//
// Get information about existing Compute Instance Group (IG)
//
data "yandex_compute_instance_group" "my_group" {
  instance_group_id = "some_instance_group_id"
}

output "instance_external_ip" {
  value = data.yandex_compute_instance_group.my_group.instances.*.network_interface.0.nat_ip_address
}
```

## Arguments & Attributes Reference

- `allocation_policy` [Block]. The allocation policy of the instance group by zone and region.
  - `instance_tags_pool` [Block]. Array of availability zone IDs with list of instance tags.
    - `tags` (**Required**)(List Of String). List of tags for instances in zone.
    - `zone` (**Required**)(String). Availability zone.
  - `zones` (**Required**)(Set Of String). A list of [availability zones](https://yandex.cloud/docs/overview/concepts/geo-scope).
- `application_balancer_state` (*Read-Only*) (List Of Object). 
  - `status_message` . 
  - `target_group_id` . 
- `application_load_balancer` [Block]. Application Load balancing (L7) specifications.
  - `ignore_health_checks` (Bool). Do not wait load balancer health checks.
  - `max_opening_traffic_duration` (Number). Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
  - `status_message` (*Read-Only*) (String). The status message of the instance.
  - `target_group_description` (String). A description of the target group.
  - `target_group_id` (*Read-Only*) (String). The ID of the target group.
  - `target_group_labels` (Map Of String). A set of key/value label pairs.
  - `target_group_name` (String). The name of the target group.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `deploy_policy` [Block]. The deployment policy of the instance group.
  - `max_creating` (Number). The maximum number of instances that can be created at the same time.
  - `max_deleting` (Number). The maximum number of instances that can be deleted at the same time.
  - `max_expansion` (**Required**)(Number). The maximum number of instances that can be temporarily allocated above the group's target size during the update process.
  - `max_unavailable` (**Required**)(Number). The maximum number of running instances that can be taken offline (stopped or deleted) at the same time during the update process.
  - `startup_duration` (Number). The amount of time in seconds to allow for an instance to start. Instance will be considered up and running (and start receiving traffic) only after the startup_duration has elapsed and all health checks are passed.
  - `strategy` (String). Affects the lifecycle of the instance during deployment. If set to `proactive` (default), Instance Groups can forcefully stop a running instance. If `opportunistic`, Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health_check` [Block]. Health check specifications.
  - `healthy_threshold` (Number). The number of successful health checks before the managed instance is declared healthy.
  - `http_options` [Block]. HTTP check options.
    - `path` (**Required**)(String). The URL path used for health check requests.
    - `port` (**Required**)(Number). The port used for HTTP health checks.
  - `interval` (Number). The interval to wait between health checks in seconds.
  - `tcp_options` [Block]. TCP check options.
    - `port` (**Required**)(Number). The port used for TCP health checks.
  - `timeout` (Number). The length of time to wait for a response before the health check times out in seconds.
  - `unhealthy_threshold` (Number). The number of failed health checks before the managed instance is declared unhealthy.
- `id` (String). 
- `instance_group_id` (**Required**)(String). The ID of a specific instance group.
- `instance_template` [Block]. The template for creating new instances.
  - `boot_disk` [Block]. Boot disk specifications for the instance.
    - `device_name` (String). This value can be used to reference the device under `/dev/disk/by-id/`.
    - `disk_id` (String). The ID of the existing disk (such as those managed by yandex_compute_disk) to attach as a boot disk.
    - `initialize_params` [Block]. Parameters for creating a disk alongside the instance.

{% note warning %}

`image_id` or `snapshot_id` must be specified.

{% endnote %}


      - `description` (String). A description of the boot disk.
      - `image_id` (String). The disk image to initialize this disk from.
      - `size` (Number). The size of the disk in GB.
      - `snapshot_id` (String). The snapshot to initialize this disk from.
      - `type` (String). The disk type.
    - `mode` (String). The access mode to the disk resource. By default a disk is attached in `READ_WRITE` mode.
    - `name` (String). When set can be later used to change DiskSpec of actual disk.
  - `description` (String). A description of the instance.
  - `filesystem` [Block]. List of filesystems to attach to the instance.
    - `device_name` (String). Name of the device representing the filesystem on the instance.
    - `filesystem_id` (**Required**)(String). ID of the filesystem that should be attached.
    - `mode` (String). Mode of access to the filesystem that should be attached. By default, filesystem is attached in `READ_WRITE` mode.
  - `hostname` (String). Hostname template for the instance. This field is used to generate the FQDN value of instance. The `hostname` must be unique within the network and region. If not specified, the hostname will be equal to `id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.
In order to be unique it must contain at least on of instance unique placeholders:
* `{instance.short_id}`
* {instance.index}
* combination of `{instance.zone_id}` and `{instance.index_in_zone}`
Example: `my-instance-{instance.index}`. If hostname is not set, `name` value will be used. It may also contain another placeholders, see `metadata` doc for full list.
  - `labels` (Map Of String). A set of key/value label pairs to assign to the instance.
  - `metadata` (Map Of String). A set of metadata key/value pairs to make available from within the instance.
  - `metadata_options` [Block]. Options allow user to configure access to managed instances metadata
    - `aws_v1_http_endpoint` (Number). Enables access to AWS flavored metadata (IMDSv1). Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
    - `aws_v1_http_token` (Number). Enables access to IAM credentials with AWS flavored metadata (IMDSv1). Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
    - `gce_http_endpoint` (Number). Enables access to GCE flavored metadata. Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
    - `gce_http_token` (Number). Enables access to IAM credentials with GCE flavored metadata. Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
  - `name` (String). Name template of the instance.
In order to be unique it must contain at least one of instance unique placeholders:*`{instance.short_id}`
* `{instance.index}`
* combination of `{instance.zone_id}` and`{instance.index_in_zone}`.
Example: `my-instance-{instance.index}`.
If not set, default name is used: `{instance_group.id}-{instance.short_id}`. It may also contain another placeholders, see `metadata` doc for full list.
  - `network_interface` [Block]. Network specifications for the instance. This can be used multiple times for adding multiple interfaces.
    - `dns_record` [Block]. List of DNS records.
      - `dns_zone_id` (String). DNS zone id (if not set, private zone used).
      - `fqdn` (**Required**)(String). DNS record FQDN (must have dot at the end).
      - `ptr` (Bool). When set to `true`, also create PTR DNS record.
      - `ttl` (Number). DNS record TTL.
    - `ip_address` (String). Manual set static IP address.
    - `ipv4` (Bool). Allocate an IPv4 address for the interface. The default value is `true`.
    - `ipv6` (Bool). If `true`, allocate an IPv6 address for the interface. The address will be automatically assigned from the specified subnet.
    - `ipv6_address` (String). Manual set static IPv6 address.
    - `ipv6_dns_record` [Block]. List of IPv6 DNS records.
      - `dns_zone_id` (String). DNS zone id (if not set, private zone used).
      - `fqdn` (**Required**)(String). DNS record FQDN (must have dot at the end).
      - `ptr` (Bool). When set to `true`, also create PTR DNS record.
      - `ttl` (Number). DNS record TTL.
    - `nat` (Bool). Flag for using NAT.
    - `nat_dns_record` [Block]. List of NAT DNS records.
      - `dns_zone_id` (String). DNS zone id (if not set, private zone used).
      - `fqdn` (**Required**)(String). DNS record FQDN (must have dot at the end).
      - `ptr` (Bool). When set to `true`, also create PTR DNS record.
      - `ttl` (Number). DNS record TTL.
    - `nat_ip_address` (String). A public address that can be used to access the internet over NAT. Use `variables` to set.
    - `network_id` (String). The ID of the network.
    - `security_group_ids` (Set Of String). Security group (SG) `IDs` for network interface.
    - `subnet_ids` (Set Of String). The ID of the subnets to attach this interface to.
  - `network_settings` [Block]. Network acceleration type for instance.
    - `type` (String). Network acceleration type. By default a network is in `STANDARD` mode.
  - `placement_policy` [Block]. The placement policy configuration.
    - `placement_group_id` (**Required**)(String). Specifies the id of the Placement Group to assign to the instances.
  - `platform_id` (String). The ID of the hardware platform configuration for the instance.
  - `reserved_instance_pool_id` (String). ID of the reserved instance pool that the instance should belong to.
  - `resources` [Block]. Compute resource specifications for the instance.
    - `core_fraction` (Number). If provided, specifies baseline core performance as a percent.
    - `cores` (**Required**)(Number). The number of CPU cores for the instance.
    - `gpus` (Number). If provided, specifies the number of GPU devices for the instance.
    - `memory` (**Required**)(Number). The memory size in GB.
  - `scheduling_policy` [Block]. The scheduling policy configuration.
    - `preemptible` (Bool). Specifies if the instance is preemptible. Defaults to `false`.
  - `secondary_disk` [Block]. A list of disks to attach to the instance.
    - `device_name` (String). This value can be used to reference the device under `/dev/disk/by-id/`.
    - `disk_id` (String). ID of the existing disk. To set use variables.
    - `initialize_params` [Block]. Parameters used for creating a disk alongside the instance.

{% note warning %}

`image_id` or `snapshot_id` must be specified.

{% endnote %}


      - `description` (String). A description of the boot disk.
      - `image_id` (String). The disk image to initialize this disk from.
      - `size` (Number). The size of the disk in GB.
      - `snapshot_id` (String). The snapshot to initialize this disk from.
      - `type` (String). The disk type.
    - `mode` (String). The access mode to the disk resource. By default a disk is attached in `READ_WRITE` mode.
    - `name` (String). When set can be later used to change DiskSpec of actual disk.
  - `service_account_id` (String). The ID of the service account authorized for this instance.
- `instances` (*Read-Only*) (List Of Object). Instances block.
  - `fqdn` . 
  - `instance_id` . 
  - `instance_tag` . 
  - `name` . 
  - `network_interface` . 
    - `index` . 
    - `ip_address` . 
    - `ipv4` . 
    - `ipv6` . 
    - `ipv6_address` . 
    - `mac_address` . 
    - `nat` . 
    - `nat_ip_address` . 
    - `nat_ip_version` . 
    - `subnet_id` . 
  - `status` . 
  - `status_changed_at` . 
  - `status_message` . 
  - `zone_id` . 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `load_balancer` [Block]. Load balancing specifications.
  - `ignore_health_checks` (Bool). Do not wait load balancer health checks.
  - `max_opening_traffic_duration` (Number). Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
  - `status_message` (*Read-Only*) (String). The status message of the target group.
  - `target_group_description` (String). A description of the target group.
  - `target_group_id` (*Read-Only*) (String). The ID of the target group.
  - `target_group_labels` (Map Of String). A set of key/value label pairs.
  - `target_group_name` (String). The name of the target group.
- `load_balancer_state` (*Read-Only*) (List Of Object). 
  - `status_message` . 
  - `target_group_id` . 
- `max_checking_health_duration` (Number). Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
- `name` (String). The resource name.
- `scale_policy` [Block]. The scaling policy of the instance group.

{% note warning %}

Either `fixed_scale` or `auto_scale` must be specified.

{% endnote %}


  - `auto_scale` [Block]. The auto scaling policy of the instance group.
    - `auto_scale_type` (String). Autoscale type, can be `ZONAL` or `REGIONAL`. By default `ZONAL` type is used.
    - `cpu_utilization_target` (Number). Target CPU load level.
    - `custom_rule` [Block]. A list of custom rules.
      - `folder_id` (String). If specified, sets the folder id to fetch metrics from. By default, it is the ID of the folder the group belongs to.
      - `labels` (Map Of String). Metrics [labels](https://yandex.cloud/en/docs/monitoring/concepts/data-model#label) from Monitoring.
      - `metric_name` (**Required**)(String). Name of the metric in Monitoring.
      - `metric_type` (**Required**)(String). Type of metric, can be `GAUGE` or `COUNTER`. `GAUGE` metric reflects the value at particular time point. `COUNTER` metric exhibits a monotonous growth over time.
      - `rule_type` (**Required**)(String). The metric rule type (UTILIZATION, WORKLOAD). UTILIZATION for metrics describing resource utilization per VM instance. WORKLOAD for metrics describing total workload on all VM instances.
      - `service` (String). If specified, sets the service name to fetch metrics. The default value is `custom`. You can use a label to specify service metrics, e.g., `service` with the `compute` value for Compute Cloud.
      - `target` (**Required**)(Number). Target metric value by which Instance Groups calculates the number of required VM instances.
    - `initial_size` (**Required**)(Number). The initial number of instances in the instance group.
    - `max_size` (Number). The maximum number of virtual machines in the group.
    - `measurement_duration` (**Required**)(Number). The amount of time, in seconds, that metrics are averaged for. If the average value at the end of the interval is higher than the `cpu_utilization_target`, the instance group will increase the number of virtual machines in the group.
    - `min_zone_size` (Number). The minimum number of virtual machines in a single availability zone.
    - `stabilization_duration` (Number). The minimum time interval, in seconds, to monitor the load before an instance group can reduce the number of virtual machines in the group. During this time, the group will not decrease even if the average load falls below the value of `cpu_utilization_target`.
    - `warmup_duration` (Number). The warm-up time of the virtual machine, in seconds. During this time, traffic is fed to the virtual machine, but load metrics are not taken into account.
  - `fixed_scale` [Block]. The fixed scaling policy of the instance group.
    - `size` (**Required**)(Number). The number of instances in the instance group.
  - `test_auto_scale` [Block]. The test auto scaling policy of the instance group. Use it to test how the auto scale works.
    - `auto_scale_type` (String). Autoscale type, can be `ZONAL` or `REGIONAL`. By default `ZONAL` type is used.
    - `cpu_utilization_target` (Number). Target CPU load level.
    - `custom_rule` [Block]. A list of custom rules.
      - `folder_id` (String). Folder ID of custom metric in Yandex Monitoring that should be used for scaling.
      - `labels` (Map Of String). A map of labels of metric.
      - `metric_name` (**Required**)(String). The name of metric.
      - `metric_type` (**Required**)(String). Metric type, `GAUGE` or `COUNTER`.
      - `rule_type` (**Required**)(String). Rule type: `UTILIZATION` - This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label. `WORKLOAD` - This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.
      - `service` (String). Service of custom metric in Yandex Monitoring that should be used for scaling.
      - `target` (**Required**)(Number). Target metric value level.
    - `initial_size` (**Required**)(Number). The initial number of instances in the instance group.
    - `max_size` (Number). The maximum number of virtual machines in the group.
    - `measurement_duration` (**Required**)(Number). The amount of time, in seconds, that metrics are averaged for. If the average value at the end of the interval is higher than the `cpu_utilization_target`, the instance group will increase the number of virtual machines in the group.
    - `min_zone_size` (Number). The minimum number of virtual machines in a single availability zone.
    - `stabilization_duration` (Number). The minimum time interval, in seconds, to monitor the load before an instance group can reduce the number of virtual machines in the group. During this time, the group will not decrease even if the average load falls below the value of `cpu_utilization_target`.
    - `warmup_duration` (Number). The warm-up time of the virtual machine, in seconds. During this time, traffic is fed to the virtual machine, but load metrics are not taken into account.
- `service_account_id` (**Required**)(String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `status` (*Read-Only*) (String). The status of the instance.
- `variables` (Map Of String). A set of key/value variables pairs to assign to the instance group.


