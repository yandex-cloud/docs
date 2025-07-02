# {{ MY }} user management

You can add and remove users, as well as manage their settings.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the following command:

  ```
  {{ yc-mdb-my }} user list --cluster-name=<cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.list](../api-ref/User/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/list.md#yandex.cloud.mdb.mysql.v1.ListUsersResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [UserService/List](../api-ref/grpc/User/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.List
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.mysql.v1.ListUsersResponse) to make sure the request was successful.

{% endlist %}

## Creating a user {#adduser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Enter a database user name.

     {% include [user-name](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  1. Select how to set a password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Enter your own password. The password must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using {{ connection-manager-name }}.

      To view the password, select the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab on the cluster page and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

  1. Select one or more databases that the user should have access to:
      1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, hover over the row with the database name and click ![image](../../_assets/console-icons/xmark.svg) at the end of the row.
  1. Set up [user privileges](../concepts/user-rights.md#db-privileges) for each of the selected databases:
      1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column, click ![image](../../_assets/console-icons/plus.svg).
      1. Select the privilege you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required privileges are added.
  1. To revoke a privilege granted by mistake, click ![image](../../_assets/console-icons/xmark.svg) to the right of its name.
  1. If necessary, specify the [{{ MY }} settings and administrative privileges](../concepts/settings-list.md#dbms-user-settings) for the user.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```bash
  {{ yc-mdb-my }} user create <username> \
    --cluster-name=<cluster_name> \
    --password=<user_password> \
    --permissions=<DB_list>
  ```

  Where:

  * `cluster-name`: Cluster name.

  * `password`: User password. The password must be from 8 to 128 characters long.

    You can also generate a password using {{ connection-manager-name }}. To do this, specify `--generate-password` instead of `--password=<password>`.

    To view the password, select the cluster you need in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

  * `permissions`: List of DBs the user must have access to.

  {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](./cluster-create.md).

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

      {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      The password must be from 8 to 128 characters long.

      You can also generate a password using {{ connection-manager-name }}. To do this, specify `generate_password = true` instead of `password = "<password>"`.

      To view the password, select the cluster you need in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and add the following contents to it:

      ```json
      {
          "userSpec": {
              "name": "<username>",
              "password": "<user_password>",
              "permissions": [
                  {
                      "databaseName": "<DB_name>",
                      "roles": [
                          "<privilege_1>", "<privilege_2>", ..., "<privilege_N>"
                      ]
                  }
              ]
          }
      }'
      ```

      Where `userSpec` lists the new DB user settings:

      * `name`: Username.

          {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `password`: User password. The password must be from 8 to 128 characters long.

          You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

          To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

      * `permissions`: User permission settings:

          * `databaseName`: Name of the database the user gets access to.
          * `roles`: Array of user privileges. Each priviledge is provided as a separate string in the array. For the list of possible values, see [{#T}](../concepts/user-rights.md#db-privileges).

          For each database, add a separate element with permission settings to the `permissions` array.

  1. Use the [User.create](../api-ref/User/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users' \
          --data "@body.json"
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and add the following contents to it:

      ```json
      {
          "cluster_id": "<cluster_ID>",
          "user_spec": {
              "name": "<username>",
              "password": "<user_password>",
              "permissions": [
                  {
                      "database_name": "<DB_name>",
                      "roles": [
                          "<privilege_1>", "<privilege_2>", ..., "<privilege_N>"
                      ]
                  }
              ]
          }
      }
      ```

      Where `user_spec` represents the new DB user settings:

      * `name`: Username.

        {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `password`: User password. The password must be from 8 to 128 characters long.

        You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generate_password": true` instead of `"password": "<user_password>"`.

        To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

      * `permissions`: User permission settings:

          * `database_name`: Name of the database the user gets access to.
          * `roles`: Array of user privileges. Each priviledge is provided as a separate string in the array. For the list of possible values, see [{#T}](../concepts/user-rights.md#db-privileges).

          For each database, add a separate element with permission settings to the `permissions` array.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Use the [UserService/Create](../api-ref/grpc/User/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Create \
          < body.json
      ```

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing a password {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Select how to set a new password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Enter your own password. The password must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using {{ connection-manager-name }}.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  To view the new password, select the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab on the cluster page and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

  To view passwords, you need the `lockbox.payloadViewer` role.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user password, run this command:

  ```bash
  {{ yc-mdb-my }} user update <username> \
    --cluster-name=<cluster_name> \
    --password=<new_password>
  ```

  The password must be from 8 to 128 characters long.

  You can also generate a new password using {{ connection-manager-name }}. To do this, specify `--generate-password` instead of `--password=<new_password>`.

  To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

  To view passwords, you need the `lockbox.payloadViewer` role.

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](./cluster-create.md).

  1. Locate the user's `yandex_mdb_mysql_user` resource.

  1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<new_password>"
        ...
      }
      ```

      The password must be from 8 to 128 characters long.

      You can also generate a new password using {{ connection-manager-name }}. To do this, specify `generate_password = true` instead of `password = "<new_password>"`.

      To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

      {% note info %}

      If the old password was generated, you cannot regenerate it using {{ TF }} due to provider limitations.

      {% endnote %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.update](../api-ref/User/update.md) method and send the following request, e.g., using {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users/<username>' \
          --data '{
                    "updateMask": "password",
                    "password": "<new_password>"
                  }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          In this case, only one parameter is provided.

      * `password`: New password. The password must be from 8 to 128 characters long.

        You can also generate a password using {{ connection-manager-name }}. To do this, edit the contents of the `data` field:

        ```bash
        {
          "updateMask": "generatePassword",
          "generatePassword": true
        }
        ```

        To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

        To view passwords, you need the `lockbox.payloadViewer` role.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [UserService/Update](../api-ref/grpc/User/update.md) call and send the following request, e.g., using {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "user_name": "<username>",
                "update_mask": {
                  "paths": [
                    "password"
                  ]
                },
                "password": "<new_password>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          Only one parameter is provided in this case.

      * `password`: New password. The password must be from 8 to 128 characters long.

        You can also generate a password using {{ connection-manager-name }}. To do this, edit the contents of the `d` parameter:

        ```bash
        {
          "cluster_id": "<cluster_ID>",
          "user_name": "<username>",
          "update_mask": {
            "paths": [
              "generate_password"
            ]
          },
          "generate_password": true
        }
        ```

        To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

        To view passwords, you need the `lockbox.payloadViewer` role.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing user settings {#update-settings}

{% note tip %}

To change user permissions to access databases, follow [this guide](grant.md#grant-privilege).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
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
    --max-questions-per-hour=<maximum_requests> \
    --max-updates-per-hour=<maximum_UPDATE_requests> \
    --max-connections-per-hour=<maximum_connections> \
    --max-user-connections=<maximum_concurrent_connections>
  ```

  Where:

  * `global-permissions`: Comma-separated list of administrative privileges.
  * `max-questions-per-hour`: Maximum number of requests per hour.
  * `max-updates-per-hour`: Maximum number of `UPDATE` requests per hour.
  * `max-connections-per-hour`: Maximum number of connections per hour.
  * `max-user-connections`: Maximum number of concurrent connections.

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](./cluster-create.md).

  1. Locate the user's `yandex_mdb_mysql_user` resource.

  1. To set limits on the number of connections and requests, add the `connection_limits` section to the resource description:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        ...
        connection_limits {
          max_questions_per_hour   = <maximum_requests>
          max_updates_per_hour     = <maximum_UPDATE_requests>
          max_connections_per_hour = <maximum_connections>
          max_user_connections     = <maximum_concurrent_connections>
          ...
        }
      }
      ```

      Where:

      * `max-questions-per-hour`: Maximum number of requests per hour.
      * `max-updates-per-hour`: Maximum number of `UPDATE` requests per hour.
      * `max-connections-per-hour`: Maximum number of connections per hour.
      * `max-user-connections`: Maximum number of concurrent connections.

  1. To configure a user authentication plugin, add the `authentication_plugin` section to the resource description:

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

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.update](../api-ref/User/update.md) method and send the following request, e.g., using {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users/<username>' \
          --data '{
                    "updateMask": "globalPermissions,connectionLimits,authenticationPlugin",
                    "globalPermissions": [
                      "<administrative_privilege_1>",
                      "<administrative_privilege_2>",
                      ...,
                      "<administrative_privilege_N>"
                    ],
                    "connectionLimits": {
                      "maxQuestionsPerHour": "<maximum_requests>",
                      "maxUpdatesPerHour": "<maximum_UPDATE_requests>",
                      "maxConnectionsPerHour": "<maximum_connections>",
                      "maxUserConnections": "<maximum_concurrent_connections>"
                    },
                    "authenticationPlugin": "<authentication_plugin>"
                  }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.
      * `globalPermissions`: Array of administrative privileges. each provided as a separate string in the array. For the list of possible values, see the [method description](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connectionLimits`: User connection settings:

          * `maxQuestionsPerHour`: Maximum number of requests per hour.
          * `maxUpdatesPerHour`: Maximum number of `UPDATE` requests per hour.
          * `maxConnectionsPerHour`: Maximum number of connections per hour.
          * `maxUserConnections`: Maximum number of concurrent connections.

          The minimum value for each connection setting is `0`.

      * `authenticationPlugin`: User authentication plugin. For the list of available plugins, see the [method description](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [UserService/Update](../api-ref/grpc/User/update.md) call and send the following request, e.g., using {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "user_name": "<username>",
                "update_mask": {
                  "paths": [
                    "global_permissions",
                    "connection_limits",
                    "authentication_plugin"
                  ]
                },
                "global_permissions": [
                  "<administrative_privilege_1>",
                  "<administrative_privilege_2>",
                  ...,
                  "<administrative_privilege_N>"
                ],
                "connection_limits": {
                  "max_questions_per_hour": "<maximum_requests>",
                  "max_updates_per_hour": "<maximum_UPDATE_requests>",
                  "max_connections_per_hour": "<maximum_connections>",
                  "max_user_connections": "<maximum_concurrent_connections>"
                },
                "authentication_plugin": "<authentication_plugin>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.
      * `global_permissions`: Array of administrative privileges. each provided as a separate string in the array. For the list of possible values, see the [method description](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connection_limits`: User connection settings:

          * `max_questions_per_hour`: Maximum number of requests per hour.
          * `max_updates_per_hour`: Maximum number of `UPDATE` requests per hour.
          * `max_connections_per_hour`: Maximum number of connections per hour.
          * `max_user_connections`: Maximum number of concurrent connections.

          The minimum value for each connection setting is `0`.

      * `authentication_plugin`: User authentication plugin. For a list of available plugins, see the [method description](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  {{ yc-mdb-my }} user delete <username> --cluster-name=<cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

  1. Delete the `yandex_mdb_mysql_user` resource with the user's description.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.delete](../api-ref/User/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users/<username>'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [UserService/Delete](../api-ref/grpc/User/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "user_name": "<username>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Delete
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
