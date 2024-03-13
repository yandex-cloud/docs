---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/getStateVariables.md
---

# DataSphere API v2, REST: Project.getStateVariables
Returns state variables of the specified notebook.
Deprecated
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:stateVariables
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the project, for which to return state variables.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
notebookId | <p>Required. ID of the notebook, for which to return state variables.</p> <p>The maximum string length in characters is 200.</p> 
variableNames | <p>Names of variables to return.</p> 
checkpointId | <p>ID of the checkpoint, for which to return state variables.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "variables": "object"
}
```

 
Field | Description
--- | ---
variables | **object**<br><p>Values of the specified variables.</p> 