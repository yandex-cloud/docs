- **Catchup timeout**{#setting-catchup-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Maximum allowed replica lag behind the master (in seconds).

    When this setting has a non-zero value, the [Odyssey connection pooler](../../managed-postgresql/concepts/pooling.md) will block connections to severely lagging replicas. This mechanism prevents reading stale data from such replicas.

    Odyssey regularly polls the cluster for lagging replicas and terminates connection attempts to replicas with the lag exceeding the configured threshold, Odyssey will return the following message:

    ```text
    remote server read/write error: failed to wait replica for catchup
    ```

    The minimum and default value is `0`, which permits connections to any replica, no matter how far it lags behind the master.

- **Conn limit**{#setting-conn-limit} {{ tag-all }}

  In transaction pooling mode, this setting limits the number of concurrent active connections per user. This pooling mode allows a user to open thousands of connections, meanwhile, limiting the number of concurrently active connections to the configured value `N`.

  In session pooling mode, this setting limits the number of connections per host a user can make in a {{ PG }} cluster. When using this pooling mode, make sure the setting value is no less than the total number of connections that can be opened by the user service backends. Each open server connection slightly slows down the {{ PG }}OLTP performance.

  Session pooling operates as follows:

  - By default, {{ mpg-name }} reserves 50 connections per host for each new {{ PG }} cluster user. The minimum number of connections per user is 1.
  - The total number of connections reserved for users must not exceed the value of the [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) parameter. {{ mpg-name }} reserves 15 service connections per host.

    For example, if the cluster is set to `"max_connections": 100`, you can reserve a maximum of 85 connections per cluster host for users.

  - We recommend isolating different {{ PG }} services with separate users, each with their own configured connection limit. If a failing service creates a connection storm, other services will remain unaffected and retain {{ PG }} connectivity.

  The value of this setting is determined by the [selected host class](#settings-instance-dependent).

- **Default transaction isolation**{#setting-user-default-transaction-isolation} {{ tag-all }}

  [Default transaction isolation](#setting-default-transaction-isolation) cluster-level setting description.

- **Grants**{#setting-user-grants} {{ tag-all }}

  [Roles](../../managed-postgresql/concepts/roles.md) granted to the user.

- **Idle in transaction session timeout**{#setting-user-idle-transaction-timeout} {{ tag-all }}

  Description of the [Idle in transaction session timeout](#setting-idle-transaction-timeout) cluster-level setting.

- **Idle session timeout**{#setting-user-idle-session-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Description of the [Idle session timeout](#setting-idle-session-timeout) cluster-level setting.

- **Lock timeout**{#setting-user-lock-timeout} {{ tag-all }}

  [Lock timeout](#setting-lock-timeout) cluster-level setting description.

- **Log min duration statement**{#setting-user-log-min-duration-statement} {{ tag-all }}

  [Log min duration statement](#setting-log-min-duration-statement) cluster-level setting description.

  We recommend defining a slow query threshold for each service and its user and logging only those queries that exceed it. For example, a query running longer than one second might be considered slow for a web service, whereas for a reporting service the slow query threshold might be 10 minutes.

  For more information, see [this {{ PG }} article](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **Log statement**{#setting-user-log-statement} {{ tag-all }}

  [Log statement](#setting-log-statement) cluster-level setting description.

- **Login**{#setting-user-login} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Defines whether the user is permitted to connect to the {{ PG }} cluster.

  Default value is `true`, meaning that the user can connect to the cluster.

- **Pg audit log**{#setting-pg-audit-log} {{ tag-all }}

  Defines which user queries will be included in the audit log.

  This setting only applies if the following conditions are met:

  * `pgaudit` [library is connected](../../managed-postgresql/operations/extensions/cluster-extensions.md#libraries-connection) to the cluster.
  * `pgaudit` [extension is enabled](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) for the database.

  The possible values are:

  {% list tabs group=instructions %}

  - Management console/CLI {#console}

    - `read`: System logs `SELECT` and `COPY` queries if the data source is a relation or a query.
    - `write`: System logs `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries when the destination is a relation.
    - `function`: Function invocations and `DO` sections are logged.
    - `role`: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
    - `ddl`: All `DDL` statements not belonging to the `ROLE` class are logged.
    - `misc`: Auxiliary commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
    - `misc_set`: System logs miscellaneous `SET`  commands, e.g., `SET ROLE`.

  - {{ TF }} {#tf}

    - `READ`: System logs `SELECT` and `COPY` queries if the data source is a relation or a query.
    - `WRITE`: System logs `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries when the destination is a relation.
    - `FUNCTION`: System logs function calls and `DO` blocks.
    - `ROLE`: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
    - `DDL`: System logs all `DDL` statements not included in the `ROLE` class.
    - `MISC`: Auxiliary commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
    - `MISC_SET`: System logs miscellaneous `SET` commands, e.g., `SET ROLE`.

  - API {#api}

    - `PG_AUDIT_SETTINGS_LOG_READ`: System logs `SELECT` and `COPY` queries if the data source is a relation or a query.
    - `PG_AUDIT_SETTINGS_LOG_WRITE`: System logs `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries when the destination is a relation.
    - `PG_AUDIT_SETTINGS_LOG_FUNCTION`: System logs function calls and `DO` blocks.
    - `PG_AUDIT_SETTINGS_LOG_ROLE`: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
    - `PG_AUDIT_SETTINGS_LOG_DDL`: System logs all `DDL` statements not included in the `ROLE` class.
    - `PG_AUDIT_SETTINGS_LOG_MISC`: Auxiliary commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
    - `PG_AUDIT_SETTINGS_LOG_MISC_SET`: System logs miscellaneous `SET`  commands, e.g., `SET ROLE`.

  {% endlist %}

  You can specify multiple values. By default, user audit logs are disabled.

  To learn more about configuring audit logs, see [Using pgaudit](../../managed-postgresql/operations/extensions/pgaudit.md).

- **Pool mode**{#setting-pool-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    [Connection pooling mode](../../managed-postgresql/concepts/pooling.md) used by the Odyssey connection pooler.

    The possible values are:

    * `SESSION`: Session mode.
    * `TRANSACTION`: Transaction mode.
    * `STATEMENT`: Statement mode.

    
    The default value is `SESSION`.


- **Prepared statements pooling**{#setting-prepared-statements-pooling} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables using [prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html) for the [connection pooler](../../managed-postgresql/concepts/pooling.md) transaction mode.

  This setting is available only if **Pool mode** is set to `TRANSACTION`.

- **Statement timeout**{#setting-user-statement-timeout} {{ tag-all }}

  Description of the [Statement timeout](#setting-statement-timeout) cluster-level setting.

- **Synchronous commit**{#setting-user-synchronous-commit} {{ tag-all }}

  [Synchronous commit](#setting-synchronous-commit) cluster-level setting description.

- **Temp file limit**{#setting-temp-file-limit} {{ tag-all }}

  [Temp file limit](#setting-temp-file-limit) cluster-level setting description.

- **Wal sender timeout**{#setting-wal-sender-timeout} {{ tag-all }}

  Time (in ms) after which inactive replication connections are terminated.

  {% include [settings-version](../../_includes/mdb/mpg/mpg-settings-v-12.md) %}
