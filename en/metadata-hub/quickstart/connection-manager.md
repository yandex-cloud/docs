# Getting started with {{ connection-manager-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

Manage connections to {{ PG }}, {{ MY }} and {{ CH }} databases with {{ connection-manager-full-name }}.

## Manage connections to managed database clusters in {{ yandex-cloud }} {#managed-cluster}

{% note warning %}

Once access to {{ connection-manager-full-name }} is granted, connections for managed database clusters will be created automatically.

{% endnote %}

1. Create one of the managed database clusters: 
    * [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md);
    * [{{ mmy-short-name }}](../../managed-mysql/operations/cluster-create.md);
    * [{{ mch-short-name }}](../../managed-clickhouse/operations/cluster-create.md).
1. In the [management console]({{ link-console-main }}) select [the folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a connection.
1. Select the **{{ metadata-hub-name }}** service.
1. On the left panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}**/ **Connections**.

In the connection list, you can view the connections created for your clusters and [configure access](../operations/connection-access.md) to them.

## Manage connections to on-premise database installations {#on-premise}

1. In the [management console]({{ link-console-main }}) select [the folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a connection.
1. Select the **{{ metadata-hub-name }}** service.
1. On the left panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}**/ **Connections**.
1. Click **Create connection**.
1. Specify the connection name and database type.
1. Optionally, add the connection description and [label](../../resource-manager/concepts/labels.md).
1. Specify [connection parameters](../operations/create-connection.md) depending on the selected database.
1. Click the **Create** button.

Once the connection has been created, you can [view its settings](../operations/update-connection.md#list-connections) in the list of connections, [edit them](../operations/update-connection.md#update-connections) and [manage access](../operations/connection-access.md) to it.

## What's next {#what-is-next}

* [{#T}](../operations/view-connection.md)
* [{#T}](../operations/update-connection.md)
* [{#T}](../operations/delete-connection.md)
* [{#T}](../operations/connection-access.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}