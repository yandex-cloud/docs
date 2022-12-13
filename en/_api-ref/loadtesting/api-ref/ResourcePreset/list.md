---
editable: false
---

# Load Testing API, REST: ResourcePreset.list
Retrieves the list of resource presets.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v1/resourcepresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resourcePresets": [
    {
      "presetId": "string",
      "name": "string",
      "description": "string",
      "cores": "string",
      "memory": "string",
      "diskSize": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resourcePresets[] | **object**<br><p>A ResourcePreset resource for describing VM configuration presets for TankInstance.</p> 
resourcePresets[].<br>presetId | **string**<br><p>ID of the ResourcePreset resource.</p> 
resourcePresets[].<br>name | **string**<br><p>Name of the ResourcePreset resource.</p> 
resourcePresets[].<br>description | **string**<br><p>Description of the ResourcePreset resource.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a Tank created with the preset.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a Tank created with the preset, in bytes.</p> 
resourcePresets[].<br>diskSize | **string** (int64)<br><p>Disk size for a tank created with the preset, in bytes.</p> 
nextPageToken | **string**