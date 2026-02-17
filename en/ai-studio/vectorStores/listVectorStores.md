---
editable: false
---

# REST: List vector stores

Returns a list of vector stores.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/vector_stores
```

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
|| data[] | **[VectorStoreObject](#VectorStoreObject)**

Required field. A vector store is a collection of processed files can be used by the `file_search` tool. ||
|| first_id | **string**

Required field.  ||
|| last_id | **string**

Required field.  ||
|| has_more | **boolean**

Required field.  ||
|#

## VectorStoreObject {#VectorStoreObject}

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
|| expires_after | **[VectorStoreExpirationAfter](#VectorStoreExpirationAfter)**

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