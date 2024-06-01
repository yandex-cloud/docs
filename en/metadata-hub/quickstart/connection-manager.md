# Getting started with Connection manager

{% include notitle [preview](../../_includes/note-preview.md) %}

Manage connections to {{ PG }}, {{ MY }}, and {{ CH }} databases with {{ connection-manager-full-name }}.

## Integrating with managed database services {#mdb-integration}

{% note warning %}

Once access to {{ connection-manager-full-name }} is confirmed, connections for clusters with managed databases will be created automatically.

{% endnote %}

1. Create a [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md) or [{{ mmy-short-name }}](../../managed-mysql/operations/cluster-create.md) cluster.
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check a connection.
1. Select **{{ metadata-hub-name }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.

In the connection list, you can view the connections created for your clusters and [configure access](../operations/connection-access.md) to them.

## Managing database connections {#database-connections}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Click **Create connection**.
   1. Enter the connection name and database type.
   1. Optionally add a connection description and [label](../../resource-manager/concepts/labels.md).
   1. Specify connection parameters depending on the selected database:
      * [Connecting to a managed database in a cluster](../operations/create-connection.md#mdb-connection)
      * [Connecting to a user database installation](../operations/create-connection.md#on-premise-connection)
   1. Specify the data required for connection authentication.
   1. Click **Create**.

{% endlist %}

Once you created a connection, you can [view its settings](../operations/update-connection.md#list-connections) in the connection list, [modify them](../operations/update-connection.md#update-connections), and [manage access](../operations/connection-access.md) to that connection.

## What's next {#what-is-next}

* [View the connection information](../operations/view-connection.md).
* [Change connection settings](../operations/update-connection.md).
* [Configure connection access permissions](../operations/connection-access.md).
* [Delete the connection you no longer need](../operations/delete-connection.md).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}