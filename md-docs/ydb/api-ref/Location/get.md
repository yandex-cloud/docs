[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for YDB](../../index.md) > [Справочник API Yandex Cloud для Managed Service for YDB](../overview.md) > [REST (англ.)](../index.md) > [Location](index.md) > Get

# Managed Service for YDB API, REST: Location.Get

Returns the specified location.

## HTTP request

```
GET https://ydb.api.cloud.yandex.net/ydb/v1/locations/{locationId}
```

## Path parameters

#|
||Field | Description ||
|| locationId | **string**

Required field. Required. ID of the location to return. ||
|#

## Response {#yandex.cloud.ydb.v1.Location}

**HTTP Code: 200 - OK**

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