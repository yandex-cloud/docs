---
editable: false
---

# DataSphere API v1, REST: Project.setUnitBalance
Sets the unit balance of the specified project.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.{{ api-host }}/datasphere/v1/projects/{projectId}:unitBalance
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the project to set the unit balance for.</p> <p>The maximum string length in characters is 200.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "unitBalance": "integer"
}
```

 
Field | Description
--- | ---
unitBalance | **integer** (int64)<br><p>The number of units available to the project.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 