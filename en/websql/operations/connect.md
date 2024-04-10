# Managing database connections

{% include notitle [preview](../../_includes/note-preview.md) %}

In [{{ websql-full-name }}]({{ websql-link }}), you can do the following using the **Connection Manager** panel (![image](../../_assets/console-icons/folder-tree.svg)):

* Add connections to [databases](#connect-db) or [database clusters](#connect-cluster).
* [Check connection settings](#change-connection-settings).
* [Re-establish previously created connections](#update-connection).
* [Delete connections](#delete-connection) that you no longer need.
* [Work with demo connections](#demo) to explore {{ websql-full-name }}.

## Connecting to a database cluster in {{ yandex-cloud }} {#connect-cluster}

If you have a [{{ PG }}](../../managed-postgresql/operations/cluster-list.md), [{{ CH }}](../../managed-clickhouse/operations/cluster-list.md), or [{{ MY }}](../../managed-mysql/operations/cluster-list.md) cluster configured in {{ yandex-cloud }}, you can connect directly to it:

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

## Connecting to an external database {#connect-db}

{% include notitle [connect-to-db](../../_includes/websql/connect-to-db.md) %}

## Adding a connection to a connection group {#add-connection-to-group}

The databases belonging to the same cluster are displayed in the connections tree as _connection groups_. In the connection settings, such databases will have the same URL and port number.

To add a connection to a group:

1. Select a group in the connections tree.
1. Click **...** to the right of the group name and select **Add connection**.
1. In the window that opens, you will see the preconfigured settings for the cluster connection. You can specify the database name as well as the username and password for access to it.
1. Click **Connect**.

## Renaming a connection group {#rename-group}

To rename a connection group:

1. Select a group in the connections tree.
1. Click **...** to the right of the group name and choose **Rename group**.
1. In the window that opens, specify a new group name and click **Apply**.

## Viewing connection settings {#change-connection-settings}

To view connection settings:

1. Select a connection or a connection group.
1. Click **...** to the right of the connection name and choose **Connection information**.

A panel with connection settings will open.

There are groups of tables and views (`VIEW`) within a single connection.

## Viewing information about a table {#view-table}

To view detailed information about a table and its columns:

1. Select the connection and database.
1. In the **Tables** group, select a table.
1. To the right of the table name, click ![image](../../_assets/console-icons/sliders-vertical.svg) and select **Table information**.

This opens a panel with information about the table, including its name, size, and an approximate number of table rows. You can also get the following information about table columns:

* Column name.
* Data type.
* Whether the column is Nullable.
* Whether the column is a primary key.

If the table contains indexes or triggers, the same panel will display information about columns and indexing types, as well as trigger events.

## Viewing information about a view {#view-view}

To see detailed information about a view:

1. Select the connection and database.
1. In the **Views** group, select the view.
1. To the right of the view name, click ![image](../../_assets/console-icons/sliders-vertical.svg) and select **View overview**.

A panel will open showing information about the view name and its columns:

* Column name.
* Data type.
* Whether or not the column is nullable.

## Viewing information about a schema {#view-scheme}

To see detailed information about a database schema:

1. Select the connection and database.
1. Select the schema.
1. To the right of the schema name, click ![image](../../_assets/console-icons/sliders-vertical.svg) and select **Schema information**.

A panel will open with information about the schema type and its sequences, if any.

## Reconnecting to databases and clusters {#update-connection}

In the Connection manager, you can view the status of connections and refresh them or reconnect to databases and clusters. Active connections are marked in green, inactive connections are marked in red.

{% note tip %}

Use the search field on the **Connection manager** panel to find a connection with the appropriate database, table, or schema.

{% endnote %}

To refresh an active connection:

1. Select an active connection.
1. Click **...** to the right of the connection name and choose **Refresh connection**.

This will update the entire hierarchy for this connection, including tables and views. If a table was deleted from a database, you will need to refresh the connection for the changes to appear in {{ websql-full-name }}.

To refresh all active connections, click ![image](../../_assets/console-icons/arrows-rotate-right.svg) in the top-right corner of the **Connection manager** panel.

To re-establish inactive connections:

1. Select an inactive connection.
1. Click **...** to the right of the connection name and choose **Reconnect**.
1. Enter your username and password for database access and click **Connect**.

## Deleting a connection {#delete-connection}

To delete the connections you no longer use:

1. Select a connection or a connection group.
1. Click **...** to the right of their name and choose **Delete connection** or **Delete group**.

## Managing demo connections {#demo}

Demo connections are pre-established connections with test databases that allow you to explore the {{ websql-full-name }} features. Demo connections are added by default. You cannot [delete](#delete-connection) or [rename](#rename-group) them, but you can hide them in the **Connection manager** panel:

1. Click **Settings** (![image](../../_assets/console-icons/gear.svg)) in the bottom-left corner.
1. Disable **Show demo connections** in the general settings.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
