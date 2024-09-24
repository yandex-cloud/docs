---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/index.md
---

# Workflows Service, REST: Execution methods
Set of methods for managing Workflows Executions.
## JSON Representation {#representation}
```json 
{
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
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Workflow execution. Generated at creation time.</p> 
workflowId | **string**<br><p>ID of the Workflow.</p> 
input | **object**<br><p>Input data for the Workflow execution.</p> 
input.<br>inputJson | **string**<br><p>JSON input data for the Workflow execution.</p> 
result | **object**<br><p>Result of the Workflow execution.</p> 
result.<br>resultJson | **string**<br><p>JSON result of the Workflow execution.</p> 
error | **object**<br><p>Error details, in case Workflow execution failed.</p> 
error.<br>message | **string**<br><p>Error message of the Workflow execution.</p> 
error.<br>errorCode | **string**<br><p>Error code of the Workflow execution.</p> 
status | **string**<br><p>Status of the Workflow execution</p> <ul> <li>QUEUED: Workflow execution is being queued.</li> <li>RUNNING: Workflow execution is running.</li> <li>PAUSED: Workflow execution is being paused.</li> <li>STOPPED: Workflow execution is stopped.</li> <li>FAILED: Workflow execution is failed.</li> <li>FINISHED: Workflow execution is finished.</li> </ul> 
startedAt | **string** (date-time)<br><p>Start timestamp for the Workflow execution.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
duration | **string**<br><p>Duration of the Workflow execution.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Retrieves specified Workflow execution.
[getHistory](getHistory.md) | Retrieves detailed history of specified Workflow execution.
[list](list.md) | Retrieves list of Workflow executions.
[start](start.md) | Starts new Workflow execution.
[stop](stop.md) | Stops specified Workflow execution.