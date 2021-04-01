# Managing {{ MY }} users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ {{ yc-mdb-my }} user list --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter a database username and password (from 8 to 128 characters).
  1. Select one or more databases that the user should have access to:
      1. Click **Add database**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, hover over the row with the database name and click ![image](../../_assets/cross.svg) at the end of the line.
  1. Set up [user roles](grant.md#db-roles) for each of the selected databases:
      1. Click ![image](../../_assets/plus-sign.svg) in the **Roles** column.
      1. Select the role you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required roles are added.
  1. To revoke a role granted by mistake, click ![image](../../_assets/cross.svg) to the right of its name.
  1. Configure [{{ MY }} settings](#advanced-settings) for the user in the **Additional settings** section.
  1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-my }} user create <username>
       --cluster-name=<cluster name>
       --password=<user password>
       --permissions=<list of DBs the user can access>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Change password**.
  1. Set a new password and click **Edit**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password, run the command:

  ```
  $ {{ yc-mdb-my }} user update <username>
       --cluster-name=<cluster name>
       --password=<new password>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing user settings {#update-settings}

To change a list of databases available to the user and the database access level, follow the [instructions on changing a list of roles](grant.md#grant-role).

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
  1. Configure [{{ MY }} settings](#advanced-settings) for the user in the **Additional settings** section.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure [{{ MY }} settings](#advanced-settings) for the user, run the command:

  ```
  $ {{ yc-mdb-my }} user update <username>
       --cluster-name=<cluster name>
       --global-permissions=<comma-separated list of global privileges>
       --authentication-plugin=<authentication plugin>
       --max-questions-per-hour=<maximum number of requests per hour>
       --max-updates-per-hour=<maximum number of UPDATE requests per hour>
       --max-connections-per-hour=<maximum number of connections per hour>
       --max-connections-per-hour=<maximum number of connections per hour>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ {{ yc-mdb-my }} user delete <username>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}

## Additional settings {#advanced-settings}

- **Authentication plugin**: An authentication plugin. Defines a user authentication policy.

  By default, not selected (the setting `Default authentication plugin` which you set when creating a cluster applies).

  To learn more about authentication plugins, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/pluggable-authentication.html).

- **Global permissions**: Server-level user's privileges (global privileges). You can set multiple global privileges for one user. Available privileges:
  - [REPLICATION CLIENT](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-client): Use this global privilege if you want to connect to the replication thread from outside {{ yandex-cloud }}. In this case, grant it to the user under whom the replication client connects to the cluster. This privilege allows you to use the following operators:
    - [SHOW MASTER STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-master-status.html): Gives information about the state of master's binary logs.
    - [SHOW REPLICA | SLAVE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-replica-status.html): Gives information about the state of the main parameters of the replication thread.
    - [SHOW BINARY LOGS](https://dev.mysql.com/doc/refman/8.0/en/show-binary-logs.html): Displays a list of binary logs on the server.
  - [REPLICATION SLAVE](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-slave): Use this global privilege if you want to connect to the replication thread from outside {{ yandex-cloud }}. In this case, grant it to the user under whom the replication client connects to the cluster. This privilege allows you to use the following operators:
    - [SHOW REPLICAS | SHOW SLAVE HOSTS](https://dev.mysql.com/doc/refman/8.0/en/show-replicas.html): Displays a list of currently registered replicas.
    - [SHOW RELAYLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-relaylog-events.html): Shows events in a replica relay log.
    - [SHOW BINLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-binlog-events.html): Shows events in a binary log.
  - [PROCESS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_process): Gives information about all threads running on the server and enables the use of the [SHOW ENGINE](https://dev.mysql.com/doc/refman/8.0/en/show-engine.html) operator to access [INNODB_ tables](https://dev.mysql.com/doc/refman/8.0/en/innodb-information-schema-system-tables.html).

  By default, not selected (global privileges are not granted to the user).

- **Connection limits** : A section to configure restrictions for the user.

  - **Max connections per hour**: The maximum number of connections per hour allowed for the user.

    The minimum value is 0 (no limitations).
By default, not set (no limitations).

  - **Max questions per hour**: The maximum number of requests per hour allowed for the user (except for queries executed within stored procedures).

    The minimum value is 0 (no limitations).
By default, not set (no limitations).

  - **Max updates per hour**: The maximum number of the `UPDATE` requests per hour allowed for the user.

    The minimum value is 0 (no limitations).
By default, not set (no limitations).

  - **Max user connections**: The maximum number of simultaneous connections allowed for the user.

    The minimum value is 0 (no limitations).
By default, not selected (the general server setting [max_user_connections](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_user_connections) applies).

  To learn more, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/user-resources.html).

