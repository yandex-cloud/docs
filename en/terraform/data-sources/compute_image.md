---
subcategory: Compute Cloud
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
- `description` (*Read-Only*) (String). The resource description.
- `family` (String). The name of the image family to which this image belongs.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hardware_generation` (*Read-Only*) (List Of Object). 
  - `generation2_features` . 
  - `legacy_features` . 
    - `pci_topology` . 
- `id` (String). 
- `image_id` (String). The ID of a specific image.
- `kms_key_id` (*Read-Only*) (String). ID of KMS symmetric key used to encrypt image.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `min_disk_size` (*Read-Only*) (Number). Minimum size in GB of the disk that will be created from this image.
- `name` (String). The resource name.
- `os_type` (*Read-Only*) (String). Operating system type that is contained in the image. Possible values: `LINUX`, `WINDOWS`.
- `pooled` (*Read-Only*) (Bool). Optimize the image to create a disk.
- `product_ids` (*Read-Only*) (Set Of String). License IDs that indicate which licenses are attached to this image.
- `size` (*Read-Only*) (Number). The size of the image, specified in GB.
- `status` (*Read-Only*) (String). The status of the image.


