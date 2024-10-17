---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/ResourcePreset/get.md
---

# Managed Service for Redis API, REST: ResourcePreset.Get {#Get}

Returns the specified resource preset.

To get the list of available resource presets, make a [List](/docs/managed-redis/api-ref/ResourcePreset/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return.
To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-redis/api-ref/ResourcePreset/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.ResourcePreset}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "memory": "string",
  "cores": "string"
}
```

A resource preset that describes hardware configuration for a host.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| memory | **string** (int64)

RAM volume for a Redis host created with the preset, in bytes. ||
|| cores | **string** (int64)

Number of CPU cores for a Redis host created with the preset. ||
|#