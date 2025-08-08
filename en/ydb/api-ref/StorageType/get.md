---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/storageTypes/{storageTypeId}
    method: get
    path:
      type: object
      properties:
        storageTypeId:
          description: |-
            **string**
            Required field. Required. ID of the storage type to return.
          type: string
      required:
        - storageTypeId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/StorageType/get.md
---

# Managed Service for YDB API, REST: StorageType.Get

Returns the specified storage types.

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/storageTypes/{storageTypeId}
```

## Path parameters

#|
||Field | Description ||
|| storageTypeId | **string**

Required field. Required. ID of the storage type to return. ||
|#

## Response {#yandex.cloud.ydb.v1.StorageType}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "deviceType": "string",
  "redundancyType": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| deviceType | **string** ||
|| redundancyType | **string** ||
|#