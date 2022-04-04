---
editable: false
sourcePath: en/_api-ref/mdb/sqlserver/api-ref/Cluster/listLogs.md
---

# Method listLogs
Retrieves logs for the specified SQL Server cluster.
 
For more information about logs, see the [Logs](/docs/managed-sqlserver/operations/cluster-logs) section in the documentation.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the SQL Server cluster to request logs for.  To get the SQL Server cluster ID, use a [list](/docs/managed-sqlserver/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from the logs table to request.  If no columns are specified, entire log records are returned.
serviceType | Type of the service to request logs about.<ul> <li>SQLSERVER_ERROR: SQL Server error log.</li> <li>SQLSERVER_APPLICATION: SQL Server application log.</li> </ul> 
fromTime | Start timestamp for the logs request.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses) returned by a previous list request.  The maximum string length in characters is 100.
alwaysNextPageToken | Always return `next_page_token`, even if current page is empty.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name to filter by. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`.  Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'`  The maximum string length in characters is 1000.
 
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
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 