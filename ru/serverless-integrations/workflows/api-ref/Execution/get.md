---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/get.md
---

# Workflows Service, REST: Execution.get
Retrieves specified Workflow execution.
 

 
## HTTP request {#https-request}
```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
executionId | <p>Required. ID of the Workflow execution.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "execution": {
    "id": "string",
    "workflowId": "string",
    "input": {
      "inputJson": "string"
    },
    "result": {
      "resultJson": "string"
    },
    "error": {
      "message": "string",
      "errorCode": "string"
    },
    "status": "string",
    "startedAt": "string",
    "duration": "string"
  }
}
```

 
Field | Description
--- | ---
execution | **object**<br><p>Workflow execution details.</p> 
execution.<br>id | **string**<br><p>ID of the Workflow execution. Generated at creation time.</p> 
execution.<br>workflowId | **string**<br><p>ID of the Workflow.</p> 
execution.<br>input | **object**<br><p>Input data for the Workflow execution.</p> 
execution.<br>input.<br>inputJson | **string**<br><p>JSON input data for the Workflow execution.</p> 
execution.<br>result | **object**<br><p>Result of the Workflow execution.</p> 
execution.<br>result.<br>resultJson | **string**<br><p>JSON result of the Workflow execution.</p> 
execution.<br>error | **object**<br><p>Error details, in case Workflow execution failed.</p> 
execution.<br>error.<br>message | **string**<br><p>Error message of the Workflow execution.</p> 
execution.<br>error.<br>errorCode | **string**<br><p>Error code of the Workflow execution.</p> 
execution.<br>status | **string**<br><p>Status of the Workflow execution</p> <ul> <li>QUEUED: Workflow execution is being queued.</li> <li>RUNNING: Workflow execution is running.</li> <li>PAUSED: Workflow execution is being paused.</li> <li>STOPPED: Workflow execution is stopped.</li> <li>FAILED: Workflow execution is failed.</li> <li>FINISHED: Workflow execution is finished.</li> </ul> 
execution.<br>startedAt | **string** (date-time)<br><p>Start timestamp for the Workflow execution.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
execution.<br>duration | **string**<br><p>Duration of the Workflow execution.</p> 