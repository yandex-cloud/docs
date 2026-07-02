[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for YDB](../../index.md) > [Справочник API Yandex Cloud для Managed Service for YDB](../overview.md) > [REST (англ.)](../index.md) > [ResourcePreset](index.md) > Get

# Managed Service for YDB API, REST: ResourcePreset.Get

Returns the specified resource preset.

## HTTP request

```
GET https://ydb.api.cloud.yandex.net/ydb/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. Required. ID of the resource preset to return. ||
|#

## Response {#yandex.cloud.ydb.v1.ResourcePreset}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cores": "string",
  "memory": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| cores | **string** (int64) ||
|| memory | **string** (int64) ||
|#