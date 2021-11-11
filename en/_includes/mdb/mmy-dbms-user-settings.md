- **Authentication plugin**{#setting-authentication-plugin} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  An authentication plugin. Defines a user authentication policy.

  By default, not selected (the setting `Default authentication plugin` which you set when creating a cluster applies).

  To learn more about authentication plugins, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/pluggable-authentication.html).

- **Administrative privileges**{#setting-administrative-priveleges} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Administrative privileges are [user permissions](../../managed-mysql/concepts/user-rights.md) that apply at the level of the entire DB cluster.

  You can grant the following administrative privileges to users:

  - [REPLICATION CLIENT](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-client): Enables the use of statements:
    - [SHOW MASTER STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-master-status.html): Gives information about the state of the master's binary logs.
    - [SHOW REPLICA | SLAVE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-replica-status.html): Gives information about the state of the main parameters of the replication thread.
    - [SHOW BINARY LOGS](https://dev.mysql.com/doc/refman/8.0/en/show-binary-logs.html): Displays a list of binary logs on the cluster host.

  - [REPLICATION SLAVE](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-slave): Enables connections to the replication thread from outside {{ yandex-cloud }}. Enables use of statements:
    - [SHOW REPLICAS | SHOW SLAVE HOSTS](https://dev.mysql.com/doc/refman/8.0/en/show-replicas.html): Displays a list of currently registered replicas.
    - [SHOW RELAYLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-relaylog-events.html): Shows events in a replica relay log.
    - [SHOW BINLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-binlog-events.html): Shows events in a binary log.

  - [PROCESS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_process): Gives information about all threads running on the cluster host and enables the use of the [SHOW ENGINE](https://dev.mysql.com/doc/refman/8.0/en/show-engine.html) statement to access [InnoDB tables](https://dev.mysql.com/doc/refman/8.0/en/innodb-information-schema-system-tables.html).

  By default, not set (the user has no administrative privileges). You can grant users multiple privileges.

- **Connection limits**{#setting-connection-limits} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  A section to configure restrictions for the user.

  - **Max connections per hour**{#setting-max-connection-per-hour}

    The maximum number of connections per hour allowed for the user.

    The minimum value is 0 (no limitations).
    By default, not set (no limitations).

  - **Max questions per hour**{#setting-max-questions-per-hour}

    The maximum number of requests per hour allowed for the user (except for queries executed within stored procedures).

    The minimum value is 0 (no limitations).
    By default, not set (no limitations).

  - **Max updates per hour**{#setting-max-updates-per-hour}

    The maximum number of `UPDATE` requests per hour allowed for the user.

    The minimum value is 0 (no limitations).
    By default, not set (no limitations).

  - **Max user connections**{#setting-max-user-connections}

    The maximum number of simultaneous connections allowed for the user.

    The minimum value is 0 (no limitations).
    By default, not set (the general cluster setting [max_user_connections](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_user_connections) applies).

  To learn more, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/user-resources.html).

