---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_database_v2 (Resource)

Manages a MySQL database within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/ru/docs/managed-mysql/operations/databases).

## Example usage

```terraform
resource "yandex_mdb_mysql_database_v2" "my_db" {
  cluster_id = yandex_mdb_mysql_cluster_v2.my_cluster.id
  name       = "testdb"
}

resource "yandex_mdb_mysql_cluster_v2" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  hosts = {
    "host1" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
    }
  }

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

### Example with deletion protection

```terraform
resource "yandex_mdb_mysql_database_v2" "protected_db" {
  cluster_id               = yandex_mdb_mysql_cluster_v2.my_cluster.id
  name                     = "protected_db"
  deletion_protection_mode = "DELETION_PROTECTION_MODE_ENABLED"
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `deletion_protection_mode` (Optional)(String). Deletion Protection inhibits deletion of the database. Possible values: `DELETION_PROTECTION_MODE_DISABLED` (default), `DELETION_PROTECTION_MODE_ENABLED`, `DELETION_PROTECTION_MODE_INHERITED`.
- `id` (*Read-Only*)(String). The resource identifier.
- `name` (**Required**)(String). The name of the database.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mysql_database_v2.<resource Name> <cluster_id>:<database_name>
terraform import yandex_mdb_mysql_database_v2.my_db ...:testdb
```
