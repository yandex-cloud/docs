---
subcategory: Identity Hub
---

# yandex_organizationmanager_group_membership (Resource)

Allows members management of a single Yandex Cloud Organization Manager Group. For more information, see [the official documentation](https://yandex.cloud/docs/organization/manage-groups#add-member).

{% note warning %}

Multiple `yandex_organizationmanager_group_iam_binding` resources with the same group id will produce inconsistent behavior!

{% endnote %}


## Example usage

```terraform
//
// Create a new OrganizationManager Group Membership.
//
resource "yandex_organizationmanager_group_membership" "group" {
  group_id = "sdf4*********3fr"
  members = [
    "xdf********123"
  ]
}
```

## Arguments & Attributes Reference

- `group_id` (**Required**)(String). The Group to add/remove members to/from.
- `id` (String). 
- `members` (**Required**)(Set Of String). A set of members of the Group. Each member is represented by an id.


