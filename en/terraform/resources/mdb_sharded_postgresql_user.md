---
subcategory: Managed Service for SPQR
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_sharded_postgresql_user.md
---

# yandex_mdb_sharded_postgresql_user (Resource)

Manages a Sharded PostgreSQL user within the Yandex.Cloud

## Example usage

```terraform
//
// Create a new MDB Sharded PostgreSQL database User.
//
resource "yandex_mdb_sharded_postgresql_user" "my_user" {
  cluster_id = yandex_mdb_sharded_postgresql_cluster.my_user.id
  name       = "alice"
  password   = "password"
  settings = {
    connection_limit = 300
    connection_retries = 5
  }
}

resource "yandex_mdb_sharded_postgresql_cluster" "default" {
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
- `grants` (Set Of String). 
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). Name of the Sharded PostgreSQL user. Provided by the client when the user is created.
- `password` (String). Password of the Sharded PostgreSQL user. Provided by the client when the user is created.
- `settings` (Map Of String). 
- `permissions` [Block]. Block represents databases that are permitted to user.
  - `database` (**Required**)(String). Name of the database that the permission grants access to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_sharded_postgresql_user.<resource Name> <resource Id>
terraform import yandex_mdb_sharded_postgresql_user.my_user ...
```
