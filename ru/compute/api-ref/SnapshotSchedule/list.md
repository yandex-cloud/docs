---
editable: false
sourcePath: en/_api-ref/compute/api-ref/SnapshotSchedule/list.md
---

# Method list
Retrieves the list of SnapshotSchedule resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/snapshotSchedules
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list snapshot schedules in.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/SnapshotSchedule/list#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/SnapshotSchedule/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/SnapshotSchedule/list#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/SnapshotSchedule/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted.</p> 
 
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
snapshotSchedules[] | **object**<br><p>List of SnapshotSchedule resources.</p> 
snapshotSchedules[].<br>id | **string**<br><p>ID of the snapshot schedule policy.</p> 
snapshotSchedules[].<br>folderId | **string**<br><p>ID of the folder that the scheduler policy belongs to.</p> 
snapshotSchedules[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
snapshotSchedules[].<br>name | **string**<br><p>Name of the schedule policy. The name is unique within the folder.</p> 
snapshotSchedules[].<br>description | **string**<br><p>Description of the schedule policy.</p> 
snapshotSchedules[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
snapshotSchedules[].<br>status | **string**
snapshotSchedules[].<br>schedulePolicy | **object**<br>schedule properties
snapshotSchedules[].<br>schedulePolicy.<br>startAt | **string** (date-time)<br><p>start time for the first run.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
snapshotSchedules[].<br>schedulePolicy.<br>expression | **string**<br><p>cron format (* * * * *)</p> 
snapshotSchedules[].<br>snapshotSpec | **object**<br>properties to create snapshot with.
snapshotSchedules[].<br>snapshotSpec.<br>description | **string**<br><p>Description of the created snapshot.</p> 
snapshotSchedules[].<br>snapshotSpec.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
snapshotSchedules[].<br>retentionPeriod | **string** <br>`snapshotSchedules[]` includes only one of the fields `retentionPeriod`, `snapshotCount`<br>
snapshotSchedules[].<br>snapshotCount | **string** (int64) <br>`snapshotSchedules[]` includes only one of the fields `retentionPeriod`, `snapshotCount`<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/SnapshotSchedule/list#query_params">pageSize</a>, use the <a href="/docs/compute/api-ref/SnapshotSchedule/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/SnapshotSchedule/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/SnapshotSchedule/list#responses">nextPageToken</a> to continue paging through the results.</p> 