---
editable: false
---

# Method set
Sets the unit balance and the limits of the specified folder budget.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.{{ api-host }}/datasphere/v1/folders/{folderId}:budget
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to set a budget for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "setMask": "string",
  "unitBalance": "integer",
  "maxUnitsPerHour": "integer",
  "maxUnitsPerExecution": "integer"
}
```

 
Field | Description
--- | ---
setMask | **string**<br><p>Field mask that specifies which fields of the budget are going to be set.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
unitBalance | **integer** (int64)<br><p>The number of units available in the folder.</p> 
maxUnitsPerHour | **integer** (int64)<br><p>The number of units that can be spent per hour.</p> 
maxUnitsPerExecution | **integer** (int64)<br><p>The number of units that can be spent on one execution.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 