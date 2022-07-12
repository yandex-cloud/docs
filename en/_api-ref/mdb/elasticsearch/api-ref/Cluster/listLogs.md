---
editable: false
---

# Method listLogs
Retrieves logs for the specified Elasticsearch cluster.
 
For more information about logs, see the [Logs](/docs/managed-elasticsearch/operations/cluster-logs) section in the documentation.
 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-elasticsearch/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Elasticsearch cluster to request logs for.</p> <p>To get the Elasticsearch cluster ID, make a <a href="/docs/managed-elasticsearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from the logs table to request.</p> <p>If no columns are specified, full log records are returned.</p> 
fromTime | <p>Start timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | <p>End timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set ``page_token`` to the <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
alwaysNextPageToken | <p>The flag that defines behavior of providing the next page token.</p> <p>If this flag is set to ``true``, this API method will always return <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses">nextPageToken</a>, even if current page is empty.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name to filter by. Currently filtering can be applied to the ``hostname`` field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 1-63 characters long and match the regular expression ``[a-z0-9.-]{1,61}``.</li> </ol> <p>Example of a filter: ``message.hostname='node1.db.cloud.yandex.net'``</p> <p>The maximum string length in characters is 1000.</p> 
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
logs[].<br>timestamp | **string** (date-time)<br><p>Log record timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> <p>This value is interchangeable with ``nextRecordToken`` from StreamLogs method.</p> 