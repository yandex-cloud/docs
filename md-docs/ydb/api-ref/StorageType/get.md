# Managed Service for YDB API, REST: StorageType.Get

Returns the specified storage types.

## HTTP request

```
GET https://ydb.api.cloud.yandex.net/ydb/v1/storageTypes/{storageTypeId}
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