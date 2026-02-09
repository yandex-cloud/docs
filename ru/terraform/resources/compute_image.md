---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/compute_image.md
---

# yandex_compute_image (Resource)

Creates a virtual machine image resource for the Yandex Compute Cloud service from an existing tarball. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/image).

{% note warning %}

One of `source_family`, `source_image`, `source_snapshot`, `source_disk` or `source_url` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Create a new Compute Image.
//
resource "yandex_compute_image" "foo-image" {
  name       = "my-custom-image"
  source_url = "https://storage.yandexcloud.net/lucky-images/kube-it.img"
}

// You can use "data.yandex_compute_image.my_image.id" identifier 
// as reference to existing resource.
resource "yandex_compute_instance" "vm" {
  name = "vm-from-custom-image"

  # ...

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.foo-image.id
    }
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `family` (String). The name of the image family to which this image belongs.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `min_disk_size` (Number). Minimum size in GB of the disk that will be created from this image.
- `name` (String). The resource name.
- `os_type` (String). Operating system type that is contained in the image. Possible values: `LINUX`, `WINDOWS`.
- `pooled` (Bool). Optimize the image to create a disk.
- `product_ids` (Set Of String). License IDs that indicate which licenses are attached to this image.
- `size` (*Read-Only*) (Number). The size of the image, specified in GB.
- `source_disk` (String). The ID of a disk to use as the source of the image. Changing this ID forces a new resource to be created.
- `source_family` (String). The name of the family to use as the source of the new image. The ID of the latest image is taken from the `standard-images` folder. Changing the family forces a new resource to be created.
- `source_image` (String). The ID of an existing image to use as the source of the image. Changing this ID forces a new resource to be created.
- `source_snapshot` (String). The ID of a snapshot to use as the source of the image. Changing this ID forces a new resource to be created.
- `source_url` (String). The URL to use as the source of the image. Changing this URL forces a new resource to be created.
- `status` (*Read-Only*) (String). The status of the image.
- `hardware_generation` [Block]. Hardware generation and its features, which will be applied to the instance when this image is used for creating a boot disk. Provide this property if you wish to override this value, which otherwise is inherited from the source.
  - `generation2_features` [Block]. A newer hardware generation, which always uses `PCI_TOPOLOGY_V2` and UEFI boot.
  - `legacy_features` [Block]. Defines the first known hardware generation and its features.
    - `pci_topology` (String). A variant of PCI topology, one of `PCI_TOPOLOGY_V1` or `PCI_TOPOLOGY_V2`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_image.<resource Name> <resource Id>
terraform import yandex_compute_image.my_image fd8go**********trjsd
```
