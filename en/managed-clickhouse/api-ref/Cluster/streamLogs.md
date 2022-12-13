---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/api-ref/Cluster/streamLogs.md
---

# Managed Service for ClickHouse API, REST: Cluster.streamLogs
Same as ListLogs but using server-side streaming. Also allows for `tail -f` semantics.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the ClickHouse cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from logs table to get in the response.</p> 
serviceType | <ul> <li>CLICKHOUSE: Logs of ClickHouse activity.</li> </ul> 
fromTime | <p>Start timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
toTime | <p>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has ``tail -f`` semantics.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
recordToken | <p>Record token. Set <a href="/docs/managed-clickhouse/api-ref/Cluster/streamLogs#query_params">recordToken</a> to the ``nextRecordToken`` returned by a previous StreamLogs request to start streaming from next log record.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.severity] fields.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 1-63 characters long and match the regular expression ``[a-z0-9.-]{1,61}``. Examples of a filter:</li> </ol> <ul> <li>``message.hostname='node1.db.cloud.yandex.net'``</li> <li>``message.severity IN ('Error', 'Fatal') AND message.hostname != 'node2.db.cloud.yandex.net'``.</li> </ul> <p>The maximum string length in characters is 1000.</p> 
 
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
record.<br>timestamp | **string** (date-time)<br><p>Log record timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
record.<br>message | **object**<br><p>Contents of the log record.</p> 
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of [next_record_token[ as value for the <a href="/docs/managed-clickhouse/api-ref/Cluster/streamLogs#query_params">recordToken</a> parameter in the next StreamLogs request. This value is interchangeable with the <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses">nextPageToken</a> from ListLogs method.</p> 