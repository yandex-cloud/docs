---
editable: false
---

# Method get
Returns the specified resource preset.
 
To get the list of available resource presets, make a [list](/docs/managed-redis/api-ref/ResourcePreset/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | Required. ID of the resource preset to return. To get the resource preset ID, use a [list](/docs/managed-redis/api-ref/ResourcePreset/list) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "memory": "string",
  "cores": "string"
}
```
A resource preset that describes hardware configuration for a host.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
memory | **string** (int64)<br><p>RAM volume for a Redis host created with the preset, in bytes.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Redis host created with the preset.</p> 