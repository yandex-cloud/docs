# Database management

You can add and remove databases, as well as view information about them.

## Getting a list of databases in a cluster {#list-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

{% endlist %}

## Creating a database {#add-db}

The number of databases in a cluster is unlimited.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need.
  1. If a new database should be owned by a non-existing user, [create a user](cluster-users.md#adduser).
  1. Select the **Databases** tab.
  1. Click **Add**.
  1. Enter the database name and select its owner.

{% endlist %}

## Removing a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

{% endlist %}

