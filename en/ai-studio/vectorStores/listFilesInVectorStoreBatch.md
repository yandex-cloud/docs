---
editable: false
---

# REST: List vector store files in a batch

Returns a list of vector store files in a batch.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/file_batches/{batch_id}/files
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store that the files belong to. ||
|| batch_id | **string**

Required field. The ID of the file batch that the files belong to. ||
|#

## Query parameters

#|
||Field | Description ||
|| limit | **integer**

A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. ||
|| order | **enum**

Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order.

- `asc`
- `desc` ||
|| after | **string**

A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `after=obj_foo` in order to fetch the next page of the list. ||
|| before | **string**

A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_foo`, your subsequent call can include `before=obj_foo` in order to fetch the previous page of the list. ||
|| filter | **enum**

Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.

- `in_progress`
- `completed`
- `failed`
- `cancelled` ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "object": "string",
  "data": [
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
  ],
  "first_id": "string",
  "last_id": "string",
  "has_more": "boolean"
}
```

#|
||Field | Description ||
|| object | **string**

Required field.  ||
|| data[] | **[VectorStoreFileObject](#VectorStoreFileObject)**

Required field. A list of files attached to a vector store. ||
|| first_id | **string**

Required field.  ||
|| last_id | **string**

Required field.  ||
|| has_more | **boolean**

Required field.  ||
|#

## VectorStoreFileObject {#VectorStoreFileObject}

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