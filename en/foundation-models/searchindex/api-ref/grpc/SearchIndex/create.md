---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/searchindex/api-ref/grpc/SearchIndex/create.md
---

# Search Index, gRPC: SearchIndexService.Create

Create a new search index in [asynchronous mode](/docs/foundation-models/concepts/#working-mode).

## gRPC request

**rpc Create ([CreateSearchIndexRequest](#yandex.cloud.ai.assistants.v1.searchindex.CreateSearchIndexRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSearchIndexRequest {#yandex.cloud.ai.assistants.v1.searchindex.CreateSearchIndexRequest}

```json
{
  "folder_id": "string",
  "file_ids": [
    "string"
  ],
  "name": "string",
  "description": "string",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  },
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
    },
    // Includes only one of the fields `ngram_tokenizer`
    "ngram_tokenizer": {
      "min_gram": "google.protobuf.Int64Value",
      "max_gram": "google.protobuf.Int64Value"
    }
    // end of the list of possible fields
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
      },
      // Includes only one of the fields `ngram_tokenizer`
      "ngram_tokenizer": {
        "min_gram": "google.protobuf.Int64Value",
        "max_gram": "google.protobuf.Int64Value"
      }
      // end of the list of possible fields
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

Request to create a new search index.

#|
||Field | Description ||
|| folder_id | **string**

Required field.  ||
|| file_ids[] | **string**

List of file IDs to be indexed. ||
|| name | **string**

Name of the search index. ||
|| description | **string**

Description of the search index. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the search index. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs to label the search index. ||
|| text_search_index | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex)**

Configuration for a traditional keyword-based text search index.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`. ||
|| vector_search_index | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex)**

Configuration for a vector-based search index using embeddings.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`. ||
|| hybrid_search_index | **[HybridSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex)**

Configuration for a hybrid (vector-based + keyword-based) search index.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`. ||
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

## TextSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex}

Defines the configuration for a traditional keyword-based text search index.

#|
||Field | Description ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Chunking strategy used to split text into smaller chunks before indexing.
In the case of text search, tokens are individual text characters. ||
|| ngram_tokenizer | **[NgramTokenizer](#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer)**

Tokenizer that generates n-grams.

Includes only one of the fields `ngram_tokenizer`.

Tokenizer type used for text search. The tokenizer determines how the
input text is broken down into tokens before indexing.
If not specified, the default tokenizer configuration is applied. ||
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

## NgramTokenizer {#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer}

Configuration for the NgramTokenizer, which splits text into overlapping character sequences (n-grams) of specified lengths.

Example:
Input text: `hello`
min_gram = 2, max_gram = 3

Generated tokens:
* For n = 2 (2-character n-grams): `he`, `el`, `ll`, `lo`
* For n = 3 (3-character n-grams): `hel`, `ell`, `llo`

Final tokens: `[he, el, ll, lo, hel, ell, llo]`

#|
||Field | Description ||
|| min_gram | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum length of characters in a gram. Defaults to 3 ||
|| max_gram | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of characters in a gram. Defaults to 4 ||
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
      },
      // Includes only one of the fields `ngram_tokenizer`
      "ngram_tokenizer": {
        "min_gram": "google.protobuf.Int64Value",
        "max_gram": "google.protobuf.Int64Value"
      }
      // end of the list of possible fields
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
        },
        // Includes only one of the fields `ngram_tokenizer`
        "ngram_tokenizer": {
          "min_gram": "google.protobuf.Int64Value",
          "max_gram": "google.protobuf.Int64Value"
        }
        // end of the list of possible fields
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
|| text_search_index | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex2)**

Keyword-based text search index configuration.
This type of index is used for traditional text search, where documents are indexed based on their keywords.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| vector_search_index | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex2)**

Vector-based search index configuration.
This type is used for vector search, where documents are indexed using vector embeddings.

Includes only one of the fields `text_search_index`, `vector_search_index`, `hybrid_search_index`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| hybrid_search_index | **[HybridSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex2)**

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

## TextSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex2}

Defines the configuration for a traditional keyword-based text search index.

#|
||Field | Description ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2)**

Chunking strategy used to split text into smaller chunks before indexing.
In the case of text search, tokens are individual text characters. ||
|| ngram_tokenizer | **[NgramTokenizer](#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer2)**

Tokenizer that generates n-grams.

Includes only one of the fields `ngram_tokenizer`.

Tokenizer type used for text search. The tokenizer determines how the
input text is broken down into tokens before indexing.
If not specified, the default tokenizer configuration is applied. ||
|#

## ChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2}

Defines a general strategy for chunking text into smaller segments.
Currently, only StaticChunkingStrategy is supported.

#|
||Field | Description ||
|| static_strategy | **[StaticChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy2)**

Includes only one of the fields `static_strategy`. ||
|#

## StaticChunkingStrategy {#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy2}

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

## NgramTokenizer {#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer2}

Configuration for the NgramTokenizer, which splits text into overlapping character sequences (n-grams) of specified lengths.

Example:
Input text: `hello`
min_gram = 2, max_gram = 3

Generated tokens:
* For n = 2 (2-character n-grams): `he`, `el`, `ll`, `lo`
* For n = 3 (3-character n-grams): `hel`, `ell`, `llo`

Final tokens: `[he, el, ll, lo, hel, ell, llo]`

#|
||Field | Description ||
|| min_gram | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum length of characters in a gram. Defaults to 3 ||
|| max_gram | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of characters in a gram. Defaults to 4 ||
|#

## VectorSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex2}

Defines the configuration for a vector-based search index. This type uses embeddings to represent documents and queries.

#|
||Field | Description ||
|| doc_embedder_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining document text embeddings. ||
|| query_embedder_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining query text embeddings. ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2)**

Chunking strategy used to split text into smaller chunks before indexing.
In the case of vector search, tokens are produced by the tokenizer from the embedding model. ||
|#

## HybridSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex2}

Defines the configuration for a hybrid (vector-based + keyword-based) search index. This type uses both embeddings and keyword-based search to represent documents and queries.

#|
||Field | Description ||
|| text_search_index | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex2)**

Configuration for a traditional keyword-based text search index. ||
|| vector_search_index | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex2)**

Configuration for a vector-based search index. ||
|| chunking_strategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy2)**

Common chunking strategy that applies to both text and vector search indexes.
If provided, it overrides the individual chunking strategies in both `text_search_index` and `vector_search_index`.
In this case, both text and vector search will use token-based chunking, where tokens are produced by the tokenizer of the embedding model. ||
|| normalization_strategy | enum **NormalizationStrategy**

Normalization strategy for relevance scores from different indices. Default is MIN_MAX_STRATEGY

- `NORMALIZATION_STRATEGY_UNSPECIFIED`
- `MIN_MAX`: https://en.wikipedia.org/wiki/Feature_scaling#Rescaling_(min-max_normalization)
- `L2`: https://en.wikipedia.org/wiki/Cosine_similarity#L2-normalized_Euclidean_distance ||
|| combination_strategy | **[CombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy2)**

Combination strategy for merging rankings from different indices. Default is arithmetic mean ||
|#

## CombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy2}

Combination strategy for merging rankings from different indices

#|
||Field | Description ||
|| mean_combination | **[MeanCombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.MeanCombinationStrategy2)**

Includes only one of the fields `mean_combination`, `rrf_combination`. ||
|| rrf_combination | **[ReciprocalRankFusionCombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ReciprocalRankFusionCombinationStrategy2)**

Includes only one of the fields `mean_combination`, `rrf_combination`. ||
|#

## MeanCombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.MeanCombinationStrategy2}

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

## ReciprocalRankFusionCombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ReciprocalRankFusionCombinationStrategy2}

https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf

#|
||Field | Description ||
|| k | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The parameter k for RRFscore. Default is 60 ||
|#