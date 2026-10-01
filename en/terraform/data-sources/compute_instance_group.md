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

- `allocation_policy` (*Read-Only*) (List Of Object). 
  - `instance_tags_pool` . 
    - `tags` . 
    - `zone` . 
  - `zones` . 
- `application_balancer_state` (*Read-Only*) (List Of Object). 
  - `status_message` . 
  - `target_group_id` . 
- `application_load_balancer` (*Read-Only*) (List Of Object). 
  - `ignore_health_checks` . 
  - `max_opening_traffic_duration` . 
  - `status_message` . 
  - `target_group_description` . 
  - `target_group_id` . 
  - `target_group_labels` . 
  - `target_group_name` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `deploy_policy` (*Read-Only*) (List Of Object). 
  - `max_creating` . 
  - `max_deleting` . 
  - `max_expansion` . 
  - `max_unavailable` . 
  - `startup_duration` . 
  - `strategy` . 
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (*Read-Only*) (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health_check` (*Read-Only*) (List Of Object). 
  - `healthy_threshold` . 
  - `http_options` . 
    - `path` . 
    - `port` . 
  - `interval` . 
  - `tcp_options` . 
    - `port` . 
  - `timeout` . 
  - `unhealthy_threshold` . 
- `id` (String). 
- `instance_group_id` (**Required**)(String). The ID of a specific instance group.
- `instance_template` (*Read-Only*) (List Of Object). 
  - `boot_disk` . 
    - `device_name` . 
    - `disk_id` . 
    - `initialize_params` . 
      - `description` . 
      - `image_id` . 
      - `size` . 
      - `snapshot_id` . 
      - `type` . 
    - `mode` . 
    - `name` . 
  - `description` . 
  - `filesystem` . 
    - `device_name` . 
    - `filesystem_id` . 
    - `mode` . 
  - `hostname` . 
  - `labels` . 
  - `metadata` . 
  - `metadata_options` . 
    - `aws_v1_http_endpoint` . 
    - `aws_v1_http_token` . 
    - `aws_v2_http_endpoint` . 
    - `aws_v2_http_token` . 
    - `gce_http_endpoint` . 
    - `gce_http_token` . 
  - `name` . 
  - `network_interface` . 
    - `dns_record` . 
      - `dns_zone_id` . 
      - `fqdn` . 
      - `ptr` . 
      - `ttl` . 
    - `ip_address` . 
    - `ipv4` . 
    - `ipv6` . 
    - `ipv6_address` . 
    - `ipv6_dns_record` . 
      - `dns_zone_id` . 
      - `fqdn` . 
      - `ptr` . 
      - `ttl` . 
    - `nat` . 
    - `nat_dns_record` . 
      - `dns_zone_id` . 
      - `fqdn` . 
      - `ptr` . 
      - `ttl` . 
    - `nat_ip_address` . 
    - `network_id` . 
    - `security_group_ids` . 
    - `subnet_ids` . 
  - `network_settings` . 
    - `type` . 
  - `placement_policy` . 
    - `placement_group_id` . 
  - `platform_id` . 
  - `reserved_instance_pool_id` . 
  - `resources` . 
    - `core_fraction` . 
    - `cores` . 
    - `gpus` . 
    - `memory` . 
  - `scheduling_policy` . 
    - `preemptible` . 
  - `secondary_disk` . 
    - `device_name` . 
    - `disk_id` . 
    - `initialize_params` . 
      - `description` . 
      - `image_id` . 
      - `size` . 
      - `snapshot_id` . 
      - `type` . 
    - `mode` . 
    - `name` . 
  - `service_account_id` . 
- `instances` (*Read-Only*) (List Of Object). 
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
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `load_balancer` (*Read-Only*) (List Of Object). 
  - `ignore_health_checks` . 
  - `max_opening_traffic_duration` . 
  - `status_message` . 
  - `target_group_description` . 
  - `target_group_id` . 
  - `target_group_labels` . 
  - `target_group_name` . 
- `load_balancer_state` (*Read-Only*) (List Of Object). 
  - `status_message` . 
  - `target_group_id` . 
- `max_checking_health_duration` (*Read-Only*) (Number). Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
- `name` (*Read-Only*) (String). The resource name.
- `scale_policy` (*Read-Only*) (List Of Object). 
  - `auto_scale` . 
    - `auto_scale_type` . 
    - `cpu_utilization_target` . 
    - `custom_rule` . 
      - `folder_id` . 
      - `labels` . 
      - `metric_name` . 
      - `metric_type` . 
      - `rule_type` . 
      - `service` . 
      - `target` . 
    - `initial_size` . 
    - `max_size` . 
    - `measurement_duration` . 
    - `min_zone_size` . 
    - `stabilization_duration` . 
    - `warmup_duration` . 
  - `fixed_scale` . 
    - `size` . 
  - `test_auto_scale` . 
    - `auto_scale_type` . 
    - `cpu_utilization_target` . 
    - `custom_rule` . 
      - `folder_id` . 
      - `labels` . 
      - `metric_name` . 
      - `metric_type` . 
      - `rule_type` . 
      - `service` . 
      - `target` . 
    - `initial_size` . 
    - `max_size` . 
    - `measurement_duration` . 
    - `min_zone_size` . 
    - `stabilization_duration` . 
    - `warmup_duration` . 
- `service_account_id` (*Read-Only*) (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `status` (*Read-Only*) (String). The status of the instance.
- `variables` (*Read-Only*) (Map Of String). A set of key/value variables pairs to assign to the instance group.


