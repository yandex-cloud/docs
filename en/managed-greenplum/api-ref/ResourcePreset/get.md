---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/api-ref/ResourcePreset/get.md
---

# Method get
Returns the specified resource preset.
 
To get the list of available resource presets, make a [list](/docs/managed-greenplum/api-ref/ResourcePreset/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | <p>Required. ID of the resource preset to return.</p> <p>To get the resource preset ID, use a <a href="/docs/managed-greenplum/api-ref/ResourcePreset/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
type | <p>Required. Required. ResourcePreset type - master or segment.</p> <ul> <li>MASTER: Greenplum® master host.</li> <li>SEGMENT: Greenplum® segment host.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A preset of resources for hardware configuration of Greenplum® hosts.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource preset.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
diskTypeIds[] | **string**<br><p>IDs of availability disk types available in the resource preset.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Greenplum® host created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Greenplum® host created with the preset, in bytes.</p> 
type | **string**<br><p>Host type.</p> <ul> <li>MASTER: Greenplum® master host.</li> <li>SEGMENT: Greenplum® segment host.</li> </ul> 
hostCountDivider | **string** (int64)<br><p>The number of hosts must be divisible by <a href="/docs/managed-greenplum/api-ref/ResourcePreset#representation">hostCountDivider</a>.</p> 
maxSegmentInHostCount | **string** (int64)<br><p>Maximum number of segments in segment host.</p> 