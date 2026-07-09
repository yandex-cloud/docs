[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for MySQL > Data Sources > mdb_mysql_user_v2

# yandex_mdb_mysql_user_v2 (DataSource)

Get information about a Yandex Managed MySQL user.


## Arguments & Attributes Reference

- `authentication_plugin` (String). Authentication plugin.
- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `deletion_protection_mode` (String). Deletion Protection inhibits deletion of the user.
- `generate_password` (Bool). Generate password using Connection Manager. Used only during creation.
- `global_permissions` (Set Of String). List of the user's global permissions.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `password` (String). The password of the user.
- `timeouts` [Block]. 
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
- `connection_limits` [Block]. User's connection limits.
  - `max_connections_per_hour` (Number). Max connections per hour.
  - `max_questions_per_hour` (Number). Max questions per hour.
  - `max_updates_per_hour` (Number). Max updates per hour.
  - `max_user_connections` (Number). Max user connections.
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database.
  - `roles` (List Of String). List of roles.