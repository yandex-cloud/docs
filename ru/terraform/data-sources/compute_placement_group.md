---
subcategory: Compute Cloud
---

# yandex_compute_placement_group (DataSource)

Get information about a Yandex Compute Placement group. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/placement-groups).

{% note warning %}

One of `group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Placement Group
//
data "yandex_compute_placement_group" "my_group" {
  group_id = "some_group_id"
}

output "placement_group_name" {
  value = data.yandex_compute_placement_group.my_group.name
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
- `placement_strategy` (Map Of String). Placement strategy set for group.


