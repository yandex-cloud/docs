---
title: "Managing PostgreSQL users"
description: "In this article you will learn how to add and remove users, as well as manage their individual settings in the PostgreSQL database management service."
---

# Managing {{ PG }} users

You can add and remove users, as well as manage their individual settings.

{% note warning %}

You can use SQL commands to assign privileges to users, but you can't use them to add or change users. For more information, see [{#T}](grant.md).

{% endnote %}

## Getting a list of users {#list-users}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the cluster you need and then select the **Users** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster users, run the following command:

   ```
   {{ yc-mdb-pg }} user list
        --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

   To get a list of cluster users, use the [list](../api-ref/User/list.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/List](../api-ref/grpc/user_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click **Add**.
   1. Enter the database username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   1. Select one or more databases that the user should have access to:
      1. Select the database from the **Database** drop-down list.
      1. Click **Add** to the right of the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, click ![image](../../_assets/cross.svg) to the right of the database name in the **Rights** list.
   1. Configure the [DBMS settings](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user in a cluster, run the command:

   ```
   {{ yc-mdb-pg }} user create <username>
        --cluster-name <cluster name>
        --password=<user password>
        --permissions=<list of DBs user can access>
        --conn-limit=<maximum number of connections per user>
   ```

   This command configures only the main user settings.

   {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   To customize the DBMS for the user, use the parameters described in [User settings](../concepts/settings-list.md#dbms-user-settings).

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_postgresql_user).

   1. Add the `yandex_mdb_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        cluster_id = "<cluster ID>"
        name       = "<username>"
        password   = "<password>"
        grants     = [ "<role1>","<role2>" ]
        login      = <allow logging in to the DB: true or false>
        conn_limit = <maximum number of connections>
        settings   = {
          <database settings>
        }
        permission {
          database_name = "<database name>"
        }
      }
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   To create a cluster user, use the [create](../api-ref/User/create.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Create](../api-ref/grpc/user_service.md#Create) gRPC API call and provide the following in the request:

   * The ID of the cluster where you want to create a user, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userSpec.name` parameter.
   * User password in the `userSpec.password` parameter.

      {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   * One or more databases that the user must have access to, in one or more `userSpec.permissions.databaseName` parameters.
   * Maximum number of connections for the user in the `userSpec.connLimit` parameter.

{% endlist %}

{% note info %}

When created, the user only gets the `CONNECT` privilege for the selected databases and can't perform any operations with the databases. To give the user access to the database, [assign](grant.md) them the required privileges or roles.

{% endnote %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon and select **Change password**.
   1. Set a new password and click **Edit**.

   {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user's password, run the command:

   ```
   {{ yc-mdb-pg }} user update <username>
       --cluster-name=<cluster name>
       --password=<new password>
   ```

   {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_postgresql_user).

   1. Find the `yandex_mdb_postgresql_user` resource of the desired user.
   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        name     = "<username>"
        password = "<new password>"
        ...
      }
      ```

      {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   To update a cluster user's password, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New user password, in the `password` parameter.

      {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   * List of user configuration fields to be changed (in this case, `password`), in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing user settings {#update-settings}

{% note info %}

The privileges and roles in {{ PG }} are not affected by these settings and are configured separately.

For information about setting up user privileges and roles, see [{#T}](grant.md).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
   1. Set up user permissions to access certain databases:
      1. To grant access to the required databases:
         1. Select the database from the **Database** drop-down list.
         1. Click **Add** to the right of the drop-down list.
         1. Repeat the previous two steps until all the required databases are selected.
      1. To revoke access to a specific database, delete it from the **Rights** list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
   1. Click **DBMS settings** to change the maximum allowed number of connections for the user (**Conn limit**), enable/disable the user to connect to a cluster (**Login**), or update other [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings).
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   You can change the user settings from the command line interface:

   1. To set up the user's permissions to access certain databases, run the command, listing the database names in the `--permissions` parameter:

      ```
      {{ yc-mdb-pg }} user update <username>
          --cluster-name=<cluster name>
          --permissions=<list of databases to grant a user access to>
      ```

      The cluster name can be requested with a [list of clusters in the folder](#list-clusters).

      This command grants the user access rights to the databases listed.

      To revoke access to a specific database, remove its name from the list and send the updated list to the command.

   1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, pass their parameters in the command:

      ```
      {{ yc-mdb-pg }} user update <username>
           --cluster-name=<cluster name>
           --<setting 1>=<value 1>
           --<setting 2>=<value 2>
           --<setting 3>=<list of values>
           ...
      ```

      You can change the connection limit for the user via the `--conn-limit` parameter.

      The cluster name can be requested with a [list of clusters in the folder](#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_postgresql_user).

   1. To grant the user permissions to access certain databases:
      1. Find the `yandex_mdb_postgresql_user` resource of the desired user.
      1. Add `permission` blocks with the appropriate DB names:

         ```hcl
         resource "yandex_mdb_postgresql_user" "<username>" {
           ...
           name = "<username>"
           permission {
             database_name = "<database name>"
           }
           permission {
             database_name = "<database name>"
           }
           ...
         }
         ```

   1. To revoke the user's permission to access a specific database, delete the `permission` block with the name of this DB from the configuration file.

   1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, pass their parameters in the `settings` block:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        name     = "<username>"
        settings = {
          <database name>
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   To update a cluster user's settings, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New values for [user settings](../concepts/settings-list.md#dbms-user-settings).
   * List of user configuration fields to be changed, in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```
   {{ yc-mdb-pg }} user delete <username>
      --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Delete the `yandex_mdb_postgresql_user` resource with the description of the desired user.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   To delete a user, use the [delete](../api-ref/User/delete.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Delete](../api-ref/grpc/user_service.md#Delete) gRPC API call and provide the following in the request:

   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
