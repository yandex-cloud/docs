---
title: User management in {{ SPQR }}
description: In this tutorial, you will learn how to add and remove users in {{ SPQR }}, as well as manage their individual settings.
---

# User management in {{ SPQR }}

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.List](../api-ref/User/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users'
     ```

  1. View the [server response](../api-ref/User/list.md#yandex.cloud.mdb.spqr.v1.ListUsersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.List](../api-ref/grpc/User/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.List
     ```

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.spqr.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Getting user info {#get-user}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Get](../api-ref/User/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users/<username>'
     ```

  1. Check the [server response](../api-ref/User/get.md#yandex.cloud.mdb.spqr.v1.User) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Get](../api-ref/grpc/User/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Get
     ```

  1. Check the [server response](../api-ref/grpc/User/get.md#yandex.cloud.mdb.spqr.v1.User) to make sure your request was successful.

{% endlist %}

## Creating a user {#add-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Specify the database user name.

     {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

  1. Enter a password. It must be from 8 to 128 characters long.

  1. Set the maximum number of user connections to the database.

  1. Set the number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

  1. Select one or more grants to assign to the user.

     The possible values are:
     - **reader**
     - **writer**
     - **admin**
     - **transfer**

  1. Select the deletion protection option.

     The possible values are:
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Select which databases the user should have access to:
     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) next to the drop-down list.
     1. Select the database from the drop-down list.
     1. Repeat these two steps to select all required databases.
     1. To delete a database added by mistake, click ![image](../../_assets/console-icons/xmark.svg) next to its name.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Create](../api-ref/User/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users' \
       --data '{
                 "userSpec": {
                   "name": "<username>",
                   "password": "<user_password>",
                   "permissions": [
                     {
                       "databaseName": "<DB_name>"
                     }
                   ],
                   "settings": {
                     "connectionLimit": "<maximum_number_of_DB_connections>",
                     "connectionRetries": "<number_of_reconnect_attempts_to_shards>"
                   },
                   "grants": [
                     "<list_of_grants>"
                   ],
                   "deletionProtection": "<protect_user_from_deletion>"
                 }
               }'
     ```

     Where `userSpec` are the settings for the new database user:

     * `name`: Username.

       {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

     * `password`: User password. The password must be from 8 to 128 characters long.

     * `permissions`: List of databases the user needs access to. Each element in the list contains the `databaseName` parameter, which is the database name.

     * `settings`: Connection settings:

       * `connLimit`: Maximum number of user connections to the database.
       * `connectionRetries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

     * `grants`: List of grants to be assigned to the user.

       The possible values are:
       - `reader`
       - `writer`
       - `admin`
       - `transfer`

     * `deletionProtection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Create](../api-ref/grpc/User/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
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
               "settings": {
                 "connection_limit": "<maximum_number_of_DB_connections>",
                 "connection_retries": "<number_of_reconnect_attempts_to_shards>"
               },
               "grants": [
                 "<list_of_grants>"
               ],
               "deletion_protection": "<protect_user_from_deletion>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Create
     ```

     Where `user_spec` are the new database user settings:

     * `name`: Username.

       {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

     * `password`: User password. The password must be from 8 to 128 characters long.

     * `permissions`: List of databases the user needs access to. Each element in the list contains the `database_name` parameter, which is the database name.

     * `settings`: Connection settings:

       * `connection_limit`: Maximum number of user connections to the database.
       * `connection_retries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

     * `grants`: List of grants to be assigned to the user.

       The possible values are:
       - `reader`
       - `writer`
       - `admin`
       - `transfer`

     * `deletion_protection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing user settings {#user-update-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Change the maximum number of user connections to the database.

  1. Change the number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

  1. Configure the grants assigned to the user.

     The possible values are:
     - **reader**
     - **writer**
     - **admin**
     - **transfer**

  1. Configure the deletion protection type.

     The possible values are:
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Configure user access to databases:
     1. To provide access to databases:
        1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) next to the drop-down list.
        1. Select the database from the drop-down list.
        1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke user access to a database, click ![image](../../_assets/console-icons/xmark.svg) next to its name.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "<list_of_parameters_to_update>",
                 "password": "<user_password>",
                 "permissions": [
                   {
                     "databaseName": "<DB_name>"
                   }
                 ],
                 "settings": {
                   "connectionLimit": "<maximum_number_of_DB_connections>",
                   "connectionRetries": "<number_of_reconnect_attempts_to_shards>"
                 },
                 "grants": [
                   "<list_of_grants>"
                 ],
                 "deletionProtection": "<protect_user_from_deletion>"
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.

     * `password`: New password. It must be from 8 to 128 characters long.

     * `permissions`: List of databases the user needs access to. Each element in the list contains the `databaseName` parameter, which is the database name.

     * `settings`: Connection settings:

       * `connLimit`: Maximum number of user connections to the database.
       * `connectionRetries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

     * `grants`: List of grants to be assigned to the user.

       The possible values are:
       - `reader`
       - `writer`
       - `admin`
       - `transfer`

     * `deletionProtection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "<array_of_settings_to_update>"
               ]
             },
             "password": "<user_password>",
             "permissions": [
               {
                 "database_name": "<DB_name>"
               }
             ],
             "settings": {
               "connection_limit": "<maximum_number_of_DB_connections>",
               "connection_retries": "<number_of_reconnect_attempts_to_shards>"
             },
             "grants": [
               "<list_of_grants>"
             ],
             "deletion_protection": "<protect_user_from_deletion>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of settings to update as an array of strings (`paths[]`).

     * `password`: Password. The password must be from 8 to 128 characters long.

     * `permissions`: List of databases the user needs access to. Each element in the list contains the `database_name` parameter, which is the database name.

     * `settings`: Connection settings:

       * `connection_limit`: Maximum number of user connections to the database.
       * `connection_retries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

     * `grants`: List of grants to be assigned to the user.

       The possible values are:
       - `reader`
       - `writer`
       - `admin`
       - `transfer`

     * `deletion_protection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a user password {#user-update-password}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Specify a new password. It must be from 8 to 128 characters long.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "password",
                 "password": "<new_password>"
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings to update.

       Here, we provide only one setting.

     * `password`: New password. It must be from 8 to 128 characters long.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
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
       yandex.cloud.mdb.spqr.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `password`: New password. It must be from 8 to 128 characters long.

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring deletion protection {#user-update-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Change the deletion protection type in the **{{ ui-key.yacloud.mdb.dialogs.field_deletion_protection }}** field.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": "<protect_user_from_deletion>"
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings to update.

       Here, we provide only one setting.

     * `deletionProtection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": "<protect_user_from_deletion>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `deletion_protection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a user {#user-remove}

A user account can have deletion protection enabled. To delete such a user, [disable the protection](#user-update-deletion-protection) first.

{% list tabs group=instructions %}

- Management console {#console}

  To delete a user:

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Confirm the deletion.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Delete](../api-ref/User/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/users/<username>'
     ```

  1. Check the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService.Delete](../api-ref/grpc/User/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Delete
     ```

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
