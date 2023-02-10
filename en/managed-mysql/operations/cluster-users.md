# Managing {{ MY }} users

You can add and remove users, as well as manage their settings.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Getting a list of users {#list-users}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the desired cluster and then select the ![image-users](../../_assets/mdb/user.svg) **Users** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster users, run the command:

   ```
   {{ yc-mdb-my }} user list --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

   Use the [list](../api-ref/User/list.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click the name of the desired cluster and select the ![image-users](../../_assets/mdb/user.svg) **Users** tab.
   1. Click **Add**.
   1. Enter the database username and password.

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   1. Select one or more databases that the user should have access to:
      1. Click **Add database**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, hover over the line with the database name and click ![image](../../_assets/cross.svg) at the end of the line.
   1. Set up [user privileges](../concepts/user-rights.md#db-privileges) for each of the selected databases:
      1. Click ![image](../../_assets/plus-sign.svg) in the **Roles** column.
      1. Select the privilege you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required privileges are added.
   1. To revoke a privilege granted by mistake, click ![image](../../_assets/cross.svg) to the right of its name.
   1. If necessary, specify the [{{ MY }} settings and administrative privileges](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user in a cluster, run the command:

   ```
   {{ yc-mdb-my }} user create <username> \
     --cluster-name=<cluster name> \
     --password=<user password> \
     --permissions=<list of databases to grant a user access to>
   ```

   {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. Add the `yandex_mdb_mysql_user` resource:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster ID>"
        name     = "<username>"
          password = "<password>"
          permission {
            database_name = "<name of the DB the user can access>"
           roles         = [<list of user privileges for the DB>]
        }
        ...
      }
      ```

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mysql_user).

- API

   Use the [create](../api-ref/User/create.md) API method and pass the following information in the request:

   * The ID of the cluster where you want to create a user, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userSpec.name` parameter.
   * User password, in the `userSpec.password` parameter.

      {% include [username-and-password-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   * The names of the databases that the user should have access to, in the required number of `userSpec.permissions.databaseName` parameters.
   * [User privileges](../concepts/user-rights.md#db-privileges) for each of the selected databases, in one or more `userSpec.permissions.roles` parameters.

{% endlist %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click the name of the desired cluster and select the ![image-users](../../_assets/mdb/user.svg) **Users** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon and select **Change password**.
   1. Set a new password and click **Edit**.

   {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user's password, run the command:

   ```
   {{ yc-mdb-my }} user update <username> \
     --cluster-name=<cluster name> \
     --password=<new password>
   ```

   {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. Find the desired user's `yandex_mdb_mysql_user` resource.

   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster ID>"
        name       = "<username>"
        password   = "<new password>"
        ...
      }
      ```

      {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mysql_user).

- API

   Use the [update](../api-ref/User/update.md) API method and pass the following in the request:

   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New user password, in the `password` parameter.

      {% include [password-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

   * List of user configuration fields to update (`password` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing user settings {#update-settings}

{% note tip %}

To change the user's permissions to access certain databases, follow the [instructions](grant.md#grant-privilege).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click the name of the desired cluster and select the ![image-users](../../_assets/mdb/user.svg) **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
   1. Configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, run the command:

   ```
   {{ yc-mdb-my }} user update <username> \
     --cluster-name=<cluster name> \
     --global-permissions=<comma-separated list of administrative privileges> \
     --authentication-plugin=<authentication plugin> \
     --max-questions-per-hour=<maximum number of requests per hour> \
     --max-updates-per-hour=<maximum number of UPDATE requests per hour> \
     --max-connections-per-hour=<maximum number of connections per hour> \
     --max-user-connections=<maximum number of simultaneous connections>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. Find the desired user's `yandex_mdb_mysql_user` resource.

   1. To set limits on the number of connections and requests, add a block named `connection_limits` to its description:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        ...
        connection_limits {
            max_questions_per_hour   = <maximum number of requests per hour>
            max_updates_per_hour     = <maximum number of UPDATE requests per hour>
            max_connections_per_hour = <maximum number of connections per hour>
            max_user_connections     = <maximum number of simultaneous connections>
          ...
        }
      }
      ```

   1. To configure a user authentication plugin, add a block named `authentication_plugin` to its description:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        ...
        authentication_plugin = "<authentication plugin>"
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mysql_user).

- API

   Use the [update](../api-ref/User/update.md) API method and pass the following in the request:

   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).
   * New values for user settings.
   * List of user configuration fields to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click the name of the desired cluster and select the ![image-users](../../_assets/mdb/user.svg) **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```
   {{ yc-mdb-my }} user delete <username> --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `yandex_mdb_mysql_user` resource with the description of the desired user.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mysql_user).

- API

   Use the [delete](../api-ref/User/delete.md) API method and pass the following in the request:
   * The ID of the cluster where the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userName` parameter. To get the username, [retrieve a list of users in the cluster](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
