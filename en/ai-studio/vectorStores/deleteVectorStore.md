---
editable: false
---

# REST: Delete vector store

Delete a vector store.

## HTTP request

```
DELETE https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "id": "string",
  "deleted": "boolean",
  "object": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| deleted | **boolean**

Required field.  ||
|| object | **enum**

Required field. 

- `vector_store.deleted` ||
|#