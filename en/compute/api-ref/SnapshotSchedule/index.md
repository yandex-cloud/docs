---
editable: false
sourcePath: en/_api-ref/compute/api-ref/SnapshotSchedule/index.md
---

# SnapshotSchedule
A set of methods for managing SnapshotSchedule resources.
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
id | **string**<br><p>ID of the snapshot schedule policy.</p> 
folderId | **string**<br><p>ID of the folder that the scheduler policy belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the schedule policy. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the schedule policy.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
status | **string**
schedulePolicy | **object**
schedulePolicy.<br>startAt | **string** (date-time)<br><p>start time for the first run.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
schedulePolicy.<br>expression | **string**<br><p>cron format (* * * * *)</p> 
snapshotSpec | **object**<br><p>Properties of created snapshot backup</p> 
snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSpec.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
retentionPeriod | **string** <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br>
snapshotCount | **string** (int64) <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a snapshot schedule in the specified folder.
[delete](delete.md) | Deletes the specified snapshot schedule.
[disable](disable.md) | Disable schedule sets status InActive.
[enable](enable.md) | Enable schedule sets status Active.
[get](get.md) | Returns the specified SnapshotSchedule resource.
[list](list.md) | Retrieves the list of SnapshotSchedule resources in the specified folder.
[listDisks](listDisks.md) | List disks that belong to schedule.
[listOperations](listOperations.md) | Lists operations for the specified snapshot schedule.
[listSnapshots](listSnapshots.md) | List snapshot created by schedule.
[update](update.md) | Updates the specified snapshot schedule.
[updateDisks](updateDisks.md) | UpdateDisks of schedule