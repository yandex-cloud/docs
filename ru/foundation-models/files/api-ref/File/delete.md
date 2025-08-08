---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/files/v1/files/{fileId}
    method: delete
    path:
      type: object
      properties:
        fileId:
          description: |-
            **string**
            Required field. ID of the file to delete.
          type: string
      required:
        - fileId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/ai/files/v1/files/api-ref/File/delete.md
---

# Files API, REST: File.Delete

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