---
title: Managing {{ PG }} cluster users in {{ mpg-full-name }}
description: In this tutorial, you will learn how to add users, remove users, and manage individual user settings in the {{ PG }} database management service.
---

# Managing {{ PG }} users

You can add users, remove users, and manage their individual settings.

{% note warning %}

While you can use SQL commands to assign user privileges, you cannot use them to add or modify users. For more information, see [Assigning privileges and roles to users](grant.md).

{% endnote %}

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the following command:

  ```
  {{ yc-mdb-pg }} user list \
       --cluster-name <cluster_name>
  ```

  You can get the cluster name from the [folder’s cluster list](cluster-list.md).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.List](../api-ref/User/list.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/User/list.md#yandex.cloud.mdb.postgresql.v1.ListUsersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.List](../api-ref/grpc/User/list.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.postgresql.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Creating a user {#adduser}

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Specify the database user’s name.

      {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  
  1. Select the method for setting a password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Set your own password. It must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man).

      To view the password, navigate to the cluster page, select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the new user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


  1. Select the deletion protection option.

     Possible values:
     - **Same as cluster**
     - **Enabled**
     - **Disabled**
  1. Choose which databases the user can access:
     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) next to the drop-down list.
     1. Select a database from the drop-down list.
     1. Repeat these two steps to select all required databases.
     1. To delete a mistakenly added database, click ![image](../../_assets/console-icons/xmark.svg) next to its name.
  1. Configure the [DBMS settings](../concepts/settings-list.md#dbms-user-settings) for the user.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster user, run this command:

  ```
  {{ yc-mdb-pg }} user create <username> \
     --cluster-name <cluster_name> \
     --password=<password> \
     --permissions=<database_list> \
     --conn-limit=<maximum_number_of_connections>
  ```

  Where:

  * `cluster-name`: Cluster name.
  * `password`: User password. The password must be 8-128 characters long.

      
      You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, replace `--password=<password>` with `--generate-password`.

      To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


  * `permissions`: List of databases to which the user must have access.
  * `conn-limit`: Maximum number of connections per user.

  This command only configures the user’s basic settings.

  {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  To configure the user’s DBMS settings, use the parameters described in [User settings](../concepts/settings-list.md#dbms-user-settings).

  You can get the cluster name from the [folder’s cluster list](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating clusters](cluster-create.md).

     For a complete list of configurable fields of {{ mpg-name }} cluster user accounts, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_user).

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
        * `login`: Database login permission, `true` or `false`.
        * `deletion_protection`: User deletion protection, `true`, `false`, or `unspecified` (inherits cluster setting). The default value is `unspecified`.

      {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

      The password must be 8-128 characters long.

      
      You can also generate a password using {{ connection-manager-name }}. To do this, replace `password = "<password>"` with `generate_password = true`.

      To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Create](../api-ref/User/create.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     Where `userSpec` are the settings for the new database user:

     * `name`: Username.

        {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * `password`: Password. The password must be 8-128 characters long.

        
        You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, replace `"password": "<user_password>"` with `"generatePassword": true`.

        To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


     * `permissions.databaseName`: Array of databases to which the user must have access. Each array item represents a single database.
     * `connLimit`: Maximum number of database connections per user.
     * `deletionProtection`: User deletion protection, `true`, `false`, or `unspecified` (inherits cluster setting). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Create](../api-ref/grpc/User/create.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     Where `user_spec` are the settings for the new database user:

     * `name`: Username.

        {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * `password`: Password. The password must be 8-128 characters long.

        
        You can also generate a password using {{ connection-manager-name }}. To do this, replace `"password": "<user_password>"` with `"generate_password": true`.

        To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


     * `permissions.database_name`: Array of databases to which the user must have access. Each array item represents a single database.
     * `conn_limit`: Maximum number of database connections per user.
     * `deletion_protection`: User deletion protection, `true`, `false`, or `unspecified` (inherits cluster setting). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note info %}

Newly created users only get the `CONNECT` privilege for selected databases and cannot perform any operations on them. To give a user access to databases, [assign](grant.md) them the required privileges or roles.

{% endnote %}

## Changing a password {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.

  
  1. Select a method for setting a new password:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Set your own password. It must be from 8 to 128 characters long.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man).


  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

      
      To view the new password, navigate to the cluster page, select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

      Viewing passwords requires the `lockbox.payloadViewer` role.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a user’s password, run this command:

  ```
  {{ yc-mdb-pg }} user update <username> \
       --cluster-name=<cluster_name> \
       --password=<new_password>
  ```

    The password must be 8-128 characters long.

    
    You can also generate a new password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, replace `--password=<new_password>` with `--generate-password`.

    To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

    Viewing passwords requires the `lockbox.payloadViewer` role.


  You can get the cluster name from the [folder’s cluster list](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of configurable fields of {{ mpg-name }} cluster user accounts, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_user).

  1. Locate the `yandex_mdb_postgresql_user` resource for the required user.
  1. Update the `password` field:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        name     = "<username>"
        password = "<new_password>"
        ...
      }
      ```

      The password must be 8-128 characters long.

      
      You can also generate a new password using [Connection Manager](cluster-create.md#conn-man). To do this, replace `password = "<new_password>"` with `generate_password = true`.

      To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

      {% note info %}

      If the current password has been automatically generated, you cannot regenerate it using {{ TF }} due to provider limitations.

      {% endnote %}


  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `password`: New password. The password must be 8-128 characters long.

       
       You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, update the `data` field value:

          ```bash
          {
            "updateMask": "generatePassword",
            "generatePassword": true
          }
          ```

       To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

        Viewing passwords requires the `lockbox.payloadViewer` role.


     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [cluster’s user list](#list-users).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `password`: New password. The password must be 8-128 characters long.

       
       You can also generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man). To do this, modify the `d` argument:

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

       To view the new password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.label_version-current }}**.

        Viewing passwords requires the `lockbox.payloadViewer` role.


     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing user settings {#update-settings}

{% note info %}

These settings do not affect {{ PG }} privileges and roles, which are configured separately.

To learn how to assign privileges and roles to a user, see [this article](grant.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Configure user permissions for access to specific databases:
     1. To grant user access to the required databases:
        1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) next to the drop-down list.
        1. Select a database from the drop-down list.
        1. Repeat these two steps to select all required databases.
     1. To revoke user access to a specific database, click ![image](../../_assets/console-icons/xmark.svg) next to its name.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}** to change the user’s maximum connections (**Conn limit**), cluster login permissions (**Login**), or other [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings).
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can change user settings from the command line interface:

  1. To configure user access to specific databases, run this command with a list of database names specified in the `--permissions` option:

     ```
     {{ yc-mdb-pg }} user update <username> \
          --cluster-name=<cluster_name> \
          --permissions=<database_list>
     ```

     Where:

     * `cluster-name`: Cluster name.
     * `permissions`: List of databases to which the user must have access.

     You can get the cluster name from the [folder’s cluster list](#list-clusters).

     This command grants the user access to the listed databases.

     To revoke user access to a specific database, remove its name from the list and run the command with the updated list.

  1. To change [{{ PG }} user settings](../concepts/settings-list.md#dbms-user-settings), run this command with the relevant arguments:

     ```
     {{ yc-mdb-pg }} user update <username> \
          --cluster-name=<cluster_name> \
          --<setting_1>=<value_1> \
          --<setting_2>=<value_2> \
          --<setting_3>=<list_of_values> \
          ...
     ```

     To change a user’s connection limit, use the `--conn-limit` option.

     You can get the cluster name from the [folder’s cluster list](#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating clusters](cluster-create.md).

        For a complete list of configurable fields of {{ mpg-name }} cluster user accounts, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_user).

    1. To configure user permissions for access to specific databases:
        1. Locate the `yandex_mdb_postgresql_user` resource for the required user.
        1. Add `permission` sections with the relevant database names:

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

    1. To revoke user access to a specific database, delete the `permission` section with its name from the configuration file.

    1. To change [{{ PG }} user settings](../concepts/settings-list.md#dbms-user-settings), specify the relevant arguments in the `settings` section:

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

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `settings`: New settings. For the list of available settings, refer to the [method description](../api-ref/User/update.md#yandex.cloud.mdb.postgresql.v1.UpdateUserRequest) and [{#T}](../concepts/settings-list.md#dbms-user-settings).

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `settings`: New settings. For the list of available settings, refer to the [method description](../api-ref/grpc/User/get.md#yandex.cloud.mdb.postgresql.v1.UserSettings) and [{#T}](../concepts/settings-list.md#dbms-user-settings).

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring deletion protection {#update-user-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Configure user deletion protection by selecting the relevant value in the **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** field.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

    1. Locate the `yandex_mdb_postgresql_user` resource for the required user.

    1. Add the `deletion_protection` attribute. Possible values: `true`, `false`, or `unspecified` (inherits cluster setting). The default value is `unspecified`.

        ```hcl
        resource "yandex_mdb_postgresql_user" "<username>" {
          ...
          deletion_protection = <deletion_protection>
          ...
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `deletionProtection`: User deletion protection, `true`, `false`, or `unspecified` (inherits cluster setting). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `deletion_protection`: User deletion protection, `true`, `false`, or `unspecified` (inherits cluster setting). The default value is `unspecified`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

Deletion protection only applies to individual users. Deleting a cluster will permanently remove all its users, including those with deletion protection.

{% endnote %}

## Deleting a user {#removeuser}

A user account can have deletion protection enabled. To delete it, [disable deletion protection](#update-user-deletion-protection) first.

{% list tabs group=instructions %}

- Management console {#console}

  To delete a user:

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a user, run this command:

  ```
  {{ yc-mdb-pg }} user delete <username> \
       --cluster-name <cluster_name>
  ```

  You can get the cluster name from the [folder’s cluster list](cluster-list.md).

- {{ TF }} {#tf}

  To delete a user:

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating clusters](cluster-create.md).

     For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

  1. Delete the `yandex_mdb_postgresql_user` resource describing the target user.

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Delete](../api-ref/User/delete.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Delete](../api-ref/grpc/User/delete.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
