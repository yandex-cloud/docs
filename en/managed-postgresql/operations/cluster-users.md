---
title: "Managing {{ PG }} cluster users in {{ mpg-full-name }}"
description: "In this tutorial, you will learn how to add and remove users, as well as manage their individual settings in the {{ PG }} database management service."
---

# Managing {{ PG }} users

You can add and remove users, as well as manage their individual settings.

{% note warning %}

You can use SQL commands to assign privileges to users, but you cannot use them to add or change users. For more information, see [Assigning privileges and roles to users](grant.md).

{% endnote %}

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster users, run the following command:

   ```
   {{ yc-mdb-pg }} user list \
        --cluster-name <cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- API {#api}

   To get a list of cluster users, use the [list](../api-ref/User/list.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/List](../api-ref/grpc/user_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a user {#adduser}

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.users.button_add }}**.
   1. Enter the database username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   1. Select the deletion protection type.

      The possible values include:
      - **Same as cluster**
      - **Enabled**
      - **Disabled**
   1. Select one or more databases that the user should have access to:
      1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) to the right of the drop-down list.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, click ![image](../../_assets/console-icons/xmark.svg) to the right of the database name.
   1. Configure the [DBMS settings](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user in a cluster, run the command:

   ```
   {{ yc-mdb-pg }} user create <username> \
        --cluster-name <cluster_name> \
        --password=<password> \
        --permissions=<DB_list> \
        --conn-limit=<maximum_number_of_connections>
   ```

   Where:

   * `cluster-name`: Cluster name.
   * `password`: User password.
   * `permissions`: List of DBs the user can access.
   * `conn-limit`: Maximum number of connections per user.

   This command configures only the main user settings.

   {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   To customize the DBMS for the user, use the parameters described in [User settings](../concepts/settings-list.md#dbms-user-settings).

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

   1. Add the `yandex_mdb_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<password>"
        grants     = [ "<role1>","<role2>" ]
        login      = <permission_to_log_in_to_DB>
        conn_limit = <maximum_number_of_connections>
        deletion_protection = <deletion_protection>
        settings   = {
          <DB_settings>
        }
        permission {
          database_name = "<DB_name>"
        }
      }
      ```

      Where:
      * `login`: Toggles the permission to log in to the DB. It may take either the `true` or `false` value.
      * `deletion_protection`: User deletion protection. It may take the `true`, `false`, or `unspecified` value (inherited from the cluster). The default value is `unspecified`.

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To create a cluster user, use the [create](../api-ref/User/create.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Create](../api-ref/grpc/user_service.md#Create) gRPC API call and provide the following in the request:

   * ID of the cluster in which you want to create a user, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userSpec.name` parameter.
   * User password in the `userSpec.password` parameter.

      {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   * Deletion protection type in the `deletionProtection` parameter. The possible values are `true` and `false`. The default value is `unspecified` (inherited from the cluster).
   * One or more databases that the user must have access to, in one or more `userSpec.permissions.databaseName` parameters.
   * Maximum number of connections for the user in the `userSpec.connLimit` parameter.

{% endlist %}

{% note info %}

When created, the user only gets the `CONNECT` privilege for the selected databases and cannot perform any operations with the databases. To give the user access to the database, [assign](grant.md) them the required privileges or roles.

{% endnote %}

## Changing a password {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
   1. Set a new password and click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

   {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user's password, run the command:

   ```
   {{ yc-mdb-pg }} user update <username> \
       --cluster-name=<cluster_name> \
       --password=<new_password>
   ```

   {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

   1. Find the `yandex_mdb_postgresql_user` resource of the desired user.
   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        name     = "<username>"
        password = "<new_password>"
        ...
      }
      ```

      {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To update a cluster user's password, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New user password in the `password` parameter.

      {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   * List of user configuration fields to be changed (in this case, `password`) in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing user settings {#update-settings}

{% note info %}

The privileges and roles in {{ PG }} are not affected by these settings and are configured separately.

For information on setting up user privileges and roles, see [Assigning privileges and roles to users](grant.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Set up user permissions to access certain databases:
      1. To grant access to the required databases:
         1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) to the right of the drop-down list.
         1. Select the database from the drop-down list.
         1. Repeat the previous two steps until all the required databases are selected.
      1. To revoke access to a specific database, click ![image](../../_assets/console-icons/xmark.svg) to the right of the database name.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}** to change the maximum allowed number of connections for the user (**Conn limit**), enable/disable the user to connect to a cluster (**Login**), or update other [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings).
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   You can change the user settings from the command line interface:

   1. To set up the user's permissions to access certain databases, run the command, listing the database names in the `--permissions` parameter:

      ```
      {{ yc-mdb-pg }} user update <username> \
          --cluster-name=<cluster_name> \
          --permissions=<DB_list>
      ```

      Where:

      * `cluster-name`: Cluster name.
      * `permissions`: List of DBs the user can access.

      You can request the cluster name with a [list of clusters in the folder](#list-clusters).

      This command grants the user access rights to the databases listed.

      To revoke access to a specific database, remove its name from the list and send the updated list to the command.

   1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, pass their parameters in the command:

      ```
      {{ yc-mdb-pg }} user update <username> \
           --cluster-name=<cluster_name> \
           --<setting_1>=<value_1> \
           --<setting_2>=<value_2> \
           --<setting_3>=<list_of_values> \
           ...
      ```

      You can change the connection limit for the user via the `--conn-limit` parameter.

      You can request the cluster name with a [list of clusters in the folder](#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

   1. To grant the user permissions to access certain databases:
      1. Find the `yandex_mdb_postgresql_user` resource of the desired user.
      1. Add `permission` blocks with the appropriate DB names:

         ```hcl
         resource "yandex_mdb_postgresql_user" "<username>" {
           ...
           name = "<username>"
           permission {
             database_name = "<DB_name>"
           }
           permission {
             database_name = "<DB_name>"
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
          <DB_settings>
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To update a cluster user's settings, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New values for [user settings](../concepts/settings-list.md#dbms-user-settings).
   * List of user configuration fields to be changed in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}



{% endlist %}

## Configuring deletion protection {#update-user-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Configure user deletion protection. To do this, select the relevant value in the **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** field.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

   1. Find the `yandex_mdb_postgresql_user` resource of the desired user.

   1. Add the `deletion_protection` parameter. Possible values: `true`, `false`, or `unspecified` (inherited from the cluster). The default value is `unspecified`.

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        deletion_protection = <deletion_protection>
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To configure user deletion protection in a cluster, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId `parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * `updateMask` parameter with the `deletionProtection` value.
   * New value of the `deletionProtection` parameter. The possible values are `true` and `false`. The default value is `unspecified` (inherited from the cluster).

   {% include [Сброс настроек изменяемого объекта](../../_includes/note-api-updatemask.md) %}



{% endlist %}

## Deleting a user {#removeuser}

A user can be protected against deletion. To delete such a user, [disable the protection](#update-user-deletion-protection) first.

{% list tabs group=instructions %}

- Management console {#console}

   To delete a user:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-remove }}**.
   1. Confirm the deletion.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```
   {{ yc-mdb-pg }} user delete <username> \
      --cluster-name <cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   To delete a user:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Delete the `yandex_mdb_postgresql_user` resource with the description of the desired user.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To delete a user, use the [delete](../api-ref/User/delete.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Delete](../api-ref/grpc/user_service.md#Delete) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
