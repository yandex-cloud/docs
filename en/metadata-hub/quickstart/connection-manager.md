# Getting started with {{ connection-manager-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

Manage connections to {{ PG }}, {{ MY }}, and {{ CH }} databases with {{ connection-manager-full-name }}.

## Managing connections to managed database clusters in {{ yandex-cloud }} {#managed-cluster}

{% note warning %}

Once access to {{ connection-manager-full-name }} is confirmed, connections for managed database clusters will be created automatically.

{% endnote %}

1. Create a [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md) cluster.
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check a connection.
1. Select **{{ metadata-hub-name }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Connections**.

In the connection list, you can view the connections created for your clusters and [configure access](../operations/connection-access.md) to them.

## Managing connections to user database installations {#on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Connections**.
   1. Click **Create connection**.
   1. Specify connection name and database type.
   1. Optionally add a connection description and [label](../../resource-manager/concepts/labels.md).
   1. Specify [connection parameters](../operations/create-connection.md) depending on the selected database.
   1. Click **Create**.

{% endlist %}

Once you created a connection, you can [view its settings](../operations/update-connection.md#list-connections) in the connection list, [modify them](../operations/update-connection.md#update-connections), and [manage access](../operations/connection-access.md) to that connection.

## What's next {#what-is-next}

* [{#T}](../operations/view-connection.md)
* [{#T}](../operations/update-connection.md)
* [{#T}](../operations/delete-connection.md)
* [{#T}](../operations/connection-access.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}