---
editable: false
sourcePath: en/_api-ref/mdb/sqlserver/api-ref/ResourcePreset/get.md
---

# Method get
Returns the specified resource preset.
 
To get the list of available resource presets, make a [list](/docs/managed-sqlserver/api-ref/ResourcePreset/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/mdb/sqlserver/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | <p>Required. ID of the resource preset to return.</p> <p>To get the resource preset ID, use a <a href="/docs/managed-sqlserver/api-ref/ResourcePreset/list">list</a> request.</p> 
 
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
A preset of resources for hardware configuration of SQL Server hosts.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for an SQL Server host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for an SQL Server host created with the preset, in bytes.</p> 