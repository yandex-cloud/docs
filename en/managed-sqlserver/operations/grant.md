---
title: "Granting privileges and roles to SQL Server users"
description: "Atomic permissions in SQL Server are called privileges and permission groups are called roles. {{ mms-name }} supports predefined roles. The user created with a {{ mms-name }} cluster is automatically assigned the owner (DB_OWNER) role for the first database in the cluster. After that, you can create other users and configure their permissions as you wish."
---

# Assigning privileges and roles to users

Atomic permissions in **{{ MS }}** are called _privileges_ and permission groups are called _roles_. **{{ mms-name }}** supports [predefined roles](#predefined-db-roles). For more information about managing permissions, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/security/authentication-access/getting-started-with-database-engine-permissions?view=sql-server-2016).

The user created with a **{{ mms-name }}** cluster is automatically assigned the owner (`DB_OWNER`) role for the first database in the cluster. After that, you can [create other users](cluster-users.md#adduser) and configure their permissions as you wish:
* [Updating the list of user roles](#grant-role).
* [Granting a privilege to a user](#grant-privilege).
* [Revoking a privilege from a user](#revoke-privilege).

## Updating the list of user roles {#grant-role}

To assign a **role** to a user, use the {{ yandex-cloud }} management console or {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}: the roles assigned by the `GRANT` request are canceled during the next database operation.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
   1. Add the desired databases for the user:
      1. Click **Add database**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To revoke access to a specific database, delete it from the list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
   1. Set up user roles for each of the selected user's databases.
      1. Click ![image](../../_assets/plus-sign.svg) in the **Roles** column.
      1. Select the role you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required roles are added.
   1. To revoke a privilege, click ![image](../../_assets/cross.svg) to the right of its name.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign roles to a cluster user, pass the list of the required roles in the `--grant-permission` parameter. This completely overwrites existing roles: if you want to extend or reduce the available list, first request the current roles with user information by running the `{{ yc-mdb-ms }} user get` command.

   To assign roles, run the command:

   ```bash
   {{ yc-mdb-ms }} user grant-permission <username> \
      --cluster-name=<cluster name> \
      --database=<database name> \
      --roles=<role list>
   ```

   Where:

   * `--cluster-name` is the name of a cluster.
      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * `--database`: Name of database a user has access to.
      Ste-by-step instructions for granting database access can be found under [User management](./cluster-users#update-settings).
   * `--roles`: List of roles to be granted to a user.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mms-name }} cluster description, find the `user` block for the required user.

   1. Edit the value in the `roles` field under `permission` for the databases.

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        user {
          ...
          permission {
            database_name = "<database name>"
            roles         = ["<list of user roles>"]
          }
          ...
        }
      }
      ```

      For a list of predefined user roles, see [below](#predefined-db-roles). A configuration file with an infrastructure plan should specify them without a prefix, such as, `OWNER`, `DDLADMIN`, and `DATAREADER`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/User/update.md) API method and pass the following in the request:

   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userName` parameter. To find out the name, [get a list of users in the cluster](cluster-users.md#list-users).
   * The name of the database that you want to change the list of user roles for, in the `permissions.databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
   * Array of the new list of user roles, in the `permissions.roles` parameter.
   * List of user configuration fields to update (`permissions` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Granting a privilege to a user {#grant-privilege}

1. [Connect](connect.md) to the database under the database owner's account.
1. Run the `GRANT` command. For more information about the command syntax, see the [{{ MS }} documentation]({{ ms.docs }}/sql/t-sql/statements/revoke-transact-sql?view=sql-server-2016).

## Revoking a privilege from a user {#revoke-privilege}

1. [Connect](connect.md) to the database under the database owner's account.
1. Run the `REVOKE` command. For more information about the command syntax, see the [{{ MS }} documentation]({{ ms.docs }}/sql/t-sql/statements/revoke-transact-sql?view=sql-server-2016).

{% include [user-ro](../../_includes/mdb/mms-user-examples.md) %}

## Description of predefined roles {#predefined-db-roles}

* `DB_OWNER`: Owner of the database. Users who have this role can perform any actions to configure and maintain the database, as well as delete the database in {{ MS }}.
* `DB_SECURITYADMIN`: Security administrator. Users who have this role can manage privileges. They can extend their own access rights, so you need to track their actions.
* `DB_ACCESSADMIN`: Access administrator. Users who have this role can grant or revoke remote database access rights for Windows users and groups and {{ MS }} users.
* `DB_BACKUPOPERATOR`: Backup operator. Users who have this role can create database backups.
* `DB_DDLADMIN`: DDL administrator. Users who have this role can execute any data description language (DDL) command.
* `DB_DATAWRITER`: User with write permission. Users with this role can add, delete, or change data in any user table.
* `DB_DATAREADER`: User with read permission. Users who have this role can read all the data from all user tables.
* `DB_DENYDATAWRITER`: User who was denied write permission. Users who have this role can't add, modify, or delete the data in user tables in the database.
* `DB_DENYDATAREADER`: User who was denied read permission. Users who have this role can't read the data from user tables in the database.
