---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndexFile/list.md
---

# Search Index, gRPC: SearchIndexFileService.List

List files that are indexed within a specific search index.

## gRPC request

**rpc List ([ListSearchIndexFilesRequest](#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesRequest)) returns ([ListSearchIndexFilesResponse](#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesResponse))**

## ListSearchIndexFilesRequest {#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesRequest}

```json
{
  "search_index_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for listing files in a specific search index.

#|
||Field | Description ||
|| search_index_id | **string**

Required field. ID of the search index whose files will be listed. ||
|| page_size | **int64**

Maximum number of files to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|#

## ListSearchIndexFilesResponse {#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesResponse}

```json
{
  "files": [
    {
      "id": "string",
      "search_index_id": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| files[] | **[SearchIndexFile](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile)**

List of files in the specified search index. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
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