[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for YDB](../../../index.md) > [Справочник API Yandex Cloud для Managed Service for YDB](../../overview.md) > [gRPC (англ.)](../index.md) > [Location](index.md) > Get

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