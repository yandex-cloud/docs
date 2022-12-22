---
editable: false
---

# Managed Service for MySQL API, REST: Backup.list
Retrieves the list of backups in a folder.
 
To list backups for an existing cluster, make a [listBackups](/docs/managed-mysql/api-ref/Cluster/listBackups) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/backups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list backups in.</p> <p>To get this ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-mysql/api-ref/Backup/list#query_params">pageSize</a>, the API returns a <a href="/docs/managed-mysql/api-ref/Backup/list#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-mysql/api-ref/Backup/list#query_params">pageToken</a> to the <a href="/docs/managed-mysql/api-ref/Backup/list#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
backups[] | **object**<br><p>List of backups.</p> 
backups[].<br>id | **string**<br><p>Required. ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp (the time when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Start timestamp (the time when the backup operation was started).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Backup/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Backup/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Backup/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/Backup/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 