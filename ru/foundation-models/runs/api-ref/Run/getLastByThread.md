---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/runs/api-ref/Run/getLastByThread.md
---

# Runs, REST: Run.GetLastByThread

Retrieves the most recent run for a specific thread.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/runs:getByThread
```

## Query parameters {#yandex.cloud.ai.assistants.v1.runs.GetLastRunByThreadRequest}

Request message for retrieving the last run associated with a specific thread.

#|
||Field | Description ||
|| threadId | **string**

Required field. ID of the thread for which the last run is being fetched. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.runs.Run}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "assistantId": "string",
  "threadId": "string",
  "createdBy": "string",
  "createdAt": "string",
  "labels": "object",
  "state": {
    "status": "string",
    // Includes only one of the fields `error`, `completedMessage`, `toolCallList`
    "error": {
      "code": "string",
      "message": "string"
    },
    "completedMessage": {
      "id": "string",
      "threadId": "string",
      "createdBy": "string",
      "createdAt": "string",
      "author": {
        "id": "string",
        "role": "string"
      },
      "labels": "object",
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
      "status": "string",
      "citations": [
        {
          "sources": [
            {
              // Includes only one of the fields `chunk`
              "chunk": {
                "searchIndex": {
                  "id": "string",
                  "folderId": "string",
                  "name": "string",
                  "description": "string",
                  "createdBy": "string",
                  "createdAt": "string",
                  "updatedBy": "string",
                  "updatedAt": "string",
                  "expirationConfig": {
                    "expirationPolicy": "string",
                    "ttlDays": "string"
                  },
                  "expiresAt": "string",
                  "labels": "object",
                  // Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`, `hybridSearchIndex`
                  "textSearchIndex": {
                    "chunkingStrategy": {
                      // Includes only one of the fields `staticStrategy`
                      "staticStrategy": {
                        "maxChunkSizeTokens": "string",
                        "chunkOverlapTokens": "string"
                      }
                      // end of the list of possible fields
                    },
                    // Includes only one of the fields `ngramTokenizer`, `standardTokenizer`
                    "ngramTokenizer": {
                      "minGram": "string",
                      "maxGram": "string"
                    },
                    "standardTokenizer": "object",
                    // end of the list of possible fields
                    // Includes only one of the fields `standardAnalyzer`, `yandexLemmerAnalyzer`
                    "standardAnalyzer": "object",
                    "yandexLemmerAnalyzer": "object"
                    // end of the list of possible fields
                  },
                  "vectorSearchIndex": {
                    "docEmbedderUri": "string",
                    "queryEmbedderUri": "string",
                    "chunkingStrategy": {
                      // Includes only one of the fields `staticStrategy`
                      "staticStrategy": {
                        "maxChunkSizeTokens": "string",
                        "chunkOverlapTokens": "string"
                      }
                      // end of the list of possible fields
                    }
                  },
                  "hybridSearchIndex": {
                    "textSearchIndex": {
                      "chunkingStrategy": {
                        // Includes only one of the fields `staticStrategy`
                        "staticStrategy": {
                          "maxChunkSizeTokens": "string",
                          "chunkOverlapTokens": "string"
                        }
                        // end of the list of possible fields
                      },
                      // Includes only one of the fields `ngramTokenizer`, `standardTokenizer`
                      "ngramTokenizer": {
                        "minGram": "string",
                        "maxGram": "string"
                      },
                      "standardTokenizer": "object",
                      // end of the list of possible fields
                      // Includes only one of the fields `standardAnalyzer`, `yandexLemmerAnalyzer`
                      "standardAnalyzer": "object",
                      "yandexLemmerAnalyzer": "object"
                      // end of the list of possible fields
                    },
                    "vectorSearchIndex": {
                      "docEmbedderUri": "string",
                      "queryEmbedderUri": "string",
                      "chunkingStrategy": {
                        // Includes only one of the fields `staticStrategy`
                        "staticStrategy": {
                          "maxChunkSizeTokens": "string",
                          "chunkOverlapTokens": "string"
                        }
                        // end of the list of possible fields
                      }
                    },
                    "chunkingStrategy": {
                      // Includes only one of the fields `staticStrategy`
                      "staticStrategy": {
                        "maxChunkSizeTokens": "string",
                        "chunkOverlapTokens": "string"
                      }
                      // end of the list of possible fields
                    },
                    "normalizationStrategy": "string",
                    "combinationStrategy": {
                      // Includes only one of the fields `meanCombination`, `rrfCombination`
                      "meanCombination": {
                        "meanEvaluationTechnique": "string",
                        "weights": [
                          "string"
                        ]
                      },
                      "rrfCombination": {
                        "k": "string"
                      }
                      // end of the list of possible fields
                    }
                  }
                  // end of the list of possible fields
                },
                "sourceFile": {
                  "id": "string",
                  "folderId": "string",
                  "name": "string",
                  "description": "string",
                  "mimeType": "string",
                  "createdBy": "string",
                  "createdAt": "string",
                  "updatedBy": "string",
                  "updatedAt": "string",
                  "expirationConfig": {
                    "expirationPolicy": "string",
                    "ttlDays": "string"
                  },
                  "expiresAt": "string",
                  "labels": "object"
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
    "toolCallList": {
      "toolCalls": [
        {
          // Includes only one of the fields `functionCall`
          "functionCall": {
            "name": "string",
            "arguments": "object"
          }
          // end of the list of possible fields
        }
      ]
    }
    // end of the list of possible fields
  },
  "usage": {
    "promptTokens": "string",
    "completionTokens": "string",
    "totalTokens": "string"
  },
  "customPromptTruncationOptions": {
    "maxPromptTokens": "string",
    // Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`
    "autoStrategy": "object",
    "lastMessagesStrategy": {
      "numMessages": "string"
    }
    // end of the list of possible fields
  },
  "customCompletionOptions": {
    "maxTokens": "string",
    "temperature": "number"
  },
  "tools": [
    {
      // Includes only one of the fields `searchIndex`, `function`
      "searchIndex": {
        "searchIndexIds": [
          "string"
        ],
        "maxNumResults": "string",
        "rephraserOptions": {
          "rephraserUri": "string"
        },
        "callStrategy": {
          // Includes only one of the fields `alwaysCall`, `autoCall`
          "alwaysCall": "object",
          "autoCall": {
            "name": "string",
            "instruction": "string"
          }
          // end of the list of possible fields
        }
      },
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "object"
      }
      // end of the list of possible fields
    }
  ],
  "customResponseFormat": {
    // Includes only one of the fields `jsonObject`, `jsonSchema`
    "jsonObject": "boolean",
    "jsonSchema": {
      "schema": "object"
    }
    // end of the list of possible fields
  }
}
```

Represents a run of an assistant over a specific thread of messages.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the run. ||
|| assistantId | **string**

Identifier for the assistant that is being run. ||
|| threadId | **string**

Identifier for the thread of messages that this run is associated with. ||
|| createdBy | **string**

Identifier of the subject who created this run. ||
|| createdAt | **string** (date-time)

Timestamp representing when the run was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the run. ||
|| state | **[RunState](#yandex.cloud.ai.assistants.v1.runs.RunState)**

Current state of the run, including its status and any associated data. ||
|| usage | **[ContentUsage](#yandex.cloud.ai.assistants.v1.runs.ContentUsage)**

Information about the content usage during the run, such as the number of [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model. ||
|| customPromptTruncationOptions | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**

Configuration options for truncating the prompt when the token count exceeds a specified limit.
If specified, these options will override the assistant's prompt truncation settings for this run. ||
|| customCompletionOptions | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**

Configuration options for completion generation.
If specified, these options will override the assistant's completion settings for this run. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that are available for the assistant to use in this run. ||
|| customResponseFormat | **[ResponseFormat](#yandex.cloud.ai.assistants.v1.ResponseFormat)**

Specifies the format of the model's response. ||
|#

## RunState {#yandex.cloud.ai.assistants.v1.runs.RunState}

Represents the current state of a run.

#|
||Field | Description ||
|| status | **enum** (RunStatus)

Current status of a run.

- `RUN_STATUS_UNSPECIFIED`: Default unspecified status.
- `PENDING`: Run has been created but has not started yet.
- `IN_PROGRESS`: Run is currently in progress.
- `FAILED`: Run has failed due to an error.
- `COMPLETED`: Run has completed successfully.
- `TOOL_CALLS`: The run is waiting for tool calls to be executed and their results to be submitted. ||
|| error | **[Error](#yandex.cloud.ai.common.Error)**

Error information if a run has failed.

Includes only one of the fields `error`, `completedMessage`, `toolCallList`.

Oneof field to capture additional data depending on the state of a run. ||
|| completedMessage | **[Message](#yandex.cloud.ai.assistants.v1.threads.Message)**

Final message generated by an assistant if a run has completed successfully.

Includes only one of the fields `error`, `completedMessage`, `toolCallList`.

Oneof field to capture additional data depending on the state of a run. ||
|| toolCallList | **[ToolCallList](#yandex.cloud.ai.assistants.v1.ToolCallList)**

A list of tool calls requested by the assistant.

Includes only one of the fields `error`, `completedMessage`, `toolCallList`.

Oneof field to capture additional data depending on the state of a run. ||
|#

## Error {#yandex.cloud.ai.common.Error}

#|
||Field | Description ||
|| code | **string** (int64) ||
|| message | **string** ||
|#

## Message {#yandex.cloud.ai.assistants.v1.threads.Message}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the message. ||
|| threadId | **string**

ID of the thread that this message belongs to. ||
|| createdBy | **string**

Identifier of the subject who created this message. ||
|| createdAt | **string** (date-time)

Timestamp representing when the message was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| author | **[Author](#yandex.cloud.ai.assistants.v1.threads.Author)**

Author of the message, containing details about the message's creator. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the message. ||
|| content | **[MessageContent](#yandex.cloud.ai.assistants.v1.threads.MessageContent)**

Content of the message. ||
|| status | **enum** (MessageStatus)

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
|| searchIndex | **[SearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndex)**

Search index associated with the file chunk. ||
|| sourceFile | **[File](#yandex.cloud.ai.files.v1.File)**

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
|| folderId | **string**

ID of the folder that the search index belongs to. ||
|| name | **string**

Name of the search index. ||
|| description | **string**

Description of the search index. ||
|| createdBy | **string**

Identifier of the subject who created this search index. ||
|| createdAt | **string** (date-time)

Timestamp representing when the search index was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this search index. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this search index was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the search index, defining when and how the search index will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the search index will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the search index. ||
|| textSearchIndex | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex)**

Keyword-based text search index configuration.
This type of index is used for traditional text search, where documents are indexed based on their keywords.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`, `hybridSearchIndex`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| vectorSearchIndex | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex)**

