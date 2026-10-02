[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for Greenplum® > Resources > mdb_greenplum_resource_group

# yandex_mdb_greenplum_resource_group (Resource)

Manages a Greenplum or Apache Cloudberry resource group within the Yandex Cloud. For more information, see [the official documentation](../../managed-greenplum/index.md).

## Example usage

```terraform
// Create a resource group in an existing Apache Cloudberry cluster.
resource "yandex_mdb_greenplum_resource_group" "analytics" {
  cluster_id      = "<cloudberry-cluster-id>"
  name            = "analytics"
  concurrency     = 10
  cpu_max_percent = 80
  cpu_weight      = 100
  memory_quota    = 1024
  min_cost        = 100
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the cluster to which resource group belongs to.
- `concurrency` (Number). The maximum number of concurrent transactions, including active and idle transactions, that are permitted in the resource group.
- `cpu_max_percent` (Number). Apache Cloudberry: the maximum percentage of CPU resources the group can use.
- `cpu_rate_limit` (Number). The percentage of CPU resources available to this resource group.
- `cpu_weight` (Number). Apache Cloudberry: the scheduling priority of the resource group.
- `id` (*Read-Only*) (String). The resource identifier.
- `is_user_defined` (*Read-Only*) (Bool). If false, the resource group is immutable and controlled by yandex
- `memory_limit` (Number). The percentage of reserved memory resources available to this resource group.
- `memory_quota` (Number). Apache Cloudberry: the memory limit in MB for the resource group.
- `memory_shared_quota` (Number). The percentage of reserved memory to share across transactions submitted in this resource group.
- `memory_spill_ratio` (Number). The memory usage threshold for memory-intensive transactions. When a transaction reaches this threshold, it spills to disk.
- `min_cost` (Number). Apache Cloudberry: the minimum cost of a query plan to be included in the resource group.
- `name` (**Required**)(String). The name of the resource group.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_mdb_greenplum_resource_group.<resource Name> <resource Id>
terraform import yandex_mdb_greenplum_resource_group.my_resource_group ...
```