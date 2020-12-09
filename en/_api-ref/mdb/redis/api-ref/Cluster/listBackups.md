---
editable: false
---

# Method listBackups
Retrieves the list of available backups for the specified Redis cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}/backups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Redis cluster. To get the Redis cluster ID use a [list](/docs/managed-redis/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-redis/api-ref/Cluster/listBackups#query_params), the service returns a [nextPageToken](/docs/managed-redis/api-ref/Cluster/listBackups#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token.  To get the next page of results, set [pageToken](/docs/managed-redis/api-ref/Cluster/listBackups#query_params) to the [nextPageToken](/docs/managed-redis/api-ref/Cluster/listBackups#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>Description of a Redis backup. For more information, see the Managed Service for Redis <a href="/docs/managed-redis/concepts/backup">documentation</a>.</p> 
backups[].<br>id | **string**<br><p>ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the Redis cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Start timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was started).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backups[].<br>sourceShardNames[] | **string**<br><p>Shard names used as a source for backup.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-redis/api-ref/Cluster/listBackups#query_params">pageSize</a>, use the <a href="/docs/managed-redis/api-ref/Cluster/listBackups#responses">nextPageToken</a> as the value for the <a href="/docs/managed-redis/api-ref/Cluster/listBackups#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-redis/api-ref/Cluster/listBackups#responses">nextPageToken</a> to continue paging through the results.</p> 