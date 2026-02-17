---
subcategory: Managed Service for Greenplum®
---

# yandex_mdb_greenplum_resource_group (Resource)

Manages a Greenplum resource group within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-greenplum/).

## Example usage

```terraform
//
// Create a new MDB Greenplum database resource group.
//
resource "yandex_mdb_greenplum_resource_group" "my_resource_group" {
  cluster_id     = yandex_mdb_greenplum_cluster.my_cluster.id
  name           = "alice"
  password       = "password"
  resource_group = "default_group"
}

resource "yandex_mdb_greenplum_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_greenplum_resource_group.<resource Name> <resource Id>
terraform import yandex_mdb_greenplum_resource_group.my_resource_group ...
```
