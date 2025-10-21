---
title: Updating a connection in {{ websql-full-name }}
description: Follow this guide to update your connections.
---

# Updating a connection

Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), you can view the [connections'](../concepts/index.md#connection) status and update them or reconnect to databases. Active connections are marked in green, while inactive ones, in red. You can:

   * [Updating an active connection](#update-active-connection)
   * [Re-enabling an inactive connection](#reconnect-inactive-connection)

{% note tip %}

Use the search field on the **Connection** panel to find a connection with the appropriate database, table, or schema.

{% endnote %}

## Updating an active connection {#update-active-connection}

1. Select the active DB connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the database name and select **Update database**.

This will update the entire hierarchy for this database, including tables and views. If a table was deleted from a database, you will need to refresh the connection for the changes to appear in {{ websql-full-name }}.

To refresh all active connections, click ![image](../../_assets/console-icons/arrows-rotate-right.svg) in the top-right corner of the ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section.

## Reconnecting inactive connections {#reconnect-inactive-connection}

1. Select the inactive connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the database name and select **Reconnect**.
