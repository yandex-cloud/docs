---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/compute_disk_placement_group.md
---

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

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `disk_placement_group_id` (String). ID of the placement group to return. To get the placement group ID, use [DiskPlacementGroupService.List] request.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `status` (*Read-Only*) (String). Status of the Disk Placement Group.
- `zone` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_disk_placement_group.<resource Name> <resource Id>
terraform import yandex_compute_disk_placement_group.my_disk_group ...
```
