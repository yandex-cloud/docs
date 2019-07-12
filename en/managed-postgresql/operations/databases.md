# Database management

You can add and remove databases, as well as view information about them.

## Getting a list of databases in a cluster {#list-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **Managed Service for PostgreSQL**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster databases, run the command:

  ```
  $ yc managed-postgresql database list
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

- API

  To get a list of cluster databases, use the [list](../api-ref/Database/list.md) method.

{% endlist %}

## Creating a database {#add-db}

The number of databases in a cluster is unlimited.

{% note important %}

By default, databases are created with string collation and sorting settings: `LC_COLLATE=C` and `LC_CTYPE=C`.
This allows PostgreSQL to more effectively execute queries with string data, but it can
work subtly, for example, with Cyrillic.

These settings are covered in more detail in the [PostgreSQL documentation](https://www.postgresql.org/docs/current/collation.html).

{% endnote %}

The LC_COLLATE and LC_CTYPE settings of a database cannot be changed after its creation.
To create a database with the necessary values for these settings, use such flags as `--lc-collate`
и `--lc-type` in the `yc managed-postgresql database create` CLI command.

Once the database is created, you can specify the collation and order sorting settings for columns when creating and changingtables. Learn more in the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-createtable.html).

{% list tabs %}

- Management console
  1. Go to the folder page and select **Managed Service for PostgreSQL**.
  1. Click on the name of the cluster you need.
  1. If a new database should be owned by a non-existing user, [create a user](cluster-users.md#adduser).
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter the database name and select its owner.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. See the description of the CLI's create database command:

     ```
     $ yc managed-postgresql database create --help
     ```

  1. Request a list of cluster users to select the owner of the new database:

     ```
     $ yc managed-postgresql user list
          --cluster-name <cluster name>
     ```

     If the required user is not in the list, [create a user](cluster-users.md#adduser).

  1. Run the create database command:

     ```
     $ yc managed-postgresql database create <database name>
          --cluster-name <cluster name>
          --owner <username of the DB owner>
     ```

     Managed Service for PostgreSQL launches the create database operation.

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

- API

  You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method.

{% endlist %}

## Removing a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **Managed Service for PostgreSQL**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a database, run the command:

  ```
  $ yc managed-postgresql database delete <database name>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

- API

  You can delete a database using the [delete](../api-ref/Database/delete.md) method.

{% endlist %}

