---
editable: false
---

# Method get
Returns the specified folder budget.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v1/folders/{folderId}:budget
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to get a budget for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "unitBalance": "integer",
  "maxUnitsPerHour": "integer",
  "maxUnitsPerExecution": "integer"
}
```

 
Field | Description
--- | ---
unitBalance | **integer** (int64)<br><p>The number of units available in the folder.</p> 
maxUnitsPerHour | **integer** (int64)<br><p>The number of units that can be spent per hour.</p> 
maxUnitsPerExecution | **integer** (int64)<br><p>The number of units that can be spent on one execution.</p> 