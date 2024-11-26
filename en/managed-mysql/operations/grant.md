---
title: Managing MySQL user permissions
description: You can manage MySQL user permissions at the level of an individual database by updating user privileges. Users can have different sets of privileges for different databases. To learn more about the privileges supported, see their respective descriptions.
---
# Managing user permissions

You can manage user permissions at the level of an individual database by updating [user privileges](../concepts/user-rights.md).

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Changing user privileges {#grant-privilege}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.

  1. Click the name of the cluster you need and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.

  1. Add the databases required for the user:

     1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
     1. Select the database from the drop-down list.
     1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke access to a specific database, delete it from the list by clicking ![image](../../_assets/console-icons/xmark.svg) to the right of the database name.

  1. Set up user privileges for each of the user's databases.

     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column, click ![image](../../_assets/console-icons/plus.svg).
     1. Select the privilege you want to add to the user from the drop-down list.
     1. Repeat the previous two steps until all the required privileges are added.

  1. To revoke a privilege, click ![image](../../_assets/console-icons/xmark.svg) to the right of its name.
  1. If necessary, set the [administrative privileges](../concepts/settings-list.md#setting-administrative-privileges) for the user.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * Granting privileges to a user:

      ```bash
      {{ yc-mdb-my }} user grant-permission <username> \
        --cluster-name <cluster_name> \
        --database <DB_name> \
        --permissions <privileges_separated_by_commas>
      ```

      You can get the cluster name with the [list of clusters in the folder](cluster-list.md), the DB name, with the [list of databases in the cluster](databases.md#list-db), and the user's name, with the [list of users in the cluster](cluster-users.md#list-users).

  * Revoking user privileges:

      ```bash
      {{ yc-mdb-my }} user revoke-permission <username> \
        --cluster-name <cluster_name> \
        --database <DB_name> \
        --permissions <privileges_separated_by_commas>
      ```

      To grant or revoke the `ALL_PRIVILEGES` privilege, specify the `ALL` synonym as the privilege name.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

  1. Find the `yandex_mdb_mysql_user` resource of the user you need and change the list of their privileges for the appropriate database in the `roles` parameter:

      ```hcl
      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
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

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [User.update](../api-ref/User/update.md) method and make a request, e.g., using {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/users/<username>' \
          --data '{
                    "updateMask": "permissions",
                    "permissions": [
                      {
                        "databaseName": "<DB_name>",
                        "roles": [
                          "<privilege_1>", "<privilege_2>", ..., "<privilege_N>"
                        ]
                      }
                    ]
                  }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          In this case, only one parameter is provided.

      * `permissions`: User permission settings:

          * `databaseName`: Name of the database the user gets access to.
          * `roles`: Array of user's privileges, each provided as a separate string in the array. For the list of possible values, see [User privileges in a cluster](../concepts/user-rights.md#db-privileges).

          For each database, add a separate item with permission settings to the `permissions` array.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [UserService/Update](../api-ref/grpc/User/update.md) call and make a request, e.g., using {{ api-examples.grpc.tool }}:

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
                    "permissions"
                  ]
                },
                "permissions": [
                  {
                    "database_name": "<DB_name>",
                    "roles": [
                      "<privilege_1>", "<privilege_2>", ..., "<privilege_N>"
                    ]
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          In this case, only one parameter is provided.

      * `permissions`: User permission settings:

          * `database_name`: Name of the database the user gets access to.
          * `roles`: Array of user's privileges, each provided as a separate string in the array. For the list of possible values, see [User privileges in a cluster](../concepts/user-rights.md#db-privileges).

          For each database, add a separate item with permission settings to the `permissions` array.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the username, with the [list of users in the cluster](#list-users).

  1. View the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
