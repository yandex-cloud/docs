---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Cluster/listLogs.md
---

# Managed Service for MySQL API, REST: Cluster.listLogs
Retrieves logs for a cluster.
 
Alternatively, logs can be streamed using [streamLogs](/docs/managed-mysql/api-ref/Cluster/streamLogs).
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to request logs for.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from the logs table to request. If no columns are specified, complete log records are returned.</p> 
serviceType | <p>The log type.</p> <ul> <li>MYSQL_ERROR: MySQL error log.</li> <li>MYSQL_GENERAL: MySQL general query log.</li> <li>MYSQL_SLOW_QUERY: MySQL slow query log.</li> <li>MYSQL_AUDIT: MySQL audit log.</li> </ul> 
fromTime | <p>Start timestamp for the logs request. The logs in the response will be within <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">fromTime</a> to <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">toTime</a> range.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
toTime | <p>End timestamp for the logs request. The logs in the response will be within <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">fromTime</a> to <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">toTime</a> range.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageSize</a>, the API returns a <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageToken</a> to the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> request.</p> <p>The maximum string length in characters is 100.</p> 
alwaysNextPageToken | <p>Option that controls the behavior of result pagination. If it is set to ``true``, then <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> will always be returned, even if the current page is empty.</p> 
 
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
logs[].<br>timestamp | **string** (date-time)<br><p>Timestamp of the log record.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> requests should use the <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> <p>This value is interchangeable with ``nextRecordToken`` from <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs">streamLogs</a> method.</p> 