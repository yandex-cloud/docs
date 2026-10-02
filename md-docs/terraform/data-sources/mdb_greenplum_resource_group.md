[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for Greenplum® > Data Sources > mdb_greenplum_resource_group

# yandex_mdb_greenplum_resource_group (DataSource)

Get information about a Greenplum or Apache Cloudberry resource group.

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
- `concurrency` (*Read-Only*) (Number). 
- `cpu_max_percent` (*Read-Only*) (Number). Apache Cloudberry: the maximum percentage of CPU resources the group can use.
- `cpu_rate_limit` (*Read-Only*) (Number). 
- `cpu_weight` (*Read-Only*) (Number). Apache Cloudberry: the scheduling priority of the resource group.
- `id` (*Read-Only*) (String). The resource identifier.
- `is_user_defined` (*Read-Only*) (Bool). If false, the resource group is immutable and controlled by yandex
- `memory_limit` (*Read-Only*) (Number). 
- `memory_quota` (*Read-Only*) (Number). Apache Cloudberry: the memory limit in MB for the resource group.
- `memory_shared_quota` (*Read-Only*) (Number). 
- `memory_spill_ratio` (*Read-Only*) (Number). 
- `min_cost` (*Read-Only*) (Number). Apache Cloudberry: the minimum cost of a query plan to be included in the resource group.
- `name` (**Required**)(String). The name of the resource group.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).