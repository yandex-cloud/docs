---
title: "Assigning privileges and roles to SQL Server users"
description: "Atomic permissions in SQL Server are called privileges, permissions groups are called roles. Managed Service for SQL Server supports predefined roles. A user created with a Managed Service for SQL Server cluster is automatically assigned the owner role (DB_OWNER) of the first database in the cluster. Then you can create other users and customize their rights as you see fit."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Assigning privileges and roles to users

Atomic permissions in **{{ MS }}** are called _privileges_ and groups of permissions are called _roles_. **{{ mms-name }}** supports [predefined roles](#predefined-db-roles). For more information about how to manage permissions, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/security/authentication-access/getting-started-with-database-engine-permissions?view=sql-server-2016).

The user created with a **{{ mms-name }}** cluster is automatically assigned the owner (`DB_OWNER`) role for the first database in the cluster. After that, you can [create other users](cluster-users.md#adduser) and configure their permissions as you wish:

- [Updating the list of user roles](#grant-role).
- [Granting a privilege to a user](#grant-privilege).
- [Revoking a privilege from a user](#revoke-privilege).

## Updating the list of user roles {#grant-role}

To assign a **role** to a user, use the {{ yandex-cloud }} management console or API: the roles assigned by the `GRANT` request are canceled during the next database operation.

{% list tabs %}

- Management console

  To change a user's list of roles:
  1. Go to the folder page and select **{{ mms-name }}**.
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
2. Run the `GRANT` command. To learn more about the command syntax, see the [documentation for {{ MS }}](https://docs.microsoft.com/en-us/sql/t-sql/statements/grant-transact-sql?view=sql-server-2016).

## Revoking a privilege from a user {#revoke-privilege}

1. [Connect](connect.md) to the database under the account of the database owner.
2. Run the `REVOKE` command. To learn more about the command syntax, see the [documentation for {{ MS }}](https://docs.microsoft.com/en-us/sql/t-sql/statements/grant-transact-sql?view=sql-server-2016).

{% include [user-ro](../../_includes/mdb/mms-user-examples.md) %}

## Description of predefined roles {#predefined-db-roles}

  - `DB_OWNER`: Owner of the database. Users who have this role can perform any actions to configure and maintain the database, as well as delete the database in {{ MS }}.
  - `DB_SECURITYADMIN`: Security administrator. Users who have this role can manage privileges. They can extend their own access rights, so you need to track their actions.
  - `DB_ACCESSADMIN`: Access administrator. Users who have this role can grant or revoke remote database access rights for Windows users and groups and {{ MS }} users.
  - `DB_BACKUPOPERATOR`: Backup operator. Users who have this role can create database backups.
  - `DB_DDLADMIN`: DDL administrator. Users who have this role can execute any data description language (DDL) command.
  - `DB_DATAWRITER`: User with write permission. Users with this role can add, delete, or change data in any user table.
  - `DB_DATAREADER`: User with read permission. Users who have this role can read all the data from all user tables.
  - `DB_DENYDATAWRITER`: User who was denied write permission. Users who have this role can't add, modify, or delete the data in user tables in the database.
  - `DB_DENYDATAREADER`: User who was denied read permission. Users who have this role can't read the data from user tables in the database.

