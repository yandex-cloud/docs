[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Compute Cloud > Data Sources > compute_instance

# yandex_compute_instance (DataSource)

Get information about a Yandex Compute instance. For more information, see [the official documentation](../../compute/concepts/vm.md).

{% note warning %}

One of `instance_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Instance.
//
data "yandex_compute_instance" "my_instance" {
  instance_id = "some_instance_id"
}

output "instance_external_ip" {
  value = data.yandex_compute_instance.my_instance.network_interface.0.nat_ip_address
}
```

## Arguments & Attributes Reference

- `boot_disk` (*Read-Only*) (List Of Object). The boot disk for the instance. Either `initialize_params` or `disk_id` must be specified.
  - `auto_delete` . 
  - `device_name` . 
  - `disk_id` . 
  - `initialize_params` . 
    - `block_size` . 
    - `description` . 
    - `image_id` . 
    - `kms_key_id` . 
    - `name` . 
    - `size` . 
    - `snapshot_id` . 
    - `type` . 
  - `mode` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `fqdn` (*Read-Only*) (String). The fully qualified DNS name of this instance.
- `gpu_cluster_id` (String). ID of the GPU cluster to attach this instance to.
- `hardware_generation` (*Read-Only*) (List Of Object). 
  - `generation2_features` . 
  - `legacy_features` . 
    - `pci_topology` . 
- `id` (String). 
- `instance_id` (String). The ID of a specific instance.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_grace_period` (String). Time between notification via metadata service and maintenance. E.g., `60s`.
- `maintenance_policy` (String). Behavior on maintenance events. Can be: `unspecified`, `migrate`, `restart`. The default is `unspecified`.
- `metadata` (*Read-Only*) (Map Of String). Metadata key/value pairs to make available from within the instance.
- `name` (String). The resource name.
- `network_acceleration_type` (*Read-Only*) (String). Type of network acceleration. Can be `standard` or `software_accelerated`. The default is `standard`.
- `network_interface` (*Read-Only*) (List Of Object). Networks to attach to the instance. This can be specified multiple times.
  - `dns_record` . 
    - `dns_zone_id` . 
    - `fqdn` . 
    - `ptr` . 
    - `ttl` . 
  - `index` . 
  - `ip_address` . 
  - `ipv4` . 
  - `ipv6` . 
  - `ipv6_address` . 
  - `ipv6_dns_record` . 
    - `dns_zone_id` . 
    - `fqdn` . 
    - `ptr` . 
    - `ttl` . 
  - `mac_address` . 
  - `nat` . 
  - `nat_dns_record` . 
    - `dns_zone_id` . 
    - `fqdn` . 
    - `ptr` . 
    - `ttl` . 
  - `nat_ip_address` . 
  - `nat_ip_version` . 
  - `security_group_ids` . 
  - `subnet_id` . 
- `platform_id` (*Read-Only*) (String). The type of virtual machine to create.
- `reserved_instance_pool_id` (String). ID of the reserved instance pool to attach this instance to.
- `resources` (*Read-Only*) (List Of Object). Compute resources that are allocated for the instance.
  - `core_fraction` . 
  - `cores` . 
  - `gpus` . 
  - `memory` . 
- `scheduling_policy` (*Read-Only*) (List Of Object). Scheduling policy configuration.
  - `preemptible` . 
- `secondary_disk` (*Read-Only*) (Set Of Object). A set of disks to attach to the instance. The structure is documented below.

{% note warning %}

The [`allow_stopping_for_update`](#allow_stopping_for_update) property must be set to `true` in order to update this structure.

{% endnote %}

  - `auto_delete` . 
  - `device_name` . 
  - `disk_id` . 
  - `mode` . 
- `service_account_id` (String). [Service account](../../iam/concepts/users/service-accounts.md) which linked to the resource.
- `status` (*Read-Only*) (String). The status of this instance.
- `zone` (*Read-Only*) (String). The [availability zone](../../overview/concepts/geo-scope.md) where resource is located. If it is not provided, the default provider zone will be used.
- `filesystem` [Block]. List of filesystems that are attached to the instance.
  - `device_name` (*Read-Only*) (String). 
  - `filesystem_id` (*Read-Only*) (String). 
  - `mode` (String). 
- `local_disk` [Block]. List of local disks that are attached to the instance.

{% note warning %}

Local disks are not available for all users by default.

{% endnote %}


  - `device_name` (*Read-Only*) (String). 
  - `kms_key_id` (String). 
  - `size_bytes` (**Required**)(Number). 
- `metadata_options` [Block]. Options allow user to configure access to instance's metadata.
  - `aws_v1_http_endpoint` (Number). 
  - `aws_v1_http_token` (Number). 
  - `aws_v2_http_endpoint` (Number). 
  - `aws_v2_http_token` (Number). 
  - `gce_http_endpoint` (Number). 
  - `gce_http_token` (Number). 
- `placement_policy` [Block]. The placement policy configuration.
  - `host_affinity_rules` (List Of Object). 
    - `key` . 
    - `op` . 
    - `values` . 
  - `placement_group_id` (String). 
  - `placement_group_partition` (Number).