---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-greenplum/v1/resourcePresets/{resourcePresetId}
    method: get
    path:
      type: object
      properties:
        resourcePresetId:
          description: |-
            **string**
            Required field. ID of the resource preset to return.
            To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-greenplum/api-ref/ResourcePreset/list#List) request.
          type: string
      required:
        - resourcePresetId
      additionalProperties: false
    query:
      type: object
      properties:
        type:
          description: |-
            **enum** (Type)
            Required field. Required. ResourcePreset type - master or segment.
            - `TYPE_UNSPECIFIED`
            - `MASTER`: Greenplum® master host.
            - `SEGMENT`: Greenplum® segment host.
          type: string
          enum:
            - TYPE_UNSPECIFIED
            - MASTER
            - SEGMENT
      required:
        - type
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/ResourcePreset/get.md
---

# Managed Service for Greenplum® API, REST: ResourcePreset.Get

Returns the specified resource preset.

To get the list of available resource presets, make a [List](/docs/managed-greenplum/api-ref/ResourcePreset/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return.

To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-greenplum/api-ref/ResourcePreset/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.greenplum.v1.GetResourcePresetRequest}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Required. ResourcePreset type - master or segment.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ResourcePreset}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "diskTypeIds": [
    "string"
  ],
  "cores": "string",
  "memory": "string",
  "type": "string",
  "hostCountDivider": "string",
  "maxSegmentInHostCount": "string"
}
```

A preset of resources for hardware configuration of Greenplum® hosts.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| diskTypeIds[] | **string**

IDs of availability disk types available in the resource preset. ||
|| cores | **string** (int64)

Number of CPU cores for a Greenplum® host created with the preset. ||
|| memory | **string** (int64)

RAM volume for a Greenplum® host created with the preset, in bytes. ||
|| type | **enum** (Type)

Host type.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|| hostCountDivider | **string** (int64)

The number of hosts must be divisible by `hostCountDivider`. ||
|| maxSegmentInHostCount | **string** (int64)

Maximum number of segments in segment host. ||
|#