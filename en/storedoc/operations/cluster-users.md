---
title: Managing {{ SD }} users in {{ mmg-full-name }}
description: In this tutorial, you will learn how to add users, remove users, and manage individual user settings in the {{ SD }} database management service.
---

# Managing {{ SD }} users

You can add and delete users as well as manage their individual settings and database access permissions.

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get a list of cluster users, run this command:
  
  ```
  {{ yc-mdb-mg }} user list \
    --cluster-name <cluster_name>
  ```
  
  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.List](../api-ref/User/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/users'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/list.md#yandex.cloud.mdb.mongodb.v1.ListUsersResponse) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.List
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.mongodb.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Creating a user {#adduser}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the name of your cluster and open the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.

  1. Enter the DB username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

  1. Configure the [roles](../concepts/users-and-roles.md) for the user:

     1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** and select the database where you want to grant a role.
     1. Add roles using ![image](../../_assets/console-icons/plus.svg).

     You can grant multiple roles to a user in different databases.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a user in a cluster:
  
  1. See the description of the CLI command for creating a user:
  
     ```
     {{ yc-mdb-mg }} user create --help
     ```
  
  1. Specify the user properties in the create command:
     ```
     {{ yc-mdb-mg }} user create <username> \
       --cluster-name <cluster_name> \
       --password <user_password> \
       --permission database=<DB_name>,role=<role>,role=<other_role>,... \
       --permission database=<other_DB_name>,role=<role>,...
     ```
  
     {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Add the `yandex_mdb_mongodb_user` resource:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<username>" {
          cluster_id = <cluster_ID>
          name       = "<username>"
          password   = "<password>"
          permission {
            database_name = "<DB_name>"
            roles         = [ "<list_of_user_roles>" ]
          }
        }
        ```

        Where `database_name` is the name of the DB you want to grant access to.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Create](../api-ref/User/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/users' \
       --data '{
                 "userSpec": {
                   "name": "<username>",
                   "password": "<user_password>",
                   "permissions": [
                     {
                       "databaseName": "<DB_name>",
                       "roles": [
                        "<role_1>", "<role_2>", ..., "<role_N>"
                       ]
                     }
                   ]
                 }
               }'
     ```

     Where `userSpec` is the settings for the new database user:

     * `name`: Username.
     * `password`: User password.

       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions`: User permissions settings:

       * `databaseName`: Name of the database to which the user will have access.
       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For a list of possible values, see [Users and roles](../concepts/users-and-roles.md).

       For each database, add a separate element with permission settings to the `permissions` array.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_spec": {
               "name": "<username>",
               "password": "<user_password>",
               "permissions": [
                 {
                   "database_name": "<DB_name>",
                   "roles": [
                      "<role_1>", "<role_2>", ..., "<role_N>"
                   ]   
                 }
               ]
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Create
     ```

     Where `user_spec` is the settings for the new database user:

     * `name`: Username.
     * `password`: User password.

          {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions`: User permission settings:

       * `database_name`: Name of the database to which the user will have access.
       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For a list of possible values, see [Users and roles](../concepts/users-and-roles.md).

       For each database, add a separate element with permission settings to the `permissions` array.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing users {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the name of your cluster and open the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

  1. To edit a user password, click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the user you need and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.

     {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  1. To change the user's [roles](../concepts/users-and-roles.md):

     1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the user you need and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
     1. To add a role, click ![image](../../_assets/console-icons/plus.svg) next to the appropriate database and select the role.
     1. To delete a role, click ![image](../../_assets/console-icons/xmark.svg) next to the role name.

  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To change a user's password or list of roles:
  
  1. See the description of the CLI's update user command:
  
     ```
     {{ yc-mdb-mg }} user update --help
     ```
  
  1. Specify the user properties in the update command:
     ```
     {{ yc-mdb-mg }} user update <username> \
       --cluster-name <cluster_name> \
       --password <user_password> \
       --permission database=<DB_name>,role=<role>,role=<other_role>,... \
       --permission database=<other_DB_name>,role=<role>,...
     ```
  
     {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  To grant a user access to a database with a defined list of roles:

  1. View a description of the CLI command to grant users permissions:
  
     ```
     {{ yc-mdb-mg }} user grant-permission --help
     ```
  
  1. Specify the properties of the user in the grant permissions command:

     ```bash
     {{ yc-mdb-mg }} user grant-permission <username> \
       --cluster-name <cluster_name> \
       --database <DB_name> \
       --role <list_of_roles_separated_by_commas>
     ```

  To revoke user database access:

  1. View a description of the CLI command to revoke users' permissions:
  
     ```
     {{ yc-mdb-mg }} user revoke-permission --help
     ```
  
  1. Specify the properties of the user in the revoke permissions command:

     ```bash
     {{ yc-mdb-mg }} user revoke-permission <username> \
       --cluster-name <cluster_name> \
       --database <DB_name>
     ```

      This command denies the user all access to the specified database.

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters), the DB name, with the [list of databases in the cluster](databases.md#list-db), and the user's name, with the [list of users in the cluster](cluster-users.md#list-users).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Find the `yandex_mdb_mongodb_user` resource.
    1. Update the `password` field value and field values under `permission`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<username>" {
          cluster_id = <cluster_ID>
          name       = "<username>"
          password   = "<new_password>"
          permission {
            database_name = "<DB_name>"
            roles         = [ "<new_list_of_user_roles>" ]
          }
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Make sure the settings are correct.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                "updateMask": "password,permissions.databaseName,permissions.roles",
                "password": "<user_password>",
                "permissions": [
                  {
                    "databaseName": "<DB_name>",
                    "roles": [
                      "<role_1>", "<role_2>", ..., "<role_N>"
                    ]
                  }
                ]
              }'
     ```                

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.
     * `password`: User password.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions`: User permission settings:

       * `database_name`: Name of the database to which the user will have access.
       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).
 
     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

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
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "password",
                 "permissions.database_name",
                 "permissions.roles"
               ]
             },
             "password": "<user_password>",
             "permissions": [
               {
                 "database_name": "<DB_name>",
                 "roles": [
                   "<role_1>", "<role_2>", ..., "<role_N>"
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Update
     ```

     Where:

     * `update_mask`: Comma-separated string of settings you want to update.
     * `password`: User password.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions`: User permission settings:

       * `database_name`: Name of the database to which the user will have access.
       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful. 

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and open the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the user you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a user, run this command:
  
  ```
  {{ yc-mdb-mg }} user delete <username> \
    --cluster-name <cluster_name>
  ```
  
  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Delete the `yandex_mdb_mongodb_user` resource with the user description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.Delete](../api-ref/User/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/users/<username>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

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
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Delete
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmg-user-examples.md) %}
