---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_user (Resource)

Manages a MySQL user within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/).

## Example usage

```terraform
//
// Create a new MDB MySQL Database User.
//
resource "yandex_mdb_mysql_user" "my_user" {
  cluster_id = yandex_mdb_mysql_cluster.my_cluster.id
  name       = "john"
  password   = "password"

  permission {
    database_name = yandex_mdb_mysql_database.testdb.name
    roles         = ["ALL"]
  }

  permission {
    database_name = yandex_mdb_mysql_database.new_testdb.name
    roles         = ["ALL", "INSERT"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}

resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 14
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  host {
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.foo.id
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

- `authentication_plugin` (String). Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH` (for version 5.7 `MYSQL_NATIVE_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH`).
- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `generate_password` (Bool). Generate password using Connection Manager. Allowed values: `true` or `false`. It's used only during user creation and is ignored during updating.

{% note warning %}

**Must specify either password or generate_password**.

{% endnote %}


- `global_permissions` (Set Of String). List user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS`, `FLUSH_OPTIMIZER_COSTS`, `SHOW_ROUTINE`, `MDB_ADMIN` for clear list use empty list. If the attribute is not specified there will be no changes.
- `id` (String). 
- `name` (**Required**)(String). The name of the user.
- `password` (String). The password of the user.
- `connection_limits` [Block]. User's connection limits. If the attribute is not specified there will be no changes. Default value is `-1`. When these parameters are set to `-1`, backend default values will be actually used.
  - `max_connections_per_hour` (Number). Max connections per hour.
  - `max_questions_per_hour` (Number). Max questions per hour.
  - `max_updates_per_hour` (Number). Max updates per hour.
  - `max_user_connections` (Number). Max user connections.
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
  - `roles` (List Of String). List user's roles in the database. Allowed roles: `ALL`,`ALTER`,`ALTER_ROUTINE`,`CREATE`,`CREATE_ROUTINE`,`CREATE_TEMPORARY_TABLES`, `CREATE_VIEW`,`DELETE`,`DROP`,`EVENT`,`EXECUTE`,`INDEX`,`INSERT`,`LOCK_TABLES`,`SELECT`,`SHOW_VIEW`,`TRIGGER`,`UPDATE`,`REFERENCES`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mysql_user.<resource Name> <resource Id>
terraform import yandex_mdb_mysql_user.my_user ...
```
