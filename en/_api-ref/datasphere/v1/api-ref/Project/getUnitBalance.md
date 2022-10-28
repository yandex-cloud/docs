---
editable: false
---

# Method getUnitBalance
Returns the unit balance of the specified project.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v1/projects/{projectId}:unitBalance
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the project to return the unit balance for.</p> <p>The maximum string length in characters is 200.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "unitBalance": "integer"
}
```

 
Field | Description
--- | ---
unitBalance | **integer** (int64)<br><p>The number of units available to the project.</p> 