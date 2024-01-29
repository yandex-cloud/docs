---
title: "Managing MySQL user permissions"
description: "You can manage MySQL user permissions at the level of an individual database by updating user privileges. Users can have different sets of privileges for different databases. To learn more about the privileges supported, see their respective descriptions."
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

      1. Click ![image](../../_assets/console-icons/plus.svg) in the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column.
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
        --permissions <comma-separated_list_of_privileges>
      ```

      You can request the cluster name with a [list of clusters in the folder](cluster-list.md), the DB name with a [list of databases in the cluster](databases.md#list-db), and the user's name with a [list of users in the cluster](cluster-users.md#list-users).

   * Revoking user privileges:

      ```bash
      {{ yc-mdb-my }} user revoke-permission <username> \
        --cluster-name <cluster_name> \
        --database <DB_name> \
        --permissions <comma-separated_list_of_privileges>
      ```

      To grant or revoke the `ALL_PRIVILEGES` privilege, specify the `ALL` synonym as the privilege name.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Find the desired user's `yandex_mdb_mysql_user` resource and change the list of their privileges for the required database in the `roles` parameter:

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

- API {#api}

   To update user privileges, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster in which the user is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username, in the `userName` parameter. To find out the name, [get a list of users in the cluster](cluster-users.md#list-users).
   * Name of the database where you want to update the list of user privileges, in the `permissions.databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
   * New list of user privileges as an array in the `permissions.roles` parameter.
   * List of user configuration fields to update (`permissions` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
