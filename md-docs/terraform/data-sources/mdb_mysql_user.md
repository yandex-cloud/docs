[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for MySQL > Data Sources > mdb_mysql_user

# yandex_mdb_mysql_user (DataSource)

Get information about a Yandex Managed MySQL user. For more information, see [the official documentation](../../managed-mysql/index.md).

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

- `authentication_plugin` (*Read-Only*) (String). Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH` (for version 5.7 `MYSQL_NATIVE_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH`).
- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `connection_limits` (*Read-Only*) (List Of Object). 
  - `max_connections_per_hour` . 
  - `max_questions_per_hour` . 
  - `max_updates_per_hour` . 
  - `max_user_connections` . 
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `global_permissions` (*Read-Only*) (Set Of String). List user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS`, `FLUSH_OPTIMIZER_COSTS`, `SHOW_ROUTINE`, `MDB_ADMIN` for clear list use empty list. If the attribute is not specified there will be no changes.
- `id` (String). 
- `name` (**Required**)(String). The name of the MySQL user.
- `permission` [Block]. 
  - `database_name` (*Read-Only*) (String). 
  - `roles` (List Of String).