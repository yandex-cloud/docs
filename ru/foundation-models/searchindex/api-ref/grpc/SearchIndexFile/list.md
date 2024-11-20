---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndexFile/list.md
---

# Search Index, gRPC: SearchIndexFileService.List {#List}

List files that are indexed within a specific search index.

## gRPC request

**rpc List ([ListSearchIndexFilesRequest](#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesRequest)) returns ([ListSearchIndexFilesResponse](#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesResponse))**

## ListSearchIndexFilesRequest {#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesRequest}

```json
{
  "searchIndexId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

Request message for listing files in a specific search index.

#|
||Field | Description ||
|| searchIndexId | **string**

Required field. ID of the search index whose files will be listed. ||
|| pageSize | **int64**

Maximum number of files to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## ListSearchIndexFilesResponse {#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesResponse}

```json
{
  "files": [
    {
      "id": "string",
      "searchIndexId": "string",
      "createdBy": "string",
      "createdAt": "google.protobuf.Timestamp",
      "chunkingStrategy": {
        // Includes only one of the fields `staticStrategy`
        "staticStrategy": {
          "maxChunkSizeTokens": "int64",
          "chunkOverlapTokens": "int64"
        }
        // end of the list of possible fields
      }
    }
  ],
  "nextPageToken": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| files[] | **[SearchIndexFile](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile)**

List of files in the specified search index. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## SearchIndexFile {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

Represents a file that has been indexed within a search index.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file that was used for indexing. ||
|| searchIndexId | **string**

ID of the search index that contains this file. ||
|| createdBy | **string**

Identifier of the subject who created the file in the search index. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file was created. ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)** ||
|#

## ChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy}

Defines a general strategy for chunking text into smaller segments.
Currently, only StaticChunkingStrategy is supported.

#|
||Field | Description ||
|| staticStrategy | **[StaticChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy)**

Includes only one of the fields `staticStrategy`. ||
|#

## StaticChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy}

Defines a chunking strategy where chunks are created with a fixed maximum chunk size and an overlap between consecutive chunks.

#|
||Field | Description ||
|| maxChunkSizeTokens | **int64**

The maximum number of tokens allowed in a single chunk.
Constraints: must be within the range [100, 2048].
Default value: 800 ||
|| chunkOverlapTokens | **int64**

The number of tokens that should overlap between consecutive chunks.
This allows for some context from the previous chunk to be included in the next chunk.
Constraints: must be less than or equal to half of `max_chunk_size_tokens`.
Default value: 400 ||
|#