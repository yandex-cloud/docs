---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/ResourcePreset/get.md
---

# Managed Service for Greenplum® API, gRPC: ResourcePresetService.Get

Returns the specified resource preset.

To get the list of available resource presets, make a [List](/docs/managed-greenplum/api-ref/grpc/ResourcePreset/list#List) request.

## gRPC request

**rpc Get ([GetResourcePresetRequest](#yandex.cloud.mdb.greenplum.v1.GetResourcePresetRequest)) returns ([ResourcePreset](#yandex.cloud.mdb.greenplum.v1.ResourcePreset))**

## GetResourcePresetRequest {#yandex.cloud.mdb.greenplum.v1.GetResourcePresetRequest}

```json
{
  "resource_preset_id": "string",
  "type": "Type"
}
```

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the resource preset to return.

To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-greenplum/api-ref/grpc/ResourcePreset/list#List) request. ||
|| type | enum **Type**

Required field. Required. ResourcePreset type - master or segment.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|#

## ResourcePreset {#yandex.cloud.mdb.greenplum.v1.ResourcePreset}

```json
{
  "id": "string",
  "zone_ids": [
    "string"
  ],
  "disk_type_ids": [
    "string"
  ],
  "cores": "int64",
  "memory": "int64",
  "type": "Type",
  "host_count_divider": "int64",
  "max_segment_in_host_count": "int64"
}
```

A preset of resources for hardware configuration of Greenplum® hosts.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zone_ids[] | **string**

IDs of availability zones where the resource preset is available. ||
|| disk_type_ids[] | **string**

IDs of availability disk types available in the resource preset. ||
|| cores | **int64**

Number of CPU cores for a Greenplum® host created with the preset. ||
|| memory | **int64**

RAM volume for a Greenplum® host created with the preset, in bytes. ||
|| type | enum **Type**

Host type.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|| host_count_divider | **int64**

The number of hosts must be divisible by `host_count_divider`. ||
|| max_segment_in_host_count | **int64**

Maximum number of segments in segment host. ||
|#