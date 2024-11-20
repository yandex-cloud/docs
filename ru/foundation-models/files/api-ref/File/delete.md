---
editable: false
sourcePath: en/_api-ref/ai/files/v1/files/api-ref/File/delete.md
---

# Files API, REST: File.Delete {#Delete}

Delete a file by its ID.

## HTTP request

```
DELETE https://rest-assistant.{{ api-host }}/files/v1/files/{fileId}
```

## Path parameters

Request message for deleting a file by ID.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file to delete. ||
|#

## Response {#yandex.cloud.ai.files.v1.DeleteFileResponse}

**HTTP Code: 200 - OK**