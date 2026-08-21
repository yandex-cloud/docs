---
title: Managing {{ SD }} users in {{ mmg-full-name }}
description: In this tutorial, you will learn how to add and remove users and how to manage individual user settings in the {{ SD }} database management service.
---

# Managing {{ SD }} users

You can add and remove users, manage individual user settings, and change database access permissions.

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/storedoc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Locate the cluster you need in the list, click its name, and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  
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

  1. Check the [server response](../api-ref/User/list.md#yandex.cloud.mdb.mongodb.v1.ListUsersResponse) to make sure your request was successful.

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


## Getting user info {#get-user}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select a folder.
    1. [Navigate]({{ link-console-main }}/link/storedoc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
    1. Locate the cluster you need in the list, click its name, and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

        User information is available in the user list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about a specific user:

    1. See the description of the CLI command for getting user info:

        ```bash
        {{ yc-mdb-mg }} user get --help
        ```

    1. Get user info by running this command:

        ```bash
        {{ yc-mdb-mg }} user get <username> \
          --cluster-id=<cluster_ID>
        ```

        You can get the username with the [list of users](#list-users) in the cluster, and the cluster ID, with the [list of clusters](cluster-list.md#list-clusters) in the folder.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [User.Get](../api-ref/User/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/users/<username>'
        ```

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder, and the username, with the [list of users](#list-users) in the cluster.

    1. Check the [server response](../api-ref/User/get.md#yandex.cloud.mdb.mongodb.v1.User) to make sure your request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
            "cluster_id": "<cluster_ID>",
            "user_name": "<username>"
          }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.UserService.Get
          ```

        You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder, and the username, with the [list of users](#list-users) in the cluster.

    1. Check the [server response](../api-ref/grpc/User/get.md#yandex.cloud.mdb.mongodb.v1.User) to make sure your request was successful.

{% endlist %}


## Creating a user {#adduser}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/storedoc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the cluster name and open the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.

  
  1. Choose the authorization method:

      * **{{ ui-key.yacloud.mongodb.UserAddDialog.label_password_2MQCs }}**: Authorization by username and password.
        
        For this authorization method, enter the username and password.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

      * **{{ ui-key.yacloud.mongodb.UserAddDialog.label_iam_ffBD5 }}**: Authroization using a [Yandex account](../../iam/concepts/users/accounts.md#passport), [federated account](../../iam/concepts/users/accounts.md#saml-federation), or [local account](../../iam/concepts/users/accounts.md#local).

        For this authorization method, select the account in the **{{ ui-key.yacloud.common.user }}** field.


  1. Configure the user’s [roles](../concepts/users-and-roles.md):

     1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** and select the database for role assignment.
     1. Add roles using the ![image](../../_assets/console-icons/plus.svg) button.

     You can assign a user multiple roles across different databases.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a cluster user:
  
  1. See the description of the CLI command for creating a user:
  
     ```
     {{ yc-mdb-mg }} user create --help
     ```
  
  1. Specify user properties in the creation command:
     
     ```
     {{ yc-mdb-mg }} user create <username> \
       --cluster-name <cluster_name> \
       --password <user_password> \
       --permission database=<DB_name>,role=<role>,role=<other_role>,... \
       --permission database=<other_DB_name>,role=<role>,... \
       --deletion-protection=<protect_user_from_deletion>
     ```
  
     Where:
     
     * `<username>`, `--password`: Username and password.

       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `--cluster-name`: Cluster name you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `--permission`: User’s database access permissions:
     
       * `database`: Name of the database the user can access.
         
         You can request the database name with the [list of databases in the cluster](databases.md#list-db).
       
       * `role`: User’s role in the database. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).
       
         A user can get several roles in a database. Specify each one in a separate `role` property.
      
       Specify a separate `--permission` property for each database you want the user to access.
     
     * `--deletion-protection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Add the `yandex_mdb_mongodb_user` resource:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<username>" {
          cluster_id          = <cluster_ID>
          name                = "<username>"
          password            = "<password>"
          deletion_protection = <protect_user_from_deletion>
          permission {
            database_name = "<DB_name>"
            roles         = [ "<list_of_user_roles>" ]
          }
        }
        ```

        Where:
        
        * `cluster_id`: Cluster ID you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `name`, `password`: Username and password.

          {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

        * `deletion_protection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.
        
        * `permission`: User’s database access permissions:
          
          * `database_name`: Name of the database the user can access.
            
            You can request the database name with the [list of databases in the cluster](databases.md#list-db).

          * `role`: List of the user’s roles in the database. For the possible values, see [Users and roles](../concepts/users-and-roles.md).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_user).

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
                   ],
                   "deletionProtection": <protect_user_from_deletion>
                 }
               }'
     ```

     Where:

     * `<cluster_ID>`: Cluster ID you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `userSpec.name`, `userSpec.password`: Username and password.
       
       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `userSpec.permissions`: User permissions:

       * `databaseName`: Name of the database the user can access.
         
         You can request the database name with the [list of databases in the cluster](databases.md#list-db).

       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).

       In the `permissions` array, add a separate element with permission settings for each database.
     
     * `userSpec.deletionProtection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.

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
               ],
               "deletion_protection": <protect_user_from_deletion>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Create
     ```

     Where:
     
     * `cluster_id`: Cluster ID you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `user_spec.name`, `user_spec.password`: Username and password.

       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `user_spec.permissions`: User permissions:

       * `database_name`: Name of the database the user can access.
         
         You can request the database name with the [list of databases in the cluster](databases.md#list-db).
         
       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).

       In the `permissions` array, add a separate element with permission settings for each database.

     * `user_spec.deletion_protection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing user settings {#updateuser}

{% note info %}

You cannot change the username.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/storedoc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the cluster name and open the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

  
  1. To change a user’s password, locate the user in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  
     * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Set your own password. It must be from 8 to 128 characters long.
     * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Generate a password using [{{ connection-manager-name }}](cluster-create.md#conn-man).

        To view the new password, navigate to the cluster page, select the **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. The new password version is marked as **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

     To view passwords, you need the `lockbox.payloadViewer` role.


  1. To change the user's [roles](../concepts/users-and-roles.md):

     1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
     1. To add a role, click ![image](../../_assets/console-icons/plus.svg) next to the target database and select the role you want to assign.
     1. To delete a role, click ![image](../../_assets/console-icons/xmark.svg) next to its name.

  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To change the user settings:
  
  1. See the description of the CLI command for updating a user:
  
     ```
     {{ yc-mdb-mg }} user update --help
     ```
  
  1. Specify user properties in the update command:
     
     ```
     {{ yc-mdb-mg }} user update <username> \
       --cluster-name <cluster_name> \
       --password <user_password> \
       --permission database=<DB_name>,role=<role>,role=<other_role>,... \
       --permission database=<other_DB_name>,role=<role>,... \
       --deletion-protection=<protect_user_from_deletion>
     ```
  
     Where:
     
     * `<username>`: Username you can request with the [list of users in the cluster](#list-users).
     * `--cluster-name`: Cluster name you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `--password`: Password.

              
       The password must be from 8 to 128 characters long.
       

     * `--permission`: User’s database access permissions:
     
       * `database`: Name of the database the user can access.
         
         You can request the database name with the [list of databases in the cluster](databases.md#list-db).
       
       * `role`: User’s role in the database. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).

         A user can get several roles in a database. Specify each one in a separate `role` property.
      
       Specify a separate `--permission` property for each database you want the user to access.
     
     * `--deletion-protection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.

  To grant a user access to a database with a specific set of roles:

  1. See the description of the CLI command for granting user permissions:
  
     ```
     {{ yc-mdb-mg }} user grant-permission --help
     ```
  
  1. Specify user properties in the `user grant permission` command:

     ```bash
     {{ yc-mdb-mg }} user grant-permission <username> \
       --cluster-name <cluster_name> \
       --database <DB_name> \
       --role <list_of_roles_separated_by_commas>
     ```

  To revoke database access from a user:

  1. See the description of the CLI command for revoking user permissions:
  
     ```
     {{ yc-mdb-mg }} user revoke-permission --help
     ```
  
  1. Specify user properties in the `user revoke permission` command:

     ```bash
     {{ yc-mdb-mg }} user revoke-permission <username> \
       --cluster-name <cluster_name> \
       --database <DB_name>
     ```

      This command revokes the user’s access to the specified database.

  You can get the cluster’s name from the [list of clusters in your folder](cluster-list.md#list-clusters), the database name from the [list of your cluster databases](databases.md#list-db), and the user's name from the [list of cluster users](#list-users).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Locate the `yandex_mdb_mongodb_user` resource.
    1. To set a new password, edit the `password` field value:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<username>" {
          ...
          password   = "<new_password>"
          ...
        }
        ```

               
        The password must be from 8 to 128 characters long.
       

    1. To set up permissions for the user, update the list of roles in the `roles` field:
        
        ```hcl
        resource "yandex_mdb_mongodb_user" "<username>" {
          ...
          permission {
            database_name = "<DB_name>"
            roles         = [ "<new_list_of_user_roles>" ]
          }
          ...
        }
        ```

        For the list of possible roles, see [Users and roles](../concepts/users-and-roles.md).
    
    1. To enable or disable user protection from accidental deletion, update the `deletion_protection` field value:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<username>" {
          ...
          deletion_protection = <protect_user_from_deletion>
          ...
        }
        ```

        Where `deletion_protection` stands for user protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.

    1. Make sure the settings are correct.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_user).

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
                "updateMask": "password,permissions.databaseName,permissions.roles,deletionProtection",
                "password": "<user_password>",
                "permissions": [
                  {
                    "databaseName": "<DB_name>",
                    "roles": [
                      "<role_1>", "<role_2>", ..., "<role_N>"
                    ]
                  }
                ],
                "deletionProtection": <protect_user_from_deletion>
              }'
     ```

     Where:

     * `<cluster_ID>`: Cluster ID you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `<username>`: Username you can request with the [list of users in the cluster](#list-users).
     * `updateMask`: Comma-separated string of settings to update.
     * `password`: Password.

              
       The password must be from 8 to 128 characters long.
       

     * `permissions`: User permissions:

       * `databaseName`: Name of the database the user can access.
         
         You can request the database name with the [list of databases in the cluster](databases.md#list-db).

       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).
     
     * `deletionProtection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.

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
                 "permissions.roles",
                 "deletion_protection"
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
             ],
             "deletion_protection": <protect_user_from_deletion>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Update
     ```

     Where:

     * `cluster_id`: Cluster ID you can request with the [list of clusters in the folder](cluster-list.md#list-clusters).
     * `user_name`: Username you can request with the [list of users in the cluster](#list-users).

     * `update_mask`: List of settings to update as an array of strings (`paths[]`).
     * `password`: Password.

              
       The password must be from 8 to 128 characters long.
       

     * `permissions`: User permissions:

       * `database_name`: Name of the database the user can access.
         
         You can request the database name with the [list of databases in the cluster](databases.md#list-db).

       * `roles`: Array of user roles. Each role is provided as a separate string in the array. For the list of possible values, see [Users and roles](../concepts/users-and-roles.md).
     
     * `deletion_protection`: User protection from accidental deletion, `true` or `false`. There is no default value; the user will use the one from the corresponding cluster setting. If the protection is enabled (`true`), you cannot delete the user.
     
  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful. 

{% endlist %}

## Deleting a user {#removeuser}

{% note info %}

Before you delete a user, [disable their deletion protection](#updateuser).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/storedoc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  1. Locate the user you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  
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

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Delete the `yandex_mdb_mongodb_user` resource with the target user’s description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_user).

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

     You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

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

     You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmg-user-examples.md) %}
