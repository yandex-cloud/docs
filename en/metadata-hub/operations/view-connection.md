---
title: How to get information about a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to view connections.
---

# Viewing connection information



{% include notitle [preview](../../_includes/note-preview.md) %}



## Getting a list of connections {#connection-list}


{% note info %}

The connection list only displays those connections to which the user has access (the [`connection-manager.auditor`](../security/connection-manager-roles.md#connection-manager-auditor) or [`connection-manager.viewer`](../security/connection-manager-roles.md#connection-manager-viewer) role). A user with access permissions for a folder will be able to view all connections in that folder.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.

- API {#api}

  To get the list of {{ connection-manager-name }} connections in the default folder, use the [Connection.List](../api-ref/Connection/list.md) REST API method or the [ConnectionService.List](../api-ref/grpc/Connection/list.md) gRPC API method.

  To view the list of connections in a different folder, provide the folder ID in the request. [Learn more about how to get a folder ID](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Viewing connection information {#connection-get}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click the line with the connection to view its details.

- API {#api}
  
  To get information about a {{ connection-manager-name }} connection, use the [Connection.Get](../api-ref/Connection/get.md) REST API method or the [ConnectionService.Get](../api-ref/grpc/Connection/get.md) gRPC API method and provide the connection ID in the request.

  You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

{% endlist %}

## Viewing connection dependencies {#dependencies}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}** and click the name of the connection you need.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.connection-manager.label_dependences }}**.

     The dependency list shows managed database clusters and service instances that use {{ connection-manager-name }} to store connection information. Click a line in the dependency list to go to a cluster or service instance.

- API {#api}
  
  To get information about {{ connection-manager-name }} connection dependencies, use the [Connection.ResolveCluster](../api-ref/Connection/resolveCluster.md) REST API method or the [ConnectionService.ResolveCluster](../api-ref/grpc/Connection/resolveCluster.md) gRPC API method and provide the connection ID in the request.

  You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

  {% note info %}

  For connections to managed database clusters, the `ResolveCluster` method returns the cluster topology. For connections to custom database installations, it returns the same information as the [Get](view-connection.md#connection-get) method.

  {% endnote %}

{% endlist %}

## Viewing the history of operations {#operations}

{% include [connection-manager-operations](../../_includes/metadata-hub/connection-manager-operations.md) %}