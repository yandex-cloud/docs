# Database management

You can add and remove databases, as well as view information about them.

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ {{ yc-mdb-pg }} database list
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

  To get a list of cluster databases, use the [list](../api-ref/Database/list.md) method.

{% endlist %}

## Creating a database {#add-db}

You can create an unlimited number of databases in each {{ mpg-name }} cluster.

By default, databases are created with the `LC_COLLATE=C` and `LC_CTYPE=C` encoding settings. This allows {{ PG }} to run queries with string data types more efficiently, but may sometimes work counter-intuitively (for example, with Cyrillic). These settings are covered in more detail in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/locale.html).

{% note alert %}

The LC_COLLATE and LC_CTYPE settings of a database cannot be changed after its creation.

{% endnote %}

You can configure character collation and sorting settings for columns when you create and edit
specific tables. Learn more in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-createtable.html).

{% list tabs %}

- Management console

  To create a database:
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need.

  1. If the owner of the new database still doesn't exist, [add the user](cluster-users.md#adduser).
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter the database name, select its owner, and configure the character set.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. See the description of the CLI's create database command:

     ```
     $ {{ yc-mdb-pg }} database create --help
     ```

  1. Request a list of cluster users to select the owner of the new database:

     ```
     $ {{ yc-mdb-pg }} user list
          --cluster-name <cluster name>
     ```

     If the required user is not in the list, [create it](cluster-users.md#adduser).

  1. Run the create database command. If needed, specify the character collation and sorting settings (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`):

     ```
     $ {{ yc-mdb-pg }} database create <database name>
          --cluster-name <cluster name>
          --owner <username of the DB owner>
          --lc-collate ru_RU.UTF-8
          --lc-type ru_RU.UTF-8
     ```

     {{ mpg-short-name }} runs the create database operation.

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

  You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```
  $ {{ yc-mdb-pg }} database delete <database name>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

  You can delete a database using the [delete](../api-ref/Database/delete.md) method.

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted is restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

