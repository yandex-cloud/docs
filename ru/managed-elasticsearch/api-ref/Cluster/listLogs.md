---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method listLogs
Retrieves logs for the specified Elasticsearch cluster.
 
For more information about logs, see the [Logs](/docs/managed-elasticsearch/operations/cluster-logs) section in the documentation.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Elasticsearch cluster to request logs for.  To get the Elasticsearch cluster ID, make a [list](/docs/managed-elasticsearch/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from the logs table to request.  If no columns are specified, full log records are returned.
fromTime | Start timestamp for the logs request.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses) returned by a previous list request.  The maximum string length in characters is 100.
alwaysNextPageToken | The flag that defines behavior of providing the next page token.  If this flag is set to `true`, this API method will always return [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses), even if current page is empty.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name to filter by. Currently filtering can be applied to the `hostname` field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.  Example of a filter: `message.hostname='node1.db.cloud.yandex.net'`  The maximum string length in characters is 1000.
serviceType | Type of the service to request logs about.
 
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
logs[].<br>timestamp | **string** (date-time)<br><p>Log record timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> <p>This value is interchangeable with ``nextRecordToken`` from StreamLogs method.</p> 