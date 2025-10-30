- **Authentication plugin**{#setting-authentication-plugin} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Authentication plugin that defines user authentication policy.

  By default, it is not specified, and the `Default authentication plugin` option you select when creating a cluster applies.

  To learn more about authentication plugins, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/pluggable-authentication.html).

- **Administrative privileges**{#setting-administrative-privileges} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Administrative privileges are [user permissions](../../managed-mysql/concepts/user-rights.md) that apply at the level of the entire DB cluster.

  You can grant the following administrative privileges to users:

  - [REPLICATION CLIENT](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-client): Enables use of statements:

    - [SHOW MASTER STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-master-status.html): Provides information about the status of the master's binary logs.
    - [SHOW REPLICA | SLAVE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-replica-status.html): Provides information about the status of the replication thread basic properties.
    - [SHOW BINARY LOGS](https://dev.mysql.com/doc/refman/8.0/en/show-binary-logs.html): Displays a list of binary logs on the cluster host.

  - [REPLICATION SLAVE](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-slave): Enables connections to the replication thread from outside {{ yandex-cloud }}. Enables use of statements:

    - [SHOW REPLICAS | SHOW SLAVE HOSTS](https://dev.mysql.com/doc/refman/8.0/en/show-replicas.html): Displays a list of currently registered replicas.
    - [SHOW RELAYLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-relaylog-events.html): Shows events in a replica relay log.
    - [SHOW BINLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-binlog-events.html): Shows events in a binary log.

  - [PROCESS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_process): Allows using the `SHOW PROCESSLIST` operator and viewing the status of data storage systems, e.g., `SHOW ENGINE INNODB STATUS`. In {{ mmy-name }}, this privilege also grants permission to read [mysql](https://dev.mysql.com/doc/refman/8.0/en/system-schema.html), [performance_schema](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html), and [sys](https://dev.mysql.com/doc/refman/8.0/en/sys-schema.html) system database tables.

  - [FLUSH OPTIMIZER COSTS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_flush-optimizer-costs): Enables using the `FLUSH OPTIMIZER_COSTS` operator.

  - `SHOW ROUTINE`: Enables viewing all definitions of stored procedures and functions in the `information_schema.ROUTINES` table (including those where a user with this privilege is not specified in the `DEFINER` field). Enables use of statements:

    - [SHOW CREATE FUNCTION](https://dev.mysql.com/doc/refman/8.0/en/show-create-function.html): Provides detailed information about a stored function.
    - [SHOW FUNCTION STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-function-status.html): Outputs brief information about a stored function.
    - [SHOW CREATE PROCEDURE](https://dev.mysql.com/doc/refman/8.0/en/show-create-procedure.html): Provides detailed information about a stored procedure.
    - [SHOW PROCEDURE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-procedure-status.html): Outputs brief information about a stored procedure.

  - `MDB ADMIN`: Includes the `PROCESS`, `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, and `FLUSH_OPTIMIZER_COSTS` privileges. Additionally, it allows you to:

    - Run the [KILL](https://dev.mysql.com/doc/refman/8.0/en/kill.html) command for user queries.
    - Create and delete custom databases and users.
    - Grant permissions for objects created by a user.

    {% note warning %}

    Objects created by a user with the `MDB ADMIN` privilege are not displayed in the user interface. Use this privilege to create temporary auxiliary databases and users.

    {% endnote %}

  By default, this setting is not specified, which means the user has no administrative privileges. You can also grant multiple privileges to users.

- **Connection limits**{#setting-connection-limits} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  This section configures user restrictions.

  - **Max connections per hour**{#setting-max-connection-per-hour}
  
    Maximum number of connections per hour allowed for the user.

    The minimum value is 0 (no limit).
    By default, this setting is not specified, which means there is no limit.

  - **Max questions per hour**{#setting-max-questions-per-hour}
  
    Maximum number of queries per hour allowed for the user (except for queries executed within stored procedures).

    The minimum value is 0 (no limit).
    By default, this setting is not specified, which means there is no limit.

  - **Max updates per hour**{#setting-max-updates-per-hour}
  
    Maximum number of `UPDATE` queries per hour allowed for the user.

    The minimum value is 0 (no limit).
    By default, this setting is not specified, which means there is no limit.

  - **Max user connections**{#setting-max-user-connections}
  
    Maximum number of simultaneous connections allowed for the user.

    The minimum value is 0 (no limit).
    By default, this setting is not specified and the [max_user_connections](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_user_connections) global cluster setting applies.

  For more information, see this [{{ MY }} guide](https://dev.mysql.com/doc/refman/8.0/en/user-resources.html).
