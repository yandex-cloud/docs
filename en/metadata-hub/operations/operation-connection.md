---
title: How to get information about a {{ metadata-hub-name }} operation. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to get information about an operation.
---

# Getting information about an operation


{% include notitle [preview](../../_includes/note-preview.md) %}


## Getting a list of operations for a specific connection {#operations-list}

{% include [connection-manager-operations](../../_includes/metadata-hub/connection-manager-operations.md) %}

## Getting information about a specific operation {#operation}

{% list tabs group=instructions %}

- API {#api}
  
  To get information about a specific connection, use the [Operation.Get](../api-ref/Operation/get.md) REST API method or the [OperationService.Get](../api-ref/grpc/Operation/get.md) gRPC API call and provide the operation ID in the request.

  You can get the operation ID from the connection [operation list](operation-connection.md#operations-list).

{% endlist %}
