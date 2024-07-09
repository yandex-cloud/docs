# Connection management

The ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section in {{ websql-full-name }} enables you to:

* Create a connection to public databases or managed database clusters. To learn more about creating connections, see [this guide](create-connection.md).
* [View information about a managed database cluster](#view-cluster-settings).
* [View information about a connection](#view-connection-settings).
* [View information about a database](#view-db-settings).
* [Change connection settings](#change-connection-settings).
* [Update a connection](#update-connection).
* [Add a connection to a managed database cluster](#add-connection-to-cluster).
* [Delete the connection you no longer need](#delete-connection).

## Viewing information about a managed database cluster {#view-cluster-settings}

To view cluster settings:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the managed database cluster.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster name and select **Cluster information**.

This will bring up a panel with cluster settings.

## Viewing information about a connection {#view-connection-settings}

To view connection settings:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection name and select **Connection information**.

This will bring up a panel with connection settings.

There are groups of tables and views (`VIEW`) within a single connection. For more information on how to view info about tables and views, see [this guide](view-db-objects-info.md).

## Viewing information about a database {#view-db-settings}

To view database settings:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the database.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the database name and select **Database information**.

This will bring up a panel with DB settings.

## Changing connection settings {#change-connection-settings}

### Changing connection settings for a managed database cluster {#change-cluster-connection-settings}

To change connection settings:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection name and select **Edit connection**.
1. Enter a new name for the connection.
1. In the **Cluster** field, select the managed database cluster you want to connect to.
1. Specify the **Username** you will use to connect to cluster databases.
1. To change the password, select the **Change password** option and enter a new user password.
1. List the **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them configured.
1. Click **Apply**.

### Changing connection settings for a public database {#change-public-db-connection-settings}

To change connection settings:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection name and select **Edit connection**.
1. Enter a new name for the connection.
1. Under **Hosts**, configure the hosts:
   * Specify the database host FQDN and port number for connecting to the database.
   * For {{ CH }}, also specify the Native Protocol port and [shard](../../managed-clickhouse/operations/shards.md#list-shards) name.
   * (Optional) Enable TLS.

      If your company has a certification authority (CA), the certificate issued by the CA will be used by default. If the company has no CA, upload the server's TLS certificate.

1. Specify the **Username** you will use to connect to cluster databases.
1. To change the password, select the **Change password** option and enter a new user password.
1. List the **Databases** you want to connect to. You can only connect to existing databases. The user you specified must have access to them configured.
1. Click **Apply**.

## Updating a connection {#update-connection}

In the ![image](../../_assets/console-icons/folder-tree.svg) [**Connection**]({{ websql-link }}) section, you can view the status of connections and update them or reconnect to databases. Active connections are marked in green, while inactive ones, in red.

{% note tip %}

Use the search field on the **Connection** panel to find a connection with the appropriate database, table, or schema.

{% endnote %}

### Updating an active connection {#update-active-connection}

1. Select the active DB connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the database name and select **Update database**.

This will update the entire hierarchy for this database, including tables and views. If a table was deleted from a database, you will need to refresh the connection for the changes to appear in {{ websql-full-name }}.

To refresh all active connections, click ![image](../../_assets/console-icons/arrows-rotate-right.svg) in the top-right corner of the ![image](../../_assets/console-icons/folder-tree.svg) [**Connection**]({{ websql-link }}) section.

### Reconnecting inactive connections {#reconnect-inactive-connection}

1. Select the inactive connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the database name and select **Reconnect**.

## Adding a connection to a managed database cluster {#add-connection-to-cluster}

Connections to databases within a cluster are grouped into an expandable list under the name of that cluster. In the connection settings, such databases will have the same URL and port number.

If you already have a database connection in a cluster, you can add a connection to another database in the same cluster:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the cluster you need in the connection tree.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster name and select **Add connection**.
1. In the window that opens, the **Database type** and **Cluster** fields will be automatically filled out. Specify the connection name, database name, and the relevant login credentials.
1. Click **Connect**.

## Deleting a connection {#delete-connection}

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of its name and select **Delete connection**.
1. In the window that opens, click **Apply**.

The connection will be deleted from both {{ websql-full-name }} and {{ connection-manager-name }} in {{ metadata-hub-name }}.

You can also delete a connection from {{ connection-manager-name }} in {{ metadata-hub-name }}. This connection will be automatically deleted from {{ websql-full-name }}. Deletion is limited to the user's folder.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
