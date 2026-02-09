---
subcategory: Managed Service for Greenplum®
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_greenplum_resource_group.md
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


