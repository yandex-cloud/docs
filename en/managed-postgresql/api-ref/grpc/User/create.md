---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/User/create.md
---

# Managed Service for PostgreSQL API, gRPC: UserService.Create

Creates a PostgreSQL user in the specified cluster.

## gRPC request

**rpc Create ([CreateUserRequest](#yandex.cloud.mdb.postgresql.v1.CreateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateUserRequest {#yandex.cloud.mdb.postgresql.v1.CreateUserRequest}

```json
{
  "cluster_id": "string",
  "user_spec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "database_name": "string"
      }
    ],
    "conn_limit": "google.protobuf.Int64Value",
    "settings": {
      "default_transaction_isolation": "TransactionIsolation",
      "lock_timeout": "google.protobuf.Int64Value",
      "log_min_duration_statement": "google.protobuf.Int64Value",
      "synchronous_commit": "SynchronousCommit",
      "temp_file_limit": "google.protobuf.Int64Value",
      "log_statement": "LogStatement",
      "pool_mode": "PoolingMode",
      "prepared_statements_pooling": "google.protobuf.BoolValue",
      "catchup_timeout": "google.protobuf.Int64Value",
      "wal_sender_timeout": "google.protobuf.Int64Value",
      "idle_in_transaction_session_timeout": "google.protobuf.Int64Value",
      "statement_timeout": "google.protobuf.Int64Value",
      "pgaudit": {
        "log": [
          "PGAuditSettingsLog"
        ]
      }
    },
    "login": "google.protobuf.BoolValue",
    "grants": [
      "string"
    ],
    "deletion_protection": "google.protobuf.BoolValue",
    "user_password_encryption": "UserPasswordEncryption",
    "generate_password": "google.protobuf.BoolValue",
    "auth_method": "AuthMethod"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| user_spec | **[UserSpec](#yandex.cloud.mdb.postgresql.v1.UserSpec)**

Required field. Properties of the user to be created. ||
|#

## UserSpec {#yandex.cloud.mdb.postgresql.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the PostgreSQL user. ||
|| password | **string**

Required field. Password of the PostgreSQL user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.postgresql.v1.Permission)**

Set of permissions to grant to the user to access specific databases. ||
|| conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of database connections that should be available to the user.

When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.max_connections.proto) setting.

When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting.

Minimum value: `10` (default: `50`), when used in session pooling. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.postgresql.v1.UserSettings)**

PostgreSQL settings for the user. ||
|| login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

This flag defines whether the user can login to a PostgreSQL database.

Default value: `true` (login is allowed). ||
|| grants[] | **string**

A set of roles and privileges that are granted to the user.

For more information, see [the documentation](/docs/managed-postgresql/operations/grant). ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the user

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|| user_password_encryption | enum **UserPasswordEncryption**

Password-based authentication method for user.
Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.
The default is `` password_encryption `` setting for cluster.

- `USER_PASSWORD_ENCRYPTION_UNSPECIFIED`
- `USER_PASSWORD_ENCRYPTION_MD5`
- `USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| generate_password | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Generate password using Connection Manager. ||
|| auth_method | enum **AuthMethod**

Auth method for user

- `AUTH_METHOD_UNSPECIFIED`
- `AUTH_METHOD_PASSWORD`
- `AUTH_METHOD_IAM` ||
|#

## Permission {#yandex.cloud.mdb.postgresql.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.postgresql.v1.UserSettings}

PostgreSQL user settings.

#|
||Field | Description ||
|| default_transaction_isolation | enum **TransactionIsolation**

SQL sets an isolation level for each transaction.
This setting defines the default isolation level to be set for all new SQL transactions.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html).

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object.
If the wait time is longer than the specified amount, then this statement is aborted.

Default value: `0` (no control is enforced, a statement waiting time is unlimited). ||
|| log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This setting controls logging of the duration of statements.

The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds).
E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged.

Value of `0` forces PostgreSQL to log the duration of all statements.

Value of `-1` (default) disables logging of the duration of statements.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). ||
|| synchronous_commit | enum **SynchronousCommit**

This setting defines whether DBMS will commit transaction in a synchronous way.

When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client.
These operations guarantee different levels of the data safety and visibility in the cluster.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum storage space size (in kilobytes) that a single process can use to create temporary files.
If a transaction exceeds this limit during execution, it will be aborted.

A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. ||
|| log_statement | enum **LogStatement**

