---
title: "Assigning privileges and roles to MySQL users"
description: "In Managed Service for MySQL, privileges are atomic user authority over individual database objects. Roles are the privileges granted to a user on all user objects in a database. Users can have different sets of roles for different databases. For details on supported roles, see the roles description."
---
# Managing user permissions

You can manage user permissions at the level of an individual database by updating [user privileges](../concepts/user-rights.md).

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Changing user privileges {#grant-privilege}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.

   1. Click on the name of the cluster you need and select the **Users** tab.

   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.

   1. Add the desired databases for the user:

      1. Click **Add database**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To revoke access to a specific database, delete it from the list by clicking ![image](../../_assets/cross.svg) to the right of the database name.

   1. Set up user privileges for each of the user's databases.

      1. Click ![image](../../_assets/plus-sign.svg) in the **Roles** column.
      1. Select the privilege you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required privileges are added.

   1. To revoke a privilege, click ![image](../../_assets/cross.svg) to the right of its name.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   * Granting privileges to a user:

      ```bash
      {{ yc-mdb-my }} user grant-permission <username> \
        --cluster-name <cluster name> \
        --database <DB name> \
        --permissions <comma-separated set of privileges>
      ```

      You can request the cluster name with a [list of clusters in the folder](cluster-list.md), the DB name with a [list of databases in the cluster](databases.md#list-db), and the user's name with a [list of users in the cluster](cluster-users.md#list-users).

   * Revoking user privileges:

      ```bash
      {{ yc-mdb-my }} user revoke-permission <username> \
        --cluster-name <cluster name> \
        --database <DB name> \
        --permissions <comma-separated set of privileges>
      ```

      To grant or revoke the `ALL_PRIVILEGES` privilege, pass the synonym `ALL` as the privilege name.

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the cluster description, find the `user` block with a description of the user and change the list of their privileges for the required database in the `roles` parameter:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        user {
          name     = "<username>"
          password = "<password>"
          permission {
            database_name = "<name of the DB the user can access>"
            roles         = [<list of user privileges for the DB>]
            ...
          }
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userName` parameter. To find out the name, [get a list of users in the cluster](cluster-users.md#list-users).
   * The name of the DB that you want to change the list of user privileges for, in the `permissions.databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
   * Array of the new list of user privileges, in the `permissions.roles` parameter.
   * List of user configuration fields to be changed (in this case, `permissions`), in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
