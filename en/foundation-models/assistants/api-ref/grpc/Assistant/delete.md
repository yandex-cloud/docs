---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/assistants/api-ref/grpc/Assistant/delete.md
---

# AI Assistants API, gRPC: AssistantService.Delete

Delete an assistant by its ID.

## gRPC request

**rpc Delete ([DeleteAssistantRequest](#yandex.cloud.ai.assistants.v1.DeleteAssistantRequest)) returns ([DeleteAssistantResponse](#yandex.cloud.ai.assistants.v1.DeleteAssistantResponse))**

## DeleteAssistantRequest {#yandex.cloud.ai.assistants.v1.DeleteAssistantRequest}

```json
{
  "assistant_id": "string"
}
```

Request message for deleting an assistant by ID.

#|
||Field | Description ||
|| assistant_id | **string**

Required field. ID of the assistant to delete. ||
|#

## DeleteAssistantResponse {#yandex.cloud.ai.assistants.v1.DeleteAssistantResponse}

```json
{}
```

Response message for the delete operation.

#|
||Field | Description ||
|| Empty | > ||
|#