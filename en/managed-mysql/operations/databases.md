---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Database management

You can add and remove databases, view information about them, and manage some database settings using {{ mmy-name }} interfaces.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ {{ yc-mdb-my }} database list
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Creating a database {#add-db}

There are no limits to the number of databases in a cluster.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need.
  1. If the owner of the new database still doesn't exist, [add the user](cluster-users.md#adduser).
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter a name for the database and click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. View a description of the CLI create database command:

     ```
     $ {{ yc-mdb-my }} database create --help
     ```

  1. Run the create database command:

     ```
     $ {{ yc-mdb-my }} database create <database name> --cluster-name=<cluster name>
     ```

     {{ mmy-short-name }} runs the create database operation.

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

{% note info %}

[Grant roles to the appropriate users](grant.md#grant-role) to access the created database.

{% endnote %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```
  $ {{ yc-mdb-my }} database delete <database name> --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

## Setting SQL mode {#sql-mode}

You can set or change the value of the [sql_mode](../concepts/settings-list.md#setting-sql-mode) setting that defines the SQL mode for the database. This operation restarts the cluster hosts.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
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
  $ {{ yc-mdb-my }} cluster update-config
       --name=<cluster name>
       --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Pay close attention to quotation marks: the entire string must constitute the parameter value, including `sql_mode=`.

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

  Pass the `sqlMode` array in the new {{ MY }} configuration by making the [update](../api-ref/Cluster/update.md) query.

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

