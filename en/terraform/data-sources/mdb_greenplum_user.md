---
subcategory: Managed Service for Greenplum®
---

# yandex_mdb_greenplum_user (DataSource)

Get information about a greenplum user.

## Example usage

```terraform
//
// Get information about existing MDB Greenplum database user.
//
data "yandex_mdb_greenplum_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "resource_group" {
  value = data.yandex_mdb_greenplum_user.my_user.resource_group
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the cluster to which user belongs to.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `password` (String). The password of the user.
- `resource_group` (String). The resource group of the user.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


