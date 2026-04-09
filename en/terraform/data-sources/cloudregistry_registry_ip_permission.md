---
subcategory: Cloud Registry
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
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


