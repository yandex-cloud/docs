---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/delete.md
---

# Files API, gRPC: FileService.Delete {#Delete}

Delete a file by its ID.

## gRPC request

**rpc Delete ([DeleteFileRequest](#yandex.cloud.ai.files.v1.DeleteFileRequest)) returns ([DeleteFileResponse](#yandex.cloud.ai.files.v1.DeleteFileResponse))**

## DeleteFileRequest {#yandex.cloud.ai.files.v1.DeleteFileRequest}

```json
{
  "fileId": "string"
}
```

Request message for deleting a file by ID.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file to delete. ||
|#

## DeleteFileResponse {#yandex.cloud.ai.files.v1.DeleteFileResponse}

```json
{}
```

Response message for the delete operation.

#|
||Field | Description ||
|| Empty | > ||
|#