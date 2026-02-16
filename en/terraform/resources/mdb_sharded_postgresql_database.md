---
subcategory: Managed Service for SPQR
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_sharded_postgresql_database.md
---

# yandex_mdb_sharded_postgresql_database (Resource)

Manages a Sharded PostgreSQL database within the Yandex.Cloud

## Example usage

```terraform
//
// Create a new MDB Sharded PostgreSQL Database.
//
resource "yandex_mdb_sharded_postgresql_database" "my_db" {
  cluster_id = yandex_mdb_sharded_postgresql_cluster.my_cluster.id
  name       = "testdb"
}

resource "yandex_mdb_sharded_postgresql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config = {
    sharded_postgresql_config = {
      common = {
        console_password = "P@ssw0rd"
      }
      router = {
        resources = {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 32
        }
      }
    }
  }

  hosts = {
    "router1" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
      assign_public_ip = false
      type = "ROUTER"
    }
  }
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

- `cluster_id` (**Required**)(String). ID of the Sharded PostgreSQL cluster. Provided by the client when the user is created.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). Name of the Sharded PostgreSQL user. Provided by the client when the user is created.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_sharded_postgresql_database.<resource Name> <resource Id>
terraform import yandex_mdb_sharded_postgresql_database.my_db ...
```
