---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/searchindex/api-ref/SearchIndexFile/get.md
---

# Search Index, REST: SearchIndexFile.Get {#Get}

Retrieves details of a specific file that has been indexed within a search index.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/searchIndexFile/{searchIndexId}/{fileId}
```

## Path parameters

Request message for retrieving a file from a search index.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file to retrieve. ||
|| searchIndexId | **string**

Required field. ID of the search index that contains the file. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "searchIndexId": "string",
  "createdBy": "string",
  "createdAt": "string",
  "chunkingStrategy": {
    // Includes only one of the fields `staticStrategy`
    "staticStrategy": {
      "maxChunkSizeTokens": "string",
      "chunkOverlapTokens": "string"
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
|| createdAt | **string** (date-time)

Timestamp representing when the file was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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