---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndex/update.md
---

# Search Index, gRPC: SearchIndexService.Update

Update an existing search index.

## gRPC request

**rpc Update ([UpdateSearchIndexRequest](#yandex.cloud.ai.assistants.v1.searchindex.UpdateSearchIndexRequest)) returns ([SearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndex))**

## UpdateSearchIndexRequest {#yandex.cloud.ai.assistants.v1.searchindex.UpdateSearchIndexRequest}

```json
{
  "search_index_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  },
  "labels": "map<string, string>"
}
```

Request message for updating an existing search index.

#|
||Field | Description ||
|| search_index_id | **string**

Required field. ID of the search index to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields to update. ||
|| name | **string**

New name for the search index. ||
|| description | **string**

New description for the search index. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

New expiration configuration for the search index. ||
|| labels | **object** (map<**string**, **string**>)

New set of labels for the search index. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expiration_policy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttl_days | **int64** ||
|#

## SearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndex}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "created_by": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_by": "string",
  "updated_at": "google.protobuf.Timestamp",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  },
  "expires_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>",
  // Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`
  "text_search_index": {
    "chunking_strategy": {
      // Includes only one of the fields `static_strategy`
      "static_strategy": {
        "max_chunk_size_tokens": "int64",
        "chunk_overlap_tokens": "int64"
      }
      // end of the list of possible fields
    }
  },
  "vector_search_index": {
    "doc_embedder_uri": "string",
    "query_embedder_uri": "string",
    "chunking_strategy": {
      // Includes only one of the fields `static_strategy`
      "static_strategy": {
        "max_chunk_size_tokens": "int64",
        "chunk_overlap_tokens": "int64"
      }
      // end of the list of possible fields
    }
  },
  "hybrid_search_index": {
    "text_search_index": {
      "chunking_strategy": {
        // Includes only one of the fields `static_strategy`
        "static_strategy": {
          "max_chunk_size_tokens": "int64",
          "chunk_overlap_tokens": "int64"
        }
        // end of the list of possible fields
      }
    },
    "vector_search_index": {
      "doc_embedder_uri": "string",
      "query_embedder_uri": "string",
      "chunking_strategy": {
        // Includes only one of the fields `static_strategy`
        "static_strategy": {
          "max_chunk_size_tokens": "int64",
          "chunk_overlap_tokens": "int64"
        }
        // end of the list of possible fields
      }
    },
    "chunking_strategy": {
      // Includes only one of the fields `static_strategy`
      "static_strategy": {
        "max_chunk_size_tokens": "int64",
        "chunk_overlap_tokens": "int64"
      }
      // end of the list of possible fields
    },
    "normalization_strategy": "NormalizationStrategy",
    "combination_strategy": {
      // Includes only one of the fields `mean_combination`, `rrf_combination`
      "mean_combination": {
        "mean_evaluation_technique": "MeanEvaluationTechnique",
        "weights": [
          "double"
        ]
      },
      "rrf_combination": {
        "k": "google.protobuf.Int64Value"
      }
      // end of the list of possible fields
    }
  }
  // end of the list of possible fields
}
```

Represents a search index used to store and query data, either using traditional keyword-based text search or vector-based search mechanisms.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the search index. ||
|| folder_id | **string**

ID of the folder that the search index belongs to. ||
|| name | **string**

Name of the search index. ||
|| description | **string**

Description of the search index. ||
|| created_by | **string**

Identifier of the subject who created this search index. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the search index was created. ||
|| updated_by | **string**

Identifier of the subject who last updated this search index. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this search index was updated. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the search index, defining when and how the search index will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the search index will expire. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the search index. ||
|| text_search_index | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex)**

Keyword-based text search index configuration.
This type of index is used for traditional text search, where documents are indexed based on their keywords.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| vector_search_index | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex)**

Vector-based search index configuration.
This type is used for vector search, where documents are indexed using vector embeddings.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| hybrid_search_index | **[HybridSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex)**

Hybrid (vector-based + keyword-based) search index configuration
This type is used for hybrid search, where documents are indexed using both keyword-based and vector-based search mechanisms.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expiration_policy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttl_days | **int64** ||
|#

## TextSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex}

Defines the configuration for a traditional keyword-based text search index.

#|
||Field | Description ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Chunking strategy used to split text into smaller chunks before indexing.
In the case of text search, tokens are individual text characters. ||
|#

## ChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy}

Defines a general strategy for chunking text into smaller segments.
Currently, only StaticChunkingStrategy is supported.

#|
||Field | Description ||
|| static_strategy | **[StaticChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy)**

Includes only one of the fields `static_strategy`. ||
|#

## StaticChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy}

Defines a chunking strategy where chunks are created with a fixed maximum chunk size and an overlap between consecutive chunks.

#|
||Field | Description ||
|| max_chunk_size_tokens | **int64**

The maximum number of tokens allowed in a single chunk.
Constraints: must be within the range [100, 2048].
Default value: 800 ||
|| chunk_overlap_tokens | **int64**

The number of tokens that should overlap between consecutive chunks.
This allows for some context from the previous chunk to be included in the next chunk.
Constraints: must be less than or equal to half of `max_chunk_size_tokens`.
Default value: 400 ||
|#

## VectorSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex}

Defines the configuration for a vector-based search index. This type uses embeddings to represent documents and queries.

#|
||Field | Description ||
|| doc_embedder_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining document text embeddings. ||
|| query_embedder_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining query text embeddings. ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Chunking strategy used to split text into smaller chunks before indexing.
In the case of vector search, tokens are produced by the tokenizer from the embedding model. ||
|#

## HybridSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex}

Defines the configuration for a hybrid (vector-based + keyword-based) search index. This type uses both embeddings and keyword-based search to represent documents and queries.

#|
||Field | Description ||
|| text_search_index | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex)**

Configuration for a traditional keyword-based text search index. ||
|| vector_search_index | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex)**

Configuration for a vector-based search index. ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Common chunking strategy that applies to both text and vector search indexes.
If provided, it overrides the individual chunking strategies in both `text_search_index` and `vector_search_index`.
In this case, both text and vector search will use token-based chunking, where tokens are produced by the tokenizer of the embedding model. ||
|| normalization_strategy | enum **NormalizationStrategy**

Normalization strategy for relevance scores from different indices. Default is MIN_MAX_STRATEGY

- `NORMALIZATION_STRATEGY_UNSPECIFIED`
- `MIN_MAX`: https://en.wikipedia.org/wiki/Feature_scaling#Rescaling_(min-max_normalization)
- `L2`: https://en.wikipedia.org/wiki/Cosine_similarity#L2-normalized_Euclidean_distance ||
|| combination_strategy | **[CombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy)**

Combination strategy for merging rankings from different indices. Default is arithmetic mean ||
|#

## CombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy}

Combination strategy for merging rankings from different indices

#|
||Field | Description ||
|| mean_combination | **[MeanCombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.MeanCombinationStrategy)**

Includes only one of the fields `mean_combination`, `rrf_combination`. ||
|| rrf_combination | **[ReciprocalRankFusionCombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ReciprocalRankFusionCombinationStrategy)**

Includes only one of the fields `mean_combination`, `rrf_combination`. ||
|#

## MeanCombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.MeanCombinationStrategy}

#|
||Field | Description ||
|| mean_evaluation_technique | enum **MeanEvaluationTechnique**

Technique for averaging relevance scores from different indices. Default is ARITHMETIC

- `MEAN_EVALUATION_TECHNIQUE_UNSPECIFIED`
- `ARITHMETIC`: https://en.wikipedia.org/wiki/Arithmetic_mean
- `GEOMETRIC`: https://en.wikipedia.org/wiki/Geometric_mean
- `HARMONIC`: https://en.wikipedia.org/wiki/Harmonic_mean ||
|| weights[] | **double**

Weights used for evaluating the weighted mean of relevance scores. The sum of the values must equal 1.0
If not provided, all scores are given equal weight ||
|#

## ReciprocalRankFusionCombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ReciprocalRankFusionCombinationStrategy}

https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf

#|
||Field | Description ||
|| k | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The parameter k for RRFscore. Default is 60 ||
|#