---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Execution/list.md
---

# Workflows Service, REST: Execution.list
Retrieves list of Workflow executions.
 

 
## HTTP request {#https-request}
```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/execution
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
workflowId | <p>Required. ID of the Workflow.</p> 
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/workflows/api-ref/Execution/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/workflows/api-ref/Execution/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can be applied to the following fields: status, started_at, finished_at.</li> <li>Operator: ``=``, ``<`` or ``>``.</li> <li>The value. Must be sting and match the regular expression ``[+:\.-a-z0-9]``. Examples of a filter: ``status=ERROR``, ``created_by=John.Doe``.</li> </ol> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "executions": [
    {
      "id": "string",
      "workflowId": "string",
      "status": "string",
      "startedAt": "string",
      "duration": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
executions[] | **object**<br><p>List of Workflow executions.</p> 
executions[].<br>id | **string**<br><p>ID of the Workflow execution. Generated at creation time.</p> 
executions[].<br>workflowId | **string**<br><p>ID of the Workflow.</p> 
executions[].<br>status | **string**<br><p>Status of the Workflow execution</p> <ul> <li>QUEUED: Workflow execution is being queued.</li> <li>RUNNING: Workflow execution is running.</li> <li>PAUSED: Workflow execution is being paused.</li> <li>STOPPED: Workflow execution is stopped.</li> <li>FAILED: Workflow execution is failed.</li> <li>FINISHED: Workflow execution is finished.</li> </ul> 
executions[].<br>startedAt | **string** (date-time)<br><p>Start timestamp for the Workflow execution.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
executions[].<br>duration | **string**<br><p>Duration of the Workflow execution.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/workflows/api-ref/Execution/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/functions/workflows/api-ref/Execution/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 