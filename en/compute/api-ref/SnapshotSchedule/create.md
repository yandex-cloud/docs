---
editable: false
sourcePath: en/_api-ref/compute/api-ref/SnapshotSchedule/create.md
---

# Compute Cloud API, REST: SnapshotSchedule.create
Creates a snapshot schedule in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://compute.{{ api-host }}/compute/v1/snapshotSchedules
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
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
  "diskIds": [
    "string"
  ],

  //  includes only one of the fields `retentionPeriod`, `snapshotCount`
  "retentionPeriod": "string",
  "snapshotCount": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder to create a snapshot schedule in.</p> <p>Snapshots are created in the same folder as the schedule, even if disks from other folders are attached to the schedule.</p> <p>To get a folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the snapshot schedule.</p> <p>The name must be unique within the folder.</p> 
description | **string**<br><p>Description of the snapshot schedule.</p> 
labels | **object**<br><p>Snapshot schedule labels as ``key:value`` pairs.</p> 
schedulePolicy | **object**<br>Frequency settings of the snapshot schedule.
schedulePolicy.<br>startAt | **string** (date-time)<br><p>Timestamp for creating the first snapshot.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
schedulePolicy.<br>expression | **string**<br><p>Cron expression for the snapshot schedule (UTC+0).</p> <p>The expression must consist of five fields (``Minutes Hours Day-of-month Month Day-of-week``) or be one of nonstandard predefined expressions (e.g. ``@hourly``). For details about the format, see <a href="/docs/compute/concepts/snapshot-schedule#cron">documentation</a></p> 
snapshotSpec | **object**<br>Attributes of snapshots created by the snapshot schedule.
snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSpec.<br>labels | **object**<br><p>Snapshot labels as ``key:value`` pairs.</p> 
diskIds[] | **string**<br><p>List of IDs of the disks attached to the snapshot schedule.</p> <p>To get a disk ID, make a <a href="/docs/compute/api-ref/Disk/list">list</a> request.</p> 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 