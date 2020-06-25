---
editable: false
---

# Метод listLogs
Retrieves logs for the specified Apache Kafka cluster.
For more information about logs, see the [Logs](/docs/managed-kafka/operations/cluster-logs) section in the documentation.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Apache Kafka cluster to request logs for.  To get the Apache Kafka cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Columns from the logs table to request.  If no columns are specified, full log records are returned.
fromTime | Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-kafka/api-ref/Cluster/listLogs#responses) that can be used to get the next page of results in subsequent list requests.  Максимальное значение — 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-kafka/api-ref/Cluster/listLogs#responses) returned by a previous list request.  Максимальная длина строки в символах — 100.
alwaysNextPageToken | The flag that defines behavior of providing the next page token.  If this flag is set to `true`, this API method will always return `next_page_token`, even if current page is empty.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name to filter by. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.  Example of a filter: `hostname='node1.db.cloud.yandex.net'`  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
logs[] | **object**<br><p>A single log record.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Log record timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/listLogs#query_params">pageSize</a>, use <code>next_page_token</code> as the value for the <a href="/docs/managed-kafka/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <code>next_page_token</code> to continue paging through the results. This value is interchangeable with <code>next_record_token</code> from StreamLogs method.</p> 