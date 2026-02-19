---
editable: false
noIndex: true
---

# yc beta managed-postgresql user create

Creates a PostgreSQL user in the specified cluster.

#### Command Usage

Syntax:

`yc beta managed-postgresql user create <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the PostgreSQL cluster to create a user in. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--user-spec` | `shorthand/json`

Properties of the user to be created.

Shorthand Syntax:

```hcl
{
  auth-method = AUTH_METHOD_PASSWORD|AUTH_METHOD_IAM,
  conn-limit = integer,
  deletion-protection = boolean,
  generate-password = boolean,
  grants = string,...,
  login = boolean,
  name = string,
  password = string,
  permissions = [
    {
      database-name = string
    }, ...
  ],
  settings = {
    catchup-timeout = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    idle-in-transaction-session-timeout = integer,
    lock-timeout = integer,
    log-min-duration-statement = integer,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    pgaudit = {
      log = [
        PG_AUDIT_SETTINGS_LOG_READ|PG_AUDIT_SETTINGS_LOG_WRITE|PG_AUDIT_SETTINGS_LOG_FUNCTION|PG_AUDIT_SETTINGS_LOG_ROLE|PG_AUDIT_SETTINGS_LOG_DDL|PG_AUDIT_SETTINGS_LOG_MISC|PG_AUDIT_SETTINGS_LOG_MISC_SET, ...
      ]
    },
    pool-mode = SESSION|TRANSACTION|STATEMENT,
    prepared-statements-pooling = boolean,
    statement-timeout = integer,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-file-limit = integer,
    wal-sender-timeout = integer
  },
  user-password-encryption = USER_PASSWORD_ENCRYPTION_MD5|USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256
}
```

JSON Syntax:

```json
{
  "auth-method": "AUTH_METHOD_PASSWORD|AUTH_METHOD_IAM",
  "conn-limit": "integer",
  "deletion-protection": "boolean",
  "generate-password": "boolean",
  "grants": [
    "string", ...
  ],
  "login": "boolean",
  "name": "string",
  "password": "string",
  "permissions": [
    {
      "database-name": "string"
    }, ...
  ],
  "settings": {
    "catchup-timeout": "integer",
    "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
    "idle-in-transaction-session-timeout": "integer",
    "lock-timeout": "integer",
    "log-min-duration-statement": "integer",
    "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
    "pgaudit": {
      "log": [
        "PG_AUDIT_SETTINGS_LOG_READ|PG_AUDIT_SETTINGS_LOG_WRITE|PG_AUDIT_SETTINGS_LOG_FUNCTION|PG_AUDIT_SETTINGS_LOG_ROLE|PG_AUDIT_SETTINGS_LOG_DDL|PG_AUDIT_SETTINGS_LOG_MISC|PG_AUDIT_SETTINGS_LOG_MISC_SET", ...
      ]
    },
    "pool-mode": "SESSION|TRANSACTION|STATEMENT",
    "prepared-statements-pooling": "boolean",
    "statement-timeout": "integer",
    "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
    "temp-file-limit": "integer",
    "wal-sender-timeout": "integer"
  },
  "user-password-encryption": "USER_PASSWORD_ENCRYPTION_MD5|USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256"
}
```

Fields:

```
auth-method -> (struct)
  Auth method for user
conn-limit -> (integer)
  Maximum number of database connections that should be available to the user. When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections] setting. When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only 'N' concurrent connections will be opened, where 'N' is the value of the setting. Minimum value: '10' (default: '50'), when used in session pooling.
deletion-protection -> (boolean)
  Deletion Protection inhibits deletion of the user Default value: 'unspecified' (inherits cluster's deletion_protection)
generate-password -> (boolean)
  Generate password using Connection Manager.
grants -> ([]string)
  A set of roles and privileges that are granted to the user. For more information, see documentation.
login -> (boolean)
  This flag defines whether the user can login to a PostgreSQL database. Default value: 'true' (login is allowed).
name -> (string)
  Name of the PostgreSQL user.
password -> (string)
  Password of the PostgreSQL user.
permissions -> ([]struct)
  Set of permissions to grant to the user to access specific databases.
  database-name -> (string)
    Name of the database that the permission grants access to.
settings -> (struct)
  PostgreSQL settings for the user.
  catchup-timeout -> (integer)
    The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. Default value: 0 Value of '0' disables this mechanism
  default-transaction-isolation -> (struct)
    SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. For more information, see the PostgreSQL documentation.
  idle-in-transaction-session-timeout -> (integer)
    Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. The default value is '0', which disables the timeout. For more information, see the PostgreSQL documentation.
  lock-timeout -> (integer)
    The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. Default value: '0' (no control is enforced, a statement waiting time is unlimited).
  log-min-duration-statement -> (integer)
    This setting controls logging of the duration of statements. The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to '500', a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. Value of '0' forces PostgreSQL to log the duration of all statements. Value of '-1' (default) disables logging of the duration of statements. For more information, see the PostgreSQL documentation.
  log-statement -> (struct)
    This setting specifies which SQL statements should be logged (on the user level). For more information, see the PostgreSQL documentation.
  pgaudit -> (struct)
    Settings of the PostgreSQL Audit Extension (pgaudit).
    log -> ([]struct)
      Defines which user queries will be written to the audit log. Corresponds to the Pg audit log user setting. The possible values are the following: * PG_AUDIT_SETTINGS_LOG_READ: 'SELECT' and 'COPY' queries are logged if the data source is a relation or query. * PG_AUDIT_SETTINGS_LOG_WRITE: 'INSERT', 'UPDATE', 'DELETE', 'TRUNCATE', and 'COPY' queries are logged if the data target is a relation. * PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and 'DO' sections are logged. * PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as 'GRANT', 'REVOKE', or 'CREATE/ALTER/DROP ROLE', are logged. * PG_AUDIT_SETTINGS_LOG_DDL: Any 'DDL' statements that do not belong to the 'ROLE' class are logged. * PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as 'DISCARD', 'FETCH', 'CHECKPOINT', 'VACUUM', and 'SET', are logged. * PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous 'SET' commands, e.g., 'SET ROLE', are logged. The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured.
  pool-mode -> (struct)
    Mode that the connection pooler is working in with specified user. For more information, see the Odyssey documentation.
  prepared-statements-pooling -> (boolean)
    User can use prepared statements with transaction pooling. This requires 'pool_mode' to be set to TRANSACTION. Odyssey documentation.
  statement-timeout -> (integer)
    The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. If 'log_min_error_statement' is set to ERROR or lower, the statement that timed out will also be logged. Value of '0' (default) disables the timeout For more information, see the PostgreSQL documentation.
  synchronous-commit -> (struct)
    This setting defines whether DBMS will commit transaction in a synchronous way. When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting 'success' to the client. These operations guarantee different levels of the data safety and visibility in the cluster. For more information, see the PostgreSQL documentation.
  temp-file-limit -> (integer)
    The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files.
  wal-sender-timeout -> (integer)
    The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. Default value: '60000' (60 seconds). Value of '0' disables the timeout mechanism. For more information, see the PostgreSQL documentation.
user-password-encryption -> (struct)
  Password-based authentication method for user. Possible values are '' USER_PASSWORD_ENCRYPTION_MD5 '' or '' USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ''. The default is '' password_encryption '' setting for cluster.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#