---
editable: false
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