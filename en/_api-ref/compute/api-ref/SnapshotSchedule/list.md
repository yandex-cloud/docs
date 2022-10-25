---
editable: false
---

# Method list
Retrieves the list of snapshot schedules in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/snapshotSchedules
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list snapshot schedules in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/compute/api-ref/SnapshotSchedule/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/compute/api-ref/SnapshotSchedule/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters snapshot schedules listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/compute/api-ref/SnapshotSchedule#representation">SnapshotSchedule.name</a> field.</li> <li>An operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be 3-63 characters long and match the regular expression ``^[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-schedule``.</li> </ol> 
orderBy | <p>A sorting expression that sorts snapshot schedules listed in the response.</p> <p>The expression must specify the field name from <a href="/docs/compute/api-ref/SnapshotSchedule#representation">SnapshotSchedule</a> and ``asc``ending or ``desc``ending order, e.g. ``createdAt desc``.</p> <p>Default value: ``id asc``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "snapshotSchedules": [
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

      // `snapshotSchedules[]` includes only one of the fields `retentionPeriod`, `snapshotCount`
      "retentionPeriod": "string",
      "snapshotCount": "string",
      // end of the list of possible fields`snapshotSchedules[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
snapshotSchedules[] | **object**<br><p>List of snapshot schedules in the specified folder.</p> 
snapshotSchedules[].<br>id | **string**<br><p>ID of the snapshot schedule.</p> 
snapshotSchedules[].<br>folderId | **string**<br><p>ID of the folder that the snapshot schedule belongs to.</p> 
snapshotSchedules[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
snapshotSchedules[].<br>name | **string**<br><p>Name of the snapshot schedule.</p> <p>The name is unique within the folder.</p> 
snapshotSchedules[].<br>description | **string**<br><p>Description of the snapshot schedule.</p> 
snapshotSchedules[].<br>labels | **object**<br><p>Snapshot schedule labels as ``key:value`` pairs.</p> 
snapshotSchedules[].<br>status | **string**<br>Status of the snapshot schedule.<br><ul> <li>CREATING: The snapshot schedule is being created.</li> <li>ACTIVE: The snapshot schedule is on: new disk snapshots will be created, old ones deleted (if [SnapshotSchedule.retention_policy] is specified).</li> <li>INACTIVE: The schedule is interrupted, snapshots won't be created or deleted.</li> <li>DELETING: The schedule is being deleted.</li> <li>UPDATING: Changes are being made to snapshot schedule settings or a list of attached disks.</li> </ul> 
snapshotSchedules[].<br>schedulePolicy | **object**<br>Frequency settings of the snapshot schedule.
snapshotSchedules[].<br>schedulePolicy.<br>startAt | **string** (date-time)<br><p>Timestamp for creating the first snapshot.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
snapshotSchedules[].<br>schedulePolicy.<br>expression | **string**<br><p>Cron expression for the snapshot schedule (UTC+0).</p> <p>The expression must consist of five fields (``Minutes Hours Day-of-month Month Day-of-week``) or be one of nonstandard predefined expressions (e.g. ``@hourly``). For details about the format, see <a href="/docs/compute/concepts/snapshot-schedule#cron">documentation</a></p> 
snapshotSchedules[].<br>snapshotSpec | **object**<br>Attributes of snapshots created by the snapshot schedule.
snapshotSchedules[].<br>snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSchedules[].<br>snapshotSpec.<br>labels | **object**<br><p>Snapshot labels as ``key:value`` pairs.</p> 
snapshotSchedules[].<br>retentionPeriod | **string** <br>`snapshotSchedules[]` includes only one of the fields `retentionPeriod`, `snapshotCount`<br><br><p>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted.</p> 
snapshotSchedules[].<br>snapshotCount | **string** (int64) <br>`snapshotSchedules[]` includes only one of the fields `retentionPeriod`, `snapshotCount`<br><br><p>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/SnapshotSchedule/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/SnapshotSchedule/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 