[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Compute Cloud > Resources > compute_disk_placement_group

# yandex_compute_disk_placement_group (Resource)



## Example usage

```terraform
//
// Create a new Disk Placement Group
//
resource "yandex_compute_disk_placement_group" "group1" {
  name        = "test-pg"
  folder_id   = "abc*********123"
  description = "my description"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Description of the placement group.
- `disk_placement_group_id` (String). ID of the placement group to return.
 To get the placement group ID, use [DiskPlacementGroupService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `folder_id` (String). ID of the folder that the placement group belongs to.
- `id` (String). ID of the placement group to return.
 To get the placement group ID, use [DiskPlacementGroupService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `labels` (Map Of String). Resource labels as `key:value` pairs.
- `name` (String). Name of the placement group.
 The name is unique within the folder.
- `status` (*Read-Only*) (String). Current status of the placement group
- `zone` (String). ID of the availability zone where the placement group resides.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_compute_disk_placement_group.<resource Name> <resource Id>
terraform import yandex_compute_disk_placement_group.my_disk_group ...
```