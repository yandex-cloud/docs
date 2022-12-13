---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/ResourcePreset/index.md
---

# Managed Service for MySQL API, REST: ResourcePreset methods
A set of methods for managing MySQL resource presets.

See [the documentation](/docs/managed-mysql/concepts/instance-types) for details.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a MySQL host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a MySQL host created with the preset, in bytes.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Retrieves information about a resource preset.
[list](list.md) | Retrieves the list of available resource presets.