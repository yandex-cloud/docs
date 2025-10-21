---
title: Deleting a connection in {{ websql-full-name }}
description: Follow this guide to delete unused connections.
---

# Deleting a connection

If you no longer need a [connection](../concepts/index.md#connection), you can delete it. To do this:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of its name and select **Delete connection**.
1. In the window that opens, click **Apply**.

The connection will be deleted from both {{ websql-full-name }} and {{ connection-manager-name }} in {{ metadata-hub-full-name }}.

You can also delete a connection from {{ connection-manager-name }} in {{ metadata-hub-full-name }}. This connection will be automatically deleted from {{ websql-full-name }}. Deletion is limited to the user's folder.
