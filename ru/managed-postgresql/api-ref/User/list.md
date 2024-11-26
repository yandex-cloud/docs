---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/User/list.md
---

# Managed Service for PostgreSQL API, REST: User.List

Retrieves the list of PostgreSQL User resources in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list PostgreSQL users in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.postgresql.v1.ListUsersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListUsersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListUsersResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "databaseName": "string"
        }
      ],
      "connLimit": "string",
      "settings": {
        "defaultTransactionIsolation": "string",
        "lockTimeout": "string",
        "logMinDurationStatement": "string",
        "synchronousCommit": "string",
        "tempFileLimit": "string",
        "logStatement": "string",
        "poolMode": "string",
        "preparedStatementsPooling": "boolean",
        "catchupTimeout": "string",
        "walSenderTimeout": "string",
        "idleInTransactionSessionTimeout": "string",
        "statementTimeout": "string",
        "pgaudit": {
          "log": [
            "string"
          ]
        }
      },
      "login": "boolean",
      "grants": [
        "string"
      ],
      "deletionProtection": "boolean",
      "userPasswordEncryption": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.postgresql.v1.User)**

List of PostgreSQL User resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListUsersRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListUsersRequest), use the `next_page_token` as the value
for the [ListUsersRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListUsersRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.postgresql.v1.User}

A PostgreSQL User resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the PostgreSQL user. ||
|| clusterId | **string**

ID of the PostgreSQL cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.postgresql.v1.Permission)**

Set of permissions granted to the user to access specific databases. ||
|| connLimit | **string** (int64)

Maximum number of database connections available to the user.

When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the `Cluster.config.postgresqlConfig_12.effectiveConfig.maxConnections` setting.

When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting.

Minimum value: `10` (default: `50`), when used in session pooling. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.postgresql.v1.UserSettings)** ||
|| login | **boolean**

This flag defines whether the user can login to a PostgreSQL database.

Default value: `true` (login is allowed). ||
|| grants[] | **string**

A set of roles and privileges that are granted to the user.

For more information, see [the documentation](/docs/managed-postgresql/operations/grant). ||
|| deletionProtection | **boolean**

Determines whether the user deletion protection is enabled.

The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. ||
|| userPasswordEncryption | **enum** (UserPasswordEncryption)

Password-based authentication method for user.
Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.
The default is `` password_encryption `` setting for cluster.

- `USER_PASSWORD_ENCRYPTION_UNSPECIFIED`
- `USER_PASSWORD_ENCRYPTION_MD5`
- `USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## Permission {#yandex.cloud.mdb.postgresql.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.postgresql.v1.UserSettings}

PostgreSQL user settings.

#|
||Field | Description ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

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
|| lockTimeout | **string** (int64)

The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object.
If the wait time is longer than the specified amount, then this statement is aborted.

Default value: `0` (no control is enforced, a statement waiting time is unlimited). ||
|| logMinDurationStatement | **string** (int64)

This setting controls logging of the duration of statements.

The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds).
E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged.

Value of `0` forces PostgreSQL to log the duration of all statements.

Value of `-1` (default) disables logging of the duration of statements.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). ||
|| synchronousCommit | **enum** (SynchronousCommit)

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
|| tempFileLimit | **string** (int64)

The maximum storage space size (in kilobytes) that a single process can use to create temporary files.
If a transaction exceeds this limit during execution, it will be aborted.

A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. ||
|| logStatement | **enum** (LogStatement)

This setting specifies which SQL statements should be logged (on the user level).

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.
- `LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).
- `LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).
- `LOG_STATEMENT_ALL`: Logs all SQL statements. ||
|| poolMode | **enum** (PoolingMode)

Mode that the connection pooler is working in with specified user.

For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.
- `TRANSACTION`: Server connection is assigned to a client only during a transaction.
- `STATEMENT`: Server connection will be put back into the pool immediately after a query completes. ||
|| preparedStatementsPooling | **boolean**

User can use prepared statements with transaction pooling.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). ||
|| catchupTimeout | **string** (int64)

The connection pooler setting. It determines the maximum allowed replication lag (in seconds).
Pooler will reject connections to the replica with a lag above this threshold.
It can be useful to prevent application from reading stale data.

Default value: 0

Value of `0` disables this mechanism ||
|| walSenderTimeout | **string** (int64)

The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+)
Terminate replication connections that are inactive for longer than this amount of time.

Default value: `60000` (60 seconds).

Value of `0` disables the timeout mechanism.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction.

The default value is `0`, which disables the timeout.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| statementTimeout | **string** (int64)

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
|| log[] | **enum** (PGAuditSettingsLog)

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