- **Catchup timeout**{#setting-catchup-timeout} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum allowed replica's lag behind the master (in seconds).

    If the setting has a non-zero value, the [Odyssey connection pooler](../../managed-postgresql/concepts/pooling.md) will not allow connections to replicas lagging far behind the master. This prevents reading stale data from such replicas.

    Odyssey regularly requests information about lagging replicas from the cluster. When attempting to connect to a replica whose lag exceeds the setting value, the connection will be terminated. Odyssey will return the following message:

    ```text
    remote server read/write error: failed to wait replica for catchup
    ```

    The minimum and default value is `0` (allows connecting to any replica regardless of its lag behind the master).

- **Conn limit**{#setting-conn-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Maximum allowed number of connections for the user.

  In transaction pooling, this setting limits the number of simultaneous connections per user transaction. When using this type of pooling, the user can open thousands of connections, but only `N` connections can run concurrently (where `N` is the setting value).

  In session pooling, the setting limits the number of user connections to each host in a {{ PG }} cluster. When using this type of pooling, make sure the setting value is not less than the sum of all connections that can be opened by the user service backends. Each open server connection slightly slows down the OLTP performance for {{ PG }}.

  The following principles apply to session pooling:

  - When adding a user, {{ mpg-name }} reserves 50 connections per host in a {{ PG }} cluster by default. The minimum number of connections per user is 1.
  - The total number of connections reserved for users must not exceed the value of the [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) parameter. {{ mpg-name }} reserves 15 service connections per host.

    For example, if the cluster is set to `"max_connections": 100`, you can reserve a maximum of 85 connections per cluster host for users.

  - We recommend distributing services that use {{ PG }} across different users and setting the required value for each user. If issues in one service lead to creating a large number of connections, other services will not be affected and will be able to connect to {{ PG }}.

  The setting [depends on the selected host class](#settings-instance-dependent).

- **Default transaction isolation**{#setting-user-default-transaction-isolation} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  See the description of the [Default transaction isolation](#setting-default-transaction-isolation) cluster-level setting.

- **Grants**{#setting-user-grants} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  [Roles](../../managed-postgresql/concepts/roles.md) granted to the user.

- **Lock timeout**{#setting-user-lock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  See the description of the [Lock timeout](#setting-lock-timeout) cluster-level setting.

- **Log min duration statement**{#setting-user-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  See the description of the [Log min duration statement](#setting-log-min-duration-statement) cluster-level setting.

  We recommend you to define the meaning of slow query execution for each service and its user and log only the queries that meet the definition. For example, for a web service, a query is slow if it runs for more than one second, while, for the reporting service, it is a query that runs for more than 10 minutes.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **Log statement**{#setting-user-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  See the description of the [Log statement](#setting-log-statement) cluster-level setting.

- **Login**{#setting-user-login} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Whether or not the user can connect to the {{ PG }} cluster.

  Default value: `true` (the user can connect to the cluster).

- **Pg audit log**{#setting-pg-audit-log} {{ tag-con }}

  Defines which user queries will be written to the audit log.

  The setting is only valid if:

  * `pgaudit` [library is connected](../../managed-postgresql/operations/extensions/cluster-extensions.md#libraries-connection) to the cluster.
  * `pgaudit` [extension is enabled](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) for the database.

  The possible values are:

  * `read`: `SELECT` and `COPY` queries are logged if the data source is a relation or query.
  * `write`: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data source is a relation.
  * `function`: Function invocations and `DO` sections are logged.
  * `role`: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
  * `ddl`: All `DDL` statements not belonging to the `ROLE` class are logged.
  * `misc`: Auxiliary commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
  * `misc_set`: The `SET` auxiliary commands, such as `SET ROLE`, are logged.

  You can select multiple values. By default, audit logs are disabled for the user.

  For more information about setting up audit logs, see [Using pgaudit](../../managed-postgresql/operations/extensions/pgaudit.md).

- **Pooling mode**{#setting-pooling-mode} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    {% note info %}

    * {{ TF }} and the gRPC API use the `pool_mode` setting name.
    * In the REST API, the `poolMode` setting name is used.

    {% endnote %}

    [Connection management mode](../../managed-postgresql/concepts/pooling.md) used by the Odyssey connection pooler.

    The possible values are:

    * `SESSION`: Session mode.
    * `TRANSACTION`: Transaction mode.
    * `STATEMENT`: Query mode.

    The default value is `SESSION`.

- **Prepared statements pooling**{#setting-prepared-statements-pooling} {{ tag-con }}

  Allows using prepared statements with merged transactions.

- **Synchronous commit**{#setting-user-synchronous-commit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  See the description of the [Synchronous commit](#setting-synchronous-commit) cluster-level setting.

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  See the description of the [Temp file limit](#setting-temp-file-limit) cluster-level setting.

- **Wal sender timeout**{#setting-wal-sender-timeout} {{ tag-con }}

  Time, in milliseconds, after which inactive replication connections are terminated. Available for {{ mpg-name }} clusters starting with version 12.
