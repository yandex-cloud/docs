---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Backup/list.md
---

# Method list
Retrieves the list of backups in a folder.
 
To list backups for an existing cluster, make a [listBackups](/docs/managed-mysql/api-ref/Cluster/listBackups) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/backups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list backups in.  To get this ID, make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return.  If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/Backup/list#query_params), the API returns a [nextPageToken](/docs/managed-mysql/api-ref/Backup/list#responses) that can be used to get the next page of results in the subsequent [list](/docs/managed-mysql/api-ref/Backup/list) requests.  The maximum value is 1000.
pageToken | Page token that can be used to iterate through multiple pages of results.  To get the next page of results, set [pageToken](/docs/managed-mysql/api-ref/Backup/list#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/Backup/list#responses) returned by the previous [list](/docs/managed-mysql/api-ref/Backup/list) request.  The maximum string length in characters is 100.
 
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
      "startedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>An object that represents MySQL backup.</p> <p>See <a href="/docs/managed-mysql/concepts/backup">the documentation</a> for details.</p> 
backups[].<br>id | **string**<br><p>Required. ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp (the time when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Start timestamp (the time when the backup operation was started).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Backup/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Backup/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Backup/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/Backup/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 