[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for MySQL > Resources > mdb_mysql_user_v2

# yandex_mdb_mysql_user_v2 (Resource)

Manages a MySQL user within the Yandex Cloud. For more information, see [the official documentation](../../managed-mysql/operations/cluster-users.md).

## Example usage

```terraform
resource "yandex_mdb_mysql_user_v2" "john" {
  cluster_id = yandex_mdb_mysql_cluster_v2.my_cluster.id
  name       = "john"
  password   = "Password123!"

  permission {
    database_name = yandex_mdb_mysql_database_v2.testdb.name
    roles         = ["ALL"]
  }

  permission {
    database_name = yandex_mdb_mysql_database_v2.new_testdb.name
    roles         = ["ALL", "INSERT"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions    = ["PROCESS", "REPLICATION_SLAVE"]
  authentication_plugin = "SHA256_PASSWORD"
  deletion_protection_mode = "DELETION_PROTECTION_MODE_DISABLED"
}

resource "yandex_mdb_mysql_cluster_v2" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  hosts = {
    "host1" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
    }
  }
}

resource "yandex_mdb_mysql_database_v2" "testdb" {
  cluster_id = yandex_mdb_mysql_cluster_v2.my_cluster.id
  name       = "testdb"
}

resource "yandex_mdb_mysql_database_v2" "new_testdb" {
  cluster_id = yandex_mdb_mysql_cluster_v2.my_cluster.id
  name       = "new_testdb"
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference
## Arguments & Attributes Reference

- `authentication_plugin` (String). Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH`.
- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `deletion_protection_mode` (String). Deletion Protection inhibits deletion of the user. Possible values: `DELETION_PROTECTION_MODE_DISABLED` (default), `DELETION_PROTECTION_MODE_ENABLED`, `DELETION_PROTECTION_MODE_INHERITED`.
- `generate_password` (Bool). Generate password using Connection Manager. Used only during creation. Default: `false`.
- `global_permissions` (Set Of String). List of the user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS`, `FLUSH_OPTIMIZER_COSTS`, `SHOW_ROUTINE`, `MDB_ADMIN`. For clear list use empty list. If the attribute is not specified there will be no changes.
- `id` (*Read-Only*) (String). The resource identifier in format `<cluster_id>:<user_name>`.
- `name` (**Required**)(String). The name of the user.
- `password` (String, Sensitive). The password of the user.
- `connection_limits` [Block]. User's connection limits. If the attribute is not specified there will be no changes. Default value is `-1`. When these parameters are set to `-1`, backend default values will be actually used.
    - `max_connections_per_hour` (Number). Max connections per hour. Default: `-1`.
    - `max_questions_per_hour` (Number). Max questions per hour. Default: `-1`.
    - `max_updates_per_hour` (Number). Max updates per hour. Default: `-1`.
    - `max_user_connections` (Number). Max user connections. Default: `-1`.
- `permission` [Block]. Set of permissions granted to the user.
    - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
    - `roles` (List Of String). List of user's roles in the database. Allowed roles: `ALL`, `ALTER`, `ALTER_ROUTINE`, `CREATE`, `CREATE_ROUTINE`, `CREATE_TEMPORARY_TABLES`, `CREATE_VIEW`, `DELETE`, `DROP`, `EVENT`, `EXECUTE`, `INDEX`, `INSERT`, `LOCK_TABLES`, `SELECT`, `SHOW_VIEW`, `TRIGGER`, `UPDATE`, `REFERENCES`.
- `timeouts` [Block].
    - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Default: `10m`.
    - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Default: `10m`.
    - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Default: `10m`.

## Import

The resource can be imported by using their `resource ID`. The resource ID format is `<cluster_id>:<user_name>`.

```shell
# terraform import yandex_mdb_mysql_user_v2.<resource_name> <cluster_id>:<user_name>
terraform import yandex_mdb_mysql_user_v2.john ...
```