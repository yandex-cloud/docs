# Managing databases in {{ mmy-name }}

You can add and remove databases, view database details, and manage some database settings using {{ mmy-name }} interfaces.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of cluster databases, run this command:

  ```bash
  {{ yc-mdb-my }} database list \
     --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.list](../api-ref/Database/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/databases'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Database/list.md#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService/List](../api-ref/grpc/Database/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.DatabaseService.List
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) to make sure your request was successful.

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name.
  1. If you want a new user to become the database owner, [create it](cluster-users.md#adduser).
  1. Select the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Enter a database name and click **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

  1. [Grant access privileges](grant.md#grant-privilege) for the created database to the relevant cluster users.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. See the description of the CLI command for creating a database:

     ```bash
      {{ yc-mdb-my }} database create --help
     ```

  1. Run this command:

      ```bash
      {{ yc-mdb-my }} database create <DB_name> --cluster-name=<cluster_name>
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

      {{ mmy-short-name }} will start creating the database.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information on how to create this file, see [this guide](cluster-create.md).

  1. Add the `yandex_mdb_mysql_database` resource:

      ```hcl
      resource "yandex_mdb_mysql_database" "<DB_name>" {
        cluster_id = "<cluster_ID>"
        name       = "<DB_name>"
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.create](../api-ref/Database/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/databases' \
          --data '{
                    "databaseSpec": {
                      "name": "<DB_name>"
                    }
                  }'
      ```

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService/Create](../api-ref/grpc/Database/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "database_spec": {
                  "name": "<DB_name>"
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.DatabaseService.Create
      ```

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the database in question and select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run this command:

  ```bash
   {{ yc-mdb-my }} database delete <DB_name> --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information on how to create this file, see [this guide](cluster-create.md).

  1. Delete the `yandex_mdb_mysql_database` resource with the name of the database you are deleting.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Database.delete](../api-ref/Database/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/databases/<DB_name>'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the database name, with the [list of databases in the cluster](#list-db).

  1. Check the [server response](../api-ref/Database/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [DatabaseService/Delete](../api-ref/grpc/Database/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "database_name": "<DB_name>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.DatabaseService.Delete
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the database name, with the [list of databases in the cluster](#list-db).

  1. Check the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete. Otherwise, the original database will be restored. You can get the operation status with the [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

## Setting SQL mode {#sql-mode}

You can set or update the [sql_mode](../concepts/settings-list.md#setting-sql-mode) parameter that defines the SQL mode for the database. This will restarts the cluster hosts.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. In the list of the settings, locate **sql_mode**.
  1. Select the required SQL modes from the drop-down list. To restore the default settings, click **{{ ui-key.yacloud.component.mdb.settings.button_reset }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}** in the DBMS settings dialog box.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Specify the required SQL modes in the `--set` parameter:

  ```bash
  {{ yc-mdb-my }} cluster update-config \
    --name <cluster_name> \
    --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Pay attention to quotation marks: the parameter value must include the entire string, including `sql_mode=`.

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. Specify the required SQL modes in the `sql_mode` parameter under `mysql_config`:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
          ...
          mysql_config = {
            sql_mode = "<SQL_mode_list>"
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mysqlConfig_<{{ MY }}_version>",
                    "configSpec": {
                      "mysqlConfig_<{{ MY }}_version>": {
                        "sqlMode": [
                          "<SQL_mode_1>", "<SQL_mode_2>", ..., "<SQL_mode_N>"
                        ]
                      }
                    }
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.mysqlConfig_<{{ MY }}_version>.sqlMode`: List of SQL modes. For all available modes, see the following {{ MY }} docs:

          * [Version 5.7](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting)
          * [Version 8.0](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting)

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.mysql_config_<{{ MY }}_version>"
                  ]
                },
                "config_spec": {
                  "mysql_config_<{{ MY }}_version>": {
                    "sql_mode": [
                      "<SQL_mode_1>", "<SQL_mode_2>", ..., "<SQL_mode_N>"
                    ]
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `config_spec.mysql_config_<{{ MY }}_version>.sql_mode`: List of SQL modes. For all available modes, see the following {{ MY }} docs:

          * [Version 5.7](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting)
          * [Version 8.0](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting)

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a character set and collation rules {#charset-collate}

To configure the `CHARACTER SET` and `COLLATE` database settings:

1. [Connect](connect.md) to the database as the database owner or as a user with the `ALTER` privilege for this database.
1. Run the [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html) query:

   ```sql
   ALTER DATABASE <DB_name> CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
   ```

1. To apply the updated settings not only to the database but also to its tables, convert the tables using the same settings:

   ```sql
   ALTER TABLE <DB_name>.<table_name> CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
   ```
