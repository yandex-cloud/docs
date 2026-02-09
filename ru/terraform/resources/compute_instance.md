---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/compute_instance.md
---

# yandex_compute_instance (Resource)

A VM instance resource. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/vm).

## Example usage

```terraform
//
// Create a new Compute Instance
//
resource "yandex_compute_instance" "default" {
  name        = "test"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.foo.id
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

// Auxiliary resources for Compute Instance
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference

- `allow_recreate` (Bool). 
- `allow_stopping_for_update` (Bool). If `true`, allows Terraform to stop the instance in order to update its properties. If you try to update a property that requires stopping the instance without setting this field, the update will fail.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `fqdn` (*Read-Only*) (String). The fully qualified DNS name of this instance.
- `gpu_cluster_id` (String). ID of the GPU cluster to attach this instance to.
- `hardware_generation` (*Read-Only*) (List Of Object). 
  - `generation2_features` . 
  - `legacy_features` . 
    - `pci_topology` . 
- `hostname` (String). Host name for the instance. This field is used to generate the instance `fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `id` of the instance and `fqdn` will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_grace_period` (String). Time between notification via metadata service and maintenance. E.g., `60s`.
- `maintenance_policy` (String). Behavior on maintenance events. Can be: `unspecified`, `migrate`, `restart`. The default is `unspecified`.
- `metadata` (Map Of String). Metadata key/value pairs to make available from within the instance.
- `name` (String). The resource name.
- `network_acceleration_type` (String). Type of network acceleration. Can be `standard` or `software_accelerated`. The default is `standard`.
- `platform_id` (String). The type of virtual machine to create.
- `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `status` (*Read-Only*) (String). The status of this instance.
- `zone` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `boot_disk` [Block]. The boot disk for the instance. Either `initialize_params` or `disk_id` must be specified.
  - `auto_delete` (Bool). Defines whether the disk will be auto-deleted when the instance is deleted. The default value is `True`.
  - `device_name` (String). Name that can be used to access an attached disk.
  - `disk_id` (String). The ID of the existing disk (such as those managed by `yandex_compute_disk`) to attach as a boot disk.
  - `mode` (String). Type of access to the disk resource. By default, a disk is attached in `READ_WRITE` mode.
  - `initialize_params` [Block]. Parameters for a new disk that will be created alongside the new instance. Either `initialize_params` or `disk_id` must be set. Either `image_id` or `snapshot_id` must be specified.
    - `block_size` (Number). Block size of the disk, specified in bytes.
    - `description` (String). Description of the boot disk.
    - `image_id` (String). A disk image to initialize this disk from.
    - `kms_key_id` (String). ID of KMS symmetric key used to encrypt disk.
    - `name` (String). Name of the boot disk.
    - `size` (Number). Size of the disk in GB.
    - `snapshot_id` (String). A snapshot to initialize this disk from.
    - `type` (String). Disk type.
- `filesystem` [Block]. List of filesystems that are attached to the instance.
  - `device_name` (String). Name of the device representing the filesystem on the instance.
  - `filesystem_id` (**Required**)(String). ID of the filesystem that should be attached.
  - `mode` (String). Mode of access to the filesystem that should be attached. By default, filesystem is attached in `READ_WRITE` mode.
- `local_disk` [Block]. List of local disks that are attached to the instance.

    {% note warning %}

    Local disks are not available for all users by default.

    {% endnote %}
  - `device_name` (*Read-Only*) (String). The name of the local disk device.
  - `size_bytes` (**Required**)(Number). Size of the disk, specified in bytes.
- `metadata_options` [Block]. Options allow user to configure access to instance's metadata.
  - `aws_v1_http_endpoint` (Number). 
  - `aws_v1_http_token` (Number). 
  - `gce_http_endpoint` (Number). 
  - `gce_http_token` (Number). 
