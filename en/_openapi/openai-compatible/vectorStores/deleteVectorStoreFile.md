---
editable: false
---

# REST: Delete vector store file

Delete a vector store file. This will remove the file from the vector store but the file itself will not be deleted.

## HTTP request

```
DELETE https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/files/{file_id}
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store that the file belongs to. ||
|| file_id | **string**

Required field. The ID of the file to delete. ||
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

- `vector_store.file.deleted` ||
|#