---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/StorageType/get.md
---

# Managed Service for YDB API, gRPC: StorageTypeService.Get

Returns the specified storage types.

## gRPC request

**rpc Get ([GetStorageTypeRequest](#yandex.cloud.ydb.v1.GetStorageTypeRequest)) returns ([StorageType](#yandex.cloud.ydb.v1.StorageType))**

## GetStorageTypeRequest {#yandex.cloud.ydb.v1.GetStorageTypeRequest}

```json
{
  "storage_type_id": "string"
}
```

#|
||Field | Description ||
|| storage_type_id | **string**

Required field. Required. ID of the storage type to return. ||
|#

## StorageType {#yandex.cloud.ydb.v1.StorageType}

```json
{
  "id": "string",
  "device_type": "string",
  "redundancy_type": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| device_type | **string** ||
|| redundancy_type | **string** ||
|#