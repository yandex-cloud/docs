---
editable: false
---

# Managed Service for PostgreSQL API, REST: Cluster.listBackups
Retrieves the list of available backups for the specified PostgreSQL cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/backups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the PostgreSQL cluster. To get the PostgreSQL cluster ID use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#query_params">pageSize</a>, the service returns a <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.  To get the next page of results, set <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#query_params">pageToken</a> to the <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "size": "string",
      "type": "string",
      "method": "string",
      "journalSize": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>List of PostgreSQL Backup resources.</p> 
backups[].<br>id | **string**<br><p>Required. ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the PostgreSQL cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>size | **string** (int64)<br><p>Size of backup, in bytes</p> 
backups[].<br>type | **string**<br><p>How this backup was created (manual/automatic/etc...)</p> <ul> <li>AUTOMATED: Backup created by automated daily schedule</li> <li>MANUAL: Backup created by user request</li> </ul> 
backups[].<br>method | **string**<br><p>Method of backup creation</p> <ul> <li>BASE: Base backup</li> <li>INCREMENTAL: Delta (incremental) PostgreSQL backup</li> </ul> 
backups[].<br>journalSize | **string** (int64)<br><p>Size of the journal associated with backup, in bytes</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups#responses">nextPageToken</a> to continue paging through the results.</p> 