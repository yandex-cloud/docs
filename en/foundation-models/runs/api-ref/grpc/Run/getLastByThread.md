---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/runs/api-ref/grpc/Run/getLastByThread.md
---

# Runs, gRPC: RunService.GetLastByThread

Retrieves the most recent run for a specific thread.

## gRPC request

**rpc GetLastByThread ([GetLastRunByThreadRequest](#yandex.cloud.ai.assistants.v1.runs.GetLastRunByThreadRequest)) returns ([Run](#yandex.cloud.ai.assistants.v1.runs.Run))**

## GetLastRunByThreadRequest {#yandex.cloud.ai.assistants.v1.runs.GetLastRunByThreadRequest}

```json
{
  "thread_id": "string"
}
```

Request message for retrieving the last run associated with a specific thread.

#|
||Field | Description ||
|| thread_id | **string**

Required field. ID of the thread for which the last run is being fetched. ||
|#

## Run {#yandex.cloud.ai.assistants.v1.runs.Run}

```json
{
  "id": "string",
  "assistant_id": "string",
  "thread_id": "string",
  "created_by": "string",
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>",
  "state": {
    "status": "RunStatus",
    // Includes only one of the fields `error`, `completed_message`, `tool_call_list`
    "error": {
      "code": "int64",
      "message": "string"
    },
    "completed_message": {
      "id": "string",
      "thread_id": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "author": {
        "id": "string",
        "role": "string"
      },
      "labels": "map<string, string>",
      "content": {
        "content": [
          {
            // Includes only one of the fields `text`
            "text": {
              "content": "string"
            }
            // end of the list of possible fields
          }
        ]
      },
      "status": "MessageStatus",
      "citations": [
        {
          "sources": [
            {
              // Includes only one of the fields `chunk`
              "chunk": {
                "search_index": {
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
                    // Includes only one of the fields `ngram_tokenizer`, `standard_tokenizer`
                    "ngram_tokenizer": {
                      "min_gram": "google.protobuf.Int64Value",
                      "max_gram": "google.protobuf.Int64Value"
                    },
                    "standard_tokenizer": "StandardTokenizer",
                    // end of the list of possible fields
                    // Includes only one of the fields `standard_analyzer`, `yandex_lemmer_analyzer`
                    "standard_analyzer": "StandardAnalyzer",
                    "yandex_lemmer_analyzer": "YandexLemmerAnalyzer"
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
                      // Includes only one of the fields `ngram_tokenizer`, `standard_tokenizer`
                      "ngram_tokenizer": {
                        "min_gram": "google.protobuf.Int64Value",
                        "max_gram": "google.protobuf.Int64Value"
                      },
                      "standard_tokenizer": "StandardTokenizer",
                      // end of the list of possible fields
                      // Includes only one of the fields `standard_analyzer`, `yandex_lemmer_analyzer`
                      "standard_analyzer": "StandardAnalyzer",
                      "yandex_lemmer_analyzer": "YandexLemmerAnalyzer"
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
                },
                "source_file": {
                  "id": "string",
                  "folder_id": "string",
                  "name": "string",
                  "description": "string",
                  "mime_type": "string",
                  "created_by": "string",
                  "created_at": "google.protobuf.Timestamp",
                  "updated_by": "string",
                  "updated_at": "google.protobuf.Timestamp",
                  "expiration_config": {
                    "expiration_policy": "ExpirationPolicy",
                    "ttl_days": "int64"
                  },
                  "expires_at": "google.protobuf.Timestamp",
                  "labels": "map<string, string>"
                },
                "content": {
                  "content": [
                    {
                      // Includes only one of the fields `text`
                      "text": {
                        "content": "string"
                      }
                      // end of the list of possible fields
                    }
                  ]
                }
              }
              // end of the list of possible fields
            }
          ]
        }
      ]
    },
    "tool_call_list": {
      "tool_calls": [
        {
          // Includes only one of the fields `function_call`
          "function_call": {
            "name": "string",
            "arguments": "google.protobuf.Struct"
          }
          // end of the list of possible fields
        }
      ]
    }
    // end of the list of possible fields
  },
  "usage": {
    "prompt_tokens": "int64",
    "completion_tokens": "int64",
    "total_tokens": "int64"
  },
  "custom_prompt_truncation_options": {
    "max_prompt_tokens": "google.protobuf.Int64Value",
    // Includes only one of the fields `auto_strategy`, `last_messages_strategy`
    "auto_strategy": "AutoStrategy",
    "last_messages_strategy": {
      "num_messages": "int64"
    }
    // end of the list of possible fields
  },
  "custom_completion_options": {
    "max_tokens": "google.protobuf.Int64Value",
    "temperature": "google.protobuf.DoubleValue"
  },
  "tools": [
    {
      // Includes only one of the fields `search_index`, `function`
      "search_index": {
        "search_index_ids": [
          "string"
        ],
        "max_num_results": "google.protobuf.Int64Value",
        "rephraser_options": {
          "rephraser_uri": "string"
        }
      },
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "google.protobuf.Struct"
      }
      // end of the list of possible fields
    }
  ]
}
```

Represents a run of an assistant over a specific thread of messages.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the run. ||
|| assistant_id | **string**

Identifier for the assistant that is being run. ||
|| thread_id | **string**

Identifier for the thread of messages that this run is associated with. ||
|| created_by | **string**

Identifier of the subject who created this run. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the run was created. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the run. ||
|| state | **[RunState](#yandex.cloud.ai.assistants.v1.runs.RunState)**

Current state of the run, including its status and any associated data. ||
|| usage | **[ContentUsage](#yandex.cloud.ai.assistants.v1.runs.ContentUsage)**

Information about the content usage during the run, such as the number of [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model. ||
|| custom_prompt_truncation_options | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**

Configuration options for truncating the prompt when the token count exceeds a specified limit.
If specified, these options will override the assistant's prompt truncation settings for this run. ||
|| custom_completion_options | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**

Configuration options for completion generation.
If specified, these options will override the assistant's completion settings for this run. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that are available for the assistant to use in this run. ||
|#

## RunState {#yandex.cloud.ai.assistants.v1.runs.RunState}

Represents the current state of a run.

#|
||Field | Description ||
|| status | enum **RunStatus**

Current status of a run.

- `RUN_STATUS_UNSPECIFIED`: Default unspecified status.
- `PENDING`: Run has been created but has not started yet.
- `IN_PROGRESS`: Run is currently in progress.
- `FAILED`: Run has failed due to an error.
- `COMPLETED`: Run has completed successfully.
- `TOOL_CALLS`: The run is waiting for tool calls to be executed and their results to be submitted. ||
|| error | **[Error](#yandex.cloud.ai.common.Error)**

Error information if a run has failed.

Includes only one of the fields `error`, `completed_message`, `tool_call_list`.

Oneof field to capture additional data depending on the state of a run. ||
|| completed_message | **[Message](#yandex.cloud.ai.assistants.v1.threads.Message)**

Final message generated by an assistant if a run has completed successfully.

Includes only one of the fields `error`, `completed_message`, `tool_call_list`.

Oneof field to capture additional data depending on the state of a run. ||
|| tool_call_list | **[ToolCallList](#yandex.cloud.ai.assistants.v1.ToolCallList)**

A list of tool calls requested by the assistant.

Includes only one of the fields `error`, `completed_message`, `tool_call_list`.

Oneof field to capture additional data depending on the state of a run. ||
|#

## Error {#yandex.cloud.ai.common.Error}

#|
||Field | Description ||
|| code | **int64** ||
|| message | **string** ||
|#

## Message {#yandex.cloud.ai.assistants.v1.threads.Message}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the message. ||
|| thread_id | **string**

ID of the thread that this message belongs to. ||
|| created_by | **string**

Identifier of the subject who created this message. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the message was created. ||
|| author | **[Author](#yandex.cloud.ai.assistants.v1.threads.Author)**

Author of the message, containing details about the message's creator. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the message. ||
|| content | **[MessageContent](#yandex.cloud.ai.assistants.v1.threads.MessageContent)**

Content of the message. ||
|| status | enum **MessageStatus**

Status of the message.

- `MESSAGE_STATUS_UNSPECIFIED`: Unspecified message status.
- `COMPLETED`: Message was successfully created by a user or generated by an assistant.
- `TRUNCATED`: Message generation was truncated due to reaching the maximum allowed number of tokens.
- `FILTERED_CONTENT`: Message generation was stopped because potentially sensitive content was detected either in the prompt or in the generated response. ||
|| citations[] | **[Citation](#yandex.cloud.ai.assistants.v1.threads.Citation)**

List of citations used to generate the message. ||
|#

## Author {#yandex.cloud.ai.assistants.v1.threads.Author}

Author of the message, containing details about the message's creator.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the author. This could be either the user's ID or the assistant's ID, depending on the role. ||
|| role | **string**

Role of the author, indicating whether the message was created by a "user" or an "assistant". ||
|#

## MessageContent {#yandex.cloud.ai.assistants.v1.threads.MessageContent}

Represents the content of a message, which can consist of multiple parts.

#|
||Field | Description ||
|| content[] | **[ContentPart](#yandex.cloud.ai.assistants.v1.threads.ContentPart)**

A list of content parts that make up the message. ||
|#

## ContentPart {#yandex.cloud.ai.assistants.v1.threads.ContentPart}

ContentPart represents an individual part of the message content, which can be of various types.

#|
||Field | Description ||
|| text | **[Text](#yandex.cloud.ai.assistants.v1.threads.Text)**

Text content of the message part.

Includes only one of the fields `text`.

Specifies the type of content that the part contains. ||
|#

## Text {#yandex.cloud.ai.assistants.v1.threads.Text}

Text represents a textual content part of a message.

#|
||Field | Description ||
|| content | **string**

Text content of the message. ||
|#

## Citation {#yandex.cloud.ai.assistants.v1.threads.Citation}

Represents a citation used for generating a message.

#|
||Field | Description ||
|| sources[] | **[Source](#yandex.cloud.ai.assistants.v1.threads.Source)**

List of sources for citation. ||
|#

## Source {#yandex.cloud.ai.assistants.v1.threads.Source}

Represents a source used for generating a message citation.

#|
||Field | Description ||
|| chunk | **[FileChunk](#yandex.cloud.ai.assistants.v1.threads.FileChunk)**

File chunk source.

Includes only one of the fields `chunk`.

Specifies the type of source type. ||
|#

## FileChunk {#yandex.cloud.ai.assistants.v1.threads.FileChunk}

FileChunk represents a chunk of a file used as a source.

#|
||Field | Description ||
|| search_index | **[SearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndex)**

Search index associated with the file chunk. ||
|| source_file | **[File](#yandex.cloud.ai.files.v1.File)**

The original file from which the chunk is derived. ||
|| content | **[ChunkContent](#yandex.cloud.ai.assistants.v1.threads.ChunkContent)**

Content of the file chunk. ||
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
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

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

Includes only one of the fields `ngram_tokenizer`, `standard_tokenizer`.

Tokenizer type used for text search. The tokenizer determines how the
input text is broken down into tokens before indexing.
If not specified, the default tokenizer configuration is applied. ||
|| standard_tokenizer | **[StandardTokenizer](#yandex.cloud.ai.assistants.v1.searchindex.StandardTokenizer)**

Tokenizer that generates words.

Includes only one of the fields `ngram_tokenizer`, `standard_tokenizer`.

Tokenizer type used for text search. The tokenizer determines how the
input text is broken down into tokens before indexing.
If not specified, the default tokenizer configuration is applied. ||
|| standard_analyzer | **[StandardAnalyzer](#yandex.cloud.ai.assistants.v1.searchindex.StandardAnalyzer)**

Standard analyzer that performs common text processing operations to normalize text.

Includes only one of the fields `standard_analyzer`, `yandex_lemmer_analyzer`.

Analyzer type used for text search. The analyzer determines how the
tokenized text is further processed before indexing.
If not specified, the default analyzer configuration is applied. ||
|| yandex_lemmer_analyzer | **[YandexLemmerAnalyzer](#yandex.cloud.ai.assistants.v1.searchindex.YandexLemmerAnalyzer)**

Specialized analyzer that uses Yandex's lemmatization technology,
particularly effective for Russian and other Slavic languages.

Includes only one of the fields `standard_analyzer`, `yandex_lemmer_analyzer`.

Analyzer type used for text search. The analyzer determines how the
tokenized text is further processed before indexing.
If not specified, the default analyzer configuration is applied. ||
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

## StandardTokenizer {#yandex.cloud.ai.assistants.v1.searchindex.StandardTokenizer}

A standard tokenizer that splits text on word boundaries and removes punctuation.
It follows the Unicode Text Segmentation rules as specified in Unicode Standard Annex #29.

Example:
Input text: `Hello, world! How are you?`
Output tokens: `[Hello, world, How, are, you]`

#|
||Field | Description ||
|| Empty | > ||
|#

## StandardAnalyzer {#yandex.cloud.ai.assistants.v1.searchindex.StandardAnalyzer}

A standard analyzer that uses StandardTokenizer.

#|
||Field | Description ||
|| Empty | > ||
|#

## YandexLemmerAnalyzer {#yandex.cloud.ai.assistants.v1.searchindex.YandexLemmerAnalyzer}

A specialized analyzer that uses Yandex's lemmatization technology to reduce words to their base forms.
Particularly effective for Russian and other Slavic languages, handling their complex morphology.
For more information, see:
https://yandex.cloud/en/docs/tutorials/dataplatform/opensearch-yandex-lemmer

#|
||Field | Description ||
|| Empty | > ||
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

## File {#yandex.cloud.ai.files.v1.File}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file. ||
|| folder_id | **string**

ID of the folder that the file belongs to. ||
|| name | **string**

Name of the file. ||
|| description | **string**

Description of the file. ||
|| mime_type | **string**

MIME type of the file, indicating the file's format (e.g., "application/pdf") ||
|| created_by | **string**

Identifier of the subject who created this file. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file was created. ||
|| updated_by | **string**

Identifier of the subject who last updated this file. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this file was updated. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the file, defining when and how the file will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file will expire. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the file. ||
|#

## ChunkContent {#yandex.cloud.ai.assistants.v1.threads.ChunkContent}

Represents the content of a file chunk.

#|
||Field | Description ||
|| content[] | **[ContentPart](#yandex.cloud.ai.assistants.v1.threads.ContentPart)**

A list of content parts that make up the chunk. ||
|#

## ToolCallList {#yandex.cloud.ai.assistants.v1.ToolCallList}

Represents a list of tool calls.

#|
||Field | Description ||
|| tool_calls[] | **[ToolCall](#yandex.cloud.ai.assistants.v1.ToolCall)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.assistants.v1.ToolCall}

Represents a call to a tool.

#|
||Field | Description ||
|| function_call | **[FunctionCall](#yandex.cloud.ai.assistants.v1.FunctionCall)**

Represents a call to a function.

Includes only one of the fields `function_call`. ||
|#

## FunctionCall {#yandex.cloud.ai.assistants.v1.FunctionCall}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#

## ContentUsage {#yandex.cloud.ai.assistants.v1.runs.ContentUsage}

Represents the content usage during a run, such as the number of [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model.

#|
||Field | Description ||
|| prompt_tokens | **int64**

The number of tokens used in the prompt. ||
|| completion_tokens | **int64**

The number of tokens used in the completion response. ||
|| total_tokens | **int64**

The total number of tokens used (prompt + completion). ||
|#

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| max_prompt_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|| auto_strategy | **[AutoStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.AutoStrategy)**

Includes only one of the fields `auto_strategy`, `last_messages_strategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|| last_messages_strategy | **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy)**

Retains only the last `num_messages` messages in the thread.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.

Includes only one of the fields `auto_strategy`, `last_messages_strategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|#

## AutoStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.AutoStrategy}

Auto truncation strategy.

#|
||Field | Description ||
|| Empty | > ||
|#

## LastMessagesStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy}

Truncates the prompt by retaining only the last `num_messages` messages in the thread.

#|
||Field | Description ||
|| num_messages | **int64**

The number of most recent messages to retain in the prompt.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit. ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| search_index | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `search_index`, `function`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `search_index`, `function`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| search_index_ids[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| max_num_results | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|| rephraser_options | **[RephraserOptions](#yandex.cloud.ai.assistants.v1.RephraserOptions)**

Options for rephrasing user queries.
Used to rewrite the last user message for search,
incorporating context from the previous conversation. ||
|#

## RephraserOptions {#yandex.cloud.ai.assistants.v1.RephraserOptions}

Options for configuring the rephrasing the last user message for search using context from previous conversation.

#|
||Field | Description ||
|| rephraser_uri | **string**

Required field. The ID of the model used to rephrase the last user message for search. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#