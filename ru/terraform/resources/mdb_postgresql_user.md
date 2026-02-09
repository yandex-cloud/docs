---
subcategory: Managed Service for PostgreSQL
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_postgresql_user.md
---

# yandex_mdb_postgresql_user (Resource)

Manages a PostgreSQL user within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/).

## Example usage

```terraform
//
// Create a new MDB PostgreSQL database User.
//
resource "yandex_mdb_postgresql_user" "my_user" {
  cluster_id = yandex_mdb_postgresql_cluster.my_cluster.id
  name       = "alice"
  password   = "password"
  conn_limit = 50
  settings = {
    default_transaction_isolation = "read committed"
    log_min_duration_statement    = 5000
  }
}

resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 15
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

- `auth_method` (String). Authentication method for the user. Possible values are `AUTH_METHOD_PASSWORD`, `AUTH_METHOD_IAM`. Default is `AUTH_METHOD_PASSWORD`.
- `cluster_id` (**Required**)(String). The ID of the PostgreSQL cluster.
- `conn_limit` (Number). The maximum number of connections per user. (Default 50).
- `connection_manager` (*Read-Only*) (Map Of String). Connection Manager connection configuration. Filled in by the server automatically.
- `deletion_protection` (String). The `true` value means that resource is protected from accidental deletion.
- `generate_password` (Bool). Generate password using Connection Manager. Allowed values: true or false. It's used only during user creation and is ignored during updating.

    {% note warning %}

    **Must specify either password or generate_password**.

    {% endnote %}
- `grants` (List Of String). List of the user's grants.
- `id` (String). 
- `login` (Bool). User's ability to login.
- `name` (**Required**)(String). The name of the PostgreSQL user.
- `password` (String). The password of the user.
- `settings` (Map Of String). Map of user settings. [Full description](https://yandex.cloud/docs/managed-postgresql/api-ref/grpc/Cluster/create#yandex.cloud.mdb.postgresql.v1.UserSettings).  - `default_transaction_isolation` - defines the default isolation level to be set for all new SQL transactions. One of:    - `read uncommitted`    - `read committed`    - `repeatable read`    - `serializable`  - `lock_timeout` - The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object (default 0)  - `log_min_duration_statement` - This setting controls logging of the duration of statements. (default -1 disables logging of the duration of statements.)  - `synchronous_commit` - This setting defines whether DBMS will commit transaction in a synchronous way. One of:    - `on`    - `off`    - `local`    - `remote write`    - `remote apply`  - `temp_file_limit` - The maximum storage space size (in kilobytes) that a single process can use to create temporary files.  - `log_statement` - This setting specifies which SQL statements should be logged (on the user level). One of:    - `none`    - `ddl`    - `mod`    - `all`  - `pool_mode` - Mode that the connection pooler is working in with specified user. One of:    - `session`    - `transaction`    - `statement`  - `prepared_statements_pooling` - This setting allows user to use prepared statements with transaction pooling. Boolean.  - `catchup_timeout` - The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. Default value is 0, which disables this feature. Integer.  - `wal_sender_timeout` - The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+). Terminate replication connections that are inactive for longer than this amount of time. Integer.  - `idle_in_transaction_session_timeout` - Sets the maximum allowed idle time (in milliseconds) between queries, when in a transaction. Value of 0 (default) disables the timeout. Integer.  - `statement_timeout` - The maximum time (in milliseconds) to wait for statement. Value of 0 (default) disables the timeout. Integer.  - `pgaudit` - Settings of the PostgreSQL Audit Extension (pgaudit). [Full description](https://yandex.cloud/ru/docs/managed-postgresql/api-ref/grpc/Cluster/create#yandex.cloud.mdb.postgresql.v1.PGAuditSettings). String (json with with escaped quotes). Example `"{\"log\": [\"READ\", \"WRITE\"]}"`
- `user_password_encryption` (String). Password-based authentication method for user.Possible values are `USER_PASSWORD_ENCRYPTION_MD5` or `USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256`.The default is password_encryption setting for cluster.
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database that the permission grants access to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_postgresql_user.<resource Name> <resource Id>
terraform import yandex_mdb_postgresql_user.my_user ...
```
