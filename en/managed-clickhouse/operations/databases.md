# Database management

{{ mch-name }} lets you manage cluster databases in two ways:

- {{ yandex-cloud }} standard interfaces (CLI, API, or management console). Choose this method if you want to use all the features of the {{ yandex-cloud }} managed service.
- SQL queries to the cluster. Choose this method if you want to use an existing solution for creating and managing databases, or if you need {{ MY }} database support in {{ mch-name }}.

## Managing databases via SQL {#sql-database-management}

To manage databases using SQL, [create a cluster](cluster-create.md) with the following settings enabled:

- **User management via SQL**.
- **Database management via SQL**.

In a cluster with DB management via SQL enabled:

- You can only manage databases and [users](cluster-users.md#sql-user-management) via SQL.
- User and DB management using {{ yandex-cloud }} standard interfaces (the CLI, API, or management console) isn't possible.
- Users are managed under the `admin` account. The password for this account is set when creating a cluster.

{% include [sql-db-and-users-alert](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

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

  The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

- API

  To get a list of cluster databases, use the [list](../api-ref/Database/list.md) method.

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-database-management).

  1. Get a list of databases:

      ```sql
      SHOW DATABASES;
      ```

{% endlist %}

## Creating a database {#add-db}

There are no limits to the number of databases in a cluster.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need.
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter a name for the database and click **Add**.

  {% note info %}

    Database names may consist of Latin letters, numbers, dashes, and underscores. The maximum name length is 63 characters. You can't create a database named `default`.

  {% endnote %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the create database command and set the name of the new database:

  ```
  $ {{ yc-mdb-ch }} database create <database name>
      --cluster-name <cluster name>
  ```

  {{ mch-short-name }} runs the create database operation.

  {% note info %}

    Database names may consist of Latin letters, numbers, dashes, and underscores. The maximum name length is 63 characters. You can't create a database named `default`.

  {% endnote %}

  The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

- API

  You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method.

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-database-management).

  1. Create a database:

      ```sql
      CREATE DATABASE <database name>;
      ```

  To learn more about creating databases, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/create/database/).

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```
  $ {{ yc-mdb-ch }} database delete <database name>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

- API

  You can delete a database using the [delete](../api-ref/Database/delete.md) method.

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-database-management).

  1. Delete the database:

      ```sql
      DROP DATABASE <database name>;
      ```

  To learn more about deleting objects, see the [documentation for{{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/drop/).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

