- **Conn limit**{#setting-conn-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Maximum allowed number of connections for the user.

  In transaction pooling, this setting limits the number of simultaneous connections per user transaction. When using this type of pooling, the user can open thousands of connections, but only `N` connections can run concurrently (where `N` is the setting value).

  In session pooling, the setting limits the number of user connections to each host in a {{ PG }} cluster. When using this type of pooling, make sure the setting value is not less than the sum of all connections that can be opened by the user service backends. Each open server connection slightly slows down the OLTP performance for {{ PG }}.

  The following principles apply to session pooling:

  - When adding a user, {{ mpg-name }} reserves 50 connections per host in a {{ PG }} cluster by default. The minimum number of connections per user is 1.
  - The total number of connections reserved for users must not exceed the value of the [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) parameter. {{ mpg-name }} reserves 15 service connections per host.

    For example, if the cluster has the `"max_connections": 100` setting, you can reserve a maximum of 85 connections per cluster host for users.

  - We recommend distributing services that use {{ PG }} across different users and setting the required value for each user. If issues in one service lead to creating a large number of connections, other services will not be affected and will be able to connect to {{ PG }}.

  The setting [depends on the selected host class](#settings-instance-dependent).

- **Default transaction isolation**{#setting-user-default-transaction-isolation} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   For more information, refer to the [Default transaction isolation](#setting-default-transaction-isolation) cluster-level setting.

- **Grants**{#setting-user-grants} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   [Roles](../../managed-postgresql/concepts/roles.md) granted to the user.

- **Lock timeout**{#setting-user-lock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   For more information, refer to the [Lock timeout](#setting-lock-timeout) cluster-level setting.

- **Log min duration statement**{#setting-user-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   For more information, refer to the [Log min duration statement](#setting-log-min-duration-statement) cluster-level setting.

  We recommend you to define the meaning of slow query execution for each service and its user and log only the queries that meet the definition. For example, for a web service, a query is slow if it runs for more than one second, while, for the reporting service, it is a query that runs for more than 10 minutes.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **Log statement**{#setting-user-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   For more information, refer to the [Log statement](#setting-log-statement) cluster-level setting.

- **Login**{#setting-user-login} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Determines whether the user can connect to a {{ PG }} cluster.

   The default value is `true`, which means the user can connect to the cluster.

- **Pooling mode**{#setting-pooling-mode} {{ tag-con }}

   The [PgBouncer](https://www.pgbouncer.org/) connection pooler's operating mode.

   The possible values include:

   * `session`: Server connection is assigned to the client when establishing a connection, and is maintained for it. The connection gets back to the pool once the client disconnects.
   * `transaction`: Server connection is assigned to the client for the transaction execution time only. The connection gets back to the pool once the transaction is completed.
   * `statement`: Server connection gets back to the pool once the query has been executed. Multi-statement transactions are not allowed in this mode.

   The default value is `session`.

  For more information, see the [PgBouncer documentation](https://www.pgbouncer.org/usage).

- **Pg audit log**{#setting-pg-audit-log} {{ tag-con }}

   Defines which user queries will be written to the audit log.

   The setting is only valid if:

   * `pgaudit` [library is connected](../../managed-postgresql/operations/extensions/cluster-extensions.md#libraries-connection) to the cluster.
   * `pgaudit` [extension is enabled](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) for the database.

   The possible values include:

   * `read`: `SELECT` and `COPY` queries are logged if the data source is a relation or query.
   * `write`: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation.
   * `function`: Function invocations and `DO` sections are logged.
   * `role`: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
   * `ddl`: Any `DDL` statements that do not belong to the `ROLE` class are logged.
   * `misc`: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
   * `misc_set`: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged.

   You can select multiple values. By default, audit logs are disabled for the user.

   For more information about setting up audit logs, see [{#T}](../../managed-postgresql/operations/extensions/pgaudit.md).

- **Prepared statements pooling**{#setting-prepared-statements-pooling} {{ tag-con }}

   Allows using prepared statements with merged transactions.

- **Synchronous commit**{#setting-user-synchronous-commit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   For more information, refer to the [Synchronous commit](#setting-synchronous-commit) cluster-level setting.

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   For more information, refer to the [Temp file limit](#setting-temp-file-limit) cluster-level setting.

- **Wal sender timeout**{#setting-wal-sender-timeout} {{ tag-con }}

   Time, in milliseconds, after which inactive replication connections are terminated. Available for {{ mpg-name }} clusters starting with version 12.
