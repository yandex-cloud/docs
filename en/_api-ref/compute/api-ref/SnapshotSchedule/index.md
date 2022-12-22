---
editable: false
---

# Compute Cloud API, REST: SnapshotSchedule methods
A set of methods for managing snapshot schedules.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
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
id | **string**<br><p>ID of the snapshot schedule.</p> 
folderId | **string**<br><p>ID of the folder that the snapshot schedule belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the snapshot schedule.</p> <p>The name is unique within the folder.</p> 
description | **string**<br><p>Description of the snapshot schedule.</p> 
labels | **object**<br><p>Snapshot schedule labels as ``key:value`` pairs.</p> 
status | **string**<br>Status of the snapshot schedule.<br><ul> <li>CREATING: The snapshot schedule is being created.</li> <li>ACTIVE: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy] is specified).</li> <li>INACTIVE: The schedule is interrupted, snapshots won't be created or deleted.</li> <li>DELETING: The schedule is being deleted.</li> <li>UPDATING: Changes are being made to snapshot schedule settings or a list of attached disks.</li> </ul> 
schedulePolicy | **object**<br><p>A resource for frequency settings of a snapshot schedule.</p> 
schedulePolicy.<br>startAt | **string** (date-time)<br><p>Timestamp for creating the first snapshot.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
schedulePolicy.<br>expression | **string**<br><p>Cron expression for the snapshot schedule (UTC+0).</p> <p>The expression must consist of five fields (``Minutes Hours Day-of-month Month Day-of-week``) or be one of nonstandard predefined expressions (e.g. ``@hourly``). For details about the format, see <a href="/docs/compute/concepts/snapshot-schedule#cron">documentation</a></p> 
snapshotSpec | **object**<br><p>A resource for attributes of snapshots created by the snapshot schedule.</p> 
snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSpec.<br>labels | **object**<br><p>Snapshot labels as ``key:value`` pairs.</p> 
retentionPeriod | **string** <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br><br><p>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted.</p> 
snapshotCount | **string** (int64) <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br><br><p>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a snapshot schedule in the specified folder.
[delete](delete.md) | Deletes the specified snapshot schedule.
[disable](disable.md) | Disables the specified snapshot schedule.
[enable](enable.md) | Enables the specified snapshot schedule.
[get](get.md) | Returns the specified snapshot schedule.
[list](list.md) | Retrieves the list of snapshot schedules in the specified folder.
[listDisks](listDisks.md) | Retrieves the list of disks attached to the specified snapshot schedule.
[listOperations](listOperations.md) | Lists operations for the specified snapshot schedule.
[listSnapshots](listSnapshots.md) | Retrieves the list of snapshots created by the specified snapshot schedule.
[update](update.md) | Updates the specified snapshot schedule.
[updateDisks](updateDisks.md) | Updates the list of disks attached to the specified schedule.