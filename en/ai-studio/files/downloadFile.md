---
editable: false
sourcePath: en/_openapi/openai-compatible/files/downloadFile.md
---

# REST: Retrieve file content

Returns the contents of the specified file.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/files/{file_id}/content
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
"string"
```