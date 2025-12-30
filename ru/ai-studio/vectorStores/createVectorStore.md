---
editable: false
sourcePath: en/_openapi/openai-compatible/vectorStores/createVectorStore.md
---

# REST: Create vector store

Create a vector store.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/vector_stores
```

## Body parameters

**Request schema: application/json**

```json
{
  "file_ids": [
    "string"
  ],
  "name": "string",
  "description": "string",
  "expires_after": {
    "anchor": "string",
    "days": "integer"
  },
  "chunking_strategy": {
    "<anyOf>": [
      {
        "description": "string",
        "name": "string",
        "parameters": "object"
      },
      {
        "type": "string",
        "static": {
          "max_chunk_size_tokens": "integer",
          "chunk_overlap_tokens": "integer"
        }
      }
    ]
  },
  "metadata": "unknown"
}
```

#|
||Field | Description ||
|| file_ids[] | **string** ||
|| name | **string**

The name of the vector store. ||
|| description | **string**

A description for the vector store. Can be used to describe the vector store's purpose. ||
|| expires_after | **[VectorStoreExpirationAfter](#VectorStoreExpirationAfter)**

Required field. The expiration policy for a vector store. ||
|| chunking_strategy | Any of **[AutoChunkingStrategyRequestParam](#AutoChunkingStrategyRequestParam)** \| **[StaticChunkingStrategyRequestParam](#StaticChunkingStrategyRequestParam)** ||
|| metadata | Any of **object** (map<**string**, **string**>) \| **null** ||
|#

## VectorStoreExpirationAfter {#VectorStoreExpirationAfter}

The expiration policy for a vector store.

#|
||Field | Description ||
|| anchor | **enum**

Required field. Anchor timestamp after which the expiration policy applies.
Supported anchors: `last_active_at`.''


- `last_active_at` ||
|| days | **integer**

Required field. The number of days after the anchor time that the vector store will expire. ||
|#

## AutoChunkingStrategyRequestParam {#AutoChunkingStrategyRequestParam}

Schema reference for server-to-client Realtime events. Servers emit JSON messages where the `type` field selects the event schema.

#|
||Field | Description ||
|| description | **string**

A description of what the function does, used by the model to choose when and how to call the function. ||
|| name | **string**

Required field. The name of the function to be called. Must be `a-z, A-Z, 0-9`, or contain underscores and dashes, with a maximum length of 64. ||
|| parameters | **object**

The parameters the functions accepts, described as a JSON Schema object. ||
|#

## StaticChunkingStrategyRequestParam {#StaticChunkingStrategyRequestParam}

Customize your own chunking strategy by setting chunk size and chunk overlap.

#|
||Field | Description ||
|| type | **enum**

Required field. Always `static`.

- `static` ||
|| static | **[StaticChunkingStrategy](#StaticChunkingStrategy)**

Required field.  ||
|#

## StaticChunkingStrategy {#StaticChunkingStrategy}

#|
||Field | Description ||
|| max_chunk_size_tokens | **integer**

Required field. The maximum number of tokens in each chunk. The default value is `800`. The minimum value is `100` and the maximum value is `4096`. ||
|| chunk_overlap_tokens | **integer**

Required field. The number of tokens that overlap between chunks. The default value is `400`. Note that the overlap must not exceed half of `max_chunk_size_tokens`. 
 ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "id": "string",
  "object": "string",
  "created_at": "integer",
  "name": "string",
  "usage_bytes": "integer",
  "file_counts": {
    "in_progress": "integer",
    "completed": "integer",
    "failed": "integer",
    "cancelled": "integer",
    "total": "integer"
  },
  "status": "string",
  "expires_after": {
    "anchor": "string",
    "days": "integer"
  },
  "expires_at": "unknown",
  "last_active_at": "unknown",
  "metadata": "unknown"
}
```

A vector store is a collection of processed files can be used by the `file_search` tool.

#|
||Field | Description ||
|| id | **string**

Required field. The identifier, which can be referenced in API endpoints. ||
|| object | **enum**

Required field. The object type, which is always `vector_store`.

- `vector_store` ||
|| created_at | **integer**

Required field. The Unix timestamp (in seconds) for when the vector store was created. ||
|| name | **string**

Required field. The name of the vector store. ||
|| usage_bytes | **integer**

Required field. The total number of bytes used by the files in the vector store. ||
|| file_counts | **[FileCounts](#FileCounts)**

Required field.  ||
|| status | **enum**

Required field. The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use.

- `expired`
- `in_progress`
- `completed` ||
|| expires_after | **[VectorStoreExpirationAfter](#VectorStoreExpirationAfter2)**

Required field. The expiration policy for a vector store. ||
|| expires_at | Any of **integer** \| **null** ||
|| last_active_at | Any of **integer** \| **null** ||
|| metadata | Any of **object** (map<**string**, **string**>) \| **null** ||
|#

## FileCounts {#FileCounts}

#|
||Field | Description ||
|| in_progress | **integer**

Required field. The number of files that are currently being processed. ||
|| completed | **integer**

Required field. The number of files that have been successfully processed. ||
|| failed | **integer**

Required field. The number of files that have failed to process. ||
|| cancelled | **integer**

Required field. The number of files that were cancelled. ||
|| total | **integer**

Required field. The total number of files. ||
|#

## VectorStoreExpirationAfter {#VectorStoreExpirationAfter2}

The expiration policy for a vector store.

#|
||Field | Description ||
|| anchor | **enum**

Required field. Anchor timestamp after which the expiration policy applies.
Supported anchors: `last_active_at`.''


- `last_active_at` ||
|| days | **integer**

Required field. The number of days after the anchor time that the vector store will expire. ||
|#