---
editable: false
apiPlayground:
  - url: https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets:getEx
    method: get
    path: null
    query:
      type: object
      properties:
        secretId:
          description: |-
            **string**
            Includes only one of the fields `secretId`, `folderAndName`.
          type: string
        folderAndName:
          description: |-
            **[FolderAndName](/docs/lockbox/api-ref/Payload/getEx#yandex.cloud.lockbox.v1.FolderAndName)**
            Includes only one of the fields `secretId`, `folderAndName`.
          $ref: '#/definitions/FolderAndName'
        versionId:
          description: '**string**'
          type: string
      additionalProperties: false
    body: null
    definitions:
      FolderAndName:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Required field. 
            type: string
          secretName:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - folderId
          - secretName
sourcePath: en/_api-ref/lockbox/v1/api-ref/Payload/getEx.md
---

# Lockbox API, REST: Payload.GetEx

## HTTP request

```
GET https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets:getEx
```

## Query parameters {#yandex.cloud.lockbox.v1.GetExRequest}

#|
||Field | Description ||
|| secretId | **string**

Includes only one of the fields `secretId`, `folderAndName`. ||
|| folderAndName | **[FolderAndName](#yandex.cloud.lockbox.v1.FolderAndName)**

Includes only one of the fields `secretId`, `folderAndName`. ||
|| versionId | **string** ||
|#

## FolderAndName {#yandex.cloud.lockbox.v1.FolderAndName}

#|
||Field | Description ||
|| folderId | **string**

Required field.  ||
|| secretName | **string**

Required field.  ||
|#

## Response {#yandex.cloud.lockbox.v1.GetExResponse}

**HTTP Code: 200 - OK**

```json
{
  "secretId": "string",
  "versionId": "string",
  "entries": "object"
}
```

#|
||Field | Description ||
|| secretId | **string** ||
|| versionId | **string** ||
|| entries | **object** (map<**string**, **string** (bytes)>) ||
|#