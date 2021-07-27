---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method streamLogs
Same as ListLogs but using server-side streaming. Also allows for `tail -f` semantics.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the ClickHouse cluster.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from logs table to get in the response.
serviceType | <ul> <li>CLICKHOUSE: Logs of ClickHouse activity.</li> </ul> 
fromTime | Start timestamp for the logs request.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has `tail -f` semantics.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
recordToken | Record token. Set [recordToken](/docs/managed-clickhouse/api-ref/Cluster/streamLogs#query_params) to the `nextRecordToken` returned by a previous StreamLogs request to start streaming from next log record.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.severity] fields. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. Examples of a filter: - `message.hostname='node1.db.cloud.yandex.net'` - `message.severity IN ('Error', 'Fatal') AND message.hostname != 'node2.db.cloud.yandex.net'`.  The maximum string length in characters is 1000.
 
## Response {#responses}
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

 
Field | Description
--- | ---
record | **object**<br><p>One of the requested log records.</p> 
record.<br>timestamp | **string** (date-time)<br><p>Log record timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
record.<br>message | **object**<br><p>Contents of the log record.</p> 
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of [next_record_token[ as value for the <a href="/docs/managed-clickhouse/api-ref/Cluster/streamLogs#query_params">recordToken</a> parameter in the next StreamLogs request. This value is interchangeable with the <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses">nextPageToken</a> from ListLogs method.</p> 