---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/ResourcePreset/get.md
---

# Managed Service for MySQL API, gRPC: ResourcePresetService.Get {#Get}

Retrieves information about a resource preset.

## gRPC request

**rpc Get ([GetResourcePresetRequest](#yandex.cloud.mdb.mysql.v1.GetResourcePresetRequest)) returns ([ResourcePreset](#yandex.cloud.mdb.mysql.v1.ResourcePreset))**

## GetResourcePresetRequest {#yandex.cloud.mdb.mysql.v1.GetResourcePresetRequest}

```json
{
  "resourcePresetId": "string"
}
```

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return information about.

To get this ID, make a [ResourcePresetService.List](/docs/managed-mysql/api-ref/grpc/ResourcePreset/list#List) request. ||
|#

## ResourcePreset {#yandex.cloud.mdb.mysql.v1.ResourcePreset}

```json
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "cores": "int64",
  "memory": "int64"
}
```

An object that represents MySQL resource preset.
A resource preset defines hardware configuration for cluster hosts.

See [the documentation](/docs/managed-mysql/concepts/instance-types) for details.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| cores | **int64**

Number of CPU cores for a MySQL host created with the preset. ||
|| memory | **int64**

RAM volume for a MySQL host created with the preset, in bytes. ||
|#