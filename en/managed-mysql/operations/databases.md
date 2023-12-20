# Database management in {{ mmy-name }}

You can add and remove databases, view information about them, and manage some database settings using {{ mmy-name }} interfaces.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the command:

   ```bash
     {{ yc-mdb-my }} database list \
        --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- API

   To get a list of databases in a cluster, use the [list](../api-ref/Database/list.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/List](../api-ref/grpc/database_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name.
   1. If the new database does not have an owner among its current users, [add such a user](cluster-users.md#adduser).
   1. Select the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.databases.button_add }}**.
   1. Enter the database name and click **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

   1. [Grant privileges](grant.md#grant-privilege) for access to the database created to the appropriate cluster users.

- CLI

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

      You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

      {{ mmy-short-name }} runs the create database operation.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

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

- API

   To create a database, use the [create](../api-ref/Database/create.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Create](../api-ref/grpc/database_service.md#Create) gRPC API call and provide the following in the request:

   * The ID of the cluster where you want to create a database, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * Database name, in the `databaseSpec.name` parameter.

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_databases }}** tab.
   1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the same row as the DB and select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a database, run the command:

   ```bash
    {{ yc-mdb-my }} database delete <DB_name> --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `yandex_mdb_mysql_database` resource with the name of the database to delete.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mysql_database).

- API

   To delete a database, use the [delete](../api-ref/Database/delete.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete) gRPC API call and provide the following in the request:

   * ID of the cluster where the database is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Database name, in the `databaseName` parameter. To find out the database name, [retrieve a list of databases in the cluster](#list-db).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

## Setting SQL mode {#sql-mode}

You can set or change the value of the [sql_mode](../concepts/settings-list.md#setting-sql-mode) setting that defines the SQL mode for the database. This operation restarts the cluster hosts.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. In the list of the settings, locate the **sql_mode** parameter.
   1. Configure a set of SQL modes in the drop-down list. To restore default settings, click **{{ ui-key.yacloud.component.mdb.settings.button_reset }}**.
   1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}** in the DBMS settings dialog box.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Set the SQL modes in the `--set` parameter, e.g.:

   ```bash
   {{ yc-mdb-my }} cluster update-config \
     --name <cluster_name> \
     --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
   ```

   Pay close attention to quotation marks: the entire string must constitute the parameter value, including `sql_mode=`.

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. Set the SQL modes in the `sql_mode` parameter under `mysql_config`, e.g.:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        mysql_config = {
          sql_mode = "<list_of_SQL_modes>"
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

- API

   To set the SQL modes you need, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * An array with new {{ MY }} settings in the following parameter:
      * `configSpec.mysqlConfig_5_7.sqlMode` for {{ MY }} 5.7.
      * `configSpec.mysqlConfig_8_0.sqlMode` for {{ MY }} 8.0.

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing a character set and collation rules {#charset-collate}

To set the `CHARACTER SET` and `COLLATE` settings for the database:

1. [Connect](connect.md) to the database under the account of the database owner or as a user with the `ALTER` privilege for this database.
1. Run the [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html) query:

   ```sql
   ALTER DATABASE <DB_name> CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
   ```

1. To apply settings to the database tables along with the database, convert the tables with the same settings:

   ```sql
   ALTER TABLE <DB_name>.<table_name> CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
   ```
