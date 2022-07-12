---
editable: false
---

# Method get
Returns the specified resource preset.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v1/resourcepresets/{presetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
presetId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A ResourcePreset resource for describing VM configuration presets for TankInstance.
 
Field | Description
--- | ---
presetId | **string**<br><p>ID of the ResourcePreset resource.</p> 
name | **string**<br><p>Name of the ResourcePreset resource.</p> 
description | **string**<br><p>Description of the ResourcePreset resource.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Tank created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Tank created with the preset, in bytes.</p> 
diskSize | **string** (int64)<br><p>Disk size for a tank created with the preset, in bytes.</p> 