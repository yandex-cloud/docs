---
subcategory: Managed Service for PostgreSQL
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_postgresql_user.md
---

# yandex_mdb_postgresql_user (DataSource)

Get information about a Yandex Managed PostgreSQL user. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/).

## Example usage

```terraform
//
// Get information about existing MDB PostgreSQL database User.
//
data "yandex_mdb_postgresql_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "permission" {
  value = data.yandex_mdb_postgresql_user.my_user.permission
}
```

## Arguments & Attributes Reference

- `auth_method` (String). Authentication method for the user. Possible values are `AUTH_METHOD_PASSWORD`, `AUTH_METHOD_IAM`. Default is `AUTH_METHOD_PASSWORD`.
- `cluster_id` (**Required**)(String). The ID of the PostgreSQL cluster.
- `conn_limit` (Number). The maximum number of connections per user. (Default 50).
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `deletion_protection` (String). The `true` value means that resource is protected from accidental deletion.
- `grants` (List Of String). List of the user's grants.
- `id` (String). 
- `login` (Bool). User's ability to login.
- `name` (**Required**)(String). The name of the PostgreSQL user.
- `password` (String). The password of the user.
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
- `settings` (Map Of String). Map of user settings. [Full description](https://yandex.cloud/docs/managed-postgresql/api-ref/grpc/Cluster/create#yandex.cloud.mdb.postgresql.v1.UserSettings).  - `default_transaction_isolation` - defines the default isolation level to be set for all new SQL transactions. One of:    - `read uncommitted`    - `read committed`    - `repeatable read`    - `serializable`  - `lock_timeout` - The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object (default 0)  - `log_min_duration_statement` - This setting controls logging of the duration of statements. (default -1 disables logging of the duration of statements.)  - `synchronous_commit` - This setting defines whether DBMS will commit transaction in a synchronous way. One of:    - `on`    - `off`    - `local`    - `remote write`    - `remote apply`  - `temp_file_limit` - The maximum storage space size (in kilobytes) that a single process can use to create temporary files.  - `log_statement` - This setting specifies which SQL statements should be logged (on the user level). One of:    - `none`    - `ddl`    - `mod`    - `all`  - `pool_mode` - Mode that the connection pooler is working in with specified user. One of:    - `session`    - `transaction`    - `statement`  - `prepared_statements_pooling` - This setting allows user to use prepared statements with transaction pooling. Boolean.  - `catchup_timeout` - The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. Default value is 0, which disables this feature. Integer.  - `wal_sender_timeout` - The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+). Terminate replication connections that are inactive for longer than this amount of time. Integer.  - `idle_in_transaction_session_timeout` - Sets the maximum allowed idle time (in milliseconds) between queries, when in a transaction. Value of 0 (default) disables the timeout. Integer.  - `statement_timeout` - The maximum time (in milliseconds) to wait for statement. Value of 0 (default) disables the timeout. Integer.  - `pgaudit` - Settings of the PostgreSQL Audit Extension (pgaudit). [Full description](https://yandex.cloud/ru/docs/managed-postgresql/api-ref/grpc/Cluster/create#yandex.cloud.mdb.postgresql.v1.PGAuditSettings). String (json with with escaped quotes). Example `"{\"log\": [\"READ\", \"WRITE\"]}"`
- `user_password_encryption` (String). Password-based authentication method for user.Possible values are `USER_PASSWORD_ENCRYPTION_MD5` or `USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256`.The default is password_encryption setting for cluster.


