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
            The maximum string length in characters is 50.
            Includes only one of the fields `secretId`, `folderAndName`.
          type: string
        folderAndName:
          description: |-
            **[FolderAndName](#yandex.cloud.lockbox.v1.FolderAndName)**
            Includes only one of the fields `secretId`, `folderAndName`.
          $ref: '#/definitions/FolderAndName'
        versionId:
          description: |-
            **string**
            The maximum string length in characters is 50.
          type: string
      additionalProperties: false
      oneOf:
        - required:
            - secretId
        - required:
            - folderAndName
    body: null
    definitions:
      FolderAndName:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Required field.
              The maximum string length in characters is 50.
            type: string
          secretName:
            description: |-
              **string**
              Required field.
              The maximum string length in characters is 100.
            type: string
        required:
          - folderId
          - secretName
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

The maximum string length in characters is 50.

Includes only one of the fields `secretId`, `folderAndName`. ||
|| folderAndName | **[FolderAndName](#yandex.cloud.lockbox.v1.FolderAndName)**

Includes only one of the fields `secretId`, `folderAndName`. ||
|| versionId | **string**

The maximum string length in characters is 50. ||
|#

## FolderAndName {#yandex.cloud.lockbox.v1.FolderAndName}

#|
||Field | Description ||
|| folderId | **string**

Required field.

The maximum string length in characters is 50. ||
|| secretName | **string**

Required field.

The maximum string length in characters is 100. ||
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