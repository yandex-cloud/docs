---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/FolderBudget/get.md
---


# Method get
Returns the specified folder budget.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.api.cloud.yandex.net/datasphere/v1/folders/{folderId}:budget
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to get a budget for.  The maximum string length in characters is 50.
 
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