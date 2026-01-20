---
editable: false
sourcePath: en/_openapi/openai-compatible/vectorStores/createVectorStoreFileBatch.md
---

# REST: Create vector store file batch

Create a vector store file batch.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/file_batches
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store for which to create a File Batch. ||
|#

## Body parameters

**Request schema: application/json**

```json
{
  "file_ids": [
    "string"
  ],
  "files": [
    {
      "file_id": "string",
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
      "attributes": "unknown"
    }
  ],
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
  "attributes": "unknown"
}
```

#|
||Field | Description ||
|| file_ids[] | **string** ||
|| files[] | **[CreateVectorStoreFileRequest](#CreateVectorStoreFileRequest)**

Required field.  ||
|| chunking_strategy | Any of **[AutoChunkingStrategyRequestParam](#AutoChunkingStrategyRequestParam)** \| **[StaticChunkingStrategyRequestParam](#StaticChunkingStrategyRequestParam)** ||
|| attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
|#

## CreateVectorStoreFileRequest {#CreateVectorStoreFileRequest}

#|
||Field | Description ||
|| file_id | **string**

Required field. A file ID that the vector store should use. Useful for tools like `file_search` that can access files. ||
|| chunking_strategy | Any of **[AutoChunkingStrategyRequestParam](#AutoChunkingStrategyRequestParam)** \| **[StaticChunkingStrategyRequestParam](#StaticChunkingStrategyRequestParam)** ||
|| attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
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
  "vector_store_id": "string",
  "status": "string",
  "file_counts": {
    "in_progress": "integer",
    "completed": "integer",
    "failed": "integer",
    "cancelled": "integer",
    "total": "integer"
  }
}
```

A batch of files attached to a vector store.

#|
||Field | Description ||
|| id | **string**

Required field. The identifier, which can be referenced in API endpoints. ||
|| object | **enum**

Required field. The object type, which is always `vector_store.file_batch`.

- `vector_store.files_batch` ||
|| created_at | **integer**

Required field. The Unix timestamp (in seconds) for when the vector store files batch was created. ||
|| vector_store_id | **string**

Required field. The ID of the vector store that the file is attached to. ||
|| status | **enum**

Required field. The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`.

- `in_progress`
- `completed`
- `cancelled`
- `failed` ||
|| file_counts | **[FileCounts](#FileCounts)**

Required field.  ||
|#

## FileCounts {#FileCounts}

#|
||Field | Description ||
|| in_progress | **integer**

Required field. The number of files that are currently being processed. ||
|| completed | **integer**

Required field. The number of files that have been processed. ||
|| failed | **integer**

Required field. The number of files that have failed to process. ||
|| cancelled | **integer**

Required field. The number of files that where cancelled. ||
|| total | **integer**

Required field. The total number of files. ||
|#