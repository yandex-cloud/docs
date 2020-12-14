---
editable: false
---

# Method listLogs
Retrieves logs for the specified Redis cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Redis cluster to request logs for. To get the Redis cluster ID use a [list](/docs/managed-redis/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from the logs table to request. If no columns are specified, entire log records are returned.
serviceType | <ul> <li>REDIS: Logs of Redis activity.</li> </ul> 
fromTime | Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-redis/api-ref/Cluster/listLogs#query_params), the service returns a [nextPageToken](/docs/managed-redis/api-ref/Cluster/listLogs#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-redis/api-ref/Cluster/listLogs#query_params) to the [nextPageToken](/docs/managed-redis/api-ref/Cluster/listLogs#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-redis/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-redis/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-redis/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-redis/api-ref/Cluster/listLogs#responses">nextPageToken</a> to continue paging through the results. This value is interchangeable with `next_record_token` from StreamLogs method.</p> 