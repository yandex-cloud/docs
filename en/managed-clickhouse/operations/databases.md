# Database management

{{ mch-name }} lets you manage cluster databases two ways:

- Using {{ yandex-cloud }} standard interfaces (CLI, API, or management console). Select this method if you wish to create and delete cluster databases using {{ mch-full-name }} features.
- SQL queries to the cluster. Select this method if you want to use an existing solution for creating and managing databases, or if you need {{ MY }} database support in {{ mch-name }}.

## Managing databases via SQL {#sql-database-management}

To enable management, select **User management via SQL** and **Database management via SQL** when [creating](cluster-create.md) or [reconfiguring](./update.md#SQL-management) a cluster.

In a cluster with DB management via SQL enabled:

- Database and [user](./cluster-users.md#sql-user-management) management via the standard {{ yandex-cloud }} interfaces (CLI, API, management console) is unavailable.
- You cannot enable user or database management via the standard {{ yandex-cloud }} interfaces.
- The existing users as well as user and database settings made with the standard {{ yandex-cloud }} interfaces will be saved.
- Users are managed under the `admin` account. You set its password when you select the **User management via SQL** and the **Database management via SQL** options.

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the command:

   ```
   $ {{ yc-mdb-ch }} database list
        --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

   To get a [list](../api-ref/Database/list.md) of cluster databases, use the list method.

- SQL

   1. [Connect](connect.md) to a cluster using the [`admin` account](#sql-database-management).
   1. Get a list of databases:

      ```sql
      SHOW DATABASES;
      ```

{% endlist %}

## Creating a database {#add-db}

The number of databases in a cluster is unlimited.

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need.&#x0D;
   1. Select the **Databases** tab.
   1. Click **Add**.
   1. Enter the database name and click **Add**.

   {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the create database command and set the name of the new database:

   ```
   $ {{ yc-mdb-ch }} database create <database name> \
       --cluster-name <cluster name>
   ```

   {{ mch-short-name }} runs the create database operation.

   {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `database` description block to the {{ mch-name }} cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        database {
          name = "<database name>"
        }
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

   You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method.

- SQL

   1. [Connect](connect.md) to a cluster using the [`admin` account](#sql-database-management).
   1. Create a database:

      ```sql
      CREATE DATABASE <database name>;
      ```

      {% include [db-name-limits](../../_includes/mdb/mch/note-info-db-name-limits.md) %}

   To learn more about creating databases, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/ru/sql-reference/statements/create/database/).

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.
   1. Click the ![image](../../_assets/vertical-ellipsis.svg) icon in the same row as the desired DB and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a database, run the command:

   ```
   $ {{ yc-mdb-ch }} database delete <database name>
        --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `database` description block from the {{ mch-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

   You can delete a database using the [delete](../api-ref/Database/delete.md) method.

- SQL

   1. [Connect](connect.md) to a cluster using the [`admin` account](#sql-database-management).
   1. Delete the database:

      ```sql
      DROP DATABASE <database name>;
      ```

   To learn more about deleting objects, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/ru/sql-reference/statements/drop/).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted is restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}
