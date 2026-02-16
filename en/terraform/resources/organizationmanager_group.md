---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_group.md
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

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `group_id` (String). ID of a Group.
- `id` (String). 
- `name` (String). The resource name.
- `organization_id` (String). Organization that the Group belongs to. If value is omitted, the default provider organization is used.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_group.<resource Name> <resource Id>
terraform import yandex_organizationmanager_group.my_group ...
```
