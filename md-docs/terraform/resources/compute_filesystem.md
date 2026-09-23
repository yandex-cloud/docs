[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Compute Cloud > Resources > compute_filesystem

# yandex_compute_filesystem (Resource)

A filesystem resource.
 For details about the concept, see [documentation](../../compute/concepts/filesystem.md).

## Example usage

```terraform
//
// Create a new Compute Filesystem.
//
resource "yandex_compute_filesystem" "default" {
  name = "fs-name"
  type = "network-ssd"
  zone = "ru-central1-a"
  size = 10

  labels = {
    environment = "test"
  }
}
```

## Arguments & Attributes Reference

- `block_size` (Number). Block size used for the filesystem, specified in bytes.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the filesystem.
- `filesystem_id` (String). ID of the filesystem to return.
 To get the filesystem ID, make a [FilesystemService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `folder_id` (String). ID of the folder that the filesystem belongs to.
- `id` (String). ID of the filesystem to return.
 To get the filesystem ID, make a [FilesystemService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `labels` (Map Of String). Filesystem labels as `key:value` pairs.
 For details about the concept, see [documentation](../../overview/concepts/services.md#labels).
- `name` (String). Name of the filesystem. The name is unique within the folder.
- `size` (Number). Size of the filesystem, specified in bytes.
- `status` (*Read-Only*) (String). Current status of the filesystem.
- `type` (String). ID of the filesystem type.
 To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List] request.
- `zone` (String). ID of the availability zone where the filesystem resides.
 A filesystem can be attached only to instances residing in the same availability zone.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_compute_filesystem.<resource Name> <resource Id>
terraform import yandex_compute_filesystem.my_filesystem fhmc7**********ngipq
```