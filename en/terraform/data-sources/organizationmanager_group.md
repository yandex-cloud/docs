---
subcategory: Identity Hub
---

# yandex_organizationmanager_group (DataSource)

Get information about a Yandex Cloud Organization Manager Group. For more information, see [the official documentation](https://yandex.cloud/docs/organization/manage-groups).

{% note warning %}

One of `group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing OrganizationManager Group.
//
data "yandex_organizationmanager_group" "group" {
  group_id        = "some_group_id"
  organization_id = "some_organization_id"
}

output "my_group.name" {
  value = data.yandex_organizationmanager_group.group.name
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `group_id` (String). ID of a Group.
- `id` (String). 
- `members` (*Read-Only*) (List Of Object). A list of members of the Group.
  - `id` . 
  - `type` . 
- `name` (String). The resource name.
- `organization_id` (String). Organization that the Group belongs to. If value is omitted, the default provider organization is used.


