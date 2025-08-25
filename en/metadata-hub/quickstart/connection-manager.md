---
title: Getting started with {{ connection-manager-name }}
description: Manage connections to {{ PG }}, {{ MY }}, {{ CH }}, and {{ RD }}, and {{ TR }} data sources using {{ connection-manager-full-name }}.
---

# Getting started with {{ connection-manager-name }}



{% include notitle [preview](../../_includes/note-preview.md) %}



Manage connections to {{ PG }}, {{ MY }}, {{ CH }}, {{ RD }}, {{ VLK }}, {{ OS }}, {{ MG }}, and {{ TR }} data sources using {{ connection-manager-full-name }}.

## Integrating with managed database services {#mdb-integration}

1. To enable {{ connection-manager-full-name }} integration with managed database clusters, contact [support]({{ link-console-support }}). Once access to {{ connection-manager-full-name }} is confirmed, the process of creating connections for managed database clusters will start automatically.
1. Create a [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md), a [{{ mmy-short-name }}](../../managed-mysql/operations/cluster-create.md), and a [{{ mch-short-name }}](../../managed-clickhouse/operations/cluster-create.md) cluster.
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check a connection.
1. Select **{{ metadata-hub-full-name }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.

In the connection list, you can view the connections created for your clusters and [configure access](../operations/connection-access.md) to them. In the list of connection [dependencies](../operations/view-connection.md#dependencies), you can view which managed database clusters are using this connection.

## Managing database connections {#database-connections}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Enter a name and database type for the connection.
  1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Specify connection parameters depending on the selected database:
     * [Connecting to a managed database in a cluster](../operations/create-connection.md#mdb-connection)
     * [Connecting to a user database installation](../operations/create-connection.md#on-premise-connection)
  1. Specify the data required for connection authentication.

     {% note tip %}

     When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

     {% endnote %}
  
  1. Click **{{ ui-key.yacloud.common.create }}**.


{% endlist %}

Once you create a connection, you can [view its settings](../operations/update-connection.md#list-connections) in the connection list and [modify them](../operations/update-connection.md#update-connections), as well as [manage access](../operations/connection-access.md) to that connection.


## What's next {#what-is-next}

* [View the connection information](../operations/view-connection.md).
* [Change connection settings](../operations/update-connection.md).
* [Configure connection access permissions](../operations/connection-access.md).
* [Delete the connection you no longer need](../operations/delete-connection.md).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
