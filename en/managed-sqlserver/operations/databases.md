# Managing databases

* [Getting a list of databases in a cluster](#list-db).
* [Create a database](#add-db).
* [Change the sorting parameters of the database](#collation).
* [Delete the database](#remove-db).

{% include [db-sql](../../_includes/mdb/mms/db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the following command:

   ```bash
   {{ yc-mdb-ms }} database list \
     --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [list](../api-ref/Database/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a database {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the desired cluster.
   1. If the owner of the new database doesn't exist, [add the user](cluster-users.md#adduser).
   1. Select the **Databases** tab.
   1. Click **Add**.
   1. Enter the database name and click **Create**.

      {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

   1. [Grant the `DB_OWNER` role](grant.md) to the user that should become the owner of the new database.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a database in the cluster:
   1. View a description of the CLI create database command:

      ```bash
      {{ yc-mdb-ms }} database create --help
      ```

   1. Run the create database command:

      ```bash
      {{ yc-mdb-ms }} database create <database name> \
        --cluster-name=<cluster name>
      ```

      {% include [db-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

      {{ mms-name }} runs the create database operation.

   To grant users access to the created database, [follow the instructions](cluster-users.md#update-settings).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add a `database` block to the {{ mms-name }} cluster description.

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        database {
          name = "<database name>"
        }
      }
      ```

      {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

   1. Add a `permission` block to the description of the user to become the owner of the new database:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        user {
          ...
          permission {
            database_name = "<database name>"
            roles         = ["OWNER"]
          }
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [create](../api-ref/Database/create.md) API method and pass the following information in the request:
   * ID of the cluster where you want to create a database, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Database name, in the `databaseSpec.name` parameter.

      {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

{% endlist %}

## Changing database collation settings {#collation}

1. [Connect](connect.md) to the database under the database owner's account.
1. Run an `ALTER DATABASE` query and specify the names of the new collation settings.

{% note info %}

The query will change collation settings for new DB objects only. Learn more about modifying collation settings for existing databases in the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/collations/set-or-change-the-database-collation).

{% endnote %}

For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/collations/set-or-change-the-database-collation).

## Deleting a database {#remove-db}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired DB and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete the database, run the command:

   ```bash
   {{ yc-mdb-ms }} database delete <database name> \
     --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the `database` description block from the {{ mms-name }} cluster description.
   1. Delete from the user description the `permission` blocks containing the `database_name` field pointing to the database to be deleted.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type the word `yes`, then press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [delete](../api-ref/Database/delete.md) API method and pass the following in the request:
   * ID of the cluster that hosts the database, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Database name, in the `databaseName` parameter. To find out the database name, [request a list of databases in the cluster](#list-db).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}