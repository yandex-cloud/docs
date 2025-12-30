---
editable: false
sourcePath: en/_openapi/openai-compatible/vectorStores/updateVectorStoreFileAttributes.md
---

# REST: Update vector store file attributes

Update attributes on a vector store file.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/files/{file_id}
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store the file belongs to. ||
|| file_id | **string**

Required field. The ID of the file to update attributes. ||
|#

## Body parameters

**Request schema: application/json**

```json
{
  "attributes": "unknown"
}
```

#|
||Field | Description ||
|| attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "id": "string",
  "object": "string",
  "usage_bytes": "integer",
  "created_at": "integer",
  "vector_store_id": "string",
  "status": "string",
  "last_error": "unknown",
  "chunking_strategy": {
    "<anyOf>": [
      {
        "type": "string",
        "static": {
          "max_chunk_size_tokens": "integer",
          "chunk_overlap_tokens": "integer"
        }
      },
      {
        "type": "string"
      }
    ]
  },
  "attributes": "unknown"
}
```

A list of files attached to a vector store.

#|
||Field | Description ||
|| id | **string**

Required field. The identifier, which can be referenced in API endpoints. ||
|| object | **enum**

Required field. The object type, which is always `vector_store.file`.

- `vector_store.file` ||
|| usage_bytes | **integer**

Required field. The total vector store usage in bytes. Note that this may be different from the original file size. ||
|| created_at | **integer**

Required field. The Unix timestamp (in seconds) for when the vector store file was created. ||
|| vector_store_id | **string**

Required field. The ID of the vector store that the file is attached to. ||
|| status | **enum**

Required field. The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use.

- `in_progress`
- `completed`
- `cancelled`
- `failed` ||
|| last_error | Any of **[LastError0](#LastError0)** \| **null** ||
|| chunking_strategy | Any of **[StaticChunkingStrategyResponseParam](#StaticChunkingStrategyResponseParam)** \| **[OtherChunkingStrategyResponseParam](#OtherChunkingStrategyResponseParam)** ||
|| attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
|#

## LastError0 {#LastError0}

The last error associated with this vector store file. Will be `null` if there are no errors.

#|
||Field | Description ||
|| code | **enum**

Required field. One of `server_error`, `unsupported_file`, or `invalid_file`.

- `server_error`
- `unsupported_file`
- `invalid_file` ||
|| message | **string**

Required field. A human-readable description of the error. ||
|#

## StaticChunkingStrategyResponseParam {#StaticChunkingStrategyResponseParam}

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

## OtherChunkingStrategyResponseParam {#OtherChunkingStrategyResponseParam}

This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API.

#|
||Field | Description ||
|| type | **enum**

Required field. Always `other`.

- `other` ||
|#