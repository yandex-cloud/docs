---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/threads/api-ref/Message/get.md
---

# Threads, REST: Message.Get

Retrieve details of a specific message by its ID.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/messages/{messageId}
```

## Path parameters

Request message for retrieving a message from a thread.

#|
||Field | Description ||
|| messageId | **string**

Required field. ID of the message to retrieve. ||
|#

## Query parameters {#yandex.cloud.ai.assistants.v1.threads.GetMessageRequest}

Request message for retrieving a message from a thread.

#|
||Field | Description ||
|| threadId | **string**

Required field. ID of the thread that contains the message. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.threads.Message}

**HTTP Code: 200 - OK**

```json
{
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
}
```

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