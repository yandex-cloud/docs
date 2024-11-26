---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/ResourcePreset/get.md
---

# Managed Service for YDB API, gRPC: ResourcePresetService.Get

Returns the specified resource preset.

## gRPC request

**rpc Get ([GetResourcePresetRequest](#yandex.cloud.ydb.v1.GetResourcePresetRequest)) returns ([ResourcePreset](#yandex.cloud.ydb.v1.ResourcePreset))**

## GetResourcePresetRequest {#yandex.cloud.ydb.v1.GetResourcePresetRequest}

```json
{
  "resource_preset_id": "string"
}
```

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. Required. ID of the resource preset to return. ||
|#

## ResourcePreset {#yandex.cloud.ydb.v1.ResourcePreset}

```json
{
  "id": "string",
  "cores": "int64",
  "memory": "int64"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| cores | **int64** ||
|| memory | **int64** ||
|#