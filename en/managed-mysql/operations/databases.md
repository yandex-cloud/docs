# Managing databases in {{ mmy-name }}

You can add and remove databases, view information about them, and manage some database settings using {{ mmy-name }} interfaces.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```bash
  {{ yc-mdb-my }} database list \
     --cluster-name=<cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.list](../api-ref/Database/list.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/databases'
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/list.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService/List](../api-ref/grpc/Database/list.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) to make sure the request was successful.

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name.
  1. If the new database does not have an owner among its current users, [add such a user](cluster-users.md#adduser).
  1. Select the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Enter the database name and click **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

  1. [Grant privileges](grant.md#grant-privilege) for access to the database created to the appropriate cluster users.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. View a description of the CLI create database command:

     ```bash
      {{ yc-mdb-my }} database create --help
     ```

  1. Run the create database command:

      ```bash
      {{ yc-mdb-my }} database create <DB_name> --cluster-name=<cluster_name>
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

      {{ mmy-short-name }} runs the create database operation.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

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

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.create](../api-ref/Database/create.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Database/create.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService/Create](../api-ref/grpc/Database/create.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the DB you need and select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```bash
   {{ yc-mdb-my }} database delete <DB_name> --cluster-name=<cluster_name>
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

  1. Delete the `yandex_mdb_mysql_database` resource with the name of the database you want to delete.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_database).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.delete](../api-ref/Database/delete.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/databases/<DB_name>'
      ```

      You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/Database/delete.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService/Delete](../api-ref/grpc/Database/delete.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

      You can get the cluster ID with the [list of clusters in your folder](cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](#list-db).

  1. View the [server response](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation1) to make sure the request was successful.

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

## Setting SQL mode {#sql-mode}

You can set or change the value of the [sql_mode](../concepts/settings-list.md#setting-sql-mode) setting that defines the SQL mode for the database. This operation restarts the cluster hosts.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. In the list of the settings, locate the **sql_mode** parameter.
  1. Configure a set of SQL modes in the drop-down list. To restore default settings, click **{{ ui-key.yacloud.component.mdb.settings.button_reset }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}** in the DBMS settings dialog box.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Set the SQL modes in the `--set` parameter, e.g.:

  ```bash
  {{ yc-mdb-my }} cluster update-config \
    --name <cluster_name> \
    --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Pay close attention to quotation marks: the entire string must constitute the parameter value, including `sql_mode=`.

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](./cluster-create.md).

    1. Set the SQL modes in the `sql_mode` parameter under `mysql_config`, e.g.:

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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          In this case, only one parameter is provided.

      * `configSpec.mysqlConfig_<version_{{ MY }}>.sqlMode`: List of SQL modes. For available modes, see the {{ MY }} documentation:

          * [for version 5.7](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting).
          * [for version 8.0](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting).

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          In this case, only one parameter is provided.

      * `config_spec.mysql_config_<version_{{ MY }}>.sql_mode`: List of SQL modes. For available modes, see the {{ MY }} documentation:

          * [for version 5.7](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting).
          * [for version 8.0](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting).

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing a character set and collation rules {#charset-collate}

To configure the `CHARACTER SET` and `COLLATE` database settings:

1. [Connect](connect.md) to the database under the account of the database owner or as a user with the `ALTER` privilege for this database.
1. Run the [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html) query:

   ```sql
   ALTER DATABASE <DB_name> CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
   ```

1. To apply settings to the database tables along with the database, convert the tables with the same settings:

   ```sql
   ALTER TABLE <DB_name>.<table_name> CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
   ```
