[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Compute Cloud > Data Sources > compute_disk

# yandex_compute_disk (DataSource)

Get information about a Yandex Compute disk. For more information, see [the official documentation](../../compute/concepts/disk.md).

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

- `block_size` (*Read-Only*) (Number). Block size of the disk, specified in bytes.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `disk_id` (String). The ID of a specific disk.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hardware_generation` (*Read-Only*) (List Of Object). 
  - `generation2_features` . 
  - `legacy_features` . 
    - `pci_topology` . 
- `id` (String). 
- `image_id` (*Read-Only*) (String). The source image to use for disk creation.
- `instance_ids` (*Read-Only*) (List Of String). 
- `kms_key_id` (*Read-Only*) (String). ID of KMS symmetric key used to encrypt disk.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `product_ids` (*Read-Only*) (List Of String). 
- `size` (*Read-Only*) (Number). Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the `image_id` or `snapshot_id` parameter, or specify it alone to create an empty persistent disk. If you specify this field along with `image_id` or `snapshot_id`, the size value must not be less than the size of the source image or the size of the snapshot.
- `snapshot_id` (*Read-Only*) (String). The source snapshot to use for disk creation.
- `status` (*Read-Only*) (String). The status of the disk.
- `type` (*Read-Only*) (String). Type of disk to create. Provide this when creating a disk.
- `zone` (*Read-Only*) (String). The [availability zone](../../overview/concepts/geo-scope.md) where resource is located. If it is not provided, the default provider zone will be used.
- `disk_placement_policy` [Block]. 
  - `disk_placement_group_id` (**Required**)(String).