This setting specifies which SQL statements should be logged (on the user level).

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.
- `LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).
- `LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).
- `LOG_STATEMENT_ALL`: Logs all SQL statements. ||
|| pool_mode | enum **PoolingMode**

Mode that the connection pooler is working in with specified user.

For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.
- `TRANSACTION`: Server connection is assigned to a client only during a transaction.
- `STATEMENT`: Server connection will be put back into the pool immediately after a query completes. ||
|| prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

User can use prepared statements with transaction pooling.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). ||
|| catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The connection pooler setting. It determines the maximum allowed replication lag (in seconds).
Pooler will reject connections to the replica with a lag above this threshold.
It can be useful to prevent application from reading stale data.

Default value: 0

Value of `0` disables this mechanism ||
|| wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+)
Terminate replication connections that are inactive for longer than this amount of time.

Default value: `60000` (60 seconds).

Value of `0` disables the timeout mechanism.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction.

The default value is `0`, which disables the timeout.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) to wait for statement.
The timeout is measured from the time a command arrives at the server until it is completed by the server.

If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged.

Value of `0` (default) disables the timeout

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| pgaudit | **[PGAuditSettings](#yandex.cloud.mdb.postgresql.v1.PGAuditSettings)**

Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). ||
|#

## PGAuditSettings {#yandex.cloud.mdb.postgresql.v1.PGAuditSettings}

#|
||Field | Description ||
|| log[] | enum **PGAuditSettingsLog**

Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting.

The possible values are the following:

* PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query.
* PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation.
* PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged.
* PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
* PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged.
* PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
* PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged.

The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured.

- `PG_AUDIT_SETTINGS_LOG_UNSPECIFIED`
- `PG_AUDIT_SETTINGS_LOG_READ`
- `PG_AUDIT_SETTINGS_LOG_WRITE`
- `PG_AUDIT_SETTINGS_LOG_FUNCTION`
- `PG_AUDIT_SETTINGS_LOG_ROLE`
- `PG_AUDIT_SETTINGS_LOG_DDL`
- `PG_AUDIT_SETTINGS_LOG_MISC`
- `PG_AUDIT_SETTINGS_LOG_MISC_SET` ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "user_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
    "permissions": [
      {
        "database_name": "string"
      }
    ],
    "conn_limit": "int64",
    "settings": {
      "default_transaction_isolation": "TransactionIsolation",
      "lock_timeout": "google.protobuf.Int64Value",
      "log_min_duration_statement": "google.protobuf.Int64Value",
      "synchronous_commit": "SynchronousCommit",
      "temp_file_limit": "google.protobuf.Int64Value",
      "log_statement": "LogStatement",
      "pool_mode": "PoolingMode",
      "prepared_statements_pooling": "google.protobuf.BoolValue",
      "catchup_timeout": "google.protobuf.Int64Value",
      "wal_sender_timeout": "google.protobuf.Int64Value",
      "idle_in_transaction_session_timeout": "google.protobuf.Int64Value",
      "statement_timeout": "google.protobuf.Int64Value",
      "pgaudit": {
        "log": [
          "PGAuditSettingsLog"
        ]
      }
    },
    "login": "google.protobuf.BoolValue",
    "grants": [
      "string"
    ],
    "deletion_protection": "google.protobuf.BoolValue",
    "user_password_encryption": "UserPasswordEncryption",
    "connection_manager": {
      "connection_id": "string"
    },
    "auth_method": "AuthMethod"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.postgresql.v1.CreateUserMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[User](#yandex.cloud.mdb.postgresql.v1.User)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateUserMetadata {#yandex.cloud.mdb.postgresql.v1.CreateUserMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the PostgreSQL cluster the user is being created in. ||
|| user_name | **string**

Name of the user that is being created. ||
|#

## User {#yandex.cloud.mdb.postgresql.v1.User}

A PostgreSQL User resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the PostgreSQL user. ||
|| cluster_id | **string**

ID of the PostgreSQL cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.postgresql.v1.Permission2)**

Set of permissions granted to the user to access specific databases. ||
|| conn_limit | **int64**

Maximum number of database connections available to the user.

When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.max_connections.proto) setting.

When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting.

Minimum value: `10` (default: `50`), when used in session pooling. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.postgresql.v1.UserSettings2)** ||
|| login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

