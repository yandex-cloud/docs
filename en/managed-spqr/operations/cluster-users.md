---
title: User management in {{ SPQR }}
description: In this tutorial, you will learn how to add and remove users in {{ SPQR }}, as well as manage their individual settings.
---

# User management in {{ SPQR }}

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run this command:

  ```bash
  yc managed-sharded-postgresql user list \
       --cluster-name <cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).


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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.spqr.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Getting user info {#get-user}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a cluster user, run this command:

  ```bash
  yc managed-sharded-postgresql user get <username> \
       --cluster-name <cluster_name>
  ```

  You can get the username with the [list of users in the cluster](#list-users).

  You can get the cluster name from the [list of clusters in your folder](cluster-list.md).


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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/grpc/User/get.md#yandex.cloud.mdb.spqr.v1.User) to make sure your request was successful.

{% endlist %}

## Creating a user {#add-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Specify the database user name.

     {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

  1. Enter a password. It must be from 8 to 128 characters long.

  1. Set the maximum number of user connections to the database.

  1. Set the number of reconnect attempts between the [router](../concepts/index.md#router) and the [shards](../concepts/index.md#shard).

  1. Select one or multiple grants to be assigned to the user.

     Its possible values are:
     - **reader**
     - **writer**
     - **admin**
     - **transfer**

  1. Select the deletion protection option.

     Its possible values are:
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Select which databases the user should have access to:
     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) next to the drop-down list.
     1. Select the database from the drop-down list.
     1. Repeat these two steps to select all required databases.
     1. To delete a database added by mistake, click ![image](../../_assets/console-icons/xmark.svg) next to its name.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster user, run this command:

  ```bash
  yc managed-sharded-postgresql user create <username> \
     --cluster-name <cluster_name> \
     --password=<password> \
     --permissions=<list_of_databases> \
     --grants=<list_of_grants>
     --connection-limit=<maximum_number_of_connections> \
     --connection-retries=<maximum_number_of_connection_retries>
  ```

  Where:

  * `cluster-name`: Cluster name.
  * `password`: User password. It must be from 8 to 128 characters long.
  * `permissions`: List of databases the user should have access to.
  * `grants`: List of grants to be assigned to the user. Its possible values are:
    * `reader`
    * `writer`
    * `admin`
    * `transfer`
  * `connection-limit`: Maximum number of user connections to the database.
  * `connection-retries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

  {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

  You can get the cluster name from the [list of clusters in your folder](cluster-list.md).


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

     To learn how to create this file, see [creating a cluster](cluster-create.md).

     For the complete list of adjustable configuration fields for {{ mspqr-name }} cluster users, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user).

  1. Add the `yandex_mdb_sharded_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_user" "my_user" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<password>"
        grants     = [ "<role1>","<role2>" ]
        settings   = {
          connection_limit = <maximum_number_of_connections>
          connection_retries = <maximum_number_of_connection_retries>
        }
        permissions {
          database = "<DB_name>"
        }
      }
      ```

      Where:

      * `name`: Username.

          {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

      * `password`: User password. The password must be from 8 to 128 characters long.

      * `grants`: List of grants to be assigned to the user. Its possible values are:
          * `reader`
          * `writer`
          * `admin`
          * `transfer`

      * `settings`: Connection settings:

          * `connection_limit`: Maximum number of user connections to the database.
          * `connection_retries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

      * `permissions`: Database the user must gain access to. To grant a user access to multiple databases, specify each one in a separate `permissions` block.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


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

     Where:

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
     * Where `userSpec` are the new database user settings:

       * `name`: Username.

         {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

       * `password`: User password. The password must be from 8 to 128 characters long.

       * `permissions`: List of databases the user needs access to. Each element in the list contains the `databaseName` parameter: The database name.

       * `settings`: Connection settings:

         * `connLimit`: Maximum number of user connections to the database.
         * `connectionRetries`: Number of reconnect attempts between the [router](../concepts/index.md#router) and the [shards](../concepts/index.md#shard).

       * `grants`: List of grants to be assigned to the user. Its possible values are:
         * `reader`
         * `writer`
         * `admin`
         * `transfer`

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

     Where:

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
     * Where `user_spec` are the new database user settings:

       * `name`: Username.

         {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

       * `password`: User password. The password must be from 8 to 128 characters long.

       * `permissions`: List of databases the user needs access to. Each element in the list contains the `database_name` parameter: The database name.

       * `settings`: Connection settings:

         * `connection_limit`: Maximum number of user connections to the database.
         * `connection_retries`: Number of reconnect attempts between the [router](../concepts/index.md#router) and the [shards](../concepts/index.md#shard).

       * `grants`: List of grants to be assigned to the user. Its possible values are:
         * `reader`
         * `writer`
         * `admin`
         * `transfer`

       * `deletion_protection`: User deletion protection, `true` or `false`.

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing user settings {#user-update-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Change the maximum number of user connections to the database.

  1. Change the number of reconnect attempts between the [router](../concepts/index.md#router) and the [shards](../concepts/index.md#shard).

  1. Configure the set of grants assigned to the user.

     Its possible values are:
     - **reader**
     - **writer**
     - **admin**
     - **transfer**

  1. Configure the deletion protection type.

     Its possible values are:
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Configure user access to the databases:
     1. To grant access to databases:
        1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../_assets/console-icons/plus.svg) next to the drop-down list.
        1. Select the database from the drop-down list.
        1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke user access to a database, click ![image](../../_assets/console-icons/xmark.svg) next to its name.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * To configure user access to specific databases, run this command with a list of database names specified in the `--permissions` option:

     ```bash
     yc managed-sharded-postgresql user update <username> \
          --cluster-name=<cluster_name> \
          --permissions=<list_of_databases>
     ```

     Where:

     * `cluster-name`: Cluster name.
     * `permissions`: List of databases the user should have access to.

     You can get the cluster name from the [list of clusters in your folder](#list-clusters).

     To revoke access to a database, remove its name from the list, and run the command once again.

  * To update the list of grants for a user, run this command:

     ```bash
     yc managed-sharded-postgresql user update <username> \
       --cluster-name=<cluster_name> \
       --grants=<new_list_of_grants>
     ```

     You can get the cluster name from the [list of clusters in your folder](#list-clusters).

     To revoke a specific grant, remove it from the list, and run the command once again.

  * To update connection settings for a user, run this command:

     ```bash
     yc managed-sharded-postgresql user update <username> \
       --cluster-name=<cluster_name> \
       --connection-limit=<maximum_number_of_connections> \
       --connection-retries=<maximum_number_of_connection_retries>
     ```

     Where:

     * `connection-limit`: Maximum number of user connections to the database.
     * `connection-retries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

     You can get the cluster name from the [list of clusters in your folder](cluster-list.md).


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

     To learn how to create this file, see [creating a cluster](cluster-create.md).

     For the complete list of adjustable configuration fields for {{ mspqr-name }} cluster users, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user).

  1. Update parameters in the `yandex_mdb_sharded_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_user" "my_user" {
        ...
        name     = "<username>"
        grants   = [ "<role1>","<role2>" ]
        settings = {
          connection_limit = <maximum_number_of_connections>
          connection_retries = <maximum_number_of_connection_retries>
        }
        permissions {
          database = "<DB_name>"
        }
      }
      ```

      Where:

      * `name`: Username.

          {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

          {% note warning %}

          Updating the username in {{ TF }} deletes the current user and creates a new one with similar settings.

          {% endnote %}

      * `grants`: List of grants to be assigned to the user. Its possible values are:
          * `reader`
          * `writer`
          * `admin`
          * `transfer`

      * `settings`: Connection settings:

          * `connection_limit`: Maximum number of user connections to the database.
          * `connection_retries`: Number of reconnect attempts from the [router](../concepts/index.md#router) to the [shards](../concepts/index.md#shard).

      * `permissions`: Database the user must gain access to. To grant a user access to multiple databases, specify each one in a separate `permissions` block. To deny a user access to a specific database, remove the respective `permissions` block.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


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

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}

     * `updateMask`: Comma-separated string of settings you want to update.

     * `password`: New password. It must be from 8 to 128 characters long.

     * `permissions`: List of databases the user needs access to. Each element in the list contains the `databaseName` parameter: The database name.

     * `settings`: Connection settings:

       * `connLimit`: Maximum number of user connections to the database.
       * `connectionRetries`: Number of reconnect attempts between the [router](../concepts/index.md#router) and the [shards](../concepts/index.md#shard).

     * `grants`: List of grants to be assigned to the user.

       Its possible values are:
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

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}

     * `update_mask`: List of settings to update as an array of strings (`paths[]`).

     * `password`: User password. The password must be from 8 to 128 characters long.

     * `permissions`: List of databases the user needs access to. Each element in the list contains the `database_name` parameter: The database name.

     * `settings`: Connection settings:

       * `connection_limit`: Maximum number of user connections to the database.
       * `connection_retries`: Number of reconnect attempts between the [router](../concepts/index.md#router) and the [shards](../concepts/index.md#shard).

     * `grants`: List of grants to be assigned to the user.

       Its possible values are:
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

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Specify a new password. It must be from 8 to 128 characters long.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a user password, run this command:

  ```bash
  yc managed-sharded-postgresql user update <username> \
       --cluster-name=<cluster_name> \
       --password=<new_password>
  ```

    The password must be from 8 to 128 characters long.

    You can get the cluster name from the [list of clusters in your folder](cluster-list.md).


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).

     For the complete list of adjustable configuration fields for {{ mspqr-name }} cluster users, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user).

  1. Update parameters in the `yandex_mdb_sharded_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_user" "my_user" {
        ...
        password = "<password>"
        ...
      }
      ```

      Where `password` is the user password. The password must be from 8 to 128 characters long.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


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

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
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

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `password`: New password. It must be from 8 to 128 characters long.

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring deletion protection {#user-update-deletion-protection}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
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

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
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

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
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

  1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.spqr.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a user, run this command:

  ```bash
  yc managed-sharded-postgresql user delete <username> \
       --cluster-name <cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).


- {{ TF }} {#tf}

  To delete a user:

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

  1. In the manifest, remove the `yandex_mdb_sharded_postgresql_user` resource describing the user you want to delete.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
