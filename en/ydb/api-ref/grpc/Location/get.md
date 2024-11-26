---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/Location/get.md
---

# Managed Service for YDB API, gRPC: LocationService.Get

Returns the specified location.

## gRPC request

**rpc Get ([GetLocationRequest](#yandex.cloud.ydb.v1.GetLocationRequest)) returns ([Location](#yandex.cloud.ydb.v1.Location))**

## GetLocationRequest {#yandex.cloud.ydb.v1.GetLocationRequest}

```json
{
  "location_id": "string"
}
```

#|
||Field | Description ||
|| location_id | **string**

Required field. Required. ID of the location to return. ||
|#

## Location {#yandex.cloud.ydb.v1.Location}

```json
{
  "id": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| description | **string** ||
|#