This flag defines whether the user can login to a PostgreSQL database.

Default value: `true` (login is allowed). ||
|| grants[] | **string**

A set of roles and privileges that are granted to the user.

For more information, see [the documentation](/docs/managed-postgresql/operations/grant). ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the user deletion protection is enabled.

The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. ||
|| user_password_encryption | enum **UserPasswordEncryption**

Password-based authentication method for user.
Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.
The default is `` password_encryption `` setting for cluster.

- `USER_PASSWORD_ENCRYPTION_UNSPECIFIED`
- `USER_PASSWORD_ENCRYPTION_MD5`
- `USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.postgresql.v1.ConnectionManager)**

Connection Manager Connection and settings associated with user. Read only field. ||
|| auth_method | enum **AuthMethod**

Auth method for user

- `AUTH_METHOD_UNSPECIFIED`
- `AUTH_METHOD_PASSWORD`
- `AUTH_METHOD_IAM` ||
|#

## Permission {#yandex.cloud.mdb.postgresql.v1.Permission2}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.postgresql.v1.UserSettings2}

PostgreSQL user settings.

#|
||Field | Description ||
|| default_transaction_isolation | enum **TransactionIsolation**

SQL sets an isolation level for each transaction.
This setting defines the default isolation level to be set for all new SQL transactions.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html).

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object.
If the wait time is longer than the specified amount, then this statement is aborted.

Default value: `0` (no control is enforced, a statement waiting time is unlimited). ||
|| log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This setting controls logging of the duration of statements.

The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds).
E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged.

Value of `0` forces PostgreSQL to log the duration of all statements.

Value of `-1` (default) disables logging of the duration of statements.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). ||
|| synchronous_commit | enum **SynchronousCommit**

This setting defines whether DBMS will commit transaction in a synchronous way.

When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client.
These operations guarantee different levels of the data safety and visibility in the cluster.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum storage space size (in kilobytes) that a single process can use to create temporary files.
If a transaction exceeds this limit during execution, it will be aborted.

A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. ||
|| log_statement | enum **LogStatement**

This setting specifies which SQL statements should be logged (on the user level).

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.
- `LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).
- `LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).
- `LOG_STATEMENT_ALL`: Logs all SQL statements. ||
|| pool_mode | enum **PoolingMode**

Mode that the connection pooler is working in with specified user.

For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.
- `TRANSACTION`: Server connection is assigned to a client only during a transaction.
- `STATEMENT`: Server connection will be put back into the pool immediately after a query completes. ||
|| prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

User can use prepared statements with transaction pooling.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). ||
|| catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The connection pooler setting. It determines the maximum allowed replication lag (in seconds).
Pooler will reject connections to the replica with a lag above this threshold.
It can be useful to prevent application from reading stale data.

Default value: 0

Value of `0` disables this mechanism ||
|| wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+)
Terminate replication connections that are inactive for longer than this amount of time.

Default value: `60000` (60 seconds).

Value of `0` disables the timeout mechanism.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction.

The default value is `0`, which disables the timeout.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) to wait for statement.
The timeout is measured from the time a command arrives at the server until it is completed by the server.

If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged.

Value of `0` (default) disables the timeout

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| pgaudit | **[PGAuditSettings](#yandex.cloud.mdb.postgresql.v1.PGAuditSettings2)**

Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). ||
|#

## PGAuditSettings {#yandex.cloud.mdb.postgresql.v1.PGAuditSettings2}

#|
||Field | Description ||
|| log[] | enum **PGAuditSettingsLog**

Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting.

The possible values are the following:

* PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query.
* PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation.
* PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged.
* PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
* PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged.
* PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
* PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged.

The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured.

- `PG_AUDIT_SETTINGS_LOG_UNSPECIFIED`
- `PG_AUDIT_SETTINGS_LOG_READ`
- `PG_AUDIT_SETTINGS_LOG_WRITE`
- `PG_AUDIT_SETTINGS_LOG_FUNCTION`
- `PG_AUDIT_SETTINGS_LOG_ROLE`
- `PG_AUDIT_SETTINGS_LOG_DDL`
- `PG_AUDIT_SETTINGS_LOG_MISC`
- `PG_AUDIT_SETTINGS_LOG_MISC_SET` ||
|#

## ConnectionManager {#yandex.cloud.mdb.postgresql.v1.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

ID of Connection Manager Connection ||
|#