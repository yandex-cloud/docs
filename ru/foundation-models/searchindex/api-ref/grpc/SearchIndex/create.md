---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndex/create.md
---

# Search Index, gRPC: SearchIndexService.Create {#Create}

Create a new search index in [asynchronous mode](/docs/foundation-models/concepts/#working-mode).

## gRPC request

**rpc Create ([CreateSearchIndexRequest](#yandex.cloud.ai.assistants.v1.searchindex.CreateSearchIndexRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSearchIndexRequest {#yandex.cloud.ai.assistants.v1.searchindex.CreateSearchIndexRequest}

```json
{
  "folderId": "string",
  "fileIds": [
    "string"
  ],
  "name": "string",
  "description": "string",
  "expirationConfig": {
    "expirationPolicy": "ExpirationPolicy",
    "ttlDays": "int64"
  },
  "labels": "string",
  // Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`
  "textSearchIndex": {
    "chunkingStrategy": {
      // Includes only one of the fields `staticStrategy`
      "staticStrategy": {
        "maxChunkSizeTokens": "int64",
        "chunkOverlapTokens": "int64"
      }
      // end of the list of possible fields
    }
  },
  "vectorSearchIndex": {
    "docEmbedderUri": "string",
    "queryEmbedderUri": "string",
    "chunkingStrategy": {
      // Includes only one of the fields `staticStrategy`
      "staticStrategy": {
        "maxChunkSizeTokens": "int64",
        "chunkOverlapTokens": "int64"
      }
      // end of the list of possible fields
    }
  }
  // end of the list of possible fields
}
```

Request to create a new search index.

#|
||Field | Description ||
|| folderId | **string**

Required field.  ||
|| fileIds[] | **string**

List of file IDs to be indexed. ||
|| name | **string**

Name of the search index. ||
|| description | **string**

Description of the search index. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the search index. ||
|| labels | **string**

Set of key-value pairs to label the search index. ||
|| textSearchIndex | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex)**

Configuration for a traditional keyword-based text search index.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`. ||
|| vectorSearchIndex | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex)**

Configuration for a vector-based search index using embeddings.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **int64** ||
|#

## TextSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex}

Defines the configuration for a traditional keyword-based text search index.

#|
||Field | Description ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Chunking strategy used to split text into smaller chunks before indexing. ||
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

## VectorSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex}

Defines the configuration for a vector-based search index. This type uses embeddings to represent documents and queries.

#|
||Field | Description ||
|| docEmbedderUri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining document text embeddings. ||
|| queryEmbedderUri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining query text embeddings. ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Chunking strategy used to split text into smaller chunks before indexing. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "createdBy": "string",
    "createdAt": "google.protobuf.Timestamp",
    "updatedBy": "string",
    "updatedAt": "google.protobuf.Timestamp",
    "expirationConfig": {
      "expirationPolicy": "ExpirationPolicy",
      "ttlDays": "int64"
    },
    "expiresAt": "google.protobuf.Timestamp",
    "labels": "string",
    // Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`
    "textSearchIndex": {
      "chunkingStrategy": {
        // Includes only one of the fields `staticStrategy`
        "staticStrategy": {
          "maxChunkSizeTokens": "int64",
          "chunkOverlapTokens": "int64"
        }
        // end of the list of possible fields
      }
    },
    "vectorSearchIndex": {
      "docEmbedderUri": "string",
      "queryEmbedderUri": "string",
      "chunkingStrategy": {
        // Includes only one of the fields `staticStrategy`
        "staticStrategy": {
          "maxChunkSizeTokens": "int64",
          "chunkOverlapTokens": "int64"
        }
        // end of the list of possible fields
      }
    }
    // end of the list of possible fields
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| response | **[SearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndex)**

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

## SearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndex}

Represents a search index used to store and query data, either using traditional keyword-based text search or vector-based search mechanisms.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the search index. ||
|| folderId | **string**

ID of the folder that the search index belongs to. ||
|| name | **string**

Name of the search index. ||
|| description | **string**

Description of the search index. ||
|| createdBy | **string**

Identifier of the subject who created this search index. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the search index was created. ||
|| updatedBy | **string**

Identifier of the subject who last updated this search index. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this search index was updated. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the search index, defining when and how the search index will expire. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the search index will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the search index. ||
|| textSearchIndex | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex2)**

Keyword-based text search index configuration.
This type of index is used for traditional text search, where documents are indexed based on their keywords.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| vectorSearchIndex | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex2)**

Vector-based search index configuration.
This type is used for vector search, where documents are indexed using vector embeddings.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expirationPolicy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **int64** ||
|#

## TextSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex2}

Defines the configuration for a traditional keyword-based text search index.

#|
||Field | Description ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2)**

Chunking strategy used to split text into smaller chunks before indexing. ||
|#

## ChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2}

Defines a general strategy for chunking text into smaller segments.
Currently, only StaticChunkingStrategy is supported.

#|
||Field | Description ||
|| staticStrategy | **[StaticChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy2)**

Includes only one of the fields `staticStrategy`. ||
|#

## StaticChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy2}

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

## VectorSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex2}

Defines the configuration for a vector-based search index. This type uses embeddings to represent documents and queries.

#|
||Field | Description ||
|| docEmbedderUri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining document text embeddings. ||
|| queryEmbedderUri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining query text embeddings. ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2)**

Chunking strategy used to split text into smaller chunks before indexing. ||
|#