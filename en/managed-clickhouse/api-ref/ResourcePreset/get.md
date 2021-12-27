---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/api-ref/ResourcePreset/get.md
---


# Method get
Returns the specified ResourcePreset resource.
 
To get the list of available ResourcePreset resources, make a [list](/docs/managed-clickhouse/api-ref/ResourcePreset/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | Required. ID of the resource preset to return. To get the resource preset ID, use a [list](/docs/managed-clickhouse/api-ref/ResourcePreset/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the ResourcePreset resource.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a ClickHouse host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a ClickHouse host created with the preset, in bytes.</p> 