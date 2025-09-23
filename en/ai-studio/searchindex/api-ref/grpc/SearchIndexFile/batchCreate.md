---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndexFile/batchCreate.md
---

# Search Index, gRPC: SearchIndexFileService.BatchCreate

Creates multiple files within a search index in [asynchronous mode](/docs/foundation-models/concepts/#working-mode).

## gRPC request

**rpc BatchCreate ([BatchCreateSearchIndexFileRequest](#yandex.cloud.ai.assistants.v1.searchindex.BatchCreateSearchIndexFileRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## BatchCreateSearchIndexFileRequest {#yandex.cloud.ai.assistants.v1.searchindex.BatchCreateSearchIndexFileRequest}

```json
{
  "file_ids": [
    "string"
  ],
  "search_index_id": "string"
}
```

Request message for creating multiple files within a search index.

#|
||Field | Description ||
|| file_ids[] | **string** ||
|| search_index_id | **string**

Required field.  ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "files": [
      {
        "id": "string",
        "search_index_id": "string",
        "created_by": "string",
        "created_at": "google.protobuf.Timestamp"
      }
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[BatchCreateSearchIndexFileResponse](#yandex.cloud.ai.assistants.v1.searchindex.BatchCreateSearchIndexFileResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## BatchCreateSearchIndexFileResponse {#yandex.cloud.ai.assistants.v1.searchindex.BatchCreateSearchIndexFileResponse}

Response message for the BatchCreate operation.

#|
||Field | Description ||
|| files[] | **[SearchIndexFile](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile)** ||
|#

## SearchIndexFile {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

Represents a file that has been indexed within a search index.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file that was used for indexing. ||
|| search_index_id | **string**

ID of the search index that contains this file. ||
|| created_by | **string**

Identifier of the subject who created the file in the search index. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file was created. ||
|#