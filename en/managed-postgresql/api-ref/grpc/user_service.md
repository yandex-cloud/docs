---
editable: false
sourcePath: en/_api-ref-grpc/managed-postgresql/api-ref/grpc/user_service.md
---

# Managed Service for PostgreSQL API, gRPC: UserService

A set of methods for managing PostgreSQL User resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified PostgreSQL User resource. |
| [List](#List) | Retrieves the list of PostgreSQL User resources in the specified cluster. |
| [Create](#Create) | Creates a PostgreSQL user in the specified cluster. |
| [Update](#Update) | Updates the specified PostgreSQL user. |
| [Delete](#Delete) | Deletes the specified PostgreSQL user. |
| [GrantPermission](#GrantPermission) | Grants permission to the specified PostgreSQL user. |
| [RevokePermission](#RevokePermission) | Revokes permission from the specified PostgreSQL user. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified PostgreSQL User resource. <br>To get the list of available PostgreSQL User resources, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the PostgreSQL User resource to return. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL user. 
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. 
settings | **[UserSettings](#UserSettings)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the user deletion protection is enabled. <br>The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.</li><li>`SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.</li><li>`LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: Logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string). <ul><li>`SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.</li><li>`TRANSACTION`: Server connection is assigned to a client only during a transaction.</li><li>`STATEMENT`: Server connection will be put back into the pool immediately after a query completes.</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. <br>The default value is `0`, which disables the timeout. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). Acceptable values are 0 to 2147483647, inclusive.
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). 
pgaudit | **[PGAuditSettings](#PGAuditSettings)**<br>Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). 


### PGAuditSettings {#PGAuditSettings}

Field | Description
--- | ---
log[] | enum **PGAuditSettingsLog**<br>Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting. <br>The possible values are the following: <br><ul><li>PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query. </li><li>PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation. </li><li>PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged. </li><li>PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged. </li></ul><br>The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured. 


## List {#List}

Retrieves the list of PostgreSQL User resources in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list PostgreSQL users in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](#User1)**<br>List of PostgreSQL User resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User1}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL user. 
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. 
settings | **[UserSettings](#UserSettings1)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the user deletion protection is enabled. <br>The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


### Permission {#Permission1}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings1}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.</li><li>`SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.</li><li>`LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: Logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string). <ul><li>`SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.</li><li>`TRANSACTION`: Server connection is assigned to a client only during a transaction.</li><li>`STATEMENT`: Server connection will be put back into the pool immediately after a query completes.</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. <br>The default value is `0`, which disables the timeout. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). Acceptable values are 0 to 2147483647, inclusive.
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). 
pgaudit | **[PGAuditSettings](#PGAuditSettings1)**<br>Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). 


### PGAuditSettings {#PGAuditSettings1}

Field | Description
--- | ---
log[] | enum **PGAuditSettingsLog**<br>Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting. <br>The possible values are the following: <br><ul><li>PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query. </li><li>PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation. </li><li>PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged. </li><li>PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged. </li></ul><br>The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured. 


## Create {#Create}

Creates a PostgreSQL user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to create a user in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_spec | **[UserSpec](#UserSpec)**<br>Required. Properties of the user to be created. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the PostgreSQL user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
password | **string**<br>Required. Password of the PostgreSQL user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions to grant to the user to access specific databases. 
conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of database connections that should be available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. The minimum value is 10.
settings | **[UserSettings](#UserSettings2)**<br>PostgreSQL settings for the user. 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Deletion Protection inhibits deletion of the user <br>Default value: `unspecified` (inherits cluster's deletion_protection) 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


### Permission {#Permission2}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings2}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.</li><li>`SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.</li><li>`LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: Logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string). <ul><li>`SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.</li><li>`TRANSACTION`: Server connection is assigned to a client only during a transaction.</li><li>`STATEMENT`: Server connection will be put back into the pool immediately after a query completes.</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. <br>The default value is `0`, which disables the timeout. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). Acceptable values are 0 to 2147483647, inclusive.
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). 
pgaudit | **[PGAuditSettings](#PGAuditSettings2)**<br>Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). 


### PGAuditSettings {#PGAuditSettings2}

Field | Description
--- | ---
log[] | enum **PGAuditSettingsLog**<br>Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting. <br>The possible values are the following: <br><ul><li>PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query. </li><li>PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation. </li><li>PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged. </li><li>PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged. </li></ul><br>The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateUserMetadata](#CreateUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User2)>**<br>if operation finished successfully. 


### CreateUserMetadata {#CreateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster the user is being created in. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User2}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL user. 
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. 
settings | **[UserSettings](#UserSettings3)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the user deletion protection is enabled. <br>The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


## Update {#Update}

Updates the specified PostgreSQL user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to be updated. To get the name of the user use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the PostgreSQL User resource should be updated. 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. The minimum value is 10.
settings | **[UserSettings](#UserSettings3)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Deletion Protection inhibits deletion of the user <br>Default value: `unspecified` (inherits cluster's deletion_protection) 
user_password_encryption | enum **UserPasswordEncryption**<br>New password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. 


### Permission {#Permission3}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings3}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.</li><li>`SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.</li><li>`LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: Logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string). <ul><li>`SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.</li><li>`TRANSACTION`: Server connection is assigned to a client only during a transaction.</li><li>`STATEMENT`: Server connection will be put back into the pool immediately after a query completes.</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. <br>The default value is `0`, which disables the timeout. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). Acceptable values are 0 to 2147483647, inclusive.
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). 
pgaudit | **[PGAuditSettings](#PGAuditSettings3)**<br>Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). 


### PGAuditSettings {#PGAuditSettings3}

Field | Description
--- | ---
log[] | enum **PGAuditSettingsLog**<br>Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting. <br>The possible values are the following: <br><ul><li>PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query. </li><li>PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation. </li><li>PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged. </li><li>PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged. </li></ul><br>The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateUserMetadata](#UpdateUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User3)>**<br>if operation finished successfully. 


### UpdateUserMetadata {#UpdateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User3}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL user. 
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission4)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. 
settings | **[UserSettings](#UserSettings4)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the user deletion protection is enabled. <br>The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


## Delete {#Delete}

Deletes the specified PostgreSQL user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to delete. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteUserMetadata](#DeleteUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteUserMetadata {#DeleteUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants permission to the specified PostgreSQL user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to grant the permission to. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
permission | **[Permission](#Permission4)**<br>Required. Permission that should be granted to the specified user. 


### Permission {#Permission4}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User4)>**<br>if operation finished successfully. 


### GrantUserPermissionMetadata {#GrantUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User4}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL user. 
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. 
settings | **[UserSettings](#UserSettings4)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the user deletion protection is enabled. <br>The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


### UserSettings {#UserSettings4}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.</li><li>`SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.</li><li>`LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: Logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string). <ul><li>`SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.</li><li>`TRANSACTION`: Server connection is assigned to a client only during a transaction.</li><li>`STATEMENT`: Server connection will be put back into the pool immediately after a query completes.</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. <br>The default value is `0`, which disables the timeout. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). Acceptable values are 0 to 2147483647, inclusive.
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). 
pgaudit | **[PGAuditSettings](#PGAuditSettings4)**<br>Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). 


### PGAuditSettings {#PGAuditSettings4}

Field | Description
--- | ---
log[] | enum **PGAuditSettingsLog**<br>Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting. <br>The possible values are the following: <br><ul><li>PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query. </li><li>PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation. </li><li>PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged. </li><li>PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged. </li></ul><br>The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured. 


## RevokePermission {#RevokePermission}

Revokes permission from the specified PostgreSQL user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to revoke a permission from. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
database_name | **string**<br>Required. Name of the database that the user should lose access to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User5)>**<br>if operation finished successfully. 


### RevokeUserPermissionMetadata {#RevokeUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User5}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL user. 
cluster_id | **string**<br>ID of the PostgreSQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user to access specific databases. 
conn_limit | **int64**<br>Maximum number of database connections available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. 
settings | **[UserSettings](#UserSettings5)**<br> 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether the user deletion protection is enabled. <br>The default value is `unspecified`. In this case, the user configuration inherits the cluster's deletion protection settings. 
user_password_encryption | enum **UserPasswordEncryption**<br>Password-based authentication method for user. Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` password_encryption `` setting for cluster. 


### Permission {#Permission5}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings5}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.</li><li>`SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.</li><li>`LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: Logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string). <ul><li>`SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.</li><li>`TRANSACTION`: Server connection is assigned to a client only during a transaction.</li><li>`STATEMENT`: Server connection will be put back into the pool immediately after a query completes.</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. <br>The default value is `0`, which disables the timeout. <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). Acceptable values are 0 to 2147483647, inclusive.
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). 
pgaudit | **[PGAuditSettings](#PGAuditSettings5)**<br>Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). 


### PGAuditSettings {#PGAuditSettings5}

Field | Description
--- | ---
log[] | enum **PGAuditSettingsLog**<br>Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting. <br>The possible values are the following: <br><ul><li>PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query. </li><li>PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation. </li><li>PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged. </li><li>PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged. </li><li>PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged. </li></ul><br>The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured. 


