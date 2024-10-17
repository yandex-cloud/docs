---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/StorageType/get.md
---

# Managed Service for YDB API, gRPC: StorageTypeService.Get {#Get}

Returns the specified storage types.

## gRPC request

**rpc Get ([GetStorageTypeRequest](#yandex.cloud.ydb.v1.GetStorageTypeRequest)) returns ([StorageType](#yandex.cloud.ydb.v1.StorageType))**

## GetStorageTypeRequest {#yandex.cloud.ydb.v1.GetStorageTypeRequest}

```json
{
  "storageTypeId": "string"
}
```

#|
||Field | Description ||
|| storageTypeId | **string**

Required field. Required. ID of the storage type to return. ||
|#

## StorageType {#yandex.cloud.ydb.v1.StorageType}

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