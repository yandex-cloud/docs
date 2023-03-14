---
editable: false
---

# Cloud Backup API, REST: Resource.listTasks
List tasks of resources.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/resources/{computeInstanceId}/tasks
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
computeInstanceId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum value is 1000.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "tasks": [
    {
      "id": "string",
      "cancellable": true,
      "policyId": "string",
      "type": "string",
      "progress": {
        "current": "string",
        "total": "string"
      },
      "status": "string",
      "enqueuedAt": "string",
      "startedAt": "string",
      "updatedAt": "string",
      "completedAt": "string",
      "computeInstanceId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
tasks[] | **object**
tasks[].<br>id | **string** (int64)
tasks[].<br>cancellable | **boolean** (boolean)<br><p>Shows whether the task is cancellable. Note: task cancellation not suppported yet.</p> 
tasks[].<br>policyId | **string**
tasks[].<br>type | **string**
tasks[].<br>progress | **object**
tasks[].<br>progress.<br>current | **string** (int64)
tasks[].<br>progress.<br>total | **string** (int64)
tasks[].<br>status | **string**<br><p>Status of task.</p> 
tasks[].<br>enqueuedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tasks[].<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tasks[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tasks[].<br>completedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tasks[].<br>computeInstanceId | **string**
nextPageToken | **string**