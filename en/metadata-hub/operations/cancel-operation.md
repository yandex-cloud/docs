---
title: How to cancel a specific {{ metadata-hub-name }} connection operation. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to cancel a specific connection operation.
---

# Canceling an operation


{% include notitle [preview](../../_includes/note-preview.md) %}


{% list tabs group=instructions %}

- API {#api}
  
  {% note alert %}

  {{ objstorage-full-name }} does not support canceling operations via API.
  
  {% endnote %}

  To cancel an operation for a specific connection, use the [Operation.Cancel](../api-ref/Operation/cancel.md) REST API method or the [OperationService.Cancel](../api-ref/grpc/Operation/cancel.md) gRPC API method and provide the operation ID in the request.

  You can get the operation ID from the connection [operation list](operation-connection.md#operations-list).

{% endlist %}