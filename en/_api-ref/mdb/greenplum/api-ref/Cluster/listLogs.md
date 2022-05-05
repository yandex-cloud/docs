---
editable: false
---

# Method listLogs
Retrieves logs for the specified Greenplum® cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-greenplum/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Greenplum® cluster to request logs for. To get the Greenplum® cluster ID, use a [list](/docs/managed-greenplum/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from logs table to request. If no columns are specified, entire log records are returned.
serviceType | Type of the service to request logs about.<p>Type of the service to request logs about.</p> <ul> <li>SERVICE_TYPE_UNSPECIFIED: Type is not specified.</li> <li>GREENPLUM: Greenplum® activity logs.</li> <li>GREENPLUM_POOLER: Greenplum® pooler logs.</li> </ul> 
fromTime | Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-greenplum/api-ref/Cluster/listLogs#query_params), the service returns a [nextPageToken](/docs/managed-greenplum/api-ref/Cluster/listLogs#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-greenplum/api-ref/Cluster/listLogs#query_params) to the [nextPageToken](/docs/managed-greenplum/api-ref/Cluster/listLogs#responses) returned by a previous list request.  The maximum string length in characters is 100.
alwaysNextPageToken | Always return `next_page_token`, even if the current page is empty.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.error_severity] (for `GREENPLUM` service) and [LogRecord.logs.message.level] (for `GREENPLUM_POOLER` service) fields. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. Examples of a filter: * `message.hostname='node1.db.cloud.yandex.net'` * `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`  The maximum string length in characters is 1000.
 
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
logs[].<br>timestamp | **string** (date-time)<br><p>Log record timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-greenplum/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-greenplum/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-greenplum/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-greenplum/api-ref/Cluster/listLogs#responses">nextPageToken</a> to continue paging through the results. This value is interchangeable with the [StreamLogRecord.next_record_token] from StreamLogs method.</p> 