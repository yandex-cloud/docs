---
editable: false
sourcePath: en/_api-ref/compute/api-ref/SnapshotSchedule/update.md
---

# Method update
Updates the specified snapshot schedule.
 

 
## HTTP request {#https-request}
```
PATCH https://compute.{{ api-host }}/compute/v1/snapshotSchedules/{snapshotScheduleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
snapshotScheduleId | <p>ID of the SnapshotSchedule resource to update.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "schedulePolicy": {
    "startAt": "string",
    "expression": "string"
  },
  "snapshotSpec": {
    "description": "string",
    "labels": "object"
  },

  //  includes only one of the fields `retentionPeriod`, `snapshotCount`
  "retentionPeriod": "string",
  "snapshotCount": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
updateMask | **string**<br>Field mask that specifies which fields of the SnapshotSchedule resource are going to be updated.
name | **string**<br><p>schedule properties</p> 
description | **string**
labels | **object**
schedulePolicy | **object**<br>schedule properties
schedulePolicy.<br>startAt | **string** (date-time)<br><p>start time for the first run.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
schedulePolicy.<br>expression | **string**<br><p>cron format (* * * * *)</p> 
snapshotSpec | **object**<br>properties to create snapshot with.
snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSpec.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
retentionPeriod | **string** <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br>
snapshotCount | **string** (int64) <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 