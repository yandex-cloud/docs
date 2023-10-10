# Managing database connections

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

On the **Connection manager** panel (![image](../../_assets/websql/connections.svg)), you can add connections to databases or database clusters, verify connection settings, reconnect previously created connections, and remove the connections you no longer need.

## Connecting to a database {#connect-db}

{% include notitle [connect-to-db](../../_includes/websql/connect-to-db.md) %}

## Connecting to a database cluster {#connect-cluster}

If you have a [{{ PG }}](../../managed-postgresql/operations/cluster-list.md), [{{ CH }}](../../managed-clickhouse/operations/cluster-list.md), or [{{ MY }}](../../managed-mysql/operations/cluster-list.md) cluster configured in {{ yandex-cloud }}, you can connect directly to it:

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

The databases belonging to the same cluster are displayed in the connections tree as _connection groups_. In the connection settings, such databases will have the same URL and port number.

To rename a connection group:

1. Select a group in the connections tree.
1. Click **...** to the right of the group name and choose **Rename connection group**.
1. In the window that opens, specify a new group name and click **Apply**.

## Review connection settings {#change-connection-settings}

To view connection settings:

1. Select a connection or a connection group.
1. Click **...** to the right of the connection name and choose **Connection group settings**.

A panel with connection settings will open.

## Reconnect to databases and clusters {#update-connection}

In the Connection manager, you can view the status of connections and refresh them or reconnect to databases and clusters. Active connections are marked in green, inactive connections are marked in red.

To refresh an active connection:

1. Select an active connection.
1. Click **...** to the right of the connection name and choose **Refresh connection**.

To refresh all active connections, click ![image](../../_assets/websql/refresh.svg) in the upper-right corner of the **Connection manager** panel.

To reconnect inactive connections:

1. Select an inactive connection.
1. Click **...** to the right of the connection name and choose **Reconnect**.
1. Enter your username and password for database access and click **Connect**.

## Deleting a connection {#delete-connection}

To delete the connections you no longer use:

1. Select a connection or a connection group.
1. Click **...** to the right of their name and choose **Remove connection** or **Remove connection group**.