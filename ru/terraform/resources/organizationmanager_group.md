---
subcategory: Identity Hub
---

# yandex_organizationmanager_group (Resource)

A Group resource.
 For more information, see [Groups](/docs/organization/operations/manage-groups).

## Example usage

```terraform
//
// Create a new OrganizationManager Group.
//
resource "yandex_organizationmanager_group" "my_group" {
  name            = "my-group"
  description     = "My new Group"
  organization_id = "sdf4*********3fr"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the group.
- `group_id` (String). ID of the Group resource to return.
 To get the group ID, use a [GroupService.List] request.
- `id` (String). ID of the Group resource to return.
 To get the group ID, use a [GroupService.List] request.
- `labels` (Map Of String). Resource labels as `key:value` pairs.
- `name` (**Required**)(String). Name of the group.
- `organization_id` (**Required**)(String). ID of the organization that the group belongs to.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_group.<resource Name> <resource Id>
terraform import yandex_organizationmanager_group.my_group ...
```
