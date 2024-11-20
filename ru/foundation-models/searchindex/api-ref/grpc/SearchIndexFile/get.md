---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndexFile/get.md
---

# Search Index, gRPC: SearchIndexFileService.Get {#Get}

Retrieves details of a specific file that has been indexed within a search index.

## gRPC request

**rpc Get ([GetSearchIndexFileRequest](#yandex.cloud.ai.assistants.v1.searchindex.GetSearchIndexFileRequest)) returns ([SearchIndexFile](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile))**

## GetSearchIndexFileRequest {#yandex.cloud.ai.assistants.v1.searchindex.GetSearchIndexFileRequest}

```json
{
  "fileId": "string",
  "searchIndexId": "string"
}
```

Request message for retrieving a file from a search index.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file to retrieve. ||
|| searchIndexId | **string**

Required field. ID of the search index that contains the file. ||
|#

## SearchIndexFile {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

```json
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
```

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