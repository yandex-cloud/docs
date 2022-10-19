---
editable: false
---

# Method listLogs
Retrieves logs for the specified OpenSearch cluster.
See the [Logs](/yandex-mdb-guide/concepts/logs.html) section in the developers guide for detailed logs description.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the OpenSearch cluster to request logs for. To get the OpenSearch cluster ID use a <a href="/docs/managed-opensearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from the logs table to request. If no columns are specified, entire log records are returned.</p> 
fromTime | <p>Start timestamp for the logs request, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | <p>End timestamp for the logs request, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#query_params">pageSize</a>, the service returns a <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#query_params">pageToken</a> to the <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
alwaysNextPageToken | <p>Always return ``next_page_token``, even if current page is empty.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field.</li> <li>A conditional operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be 1-63 characters long and match the regular expression ``^[a-z0-9.-]{1,61}$``. Examples of a filter: ``message.hostname='node1.db.cloud.yandex.net'``</li> </ol> <p>The maximum string length in characters is 1000.</p> 
serviceType | <p>Type of the service to request logs about.</p> 
 
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
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-opensearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> to continue paging through the results. This value is interchangeable with ``next_record_token`` from StreamLogs method.</p> 