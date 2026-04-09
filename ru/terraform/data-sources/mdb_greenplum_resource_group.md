---
subcategory: Managed Service for Greenplum®
---

# yandex_mdb_greenplum_resource_group (DataSource)

Get information about a greenplum resource group.

## Example usage

```terraform
//
// Get information about existing MDB Greenplum database resource group.
//
data "yandex_mdb_greenplum_resource_group" "my_resource_group" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "concurrency" {
  value = data.yandex_mdb_greenplum_resource_group.my_resource_group.concurrency
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the cluster to which resource group belongs to.
- `concurrency` (Number). The maximum number of concurrent transactions, including active and idle transactions, that are permitted in the resource group.
- `cpu_rate_limit` (Number). The percentage of CPU resources available to this resource group.
- `id` (*Read-Only*) (String). The resource identifier.
- `is_user_defined` (*Read-Only*) (Bool). If false, the resource group is immutable and controlled by yandex
- `memory_limit` (Number). The percentage of reserved memory resources available to this resource group.
- `memory_shared_quota` (Number). The percentage of reserved memory to share across transactions submitted in this resource group.
- `memory_spill_ratio` (Number). The memory usage threshold for memory-intensive transactions. When a transaction reaches this threshold, it spills to disk.
- `name` (**Required**)(String). The name of the resource group.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


