---
subcategory: Managed Service for Greenplum®
---

# yandex_mdb_greenplum_user (Resource)

Manages a Greenplum user within the Yandex Cloud.

## Example usage

```terraform
//
// Create a new MDB Greenplum database user.
//
resource "yandex_mdb_greenplum_user" "my_user" {
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

- `cluster_id` (**Required**)(String). The ID of the cluster to which user belongs to.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `password` (String). The password of the user.
- `resource_group` (String). The resource group of the user.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_greenplum_user.<resource Name> <resource Id>
terraform import yandex_mdb_greenplum_user.my_user ...
```
