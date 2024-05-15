# Managing {{ MY }} users

You can add and remove users, as well as manage their settings.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster users, run the following command:

   ```
   {{ yc-mdb-my }} user list --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- API {#api}

   To get a list of users, use the [list](../api-ref/User/list.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/List](../api-ref/grpc/user_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Adding a user {#adduser}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.users.button_add }}**.
   1. Enter the database username and password.

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   1. Select one or more databases that the user should have access to:
      1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, hover over the line with the database name and click ![image](../../_assets/console-icons/xmark.svg) at the end of the line.
   1. Set up [user privileges](../concepts/user-rights.md#db-privileges) for each of the selected databases:
      1. Click ![image](../../_assets/console-icons/plus.svg) in the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column.
      1. Select the privilege you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required privileges are added.
   1. To revoke a privilege granted by mistake, click ![image](../../_assets/console-icons/xmark.svg) to the right of its name.
   1. If necessary, specify the [{{ MY }} settings and administrative privileges](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user in a cluster, run the command:

   ```
   {{ yc-mdb-my }} user create <username> \
     --cluster-name=<cluster_name> \
     --password=<user_password> \
     --permissions=<DB_list>
   ```

   Where `permissions` is a list of DBs the user must have access to.

   {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](./cluster-create.md).

   1. Add the `yandex_mdb_mysql_user` resource:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<password>"
        permission {
          database_name = "<DB_name>"
          roles         = [<list_of_privileges>]
        }
        ...
      }
      ```

      Where:

      * `database_name`: Name of the DB the user must have access to.
      * `roles`: List of user privileges for the DB.

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- API {#api}

   To add a user, use the [create](../api-ref/User/create.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Create](../api-ref/grpc/user_service.md#Create) gRPC API call and provide the following in the request:

   * ID of the cluster in which you want to create a user, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userSpec.name` parameter.
   * User password in the `userSpec.password` parameter.

      {% include [username-and-password-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   * The names of the databases that the user should have access to, in the required number of `userSpec.permissions.databaseName` parameters.
   * [User privileges](../concepts/user-rights.md#db-privileges) for each of the selected databases, in one or more `userSpec.permissions.roles` parameters.

{% endlist %}

## Changing a password {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
   1. Set a new password and click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

   {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user's password, run the command:

   ```
   {{ yc-mdb-my }} user update <username> \
     --cluster-name=<cluster_name> \
     --password=<new_password>
   ```

   {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](./cluster-create.md).

   1. Find the desired user's `yandex_mdb_mysql_user` resource.

   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<new_password>"
        ...
      }
      ```

      {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- API {#api}

   To update a user's password, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New user password in the `password` parameter.

      {% include [password-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

   * List of user configuration fields to update (`password` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing user settings {#update-settings}

{% note tip %}

To change user permissions to access databases, follow [this guide](grant.md#grant-privilege).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, run the command:

   ```
   {{ yc-mdb-my }} user update <username> \
     --cluster-name=<cluster_name> \
     --global-permissions=<list_of_privileges> \
     --authentication-plugin=<authentication_plugin> \
     --max-questions-per-hour=<max_queries> \
     --max-updates-per-hour=<max_UPDATE_queries> \
     --max-connections-per-hour=<max_connections> \
     --max-user-connections=<max_concurent_connections>
   ```

   Where:

   * `global-permissions`: Comma-separated list of administrative privileges.
   * `max-questions-per-hour`: Maximum number of queries per hour.
   * `max-updates-per-hour`: Maximum number of `UPDATE` queries per hour.
   * `max-connections-per-hour`: Maximum number of connections per hour.
   * `max-user-connections`: Maximum number of concurrent connections.

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](./cluster-create.md).

   1. Find the desired user's `yandex_mdb_mysql_user` resource.

   1. To set limits on the number of connections and requests, add a block named `connection_limits` to its description:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        ...
        connection_limits {
          max_questions_per_hour   = <max_queries>
          max_updates_per_hour     = <max_UPDATE_queries>
          max_connections_per_hour = <max_connections>
          max_user_connections     = <max_concurent_connections>
          ...
        }
      }
      ```

      Where:

      * `max-questions-per-hour`: Maximum number of queries per hour.
      * `max-updates-per-hour`: Maximum number of `UPDATE` queries per hour.
      * `max-connections-per-hour`: Maximum number of connections per hour.
      * `max-user-connections`: Maximum number of concurrent connections.

   1. To configure a user authentication plugin, add a block named `authentication_plugin` to its description:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        ...
        authentication_plugin = "<authentication_plugin>"
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- API {#api}

   To update user settings, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New values for user settings.
   * List of user configuration fields to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_remove }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```
   {{ yc-mdb-my }} user delete <username> --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Delete the `yandex_mdb_mysql_user` resource with the description of the desired user.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- API {#api}

   To delete a user, use the [delete](../api-ref/User/delete.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Delete](../api-ref/grpc/user_service.md#Delete) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
