# Managing {{ MY }} users

You can add and remove users, as well as manage their settings.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of cluster users, run the following command:

  ```
  {{ yc-mdb-my }} user list --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.list](../api-ref/User/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/User/list.md#yandex.cloud.mdb.mysql.v1.ListUsersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/List](../api-ref/grpc/User/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.mysql.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Creating a user {#adduser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Specify the database user’s name.

     {% include [user-name](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  
  1. Select a method for setting a password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Set your own password. The password must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password with {{ connection-manager-name }}.

      To view the password, navigate to the cluster page, select the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the new user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


  1. Select one or more databases the user will have access to:
      1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
      1. Select the database from the drop-down list.
      1. Repeat these two steps to select all required databases.
      1. To delete a database added by mistake, hover over the database row and click ![image](../../_assets/console-icons/xmark.svg).
  1. Set up [user privileges](../concepts/user-rights.md#db-privileges) for each of the selected databases:
      1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column, click ![image](../../_assets/console-icons/plus.svg).
      1. In the drop-down list, select the privilege you want to grant the user.
      1. Repeat these two steps to add all required privileges.
  1. To revoke a privilege granted by mistake, click ![image](../../_assets/console-icons/xmark.svg) to its right.
  1. Configure the [{{ MY }} settings and administrative privileges](../concepts/settings-list.md#dbms-user-settings) for the user, if required.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster user, run this command:

  ```bash
  {{ yc-mdb-my }} user create <username> \
    --cluster-name=<cluster_name> \
    --password=<user_password> \
    --permissions=<database_list>
  ```

  Where:

  * `cluster-name`: Cluster name.

  * `password`: User password. The password must be from 8 to 128 characters long.

    
    You can also generate a password using {{ connection-manager-name }}. To do this, specify `--generate-password` rather than `--password=<password>`.

    To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the new user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


  * `permissions`: List of databases the user will have access to.

  {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

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

      * `database_name`: Name of the database the user will have access to.
      * `roles`: List of user privileges for the database.

      {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      The password must be from 8 to 128 characters long.

      
      You can also generate a password using {{ connection-manager-name }}. To do this, specify `generate_password = true` rather than `password = "<password>"`.

      To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the new user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

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

      Where `userSpec` are the settings for the new database user:

      * `name`: Username.

          {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `password`: Password. The password must be from 8 to 128 characters long.

          
          You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` rather than `"password": "<user_password>"`.

          To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


      * `permissions`: User permission settings:

          * `databaseName`: Name of the database to which the user will have access.
          * `roles`: Array of user privileges, each provided as a separate string in the array. For the list of possible values, see [{#T}](../concepts/user-rights.md#db-privileges).

          For each database, add a separate element with permission settings to the `permissions` array.

  1. Call the [User.create](../api-ref/User/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users' \
          --data "@body.json"
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

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

      Where `user_spec` are the settings for the new database user:

      * `name`: Username.

        {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `password`: Password. The password must be from 8 to 128 characters long.

        
        You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generate_password": true` rather than `"password": "<user_password>"`.

        To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


      * `permissions`: User permission settings:

          * `database_name`: Name of the database to which the user will have access.
          * `roles`: Array of user privileges, each provided as a separate string in the array. For the list of possible values, see [{#T}](../concepts/user-rights.md#db-privileges).

          For each database, add a separate element with permission settings to the `permissions` array.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Call the [UserService/Create](../api-ref/grpc/User/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a password {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.

  
  1. Select a method for setting a new password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Set your own password. The password must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password with {{ connection-manager-name }}.


  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  
  To view the new password, navigate to the cluster page, select the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

  To view passwords, you need the `lockbox.payloadViewer` role.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a user password, run this command:

  ```bash
  {{ yc-mdb-my }} user update <username> \
    --cluster-name=<cluster_name> \
    --password=<new_password>
  ```

  The password must be from 8 to 128 characters long.

  
  You can also generate a new password with {{ connection-manager-name }}. To do this, specify `--generate-password` rather than `--password=<new_password>`.

  To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

  To view passwords, you need the `lockbox.payloadViewer` role.


  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

  1. Locate the `yandex_mdb_mysql_user` resource for the user in question.

  1. Update the `password` field:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<new_password>"
        ...
      }
      ```

      The password must be from 8 to 128 characters long.

      
      You can also generate a new password with {{ connection-manager-name }}. To do this, specify `generate_password = true` rather than `password = "<new_password>"`.

      To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

      {% note info %}

      If the current password has been automatically generated, you cannot regenerate it using {{ TF }} due to provider limitations.

      {% endnote %}


  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `password`: New password. The password must be from 8 to 128 characters long.

        
        You can also generate a password using {{ connection-manager-name }}. To do this, modify the `data` field as follows:

        ```bash
        {
          "updateMask": "generatePassword",
          "generatePassword": true
        }
        ```

        To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

        To view passwords, you need the `lockbox.payloadViewer` role.


      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](#list-users).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `password`: New password. The password must be from 8 to 128 characters long.

        
        You can also generate a password using {{ connection-manager-name }}. To do this, modify the `d` parameter as follows:

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

        To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

        To view passwords, you need the `lockbox.payloadViewer` role.


      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](#list-users).

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing user settings {#update-settings}

{% note tip %}

To change user's database access privileges, follow [this guide](grant.md#grant-privilege).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for a user, run this command:

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

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

  1. Locate the `yandex_mdb_mysql_user` resource for the user in question.

  1. To set limits on the number of connections and requests, add the `connection_limits` section to the user description:

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

  1. To configure a user authentication plugin, add the `authentication_plugin` section to the user description:

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

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      * `updateMask`: Comma-separated list of settings you want to update.
      * `globalPermissions`: Array of administrative privileges, each provided as a separate string in the array. For the list of possible values, see the [method description](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connectionLimits`: User connection settings:

          * `maxQuestionsPerHour`: Maximum number of requests per hour.
          * `maxUpdatesPerHour`: Maximum number of `UPDATE` requests per hour.
          * `maxConnectionsPerHour`: Maximum number of connections per hour.
          * `maxUserConnections`: Maximum number of concurrent connections.

          The minimum value for each of these connection settings is `0`.

      * `authenticationPlugin`: User authentication plugin. For the list of available plugins, see the [method description](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](#list-users).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
      * `global_permissions`: Array of administrative privileges, each provided as a separate string in the array. For the list of possible values, see the [method description](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connection_limits`: User connection settings:

          * `max_questions_per_hour`: Maximum number of requests per hour.
          * `max_updates_per_hour`: Maximum number of `UPDATE` requests per hour.
          * `max_connections_per_hour`: Maximum number of connections per hour.
          * `max_user_connections`: Maximum number of concurrent connections.

          The minimum value for each of these connection settings is `0`.

      * `authentication_plugin`: User authentication plugin. For the list of available plugins, see the [method description](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](#list-users).

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a user, run this command:

  ```
  {{ yc-mdb-my }} user delete <username> --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information on how to create this file, see [this guide](cluster-create.md).

  1. Delete the `yandex_mdb_mysql_user` resource with the user description.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.delete](../api-ref/User/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users/<username>'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](#list-users).

  1. Check the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Delete](../api-ref/grpc/User/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](#list-users).

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
