---
editable: false
---

# ResourcePreset
A set of methods for managing resource presets.
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
zoneIds[] | **string**<br><p>IDs of the availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of the CPU cores for an OpenSearch host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for an OpenSearch host created with the preset, in bytes.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified resource preset.
[list](list.md) | Retrieves the list of available resource presets.