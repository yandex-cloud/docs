---
title: Adding a connection to a DB in a cluster in {{ websql-full-name }}
description: Follow this guide to create connections to managed database clusters.
---

# Adding a connection to a DB in a cluster

[Connections](../concepts/index.md#connection) to databases within a cluster are grouped into an expandable list under the name of that cluster. In the connection settings, such databases will have the same URL and port number.

If you already have a database connection in a cluster, you can add a connection to another database in the same cluster:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the cluster in the connection tree.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster name and select **Add connection**.
1. In the window that opens, the **Database type** and **Cluster** fields will be automatically filled out. Specify the connection name, database name, and the relevant login credentials.
1. Click **Create**.
