---
editable: false
---

# Метод streamLogs
Same as [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs) but using server-side streaming. Also allows for 'tail -f' semantics.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}:stream_logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Kafka cluster.  To get the Apache Kafka cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Columns from logs table to get in the response.  If no columns are specified, full log records are returned.
fromTime | Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format.  If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
recordToken | Record token.  Set `record_token` to the `next_record_token` returned by a previous [streamLogs](/docs/managed-kafka/api-ref/Cluster/streamLogs) request to start streaming from next log record.  Максимальная длина строки в символах — 100.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name to filter by. Currently filtering can be applied to the [LogRecord.logs.hostname] field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Example of a filter: `hostname='node1.db.cloud.yandex.net'`  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "record": {
    "timestamp": "string",
    "message": "object"
  },
  "nextRecordToken": "string"
}
```

 
Поле | Описание
--- | ---
record | **object**<br><p>One of the requested log records.</p> <p>A single log record.</p> 
record.<br>timestamp | **string** (date-time)<br><p>Log record timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
record.<br>message | **object**<br><p>Contents of the log record.</p> 
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of <code>next_record_token</code> as value for <code>record_token</code> parameter in the next StreamLogs request. This value is interchangeable with <code>next_page_token</code> from ListLogs method.</p> 