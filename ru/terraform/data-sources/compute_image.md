---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/compute_image.md
---

# yandex_compute_image (DataSource)

Get information about a Yandex Compute image. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/image).

{% note warning %}

Either `image_id`, `family` or `name` must be specified.

{% endnote %}


{% note warning %}

If you specify `family` without `folder_id` then lookup takes place in the 'standard-images' folder.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Image
//
data "yandex_compute_image" "my_image" {
  family = "ubuntu-1804-lts"
}

// You can use "data.yandex_compute_image.my_image.id" identifier 
// as reference to existing resource.
resource "yandex_compute_instance" "default" {
  # ...
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }
  # ...
  lifecycle {
    ignore_changes = [boot_disk[0].initialize_params[0].image_id]
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `family` (String). The name of the image family to which this image belongs.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hardware_generation` [Block]. Hardware generation and its features, which will be applied to the instance when this image is used for creating a boot disk. Provide this property if you wish to override this value, which otherwise is inherited from the source.
  - `generation2_features` [Block]. A newer hardware generation, which always uses `PCI_TOPOLOGY_V2` and UEFI boot.
  - `legacy_features` [Block]. Defines the first known hardware generation and its features.
    - `pci_topology` (String). A variant of PCI topology, one of `PCI_TOPOLOGY_V1` or `PCI_TOPOLOGY_V2`.
- `id` (String). 
- `image_id` (String). The ID of a specific image.
- `kms_key_id` (*Read-Only*) (String). ID of KMS symmetric key used to encrypt image.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `min_disk_size` (Number). Minimum size in GB of the disk that will be created from this image.
- `name` (String). The resource name.
- `os_type` (String). Operating system type that is contained in the image. Possible values: `LINUX`, `WINDOWS`.
- `pooled` (Bool). Optimize the image to create a disk.
- `product_ids` (Set Of String). License IDs that indicate which licenses are attached to this image.
- `size` (*Read-Only*) (Number). The size of the image, specified in GB.
- `status` (*Read-Only*) (String). The status of the image.