Vector-based search index configuration.
This type is used for vector search, where documents are indexed using vector embeddings.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`, `hybridSearchIndex`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|| hybridSearchIndex | **[HybridSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex)**

Hybrid (vector-based + keyword-based) search index configuration
This type is used for hybrid search, where documents are indexed using both keyword-based and vector-based search mechanisms.

Includes only one of the fields `textSearchIndex`, `vectorSearchIndex`, `hybridSearchIndex`.

Type of the search index. It can be either a traditional keyword-based text search or a vector-based search. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## TextSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex}

Defines the configuration for a traditional keyword-based text search index.

#|
||Field | Description ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Chunking strategy used to split text into smaller chunks before indexing.
In the case of text search, tokens are individual text characters. ||
|| ngramTokenizer | **[NgramTokenizer](#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer)**

Tokenizer that generates n-grams.

Includes only one of the fields `ngramTokenizer`, `standardTokenizer`.

Tokenizer type used for text search. The tokenizer determines how the
input text is broken down into tokens before indexing.
If not specified, the default tokenizer configuration is applied. ||
|| standardTokenizer | **object**

Tokenizer that generates words.

Includes only one of the fields `ngramTokenizer`, `standardTokenizer`.

Tokenizer type used for text search. The tokenizer determines how the
input text is broken down into tokens before indexing.
If not specified, the default tokenizer configuration is applied. ||
|| standardAnalyzer | **object**

Standard analyzer that performs common text processing operations to normalize text.

Includes only one of the fields `standardAnalyzer`, `yandexLemmerAnalyzer`.

Analyzer type used for text search. The analyzer determines how the
tokenized text is further processed before indexing.
If not specified, the default analyzer configuration is applied. ||
|| yandexLemmerAnalyzer | **object**

Specialized analyzer that uses Yandex's lemmatization technology,
particularly effective for Russian and other Slavic languages.

Includes only one of the fields `standardAnalyzer`, `yandexLemmerAnalyzer`.

Analyzer type used for text search. The analyzer determines how the
tokenized text is further processed before indexing.
If not specified, the default analyzer configuration is applied. ||
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
|| maxChunkSizeTokens | **string** (int64)

The maximum number of tokens allowed in a single chunk.
Constraints: must be within the range [100, 2048].
Default value: 800 ||
|| chunkOverlapTokens | **string** (int64)

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
|| minGram | **string** (int64)

Minimum length of characters in a gram. Defaults to 3 ||
|| maxGram | **string** (int64)

Maximum length of characters in a gram. Defaults to 4 ||
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

Chunking strategy used to split text into smaller chunks before indexing.
In the case of vector search, tokens are produced by the tokenizer from the embedding model. ||
|#

## HybridSearchIndex {#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex}

Defines the configuration for a hybrid (vector-based + keyword-based) search index. This type uses both embeddings and keyword-based search to represent documents and queries.

#|
||Field | Description ||
|| textSearchIndex | **[TextSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.TextSearchIndex)**

Configuration for a traditional keyword-based text search index. ||
|| vectorSearchIndex | **[VectorSearchIndex](#yandex.cloud.ai.assistants.v1.searchindex.VectorSearchIndex)**

Configuration for a vector-based search index. ||
|| chunkingStrategy | **[ChunkingStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ChunkingStrategy)**

Common chunking strategy that applies to both text and vector search indexes.
If provided, it overrides the individual chunking strategies in both `text_search_index` and `vector_search_index`.
In this case, both text and vector search will use token-based chunking, where tokens are produced by the tokenizer of the embedding model. ||
|| normalizationStrategy | **enum** (NormalizationStrategy)

Normalization strategy for relevance scores from different indices. Default is MIN_MAX_STRATEGY

- `NORMALIZATION_STRATEGY_UNSPECIFIED`
- `MIN_MAX`: https://en.wikipedia.org/wiki/Feature_scaling#Rescaling_(min-max_normalization)
- `L2`: https://en.wikipedia.org/wiki/Cosine_similarity#L2-normalized_Euclidean_distance ||
|| combinationStrategy | **[CombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy)**

Combination strategy for merging rankings from different indices. Default is arithmetic mean ||
|#

## CombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy}

Combination strategy for merging rankings from different indices

#|
||Field | Description ||
|| meanCombination | **[MeanCombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.MeanCombinationStrategy)**

Includes only one of the fields `meanCombination`, `rrfCombination`. ||
|| rrfCombination | **[ReciprocalRankFusionCombinationStrategy](#yandex.cloud.ai.assistants.v1.searchindex.ReciprocalRankFusionCombinationStrategy)**

Includes only one of the fields `meanCombination`, `rrfCombination`. ||
|#

## MeanCombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.MeanCombinationStrategy}

#|
||Field | Description ||
|| meanEvaluationTechnique | **enum** (MeanEvaluationTechnique)

Technique for averaging relevance scores from different indices. Default is ARITHMETIC

- `MEAN_EVALUATION_TECHNIQUE_UNSPECIFIED`
- `ARITHMETIC`: https://en.wikipedia.org/wiki/Arithmetic_mean
- `GEOMETRIC`: https://en.wikipedia.org/wiki/Geometric_mean
- `HARMONIC`: https://en.wikipedia.org/wiki/Harmonic_mean ||
|| weights[] | **string**

Weights used for evaluating the weighted mean of relevance scores. The sum of the values must equal 1.0
If not provided, all scores are given equal weight ||
|#

## ReciprocalRankFusionCombinationStrategy {#yandex.cloud.ai.assistants.v1.searchindex.ReciprocalRankFusionCombinationStrategy}

https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf

#|
||Field | Description ||
|| k | **string** (int64)

The parameter k for RRFscore. Default is 60 ||
|#

## File {#yandex.cloud.ai.files.v1.File}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file. ||
|| folderId | **string**

ID of the folder that the file belongs to. ||
|| name | **string**

Name of the file. ||
|| description | **string**

Description of the file. ||
|| mimeType | **string**

MIME type of the file, indicating the file's format (e.g., "application/pdf") ||
|| createdBy | **string**

Identifier of the subject who created this file. ||
|| createdAt | **string** (date-time)

Timestamp representing when the file was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this file. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this file was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the file, defining when and how the file will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the file will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| toolCalls[] | **[ToolCall](#yandex.cloud.ai.assistants.v1.ToolCall)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.assistants.v1.ToolCall}

Represents a call to a tool.

#|
||Field | Description ||
|| functionCall | **[FunctionCall](#yandex.cloud.ai.assistants.v1.FunctionCall)**

Represents a call to a function.

Includes only one of the fields `functionCall`. ||
|#

## FunctionCall {#yandex.cloud.ai.assistants.v1.FunctionCall}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **object**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#

## ContentUsage {#yandex.cloud.ai.assistants.v1.runs.ContentUsage}

Represents the content usage during a run, such as the number of [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model.

#|
||Field | Description ||
|| promptTokens | **string** (int64)

The number of tokens used in the prompt. ||
|| completionTokens | **string** (int64)

The number of tokens used in the completion response. ||
|| totalTokens | **string** (int64)

The total number of tokens used (prompt + completion). ||
|#

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| maxPromptTokens | **string** (int64)

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|| autoStrategy | **object**

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|| lastMessagesStrategy | **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy)**

Retains only the last `num_messages` messages in the thread.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|#

## LastMessagesStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy}

Truncates the prompt by retaining only the last `num_messages` messages in the thread.

#|
||Field | Description ||
|| numMessages | **string** (int64)

The number of most recent messages to retain in the prompt.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit. ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| maxTokens | **string** (int64)

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| searchIndex | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `searchIndex`, `function`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `searchIndex`, `function`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| searchIndexIds[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| maxNumResults | **string** (int64)

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|| rephraserOptions | **[RephraserOptions](#yandex.cloud.ai.assistants.v1.RephraserOptions)**

Options for rephrasing user queries.
Used to rewrite the last user message for search,
incorporating context from the previous conversation. ||
|| callStrategy | **[CallStrategy](#yandex.cloud.ai.assistants.v1.CallStrategy)**

Defines the strategy for triggering search.
Controls whether search results are always included or returned only when
the model explicitly calls the tool. ||
|#

## RephraserOptions {#yandex.cloud.ai.assistants.v1.RephraserOptions}

Options for configuring the rephrasing the last user message for search using context from previous conversation.

#|
||Field | Description ||
|| rephraserUri | **string**

Required field. The ID of the model used to rephrase the last user message for search. ||
|#

## CallStrategy {#yandex.cloud.ai.assistants.v1.CallStrategy}

Defines when the assistant uses the search tool.

#|
||Field | Description ||
|| alwaysCall | **object**

Includes only one of the fields `alwaysCall`, `autoCall`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|| autoCall | **[AutoCall](#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall)**

Includes only one of the fields `alwaysCall`, `autoCall`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|#

## AutoCall {#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall}

Exposes the tool as a callable function.
The model decides when to trigger search based on the instruction.

#|
||Field | Description ||
|| name | **string**

The name of the tool as exposed to the model. ||
|| instruction | **string**

Required field. Required instruction that helps the model decide when to call the tool. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **object**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#

## ResponseFormat {#yandex.cloud.ai.assistants.v1.ResponseFormat}

Specifies the format of the model's response.

#|
||Field | Description ||
|| jsonObject | **boolean**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `jsonObject`, `jsonSchema`. ||
|| jsonSchema | **[JsonSchema](#yandex.cloud.ai.assistants.v1.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `jsonObject`, `jsonSchema`. ||
|#

## JsonSchema {#yandex.cloud.ai.assistants.v1.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **object**

The JSON Schema that the model's output must conform to. ||
|#