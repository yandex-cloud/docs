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
resourcePresetId | <p>Required. Required. ID of the resource preset to return.</p> 
 
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
id | **string**
cores | **string** (int64)
memory | **string** (int64)