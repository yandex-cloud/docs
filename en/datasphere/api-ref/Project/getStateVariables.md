---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/Project/getStateVariables.md
---


# Method getStateVariables
Returns state variables of the specified notebook.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.api.cloud.yandex.net/datasphere/v1/projects/{projectId}:stateVariables
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | Required. ID of the project, for which to return state variables.  The maximum string length in characters is 200.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
notebookId | Required. ID of the notebook, for which to return state variables.  The maximum string length in characters is 200.
variableNames | Names of variables to return.
checkpointId | ID of the checkpoint, for which to return state variables.
 
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