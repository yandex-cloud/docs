---
editable: false
---

# ResourcePreset
A set of methods for working with resource presets.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
memory | **string** (int64)<br><p>RAM volume for a Redis host created with the preset, in bytes.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Redis host created with the preset.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified resource preset.
[list](list.md) | Retrieves the list of available resource presets.