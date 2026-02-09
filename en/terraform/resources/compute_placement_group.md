---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/compute_placement_group.md
---

# yandex_compute_placement_group (Resource)

A Placement group resource. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/placement-groups).

## Example usage

```terraform
//
// Create a new Compute Placement Group.
//
resource "yandex_compute_placement_group" "group1" {
  name        = "test-pg"
  folder_id   = "abc*********123"
  description = "my description"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `placement_strategy_partitions` (Number). A number of partitions in the placement strategy with partitions policy of the Placement Group (conflicts with placement_strategy_spread).
- `placement_strategy_spread` (Bool). A placement strategy with spread policy of the Placement Group. Should be true or unset (conflicts with placement_strategy_partitions).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_placement_group.<resource Name> <resource Id>
terraform import yandex_compute_placement_group.my_pg1 ...
```
