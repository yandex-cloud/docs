---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/ResourcePreset/get.md
---

# Managed Service for Apache Kafka® API, gRPC: ResourcePresetService.Get

Returns the specified resource preset.

To get the list of available resource presets, make a [List](/docs/managed-kafka/api-ref/grpc/ResourcePreset/list#List) request.

## gRPC request

**rpc Get ([GetResourcePresetRequest](#yandex.cloud.mdb.kafka.v1.GetResourcePresetRequest)) returns ([ResourcePreset](#yandex.cloud.mdb.kafka.v1.ResourcePreset))**

## GetResourcePresetRequest {#yandex.cloud.mdb.kafka.v1.GetResourcePresetRequest}

```json
{
  "resource_preset_id": "string"
}
```

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the resource preset to return.

To get the resource preset ID, use a [ResourcePresetService.List](/docs/managed-kafka/api-ref/grpc/ResourcePreset/list#List) request. ||
|#

## ResourcePreset {#yandex.cloud.mdb.kafka.v1.ResourcePreset}

```json
{
  "id": "string",
  "zone_ids": [
    "string"
  ],
  "cores": "int64",
  "memory": "int64"
}
```

A ResourcePreset resource for describing hardware configuration presets.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zone_ids[] | **string**

IDs of availability zones where the resource preset is available. ||
|| cores | **int64**

Number of CPU cores for a Kafka broker created with the preset. ||
|| memory | **int64**

RAM volume for a Kafka broker created with the preset, in bytes. ||
|#