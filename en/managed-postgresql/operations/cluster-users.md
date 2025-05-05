---
title: Managing {{ PG }} cluster users in {{ mpg-full-name }}
description: In this tutorial, you will learn how to add and remove users, as well as manage each user’s settings in the {{ PG }} database management service.
---

# User management {{ PG }}

You can add and remove users, as well as manage their individual settings.

{% note warning %}

You can use SQL commands to assign privileges to users but you cannot use them to add or change users. For more information, see [Assigning privileges and roles to users](grant.md).

{% endnote %}

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the following command:

  ```
  {{ yc-mdb-pg }} user list \
       --cluster-name <cluster_name>
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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users'
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/list.md#yandex.cloud.mdb.postgresql.v1.ListUsersResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [UserService.List](../api-ref/grpc/User/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.List
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.postgresql.v1.ListUsersResponse) to make sure the request was successful.

{% endlist %}

## Creating a user {#adduser}

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Enter a database username.

      {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  1. Select how to set a password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Enter your own password. The password must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man).

      To view the password, select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab on the cluster page and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

  1. Select the deletion protection type.

     The possible values are:
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
     --permissions=<database_list> \
     --conn-limit=<maximum_number_of_connections>
  ```

  Where:

  * `cluster-name`: Cluster name.
  * `password`: User password. The password must be from 8 to 128 characters long.

      You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, specify `--generate-password` instead of `--password=<password>`.

      To view the password, select the cluster you need in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

  * `permissions`: List of databases the user should have access to.
  * `conn-limit`: Maximum number of connections per user.

  This command configures only the main user settings.

  {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  To customize the DBMS for the user, use the parameters described in [User settings](../concepts/settings-list.md#dbms-user-settings).

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).

     For a complete list of editable fields in the {{ mpg-name }} cluster user configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

  1. Add the `yandex_mdb_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<password>"
        grants     = [ "<role1>","<role2>" ]
        login      = <DB_login_permission>
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
        * `login`: Permission to log in to the DB, `true` or `false`.
        * `deletion_protection`: User deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

      {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

      The password must be from 8 to 128 characters long.

      You can also generate a password using {{ connection-manager-name }}. To do this, specify `generate_password = true` instead of `password = "<password>"`.

      To view the password, select the cluster you need in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.create](../api-ref/User/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users' \
       --data '{
                 "userSpec": {
                   "name": "<username>",
                   "password": "<user_password>",
                   "permissions": [
                     {
                       "databaseName": "<DB_name>"
                     }
                   ],
                   "connLimit": "<maximum_number_of_DB_connections>",
                   "deletionProtection": <deletion_protection>
                 }
               }'
     ```

     Where `userSpec` lists the new DB user settings:

     * `name`: Username.

        {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * `password`: User password. The password must be from 8 to 128 characters long.
       
        You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

        To view the password, select the cluster you need in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

     * `permissions.databaseName`: Array of databases the user should have access to. Each array element is mapped to a separate DB.
     * `connLimit`: Maximum number of DB connections for the user.
     * `deletionProtection`: User deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Create](../api-ref/grpc/User/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_spec": {
               "name": "<username>",
               "password": "<user_password>",
               "permissions": [
                 {
                   "database_name": "<DB_name>"
                 }
               ],
               "conn_limit": "<maximum_number_of_DB_connections>",
               "deletion_protection": <deletion_protection>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Create
     ```

     Where `user_spec` lists the new DB user settings:

     * `name`: Username.

        {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * `password`: User password. The password must be from 8 to 128 characters long.
       
        You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generate_password": true` instead of `"password": "<user_password>"`.

        To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the new user row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

     * `permissions.database_name`: Array of databases the user should have access to. Each array element is mapped to a separate DB.
     * `conn_limit`: Maximum number of DB connections for the user.
     * `deletion_protection`: User deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% note info %}

Once created, the user only gets the `CONNECT` privilege for the selected databases and cannot perform any operations on them. To give the user access to the database, [assign](grant.md) them the required privileges or roles.

{% endnote %}

## Changing a password {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Select how to set a new password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Enter your own password. The password must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man).

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

      To view the new password, select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab on the cluster page and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.
    
      To view passwords, you need the `lockbox.payloadViewer` role.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user password, run this command:

  ```
  {{ yc-mdb-pg }} user update <username> \
       --cluster-name=<cluster_name> \
       --password=<new_password>
  ```

    The password must be from 8 to 128 characters long.

    You can also generate a new password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, specify `--generate-password` instead of `--password=<new_password>`.

    To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.
    
    To view passwords, you need the `lockbox.payloadViewer` role.

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of editable fields in the {{ mpg-name }} cluster user configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

  1. Locate the user's `yandex_mdb_postgresql_user` resource.
  1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        name     = "<username>"
        password = "<new_password>"
        ...
      }
      ```

      The password must be from 8 to 128 characters long.

      You can also generate a new password using [Connection Manager](cluster-create.md#conn-man). To do this, specify `generate_password = true` instead of `password = "<new_password>"`.

      To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

      {% note info %}

      If the old password was generated, you cannot regenerate it using {{ TF }} due to provider limitations.

      {% endnote %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "password",
                 "password": "<new_password>"
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `password`: New password. The password must be from 8 to 128 characters long.

       You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, edit the contents of the `data` field:

          ```bash
          {
            "updateMask": "generatePassword",
            "generatePassword": true
          }
          ```

        To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**. 
        
        To view passwords, you need the `lockbox.payloadViewer` role.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/User/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
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
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `password`: New password. The password must be from 8 to 128 characters long.

       You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, edit the contents of the `d` parameter:

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

        To view the new password, select the cluster in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. The new password version is labeled as **{{ ui-key.yacloud.lockbox.label_version-current }}**.
        
        To view passwords, you need the `lockbox.payloadViewer` role.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing user settings {#update-settings}

{% note info %}

The privileges and roles in {{ PG }} are not affected by these settings and are configured separately.

For information on setting up user privileges and roles, see [Assigning privileges and roles to users](grant.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Configure user permissions to access certain databases:
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
          --permissions=<database_list>
     ```

     Where:

     * `cluster-name`: Cluster name.
     * `permissions`: List of databases the user should have access to.

     You can request the cluster name with the [list of clusters in the folder](#list-clusters).

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

     You can request the cluster name with the [list of clusters in the folder](#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of editable fields in the {{ mpg-name }} cluster user configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

    1. To grant the user permissions to access certain databases:
        1. Locate the user's `yandex_mdb_postgresql_user` resource.
        1. Add `permission` sections with the appropriate DB names:

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

    1. To revoke the user's permission to access a specific database, delete the `permission` section with the name of this DB from the configuration file.

    1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, provide their parameters in the `settings` section:

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "settings",
                 "settings": {
                   <settings>
                 }
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       Only one parameter is provided in this case.

     * `settings`: New settings. See the [method description](../api-ref/User/update.md#yandex.cloud.mdb.postgresql.v1.UpdateUserRequest) and [{#T}](../concepts/settings-list.md#dbms-user-settings) for the list of available settings.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/User/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "settings"
               ]
             },
             "settings": {
               <settings>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `settings`: New settings. See the [method description](../api-ref/grpc/User/get.md#yandex.cloud.mdb.postgresql.v1.UserSettings) and [{#T}](../concepts/settings-list.md#dbms-user-settings) for the list of available settings.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Configuring deletion protection {#update-user-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Configure user deletion protection. To do this, select the relevant value in the **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** field.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

    1. Locate the user's `yandex_mdb_postgresql_user` resource.

    1. Add the `deletion_protection` parameter. The possible values are `true`,`false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": <deletion_protection>
                 }
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       Only one parameter is provided in this case.

     * `deletionProtection`: User deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/User/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": <deletion_protection>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `deletion_protection`: User deletion protection, `true`, `false`, or `unspecified` (inherits the value from the cluster). The default value is `unspecified`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% note warning %}

Deletion protection only applies at specific user level. Deleting a cluster will delete all users, including those protected from deletion.

{% endnote %}

## Deleting a user {#removeuser}

A user can be protected against deletion. To delete such a user, [disable the protection](#update-user-deletion-protection) first.

{% list tabs group=instructions %}

- Management console {#console}

  To delete a user:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  {{ yc-mdb-pg }} user delete <username> \
       --cluster-name <cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  To delete a user:

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).

     For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

  1. Delete the `yandex_mdb_postgresql_user` resource with the user's description.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.delete](../api-ref/User/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>'
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Delete](../api-ref/grpc/User/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Delete
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
