---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/ResourcePreset/get.md
---

# Method get
Retrieves information about a resource preset.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-mysql/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | <p>Required. ID of the resource preset to return information about.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> request.</p> 
 
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
An object that represents MySQL resource preset.
A resource preset defines hardware configuration for cluster hosts.

See [the documentation](/docs/managed-mysql/concepts/instance-types) for details.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a MySQL host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a MySQL host created with the preset, in bytes.</p> 