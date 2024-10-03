---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/getHistory.md
---

# Workflows Service, REST: Execution.getHistory
Retrieves detailed history of specified Workflow execution.
 

 
## HTTP request {#https-request}
```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{executionId}/history
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
    "status": "string",
    "startedAt": "string",
    "duration": "string"
  },
  "entries": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "startedAt": "string",
      "duration": "string",
      "input": {
        "inputJson": "string"
      },
      "output": {
        "outputJson": "string"
      },
      "error": {
        "message": "string",
        "errorCode": "string"
      },
      "status": "string",
      "type": "string",
      "attempts": "string",
      "lastError": {
        "message": "string",
        "errorCode": "string"
      }
    }
  ]
}
```

 
Field | Description
--- | ---
execution | **object**<br><p>Workflow execution details.</p> 
execution.<br>id | **string**<br><p>ID of the Workflow execution. Generated at creation time.</p> 
execution.<br>workflowId | **string**<br><p>ID of the Workflow.</p> 
execution.<br>status | **string**<br><p>Status of the Workflow execution</p> <ul> <li>QUEUED: Workflow execution is being queued.</li> <li>RUNNING: Workflow execution is running.</li> <li>PAUSED: Workflow execution is being paused.</li> <li>STOPPED: Workflow execution is stopped.</li> <li>FAILED: Workflow execution is failed.</li> <li>FINISHED: Workflow execution is finished.</li> </ul> 
execution.<br>startedAt | **string** (date-time)<br><p>Start timestamp for the Workflow execution.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
execution.<br>duration | **string**<br><p>Duration of the Workflow execution.</p> 
entries[] | **object**<br><p>Required. Workflow execution detailed history items.</p> <p>Must contain at least one element.</p> 
entries[].<br>id | **string**<br><p>ID of the Workflow step.</p> 
entries[].<br>title | **string**<br><p>Title of the Workflow step.</p> 
entries[].<br>description | **string**<br><p>Description of the Workflow step.</p> 
entries[].<br>startedAt | **string** (date-time)<br><p>Start timestamp for the Workflow step.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
entries[].<br>duration | **string**<br><p>Duration of the Workflow step.</p> 
entries[].<br>input | **object**<br><p>Input data for the Workflow step.</p> 
entries[].<br>input.<br>inputJson | **string**<br><p>JSON input data for the Workflow step.</p> 
entries[].<br>output | **object**<br><p>Result of the Workflow step.</p> 
entries[].<br>output.<br>outputJson | **string**<br><p>JSON result for the Workflow step.</p> 
entries[].<br>error | **object**<br><p>Error details, in case Workflow step failed.</p> 
entries[].<br>error.<br>message | **string**<br><p>Error message of the Workflow step.</p> 
entries[].<br>error.<br>errorCode | **string**<br><p>Error code of the Workflow step.</p> 
entries[].<br>status | **string**<br><p>Status of the Workflow step.</p> <ul> <li>SCHEDULED: Step execution is being scheduled.</li> <li>STARTED: Step execution is started.</li> <li>COMPLETED: Step execution is completed.</li> <li>FAILED: Step execution is failed.</li> <li>CANCEL_REQUESTED: Step execution is requested to be cancelled.</li> <li>CANCELLED: Step execution is canceled.</li> </ul> 
entries[].<br>type | **string**<br><p>Type of the Workflow step (for example, FunctionCall or HttpCall).</p> 
entries[].<br>attempts | **string** (int64)<br><p>Number of attempts (including all retries of unsuccessful attempts). Value "1" means there were no retries.</p> 
entries[].<br>lastError | **object**<br><p>Last received error details in case of retries.</p> 
entries[].<br>lastError.<br>message | **string**<br><p>Error message of the Workflow step.</p> 
entries[].<br>lastError.<br>errorCode | **string**<br><p>Error code of the Workflow step.</p> 