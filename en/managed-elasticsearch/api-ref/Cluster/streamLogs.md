---
editable: false
---

# Method streamLogs
Same as [listLogs](/docs/managed-elasticsearch/api-ref/Cluster/listLogs) but using server-side streaming. Also supports `tail -f` semantics.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Elasticsearch cluster.  To get the Elasticsearch cluster ID, make a [list](/docs/managed-elasticsearch/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | Columns from logs table to get in the response.  If no columns are specified, full log records are returned.
fromTime | Start timestamp for the logs request.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
toTime | End timestamp for the logs request.  If this field is not set, all existing logs will be sent and then the new ones asthey appear. In essence it has `tail -f` semantics.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
recordToken | Record token.  Set `record_token` to the `nextRecordToken` returned by a previous [streamLogs](/docs/managed-elasticsearch/api-ref/Cluster/streamLogs) request to start streaming from next log record.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name to filter by. Currently filtering can be applied to the `hostname` field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Example of a filter: `message.hostname='node1.db.cloud.yandex.net'`  The maximum string length in characters is 1000.
serviceType | Type of the service to request logs about.
 
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
record | **object**<br><p>One of the requested log records.</p> <p>A single log record.</p> 
record.<br>timestamp | **string** (date-time)<br><p>Log record timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
record.<br>message | **object**<br><p>Contents of the log record.</p> 
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record.</p> <p>To continue streaming, specify value of ``next_record_token`` as value for <a href="/docs/managed-elasticsearch/api-ref/Cluster/streamLogs#query_params">recordToken</a> parameter in the next StreamLogs request.</p> <p>This value is interchangeable with <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses">nextPageToken</a> from ListLogs method.</p> 