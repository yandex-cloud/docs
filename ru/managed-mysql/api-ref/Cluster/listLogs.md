---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Cluster/listLogs.md
---

# Method listLogs
Retrieves logs for a cluster.
 
Alternatively, logs can be streamed using [streamLogs](/docs/managed-mysql/api-ref/Cluster/streamLogs).
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to request logs for.  To get this ID, make a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from the logs table to request. If no columns are specified, complete log records are returned.
serviceType | The log type.<ul> <li>MYSQL_ERROR: MySQL error log.</li> <li>MYSQL_GENERAL: MySQL general query log.</li> <li>MYSQL_SLOW_QUERY: MySQL slow query log.</li> <li>MYSQL_AUDIT: MySQL audit log.</li> </ul> 
fromTime | Start timestamp for the logs request. The logs in the response will be within [fromTime](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params) to [toTime](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params) range.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request. The logs in the response will be within [fromTime](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params) to [toTime](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params) range.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
pageSize | The maximum number of results per page to return.  If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params), the API returns a [nextPageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#responses) that can be used to get the next page of results in the subsequent [listLogs](/docs/managed-mysql/api-ref/Cluster/listLogs) requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token that can be used to iterate through multiple pages of results.  To get the next page of results, set [pageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#responses) returned by the previous [listLogs](/docs/managed-mysql/api-ref/Cluster/listLogs) request.  The maximum string length in characters is 100.
alwaysNextPageToken | Option that controls the behavior of result pagination. If it is set to `true`, then [nextPageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#responses) will always be returned, even if the current page is empty.
 
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
logs[] | **object**<br><p>A single log record.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Timestamp of the log record.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> requests should use the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> <p>This value is interchangeable with ``nextRecordToken`` from <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs">streamLogs</a> method.</p> 