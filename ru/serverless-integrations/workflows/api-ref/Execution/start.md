---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/start.md
---

# Workflows Service, REST: Execution.start
Starts new Workflow execution.
 

 
## HTTP request {#https-request}
```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/start
```
 
## Body parameters {#body_params}
 
```json 
{
  "workflowId": "string",
  "input": {
    "inputJson": "string"
  }
}
```

 
Field | Description
--- | ---
workflowId | **string**<br><p>Required. ID of the Workflow.</p> 
input | **object**<br><p>Input for the Workflow execution</p> 
input.<br>inputJson | **string**<br><p>JSON input data for the Workflow execution.</p> 
 
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