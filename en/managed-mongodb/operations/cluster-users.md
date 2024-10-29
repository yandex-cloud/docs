---
title: Managing {{ MG }} users in {{ mmg-full-name }}
description: In this tutorial, you will learn how to add and remove users, as well as manage each user’s settings in the {{ MG }} database management service.
---

# Managing {{ MG }} users

You can add and delete users as well as manage their individual settings and database access permissions.

## Getting a list of users {#list-users}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the following command:

  ```
  {{ yc-mdb-mg }} user list \
    --cluster-name <cluster_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

  To get a list of users, use the [list](../api-ref/User/list.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/List](../api-ref/grpc/User/list.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a user {#adduser}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.

  1. Enter the DB user name and password.

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

  1. See the description of the create user CLI command:

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

     You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- API {#api}
  
  To create a user, use the [create](../api-ref/User/create.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Create](../api-ref/grpc/User/create.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * User settings in the `userSpec` parameter:
    * Username in the `name` parameter.
    * User password in the `password` parameter.
    * Database access permissions (one or more `permissions` parameters, one for each database):
      * Database name in the `databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
      * Database access permissions in the `roles` parameter.

{% endlist %}

## Changing users {#updateuser}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.

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

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- API {#api}

  To update a user, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/User/update.md) gRPC API call and provide the following in the request:

  * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](cluster-users.md#list-users).
  * Name of the database for which you want to update the list of user roles, in the `permissions.databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
  * Array with the new list of user roles in the `permissions.roles` parameter.
  * List of user settings to update, in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the user you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  {{ yc-mdb-mg }} user delete <username> \
    --cluster-name <cluster_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Delete the `yandex_mdb_mongodb_user` resource with the description of the user you need.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- API {#api}

  To delete a user, use the [delete](../api-ref/User/delete.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Delete](../api-ref/grpc/User/delete.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Name of the user to delete in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmg-user-examples.md) %}
