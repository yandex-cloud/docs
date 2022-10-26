---
editable: false
sourcePath: en/_api-ref/compute/api-ref/SnapshotSchedule/update.md
---

# Method update
Updates the specified snapshot schedule.
 
The schedule is updated only after all snapshot creations and deletions triggered by the schedule are completed.
 
## HTTP request {#https-request}
```
PATCH https://compute.{{ api-host }}/compute/v1/snapshotSchedules/{snapshotScheduleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
snapshotScheduleId | <p>ID of the snapshot schedule to update.</p> <p>To get the snapshot schedule ID, make a <a href="/docs/compute/api-ref/SnapshotSchedule/list">list</a> request.</p> 
 
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
updateMask | **string**<br>Field mask that specifies which attributes of the snapshot schedule should be updated.
name | **string**<br><p>New name for the snapshot schedule.</p> <p>The name must be unique within the folder.</p> 
description | **string**<br><p>New description of the snapshot schedule.</p> 
labels | **object**<br><p>Snapshot schedule labels as ``key:value`` pairs.</p> <p>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label:</p> <ol> <li>Get the current set of labels with a <a href="/docs/compute/api-ref/SnapshotSchedule/get">get</a> request.</li> <li>Add or remove a label in this set.</li> <li>Send the new set in this field.</li> </ol> 
schedulePolicy | **object**<br>New frequency settings of the snapshot schedule.
schedulePolicy.<br>startAt | **string** (date-time)<br><p>Timestamp for creating the first snapshot.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
schedulePolicy.<br>expression | **string**<br><p>Cron expression for the snapshot schedule (UTC+0).</p> <p>The expression must consist of five fields (``Minutes Hours Day-of-month Month Day-of-week``) or be one of nonstandard predefined expressions (e.g. ``@hourly``). For details about the format, see <a href="/docs/compute/concepts/snapshot-schedule#cron">documentation</a></p> 
snapshotSpec | **object**<br>New attributes of snapshots created by the snapshot schedule.
snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSpec.<br>labels | **object**<br><p>Snapshot labels as ``key:value`` pairs.</p> 
retentionPeriod | **string** <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br><br><p>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted.</p> 
snapshotCount | **string** (int64) <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br><br><p>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on.</p> 
 
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