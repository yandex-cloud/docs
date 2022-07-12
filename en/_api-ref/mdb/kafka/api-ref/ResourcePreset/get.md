---
editable: false
---

# Method get
Returns the specified resource preset.
 
To get the list of available resource presets, make a [list](/docs/managed-kafka/api-ref/ResourcePreset/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-kafka/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | <p>Required. ID of the resource preset to return.</p> <p>To get the resource preset ID, use a <a href="/docs/managed-kafka/api-ref/ResourcePreset/list">list</a> request.</p> 
 
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
A ResourcePreset resource for describing hardware configuration presets.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Kafka broker created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Kafka broker created with the preset, in bytes.</p> 