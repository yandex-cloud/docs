- **Catchup timeout**{#setting-catchup-timeout} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Maximum allowed replica lag behind the master (in seconds).

    When this setting has a non-zero value, the [Odyssey connection pooler](../../managed-postgresql/concepts/pooling.md) will block connections to severely lagging replicas. This mechanism prevents reading stale data from such replicas.

    Odyssey regularly polls the cluster for lagging replicas and terminates connection attempts to replicas with the lag exceeding the configured threshold, throwing the following error:

    ```text
    remote server read/write error: failed to wait replica for catchup
    ```

    The minimum and default value is `0`, which permits connections to any replica, no matter how far it lags behind the master.

- **Conn limit**{#setting-conn-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  In transaction pooling mode, this setting limits the number of concurrent active connections per user. This pooling mode allows a user to open thousands of connections, meanwhile, limiting the number of concurrently active connections to the configured value `N`.

  In session pooling mode, this setting limits the number of connections per host a user can make in a {{ PG }} cluster. When using this pooling mode, make sure the setting value is no less than the total number of connections that can be opened by the user service backends. Each open server connection slightly slows down the {{ PG }} OLTP performance.

  Session pooling operates as follows:

  - By default, {{ mpg-name }} reserves 50 connections per host for each new {{ PG }} cluster user. The minimum number of connections per user is 1.
  - The total number of connections reserved for users must not exceed the [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections) value. Note that {{ mpg-name }} reserves 15 service connections per host.

    For example, for `"max_connections": 100`, you can reserve no more than 85 user connections per cluster host.

  - We recommend isolating different {{ PG }} services with separate users, each with their own configured connection limit. If a failing service creates a connection storm, other services will remain unaffected and retain {{ PG }} connectivity.

  The value of this setting is determined by the [selected host class](#settings-instance-dependent).

- **Default transaction isolation**{#setting-user-default-transaction-isolation} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Refer to the [Default transaction isolation](#setting-default-transaction-isolation) cluster-level setting description.

- **Grants**{#setting-user-grants} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  [Roles](../../managed-postgresql/concepts/roles.md) granted to the user.

- **Lock timeout**{#setting-user-lock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Refer to the [Lock timeout](#setting-lock-timeout) cluster-level setting description.

- **Log min duration statement**{#setting-user-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Refer to the [Log min duration statement](#setting-log-min-duration-statement) cluster-level setting description.

  We recommend defining a slow query threshold for each service and its user and logging only those queries that exceed it. For example, a query running longer than one second might be considered slow for a web service, whereas for a reporting service the slow query threshold might be 10 minutes.

  For more information, see [this {{ PG }} article](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **Log statement**{#setting-user-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Refer to the [Log statement](#setting-log-statement) cluster-level setting description.

- **Login**{#setting-user-login} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Defines whether the user is permitted to connect to the {{ PG }} cluster.

  Default value is `true`, meaning that the user can connect to the cluster.

- **Pg audit log**{#setting-pg-audit-log} {{ tag-con }}

  Defines which user queries will be included in the audit log.

  This setting only applies if the following conditions are met:

  * `pgaudit` [library is connected](../../managed-postgresql/operations/extensions/cluster-extensions.md#libraries-connection) to the cluster.
  * `pgaudit` [extension is enabled](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) for the database.

  The possible values are:

  * `read`: System logs `SELECT` and `COPY` queries if the data source is a relation or a query.
  * `write`: System logs `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries when the destination is a relation.
  * `function`: System logs function calls and `DO` blocks.
  * `role`: System logs the statements related to roles and privileges, e.g., `GRANT`, `REVOKE`, `CREATE/ALTER/DROP ROLE`.
  * `ddl`: System logs all `DDL` statements not included in the `ROLE` class.
  * `misc`: System logs miscellaneous commands, e.g., `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, `SET`.
  * `misc_set`: System logs miscellaneous `SET` commands, e.g., `SET ROLE`.

  You can specify multiple values. By default, user audit logs are disabled.

  To learn more about configuring audit logs, see [Using pgaudit](../../managed-postgresql/operations/extensions/pgaudit.md).

- **Pooling mode**{#setting-pooling-mode} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    {% note info %}

    * In {{ TF }} and the gRPC API, this setting is called `pool_mode`.
    * In the REST API, this setting is called `poolMode`.

    {% endnote %}

    [Connection pooling mode](../../managed-postgresql/concepts/pooling.md) used by the Odyssey connection pooler.

    The possible values are:

    * `SESSION`: Session mode.
    * `TRANSACTION`: Transaction mode.
    * `STATEMENT`: Statement mode.

    
    The default value is `SESSION`.


- **Prepared statements pooling**{#setting-prepared-statements-pooling} {{ tag-con }}

  Allows using prepared statements with transaction pooling.

- **Synchronous commit**{#setting-user-synchronous-commit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Refer to the [Synchronous commit](#setting-synchronous-commit) cluster-level setting description.

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Refer to the [Temp file limit](#setting-temp-file-limit) cluster-level setting description.

- **Wal sender timeout**{#setting-wal-sender-timeout} {{ tag-con }}

  Time (in ms) after which inactive replication connections are terminated.

  {% include [settings-version](../../_includes/mdb/mpg/mpg-settings-v-12.md) %}
