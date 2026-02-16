---
title: Managing MySQL user permissions
description: You can manage MySQL user permissions for individual databases by changing user privileges. User’s privileges can vary across different databases. To learn more about supported privileges, refer to the respective privilege descriptions.
---
# Managing user permissions

You can manage user permissions for individual databases by changing [user privileges](../concepts/user-rights.md).

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Changing user privileges {#grant-privilege}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.

  1. Click the name of your cluster and select the ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.

  1. Optionally, add the databases required for the user:

     1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
     1. Select a database from the drop-down list.
     1. Repeat these two steps to select all required databases.
     1. To revoke access to a specific database, delete it from the list by clicking ![image](../../_assets/console-icons/xmark.svg) to the right of the database name.

  1. Set up user privileges for each of the user’s databases:

     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column, click ![image](../../_assets/console-icons/plus.svg).
     1. In the drop-down list, select the privilege you want to grant the user.
     1. Repeat these two steps to add all required privileges.

  1. To revoke a privilege, click ![image](../../_assets/console-icons/xmark.svg) to the right of its name.
  1. Configure the [administrative privileges](../concepts/settings-list.md#setting-administrative-privileges) for the user, if required.
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

      You can get the cluster name with the [list of clusters in the folder](cluster-list.md), the database name, with the [list of databases in the cluster](databases.md#list-db), and the username, with the [list of users in the cluster](cluster-users.md#list-users).

  * Revoking privileges from a user:

      ```bash
      {{ yc-mdb-my }} user revoke-permission <username> \
        --cluster-name <cluster_name> \
        --database <DB_name> \
        --permissions <privileges_separated_by_commas>
      ```

      To grant or revoke `ALL_PRIVILEGES`, specify the `ALL` alias as the privilege name.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For information on how to create such a file, see [Creating a cluster](cluster-create.md).

  1. Find the relevant `yandex_mdb_mysql_user` resource and change the list of user’s privileges for the appropriate database in the `roles` parameter:

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

      * `database_name`: Name of the database the user will have access to.
      * `roles`: List of user privileges for the database.

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

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `permissions`: User permission settings:

          * `databaseName`: Name of the database to which the user will have access.
          * `roles`: Array of user privileges, each provided as a separate string in the array. For the list of possible values, see [User privileges in a cluster](../concepts/user-rights.md#db-privileges).

          For each database, add a separate element with permission settings to the `permissions` array.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

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

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `permissions`: User permission settings:

          * `database_name`: Name of the database to which the user will have access.
          * `roles`: Array of user privileges, each provided as a separate string in the array. For the list of possible values, see [User privileges in a cluster](../concepts/user-rights.md#db-privileges).

          For each database, add a separate element with permission settings to the `permissions` array.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-users).

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
