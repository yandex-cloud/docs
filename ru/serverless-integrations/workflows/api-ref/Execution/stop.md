---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/stop.md
---

# Workflows Service, REST: Execution.stop
Stops specified Workflow execution.
 

 
## HTTP request {#https-request}
```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}/stop
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
executionId | <p>Required. ID of the Workflow execution.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "executionId": "string"
}
```

 
Field | Description
--- | ---
executionId | **string**<br><p>ID of the Workflow execution.</p> 