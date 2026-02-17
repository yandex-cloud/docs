---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_user (DataSource)

Get information about a Yandex Managed MySQL user. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/).

## Example usage

```terraform
//
// Get information about existing MDB MySQL Database User.
//
data "yandex_mdb_mysql_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "permission" {
  value = data.yandex_mdb_mysql_user.foo.permission
}
```

## Arguments & Attributes Reference

- `authentication_plugin` (String). Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH` (for version 5.7 `MYSQL_NATIVE_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH`).
- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `connection_limits` [Block]. User's connection limits. If the attribute is not specified there will be no changes. Default value is `-1`. When these parameters are set to `-1`, backend default values will be actually used.
  - `max_connections_per_hour` (Number). Max connections per hour.
  - `max_questions_per_hour` (Number). Max questions per hour.
  - `max_updates_per_hour` (Number). Max updates per hour.
  - `max_user_connections` (Number). Max user connections.
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `global_permissions` (Set Of String). List user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS`, `FLUSH_OPTIMIZER_COSTS`, `SHOW_ROUTINE`, `MDB_ADMIN` for clear list use empty list. If the attribute is not specified there will be no changes.
- `id` (String). 
- `name` (**Required**)(String). The name of the user.
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
  - `roles` (List Of String). List user's roles in the database. Allowed roles: `ALL`,`ALTER`,`ALTER_ROUTINE`,`CREATE`,`CREATE_ROUTINE`,`CREATE_TEMPORARY_TABLES`, `CREATE_VIEW`,`DELETE`,`DROP`,`EVENT`,`EXECUTE`,`INDEX`,`INSERT`,`LOCK_TABLES`,`SELECT`,`SHOW_VIEW`,`TRIGGER`,`UPDATE`,`REFERENCES`.


