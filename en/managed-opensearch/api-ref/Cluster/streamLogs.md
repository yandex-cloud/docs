---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/api-ref/Cluster/streamLogs.md
---

# Managed Service for OpenSearch API, REST: Cluster.streamLogs
Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the OpenSearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from log table to get in the response. If no columns are specified, entire log records are returned.</p> 
fromTime | <p>Start timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
toTime | <p>End timestamp for the logs request.</p> <p>If this field is not set, all existing logs are sent as well as the new ones as they appear.</p> <p>In essence it has ``tail -f`` semantics.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
recordToken | <p>Record token. Set ``record_token`` to the ``next_record_token`` returned by the previous [StreamLogs] request to start streaming from the next log record.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li> <p>A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field.</p> </li> <li> <p>A conditional operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</p> </li> <li> <p>A value. Must be 1-63 characters long and match the regular expression ``^[a-z0-9.-]{1,61}$``.</p> </li> </ol> <p>Examples of a filter:</p> <ul> <li>``message.hostname='node1.db.cloud.yandex.net'``;</li> <li>``message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"``.</li> </ul> <p>The maximum string length in characters is 1000.</p> 
serviceType | <p>Type of the service to request logs about.</p> <ul> <li>SERVICE_TYPE_UNSPECIFIED: Type is not specified. - OPENSEARCH: OpenSearch logs.</li> <li>DASHBOARDS: Dashboards logs.</li> </ul> 
 
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
record.<br>timestamp | **string** (date-time)<br><p>Time when the log was recorded.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
record.<br>message | **object**<br><p>Contents of the log record.</p> 
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record.</p> <p>To do that, specify value of ``nextRecordToken`` as the value for [StreamLogs.record_token] parameter in the next [StreamLogs] request.</p> <p>This value is interchangeable with [ListLogs.next_page_token] from [ListLogs] method.</p> 