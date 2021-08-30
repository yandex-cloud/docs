---
title: "Assigning privileges and roles to MySQL users"
description: "In Managed Service for MySQL, privileges are atomic user authority over individual database objects. Roles are the privileges granted to a user on all user objects in a database. Users can have different sets of roles for different databases. For details on supported roles, see the roles description."
---

# Assigning privileges and roles to users

In **{{ mmy-name }}**, _privileges_ are atomic user permissions for individual database objects. _Roles_ are the privileges granted to the user for all user objects in a database. Users can have different role sets for different databases. To learn more about supported roles, see the [description of roles](#db-roles).

The user created with a **{{ mmy-name }}** cluster is automatically assigned the owner (`ALL_PRIVILEGES`) role for the first database in the cluster. After that, you can [create other users](cluster-users.md#adduser) and configure their permissions as you wish:

- [Updating the list of user roles](#grant-role).
- [Granting a privilege to a user](#grant-privilege).
- [Revoking a privilege from a user](#revoke-privilege).

## Updating the list of user roles {#grant-role}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
  1. Add the desired databases for the user:
     1. Click **Add database**.
     1. Select the database from the drop-down list.
     1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke access to a specific database, remove it from the list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
  1. Set up user roles for each of the selected user's databases.
     1. Click ![image](../../_assets/plus-sign.svg) in the **Roles** column.
     1. Select the role you want to add to the user from the drop-down list.
     1. Repeat the previous two steps until all the required roles are added.
  1. To revoke a role, click ![image](../../_assets/cross.svg) to the right of its name.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  ```bash
  $ {{ yc-mdb-my }} user grant-permission <username>
       --cluster-name <cluster name>
       --database <DB name>
       --permissions <comma-separated set of roles>
  ```

  You can find out the cluster name by requesting [a list of clusters in the folder](cluster-list.md), the database name by requesting [a list of databases in the cluster](databases.md#list-db), and the user name by requesting [a list of users in the cluster](cluster-users.md#list-users).

  To grant the `ALL_PRIVILEGES` role to a user, pass the synonym `ALL` as the role name.

- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the user is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Username, in the `userName` parameter. To find out the name, [get a list of users in the cluster](cluster-users.md#list-users).
  - The name of the database for which you want to change the list of user roles, in the `permissions.databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
  - Array of the new list of user roles, in the `permissions.roles` parameter.
  - List of user configuration fields to be changed (in this case, `permissions`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the name of the field to be changed (in this case, `permissions`), in the `updateMask` parameter.

  {% endnote %}

{% endlist %}

## Granting a privilege to a user {#grant-privilege}

1. [Connect](connect.md) to the database under the account of the database owner.
2. Run the `GRANT` command. To learn more about the syntax of the command, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/grant.html).

## Revoking a privilege from a user {#revoke-privilege}

1. [Connect](connect.md) to the database under the account of the database owner.
2. Run the `REVOKE` command. To learn more about the syntax of the command, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/revoke.html).

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}

## Description of roles {#db-roles}

  - `ALL_PRIVILEGES`: Allows you to perform any action with custom data in the database and using the `SHOW SLAVE STATUS` operator.
  - `ALL`: A synonym for the `ALL_PRIVILEGES` role used for managing roles via the CLI.
  - `ALTER`: Necessary to use the `ALTER TABLE` operator to change the structure of any custom tables in the database. Requires `CREATE` and `INSERT` permissions or `DROP`, `CREATE`, and `INSERT` permissions for renaming tables.
  - `ALTER_ROUTINE`: Necessary to use the `ALTER ROUTINE` operator to change or delete any stored custom procedures and functions in the database.
  - `CREATE`: Necessary to use the `CREATE` operator to create custom tables in the database.
  - `CREATE_ROUTINE`: Necessary to use the `CREATE ROUTINE` operator to create stored custom procedures and functions in the database.
  - `CREATE_TEMPORARY_TABLES`: Necessary to use the `CREATE TEMPORARY TABLE` operator to create temporary custom tables in the database.
  - `CREATE_VIEW`: Necessary to use the `CREATE VIEW` operator to create custom views in the database.
  - `DELETE`: Necessary to delete records from any custom tables in the database.
  - `DROP`: Necessary to delete tables and views.
  - `EVENT`: Necessary to create, change, delete, or display events in the [Event Scheduler](https://dev.mysql.com/doc/refman/8.0/en/events-overview.html).
  - `EXECUTE`: Necessary to execute any stored custom procedures and functions.
  - `INDEX`: Necessary to create and delete indexes from existing tables in the database.
  - `INSERT`: Necessary to insert records into custom tables in the database.
  - `LOCK_TABLES`: Allows the explicit use of the `LOCK_TABLES` operator to create table locks in the database.
  - `PROCESS`: Necessary to use the `SHOW PROCESSLIST` operator and view the status of data storage systems (for example, `SHOW ENGINE INNODB STATUS`). In addition, in {{ mmy-name }}, this role grants the permission to read [mysql](https://dev.mysql.com/doc/refman/8.0/en/system-schema.html), [performance_schema](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html), and [sys](https://dev.mysql.com/doc/refman/8.0/en/sys-schema.html) system database tables.
  - `SELECT`: Necessary to read data from tables in the database.
  - `SHOW_VIEW`: Necessary to use the `SHOW CREATE VIEW` operator.
  - `TRIGGER`: Necessary to create, delete, execute, or display triggers for existing tables in the database.
  - `UPDATE`: Necessary to update records in tables in the database.

