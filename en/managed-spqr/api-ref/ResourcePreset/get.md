---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/resourcePresets/{resourcePresetId}
    method: get
    path:
      type: object
      properties:
        resourcePresetId:
          description: |-
            **string**
            Required field. ID of the resource preset to return.
            To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-spqr/api-ref/ResourcePreset/list#List) request.
          type: string
      required:
        - resourcePresetId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for SPQR API, REST: ResourcePreset.Get

Returns the specified ResourcePreset resource.

To get the list of available ResourcePreset resources, make a [List](/docs/managed-spqr/api-ref/ResourcePreset/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return.
To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-spqr/api-ref/ResourcePreset/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.ResourcePreset}

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

A ResourcePreset resource for describing hardware configuration presets.

#|
||Field | Description ||
|| id | **string**

ID of the ResourcePreset resource. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| cores | **string** (int64)

Number of CPU cores for a SPQR host created with the preset. ||
|| memory | **string** (int64)

RAM volume for a SPQR host created with the preset, in bytes. ||
|#