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
  "diskTypeIds": [
    "string"
  ],
  "cores": "string",
  "memory": "string",
  "type": "string",
  "hostCountDivider": "string",
  "maxSegmentInHostCount": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
diskTypeIds[] | **string**<br><p>IDs of availability disk types available in the resource preset.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Greenplum host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Greenplum host created with the preset, in bytes.</p> 
type | **string**<br><p>Host type</p> <ul> <li>MASTER: Greenplum master host.</li> <li>SEGMENT: Greenplum segment host.</li> </ul> 
hostCountDivider | **string** (int64)<br><p>The number of hosts must be divisible by host_count_divider</p> 
maxSegmentInHostCount | **string** (int64)<br><p>Max segment count in host (actual only for segment host)</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified resource preset.
[list](list.md) | Retrieves the list of available resource presets.