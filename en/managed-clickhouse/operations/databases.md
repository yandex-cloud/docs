# Database management

You can add and remove databases, as well as view information about them.

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

{% endlist %}

## Creating a database {#add-db}

The number of databases in a cluster is unlimited.

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

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted is restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}