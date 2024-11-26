---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndex/delete.md
---

# Search Index, gRPC: SearchIndexService.Delete

Delete a search index by its ID.

## gRPC request

**rpc Delete ([DeleteSearchIndexRequest](#yandex.cloud.ai.assistants.v1.searchindex.DeleteSearchIndexRequest)) returns ([DeleteSearchIndexResponse](#yandex.cloud.ai.assistants.v1.searchindex.DeleteSearchIndexResponse))**

## DeleteSearchIndexRequest {#yandex.cloud.ai.assistants.v1.searchindex.DeleteSearchIndexRequest}

```json
{
  "search_index_id": "string"
}
```

Request message for deleting a search index by ID.

#|
||Field | Description ||
|| search_index_id | **string**

Required field. ID of the search index to delete. ||
|#

## DeleteSearchIndexResponse {#yandex.cloud.ai.assistants.v1.searchindex.DeleteSearchIndexResponse}

```json
{}
```

Response message for the delete operation.

#|
||Field | Description ||
|| Empty | > ||
|#