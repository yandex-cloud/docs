---
editable: false
sourcePath: en/_api-ref/ydb/api-ref/ResourcePreset/get.md
---

# Method get
Returns the specified resource preset.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/resourcePresets/{resourcePresetId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourcePresetId | Required. Required. ID of the resource preset to return.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "cores": "string",
  "memory": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br>
cores | **string** (int64)<br>
memory | **string** (int64)<br>