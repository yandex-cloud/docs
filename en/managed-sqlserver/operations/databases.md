---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Database management

- [Getting a list of cluster databases](#list-db).
- [Creating a database](#add-db).
- [Deleting a database](#remove-db).

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

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
  1. [Grant the `DB_OWNER`](grant.md) role to the user that should become the owner of the new database.

- API

  Use the [create](../api-ref/Database/create.md) API method and pass the following in the request:
  - ID of the cluster where you want to create a database, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Database name, in the `databaseSpec.name` parameter.

To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Delete**.

- API

  Use the [delete](../api-ref/Database/delete.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the database is hosted. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Database name, in the `databaseName` parameter. To find out the database name, [get a list of databases in the cluster](#list-db).

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted is restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

