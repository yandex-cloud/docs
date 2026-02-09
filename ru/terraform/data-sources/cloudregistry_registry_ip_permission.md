---
subcategory: Cloud Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/cloudregistry_registry_ip_permission.md
---

# yandex_cloudregistry_registry_ip_permission (DataSource)

Creates a new Cloud Registry IP Permission. For more information, see [the official documentation](https://yandex.cloud/docs/cloud-registry/operations/registry/registry-access)

## Example usage

```terraform
//
// Get information about existing IP Permission of specific Cloud Registry.
//
data "yandex_cloudregistry_registry_ip_permission" "my_ip_permission_by_registry_id" {
  registry_id = yandex_cloudregistry_registry.my_registry.id
}
```

## Arguments & Attributes Reference

- `id` (*Read-Only*) (String). The ID of IP permission.
- `pull` (Set Of String). List of configured CIDRs from which `pull` operations are allowed.
- `push` (Set Of String). List of configured CIDRs from which `push` operations are allowed.
- `registry_id` (**Required**)(String). The ID of the registry that IP restrictions are applied to.
- `registry_name` (String). The name of the registry that IP restrictions are applied to.