- `network_interface` [Block]. Networks to attach to the instance. This can be specified multiple times.
  - `index` (Number). Index of network interface, will be calculated automatically for instance create or update operations if not specified. Required for attach/detach operations.
  - `ip_address` (String). The private IP address to assign to the instance. If empty, the address will be automatically assigned from the specified subnet.
  - `ipv4` (Bool). Allocate an IPv4 address for the interface. The default value is `true`.
  - `ipv6` (Bool). If `true`, allocate an IPv6 address for the interface. The address will be automatically assigned from the specified subnet.
  - `ipv6_address` (String). The private IPv6 address to assign to the instance.
  - `mac_address` (*Read-Only*) (String). 
  - `nat` (Bool). Provide a public address, for instance, to access the internet over NAT.
  - `nat_ip_address` (String). Provide a public address, for instance, to access the internet over NAT. Address should be already reserved in web UI.
  - `nat_ip_version` (*Read-Only*) (String). 
  - `security_group_ids` (Set Of String). Security Group (SG) IDs for network interface.
  - `subnet_id` (**Required**)(String). ID of the subnet to attach this interface to. The subnet must exist in the same zone where this instance will be created.
  - `dns_record` [Block]. List of configurations for creating ipv4 DNS records.
    - `dns_zone_id` (String). DNS zone ID (if not set, private zone used).
    - `fqdn` (**Required**)(String). DNS record FQDN (must have a dot at the end).
    - `ptr` (Bool). When set to `true`, also create a PTR DNS record.
    - `ttl` (Number). DNS record TTL in seconds.
  - `ipv6_dns_record` [Block]. List of configurations for creating ipv6 DNS records.
    - `dns_zone_id` (String). DNS zone ID (if not set, private zone used).
    - `fqdn` (**Required**)(String). DNS record FQDN (must have a dot at the end).
    - `ptr` (Bool). When set to `true`, also create a PTR DNS record.
    - `ttl` (Number). DNS record TTL in seconds.
  - `nat_dns_record` [Block]. List of configurations for creating ipv4 NAT DNS records.
    - `dns_zone_id` (String). DNS zone ID (if not set, private zone used).
    - `fqdn` (**Required**)(String). DNS record FQDN (must have a dot at the end).
    - `ptr` (Bool). When set to `true`, also create a PTR DNS record.
    - `ttl` (Number). DNS record TTL in seconds.
- `placement_policy` [Block]. The placement policy configuration.
  - `host_affinity_rules` (List Of Object). List of host affinity rules.

      {% note warning %}

      Due to terraform limitations, simply deleting the `placement_policy` fields does not work. To reset the values of these fields, you need to set them empty:placement_policy {    placement_group_id = ""    host_affinity_rules = []}

      {% endnote %}
    - `key` . 
    - `op` . 
    - `values` . 
  - `placement_group_id` (String). Specifies the id of the Placement Group to assign to the instance.
  - `placement_group_partition` (Number). 
- `resources` [Block]. Compute resources that are allocated for the instance.
  - `core_fraction` (Number). If provided, specifies baseline performance for a core as a percent.
  - `cores` (**Required**)(Number). CPU cores for the instance.
  - `gpus` (Number). If provided, specifies the number of GPU devices for the instance.
  - `memory` (**Required**)(Number). Memory size in GB.
- `scheduling_policy` [Block]. Scheduling policy configuration.
  - `preemptible` (Bool). Specifies if the instance is preemptible. Defaults to `false`.
- `secondary_disk` [Block]. A set of disks to attach to the instance. The structure is documented below.

    {% note warning %}

    The [`allow_stopping_for_update`](#allow_stopping_for_update) property must be set to `true` in order to update this structure.

    {% endnote %}
  - `auto_delete` (Bool). Whether the disk is auto-deleted when the instance is deleted. The default value is `false`.
  - `device_name` (String). Name that can be used to access an attached disk under `/dev/disk/by-id/`.
  - `disk_id` (**Required**)(String). ID of the disk that is attached to the instance.
  - `mode` (String). Type of access to the disk resource. By default, a disk is attached in `READ_WRITE` mode.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_instance.<resource Name> <resource Id>
terraform import yandex_compute_instance.my_vm1 fhmur**********j51ah
```
