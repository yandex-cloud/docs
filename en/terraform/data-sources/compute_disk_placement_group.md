---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/compute_disk_placement_group.md
---

# yandex_compute_disk_placement_group (DataSource)

Get information about a Yandex Compute Disk Placement group. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/disk#nr-disks).

{% note warning %}

One of `group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Disk Placement Group.
//
data "yandex_compute_disk_placement_group" "my_group" {
  group_id = "some_group_id"
}

output "placement_group_name" {
  value = data.yandex_compute_disk_placement_group.my_group.name
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `group_id` (String). The ID of a specific group.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `status` (*Read-Only*) (String). Status of the Disk Placement Group.
- `zone` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.


