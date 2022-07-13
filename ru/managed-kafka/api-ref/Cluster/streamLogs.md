---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Cluster/streamLogs.md
---

# Method streamLogs
Same as [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs) but using server-side streaming. Also allows for `tail -f` semantics.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-kafka/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from logs table to get in the response.</p> <p>If no columns are specified, full log records are returned.</p> 
fromTime | <p>Start timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | <p>End timestamp for the logs request.</p> <p>If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has ``tail -f`` semantics.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
recordToken | <p>Record token.</p> <p>Set <a href="/docs/managed-kafka/api-ref/Cluster/streamLogs#query_params">recordToken</a> to the ``nextRecordToken`` returned by a previous <a href="/docs/managed-kafka/api-ref/Cluster/streamLogs">streamLogs</a> request to start streaming from next log record.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name to filter by. Currently filtering can be applied to the ``hostname`` field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>Example of a filter: ``message.hostname='node1.db.cloud.yandex.net'``</p> <p>The maximum string length in characters is 1000.</p> 
 
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
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record.</p> <p>To continue streaming, specify value of ``nextRecordToken`` as value for <a href="/docs/managed-kafka/api-ref/Cluster/streamLogs#query_params">recordToken</a> parameter in the next StreamLogs request.</p> <p>This value is interchangeable with <a href="/docs/managed-kafka/api-ref/Cluster/listLogs#responses">nextPageToken</a> from ListLogs method.</p> 