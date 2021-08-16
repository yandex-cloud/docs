---
editable: false
---

# Method listBackups
Retrieves the list of available backups for the specified MongoDB cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/backups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MongoDB cluster. To get the MongoDB cluster ID, use a [list](/docs/managed-mongodb/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | Page token.  To get the next page of results, set [pageToken](/docs/managed-mongodb/api-ref/Cluster/listBackups#query_params) to the [nextPageToken](/docs/managed-mongodb/api-ref/Cluster/listBackups#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "sourceClusterId": "string",
      "startedAt": "string",
      "sourceShardNames": [
        "string"
      ],
      "size": "string",
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>A MongoDB Backup resource. For more information, see the <a href="/docs/managed-mongodb/concepts">Developer's Guide</a>.</p> 
backups[].<br>id | **string**<br><p>ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the MongoDB cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backups[].<br>sourceShardNames[] | **string**<br><p>Shard names used as a source for backup.</p> 
backups[].<br>size | **string** (int64)<br><p>Size of backup in bytes</p> 
backups[].<br>type | **string**<br><p>How this backup was created (manual/automatic/etc...)</p> <ul> <li>AUTOMATED: Backup created by automated daily schedule</li> <li>MANUAL: Backup created by user request</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mongodb/api-ref/Cluster/listBackups#query_params">pageSize</a>, use the <a href="/docs/managed-mongodb/api-ref/Cluster/listBackups#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mongodb/api-ref/Cluster/listBackups#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mongodb/api-ref/Cluster/listBackups#responses">nextPageToken</a> to continue paging through the results.</p> 