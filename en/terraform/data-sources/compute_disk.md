---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/compute_disk.md
---

# yandex_compute_disk (DataSource)

Get information about a Yandex Compute disk. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/disk).

{% note warning %}

One of `disk_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Disk.
//
data "yandex_compute_disk" "my_disk" {
  disk_id = "some_disk_id"
}

// You can use "data.yandex_compute_disk.my_disk.id" identifier 
// as reference to the existing resource.
resource "yandex_compute_instance" "default" {
  # ...

  secondary_disk {
    disk_id = data.yandex_compute_disk.my_disk.id
  }
}
```

## Arguments & Attributes Reference

- `block_size` (Number). Block size of the disk, specified in bytes.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `disk_id` (String). The ID of a specific disk.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hardware_generation` [Block]. Hardware generation and its features, which will be applied to the instance when this disk is used as a boot disk. Provide this property if you wish to override this value, which otherwise is inherited from the source.
  - `generation2_features` [Block]. A newer hardware generation, which always uses `PCI_TOPOLOGY_V2` and UEFI boot.
  - `legacy_features` [Block]. Defines the first known hardware generation and its features.
    - `pci_topology` (String). A variant of PCI topology, one of `PCI_TOPOLOGY_V1` or `PCI_TOPOLOGY_V2`.
- `id` (String). 
- `image_id` (String). The source image to use for disk creation.
- `instance_ids` (*Read-Only*) (List Of String). 
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


