---
editable: false
---

# Method get
Returns the specified SnapshotSchedule resource.
 
To get the list of available SnapshotSchedule resources, make a [list](/docs/compute/api-ref/SnapshotSchedule/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/snapshotSchedules/{snapshotScheduleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
snapshotScheduleId | <p>ID of the SnapshotSchedule resource to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
schedulePolicy | **object**<br>schedule properties
schedulePolicy.<br>startAt | **string** (date-time)<br><p>start time for the first run.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
schedulePolicy.<br>expression | **string**<br><p>cron format (* * * * *)</p> 
snapshotSpec | **object**<br>properties to create snapshot with.
snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSpec.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
retentionPeriod | **string** <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br>
snapshotCount | **string** (int64) <br> includes only one of the fields `retentionPeriod`, `snapshotCount`<br>