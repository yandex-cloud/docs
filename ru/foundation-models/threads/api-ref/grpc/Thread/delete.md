---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/threads/api-ref/grpc/Thread/delete.md
---

# Threads, gRPC: ThreadService.Delete {#Delete}

Delete a thread by its ID.

## gRPC request

**rpc Delete ([DeleteThreadRequest](#yandex.cloud.ai.assistants.v1.threads.DeleteThreadRequest)) returns ([DeleteThreadResponse](#yandex.cloud.ai.assistants.v1.threads.DeleteThreadResponse))**

## DeleteThreadRequest {#yandex.cloud.ai.assistants.v1.threads.DeleteThreadRequest}

```json
{
  "threadId": "string"
}
```

Request message for deleting a thread by ID.

#|
||Field | Description ||
|| threadId | **string**

Required field. ID of the thread to delete. ||
|#

## DeleteThreadResponse {#yandex.cloud.ai.assistants.v1.threads.DeleteThreadResponse}

```json
{}
```

Response message for the delete operation.

#|
||Field | Description ||
|| Empty | > ||
|#