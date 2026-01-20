---
editable: false
sourcePath: en/_openapi/openai-compatible/files/deleteFile.md
---

# REST: Delete file

Delete a file and remove it from all vector stores.

## HTTP request

```
DELETE https://ai.api.cloud.yandex.net/v1/files/{file_id}
```

## Path parameters

#|
||Field | Description ||
|| file_id | **string**

Required field. The ID of the file to use for this request. ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "id": "string",
  "object": "string",
  "deleted": "boolean"
}
```

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| object | **enum**

Required field. 

- `file` ||
|| deleted | **boolean**

Required field.  ||
|#