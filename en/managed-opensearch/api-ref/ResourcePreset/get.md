---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/resourcePresets/{resourcePresetId}
    method: get
    path:
      type: object
      properties:
        resourcePresetId:
          description: |-
            **string**
            Required field. ID of the resource preset to return.
            To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-opensearch/api-ref/ResourcePreset/list#List) request.
          type: string
      required:
        - resourcePresetId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/ResourcePreset/get.md
---

# Managed Service for OpenSearch API, REST: ResourcePreset.Get

Returns the specified resource preset.

To get the list of available resource presets, make a [List](/docs/managed-opensearch/api-ref/ResourcePreset/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return.

To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-opensearch/api-ref/ResourcePreset/list#List) request. ||
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