---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/ResourcePreset/index.md
---

# Managed Service for Elasticsearch API, REST: ResourcePreset methods
A set of methods for managing Elasticsearch resource presets.
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
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for an Elasticsearch node created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for an Elasticsearch node created with the preset, in bytes.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified resource preset.
[list](list.md) | Retrieves the list of available resource presets.