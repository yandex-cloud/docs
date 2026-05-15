---
subcategory: Compute Cloud
---

# yandex_compute_filesystem (Resource)

A filesystem resource.
 For details about the concept, see [documentation](/docs/compute/concepts/filesystem).

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
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_filesystem.<resource Name> <resource Id>
terraform import yandex_compute_filesystem.my_filesystem fhmc7**********ngipq
```
