---
editable: false
---

# ResourcePreset

## JSON Representation {#representation}
```json 
{
  "presetId": "string",
  "name": "string",
  "description": "string",
  "cores": "string",
  "memory": "string",
  "diskSize": "string"
}
```
 
Field | Description
--- | ---
presetId | **string**<br><p>ID of the ResourcePreset resource.</p> 
name | **string**<br><p>Name of the ResourcePreset resource.</p> 
description | **string**<br><p>Description of the ResourcePreset resource.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Tank created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Tank created with the preset, in bytes.</p> 
diskSize | **string** (int64)<br><p>Disk size for a tank created with the preset, in bytes.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified resource preset.
[list](list.md) | Retrieves the list of resource presets.