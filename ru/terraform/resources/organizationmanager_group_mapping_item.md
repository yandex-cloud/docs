---
subcategory: Identity Hub
---

# yandex_organizationmanager_group_mapping_item (Resource)

Allows management of [Yandex Cloud Organization Manager Group Mapping Items](https://yandex.cloud/docs/organization/concepts/add-federation#group-mapping)

 ~> Group mapping items depends on [group mapping](organizationmanager_group_mapping.html). If you create group mapping via terraform use `depends_on` meta-argument to avoid errors (see example below)
.

## Example usage

```terraform
//
// Create a new OrganizationManager Group Mapping Item.
//
resource "yandex_organizationmanager_group_mapping_item" "group_mapping_item" {
  federation_id     = "my-federation_id"
  internal_group_id = "my_internal_group_id"
  external_group_id = "my_external_group_id"

  depends_on = [yandex_organizationmanager_group_mapping.group_mapping]
}
```

## Arguments & Attributes Reference

- `external_group_id` (**Required**)(String). ID of the external group
- `federation_id` (**Required**)(String). ID of the SAML Federation
- `id` (String). 
- `internal_group_id` (**Required**)(String). ID of the internal group

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_group_mapping_item.<resource Name> <resource Id>
terraform import yandex_organizationmanager_group_mapping_item.group_mapping_item .../.../...
```
