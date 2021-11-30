# Database management

- [Getting a list of cluster databases](#list-db).
- [Creating a database](#add-db).
- [Changing database collation settings](#collation).
- [Deleting a database](#remove-db).

{% include [db-sql](../../_includes/mdb/mms/db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

- API

  Use the [list](../api-ref/Database/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a database {#add-db}

You can create an unlimited number of databases in each {{ mms-name }} cluster.

{% list tabs %}

- Management console

  To create a database:

  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need.
  1. If the owner of the new database still doesn't exist, [add the user](cluster-users.md#adduser).
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter the database name and click **Create**.

      {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

  1. [Grant the `DB_OWNER`](grant.md) role to the user that should become the owner of the new database.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

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

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mms }}).

- API

  Use the [create](../api-ref/Database/create.md) API method and pass the following in the request:

  - ID of the cluster where you want to create a database, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

  - Database name, in the `databaseSpec.name` parameter.

      {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Changing database collation settings {#collation}

1. [Connect](connect.md) to the database under the database owner's account.
1. Run an `ALTER DATABASE` query and specify the names of the new collation settings.

{% note info %}

The query will change collation settings for new DB objects only. Learn more about modifying collation settings for existing databases in the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-database-collation).

{% endnote %}

For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-database-collation).

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Delete**.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. Delete the `database` description block from the {{ mms-name }} cluster description.

    1. Delete from the user description the `permission` blocks containing the `database_name` field pointing to the database to delete.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the deletion of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mms }}).

- API

  Use the [delete](../api-ref/Database/delete.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the database is hosted. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Database name, in the `databaseName` parameter. To find out the database name, [get a list of databases in the cluster](#list-db).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

