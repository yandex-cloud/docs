---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/ResourcePreset/get.md
---

# Managed Service for MySQL API, REST: ResourcePreset.Get

Retrieves information about a resource preset.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/resourcePresets/{resourcePresetId}
```

## Path parameters

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the resource preset to return information about.

To get this ID, make a [ResourcePresetService.List](/docs/managed-mysql/api-ref/ResourcePreset/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.ResourcePreset}

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

An object that represents MySQL resource preset.
A resource preset defines hardware configuration for cluster hosts.

See [the documentation](/docs/managed-mysql/concepts/instance-types) for details.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| cores | **string** (int64)

Number of CPU cores for a MySQL host created with the preset. ||
|| memory | **string** (int64)

RAM volume for a MySQL host created with the preset, in bytes. ||
|#