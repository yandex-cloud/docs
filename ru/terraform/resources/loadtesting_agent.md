---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/loadtesting_agent.md
---

# yandex_loadtesting_agent (Resource)

A Load Testing Agent resource. For more information, see [the official documentation](https://yandex.cloud/docs/load-testing/concepts/agent).

## Example usage

```terraform
//
// Create a new LoadTesting Agent.
//
resource "yandex_loadtesting_agent" "my-agent" {
  name        = "my-agent"
  description = "2 core 4 GB RAM agent"
  folder_id   = data.yandex_resourcemanager_folder.test_folder.id
  labels = {
    jmeter = "5"
  }

  compute_instance {
    zone_id            = "ru-central1-b"
    service_account_id = yandex_iam_service_account.test_account.id
    resources {
      memory = 4
      cores  = 2
    }
    boot_disk {
      initialize_params {
        size = 15
      }
      auto_delete = true
    }
    network_interface {
      subnet_id = yandex_vpc_subnet.my-subnet-a.id
    }
  }
}
```

## Arguments & Attributes Reference

- `compute_instance_id` (*Read-Only*) (String). Compute Instance ID.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `compute_instance` [Block]. The template for creating new compute instance running load testing agent.
  - `computed_labels` (*Read-Only*) (Map Of String). The set of labels `key:value` pairs assigned to this instance. This includes user custom `labels` and predefined items created by Yandex Cloud Load Testing.
  - `computed_metadata` (*Read-Only*) (Map Of String). The set of metadata `key:value` pairs assigned to this instance. This includes user custom `metadata`, and predefined items created by Yandex Cloud Load Testing.
  - `labels` (Map Of String). A set of key/value label pairs to assign to the instance.
  - `metadata` (Map Of String). A set of metadata key/value pairs to make available from within the instance.
  - `platform_id` (String). The Compute platform for virtual machine.
  - `service_account_id` (**Required**)(String). The ID of the service account authorized for this load testing agent. Service account should have `loadtesting.generatorClient` or `loadtesting.externalAgent` role in the folder.
  - `zone_id` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
  - `boot_disk` [Block]. Boot disk specifications for the instance.
    - `auto_delete` (Bool). Whether the disk is auto-deleted when the instance is deleted. The default value is true.
    - `device_name` (String). This value can be used to reference the device under `/dev/disk/by-id/`.
    - `disk_id` (*Read-Only*) (String). The ID of created disk.
    - `initialize_params` [Block]. Parameters for creating a disk alongside the instance.
      - `block_size` (Number). Block size of the disk, specified in bytes.
      - `description` (String). A description of the boot disk.
      - `name` (String). A name of the boot disk.
      - `size` (Number). The size of the disk in GB. Defaults to 15 GB.
      - `type` (String). The disk type.
  - `network_interface` [Block]. Network specifications for the instance. This can be used multiple times for adding multiple interfaces.
    - `index` (*Read-Only*) (Number). 
    - `ip_address` (String). Manual set static IP address.
    - `ipv4` (Bool). Flag for allocating IPv4 address for the network interface.
    - `ipv6` (Bool). Flag for allocating IPv6 address for the network interface.
    - `ipv6_address` (String). Manual set static IPv6 address.
    - `mac_address` (*Read-Only*) (String). 
    - `nat` (Bool). Flag for using NAT.
    - `nat_ip_address` (String). A public address that can be used to access the internet over NAT.
    - `nat_ip_version` (*Read-Only*) (String). 
    - `security_group_ids` (Set Of String). Security group ids for network interface.
    - `subnet_id` (**Required**)(String). The ID of the subnet to attach this interface to. The subnet must reside in the same zone where this instance was created.
  - `resources` [Block]. Compute resource specifications for the instance.
    - `core_fraction` (Number). If provided, specifies baseline core performance as a percent.
    - `cores` (Number). The number of CPU cores for the instance. Defaults to 2 cores.
    - `memory` (Number). The memory size in GB. Defaults to 2 GB.
- `log_settings` [Block]. The logging settings of the load testing agent.
  - `log_group_id` (String). The ID of cloud logging group to which the load testing agent sends logs.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_loadtesting_agent.<resource Name> <resource Id>
terraform import yandex_loadtesting_agent.my-agent ...
```
