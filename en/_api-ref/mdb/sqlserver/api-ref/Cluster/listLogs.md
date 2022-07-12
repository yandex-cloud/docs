---
editable: false
---

# Method listLogs
Retrieves logs for the specified SQL Server cluster.
 
For more information about logs, see the [Logs](/docs/managed-sqlserver/operations/cluster-logs) section in the documentation.
 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/mdb/sqlserver/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the SQL Server cluster to request logs for.</p> <p>To get the SQL Server cluster ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from the logs table to request.</p> <p>If no columns are specified, entire log records are returned.</p> 
serviceType | <p>Type of the service to request logs about.</p> <ul> <li>SQLSERVER_ERROR: SQL Server error log.</li> <li>SQLSERVER_APPLICATION: SQL Server application log.</li> </ul> 
fromTime | <p>Specifies a moment that the logs are requested from.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | <p>Specifies a moment that the logs are requested till.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageSize</a>, the service returns a <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageToken</a> to the <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
alwaysNextPageToken | <p>The service returns [next_page_token] even if the current page is empty.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>A field name to filter by. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field only.</li> <li>A conditional operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>A value. Must be 1-63 characters long and match the regular expression ``[a-z0-9.-]{1,61}``.</li> </ol> <p>Example of a filter: ``message.hostname='node1.db.cloud.yandex.net'``.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logs": [
    {
      "timestamp": "string",
      "message": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
logs[] | **object**<br><p>Requested log records.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Log record timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses">nextPageToken</a> to continue paging through the results.</p> 