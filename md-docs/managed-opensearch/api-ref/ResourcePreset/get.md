# Managed Service for OpenSearch API, REST: ResourcePreset.Get

Returns the specified resource preset.

To get the list of available resource presets, make a [List](list.md#List) request.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-opensearch/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return.

To get the resource preset ID, use a [ResourcePresetService.List](list.md#List) request. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.ResourcePreset}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "cores": "string",
  "memory": "string"
}
```

A preset of resources for hardware configuration of the OpenSearch hosts.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zoneIds[] | **string**

IDs of the availability zones where the resource preset is available. ||
|| cores | **string** (int64)

Number of the CPU cores for an OpenSearch host created with the preset. ||
|| memory | **string** (int64)

RAM volume for an OpenSearch host created with the preset, in bytes. ||
|#