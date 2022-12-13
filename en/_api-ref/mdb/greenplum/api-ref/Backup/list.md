---
editable: false
---

# Managed Service for Greenplum® API, REST: Backup.list
Returns the list of available backups for the specified Greenplum® cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/backups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list backups in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-greenplum/api-ref/Backup/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-greenplum/api-ref/Backup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value is 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The page token. To get the next page of results, set <a href="/docs/managed-greenplum/api-ref/Backup/list#query_params">pageToken</a> to the <a href="/docs/managed-greenplum/api-ref/Backup/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "size": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>Requested list of backups.</p> 
backups[].<br>id | **string**<br><p>Required. ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Time when the backup operation was completed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the Greenplum® cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>size | **string** (int64)<br><p>Size of the backup in bytes.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for a list request.</p> <p>If the number of results is larger than <a href="/docs/managed-greenplum/api-ref/Backup/list#query_params">pageSize</a> specified in the request, use the <a href="/docs/managed-greenplum/api-ref/Backup/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-greenplum/api-ref/Backup/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent ListBackups request has its own <a href="/docs/managed-greenplum/api-ref/Backup/list#responses">nextPageToken</a> to continue paging through the results.</p> 