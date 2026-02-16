---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/compute_filesystem.md
---

# yandex_compute_filesystem (DataSource)

Get information about a Yandex Compute filesystem. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/filesystem).

{% note warning %}

One of `filesystem_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Filesystem.
//
data "yandex_compute_filesystem" "my_fs" {
  filesystem_id = "some_fs_id"
}

// You can use "data.yandex_compute_filesystem.my_fs.id" identifier 
// as reference to the existing resource.
resource "yandex_compute_instance" "default" {
  # ...

  filesystem {
    filesystem_id = data.yandex_compute_filesystem.my_fs.id
  }
}
```

## Arguments & Attributes Reference

- `block_size` (*Read-Only*) (Number). Block size of the filesystem, specified in bytes.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `filesystem_id` (String). ID of the filesystem.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `size` (*Read-Only*) (Number). Size of the filesystem, specified in GB.
- `status` (*Read-Only*) (String). The status of the filesystem.
- `type` (*Read-Only*) (String). Type of filesystem to create. Type `network-hdd` is set by default.
- `zone` (*Read-Only*) (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.


