---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_group_mapping.md
---

# yandex_organizationmanager_group_mapping (Resource)

Allows management of [Yandex Cloud Organization Manager Group Mapping](https://yandex.cloud/docs/organization/concepts/add-federation#group-mapping). It supports the creation, updating(enabling/disabling), and deletion of group mapping.

## Example usage

```terraform
//
// Create a new OrganizationManager Group Mapping.
//
resource "yandex_organizationmanager_group_mapping" "my_group_map" {
  federation_id = "my-federation-id"
  enabled       = true
}
```

## Arguments & Attributes Reference

- `enabled` (Bool). Set "true" to enable organization manager group mapping.
- `federation_id` (**Required**)(String). ID of the SAML Federation.
- `id` (String).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_group_mapping.<resource Name> <resource Id>
terraform import yandex_organizationmanager_group.my_group_map ...
```
