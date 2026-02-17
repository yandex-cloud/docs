---
subcategory: Compute Cloud
---

# yandex_compute_disk (Resource)

Persistent disks are used for data storage and function similarly to physical hard and solid state drives.

A disk can be attached or detached from the virtual machine and can be located locally. A disk can be moved between virtual machines within the same availability zone. Each disk can be attached to only one virtual machine at a time.

For more information about disks in Yandex Cloud, see:
* [Documentation](https://yandex.cloud/docs/compute/concepts/disk)
* How-to Guides:
  * [Attach and detach a disk](https://yandex.cloud/docs/compute/concepts/disk#attach-detach)
  * [Backup operation](https://yandex.cloud/docs/compute/concepts/disk#backup)

{% note warning %}

Only one of `image_id` or `snapshot_id` can be specified.

{% endnote %}


## Example usage

```terraform
//
// Create a new Compute Disk.
//
resource "yandex_compute_disk" "my_disk" {
  name     = "disk-name"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  image_id = "ubuntu-16.04-v20180727"

  labels = {
    environment = "test"
  }
}
```
```terraform
//
// Create a new Compute Disk and put it to the specific Placement Group.
//
resource "yandex_compute_disk" "my_vm" {
  name = "non-replicated-disk-name"
  size = 93 // Non-replicated SSD disk size must be divisible by 93G
  type = "network-ssd-nonreplicated"
  zone = "ru-central1-b"

  disk_placement_policy {
    disk_placement_group_id = yandex_compute_disk_placement_group.my_pg.id
  }
}

resource "yandex_compute_disk_placement_group" "my_pg" {
  zone = "ru-central1-b"
}
```

## Arguments & Attributes Reference

- `allow_recreate` (Bool). 
- `block_size` (Number). Block size of the disk, specified in bytes.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `image_id` (String). The source image to use for disk creation.
- `kms_key_id` (String). ID of KMS symmetric key used to encrypt disk.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `product_ids` (*Read-Only*) (List Of String). 
- `size` (Number). Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the `image_id` or `snapshot_id` parameter, or specify it alone to create an empty persistent disk. If you specify this field along with `image_id` or `snapshot_id`, the size value must not be less than the size of the source image or the size of the snapshot.
- `snapshot_id` (String). The source snapshot to use for disk creation.
- `status` (*Read-Only*) (String). The status of the disk.
- `type` (String). Type of disk to create. Provide this when creating a disk.
- `zone` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `disk_placement_policy` [Block]. Disk placement policy configuration.
  - `disk_placement_group_id` (**Required**)(String). Specifies Disk Placement Group id.
- `hardware_generation` [Block]. Hardware generation and its features, which will be applied to the instance when this disk is used as a boot disk. Provide this property if you wish to override this value, which otherwise is inherited from the source.
  - `generation2_features` [Block]. A newer hardware generation, which always uses `PCI_TOPOLOGY_V2` and UEFI boot.
  - `legacy_features` [Block]. Defines the first known hardware generation and its features.
    - `pci_topology` (String). A variant of PCI topology, one of `PCI_TOPOLOGY_V1` or `PCI_TOPOLOGY_V2`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_disk.<resource Name> <resource Id>
terraform import yandex_compute_disk.my_disk fhmrm**********90r5f
```
