# Managing databases

You can add and remove databases, view information about them, and manage some database settings using {{ mmy-name }} interfaces.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  {{ yc-mdb-my }} database list
     --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

  Use the [list](../api-ref/Database/list.md) API method and pass the cluster ID in the `clusterId` request parameter.

  {% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Creating a database {#add-db}

There are no limits to the number of databases in a cluster.

{% note info %}

Created databases are not available to cluster users by default. To connect to a new database, [grant privileges to the appropriate users](grant.md#grant-privilege).

{% endnote %}

{% list tabs %}

- Management console
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
  1. Click on the name of the desired cluster.
  1. If the owner of the new database still doesn't exist, [add the user](cluster-users.md#adduser).
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter a name for the database and click **Add**.

  {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. View a description of the CLI create database command:

     ```
     {{ yc-mdb-my }} database create --help
     ```

  1. Run the create database command:

     ```
     {{ yc-mdb-my }} database create <database name> --cluster-name=<cluster name>
     ```

     {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     {{ mmy-short-name }} runs the create database operation.

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. Add a `database` description block to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        database {
          name = "<DB name>"
        }
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

- API

  Use the [create](../api-ref/Database/create.md) API method and pass the following in the request:

  * The ID of the cluster where you want to create a database, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

  * Database name, in the `databaseSpec.name` parameter.

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```
  {{ yc-mdb-my }} database delete <database name> --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. Delete the `database` description block from the {{ mmy-name }} cluster description.

  1. Delete from the user description the `permission` blocks containing the `database_name` field pointing to the database to delete.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

- API

  Use the [delete](../api-ref/Database/delete.md) API method and pass the following in the request:
  * The ID of the cluster where the database is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Database name, in the `databaseName` parameter. To find out the database name, [get a list of databases in the cluster](#list-db).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

## Setting SQL mode {#sql-mode}

You can set or change the value of the [sql_mode](../concepts/settings-list.md#setting-sql-mode) setting that defines the SQL mode for the database. This operation restarts the cluster hosts.

{% list tabs %}

- Management console
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **DBMS settings**, click **Settings**.
  1. In the list of the settings, locate the **Sql mode** parameter.
  1. Configure a set of SQL modes in the drop-down list. To restore default settings, click **Reset**.
  1. Click **Save** in the DBMS settings dialog box.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Set the SQL modes in the `--set` parameter, for example:

  ```bash
  {{ yc-mdb-my }} cluster update-config
    --name <cluster name>
    --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Pay close attention to quotation marks: the entire string must constitute the parameter value, including `sql_mode=`.

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. Set the SQL modes in the `sql_mode` parameter under `mysql_config`, for example:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster name>" {
          ...
          mysql_config = {
            sql_mode = "<list of SQL modes>"
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * An array with new {{ MY }} settings in the following parameter:
        * `configSpec.mysqlConfig_5_7.sqlMode` for {{ MY }} 5.7.
        * `configSpec.mysqlConfig_8_0.sqlMode` for {{ MY }} 8.0.

    {% include [Resetting the settings of the object being modified](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Changing a character set and collation rules {#charset-collate}

To set the `CHARACTER SET` and `COLLATE` settings for the database:

1. [Connect](connect.md) to the database under the account of the database owner or as a user with the `ALTER` privilege for this database.

1. Run the [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html) query:

   ```sql
   ALTER DATABASE <DB name> CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci'.
   ```

1. To apply settings to the database tables along with the database, convert the tables with the same settings:

   ```sql
   ALTER TABLE <DB name>.<table name> CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci'.
   ```
