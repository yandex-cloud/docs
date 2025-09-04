---
title: Deleting a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to delete connections.
---

# Deleting a connection



{% include notitle [preview](../../_includes/note-preview.md) %}



{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) in which to delete a connection.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. In the list of connections, click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection you want to delete.
    1. Select **{{ ui-key.yacloud.common.delete }}**.

- API {#api}
  
  To delete a {{ connection-manager-name }} connection, use the [Connection.Delete](../api-ref/Connection/delete.md) REST API method or the [ConnectionService.Delete](../api-ref/grpc/Connection/delete.md) gRPC API call and provide the connection ID in the request.

  You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

{% endlist %}
