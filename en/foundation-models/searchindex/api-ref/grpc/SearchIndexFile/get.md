---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndexFile/get.md
---

# Search Index, gRPC: SearchIndexFileService.Get

Retrieves details of a specific file that has been indexed within a search index.

## gRPC request

**rpc Get ([GetSearchIndexFileRequest](#yandex.cloud.ai.assistants.v1.searchindex.GetSearchIndexFileRequest)) returns ([SearchIndexFile](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile))**

## GetSearchIndexFileRequest {#yandex.cloud.ai.assistants.v1.searchindex.GetSearchIndexFileRequest}

```json
{
  "file_id": "string",
  "search_index_id": "string"
}
```

Request message for retrieving a file from a search index.

#|
||Field | Description ||
|| file_id | **string**

Required field. ID of the file to retrieve. ||
|| search_index_id | **string**

Required field. ID of the search index that contains the file. ||
|#

## SearchIndexFile {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

```json
{
  "id": "string",
  "search_index_id": "string",
  "created_by": "string",
  "created_at": "google.protobuf.Timestamp"
}
```

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