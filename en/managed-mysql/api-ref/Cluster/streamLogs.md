---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Cluster/streamLogs.md
---

# Managed Service for MySQL API, REST: Cluster.streamLogs
Retrieves a log stream for a cluster.
 
This method is similar to [listLogs](/docs/managed-mysql/api-ref/Cluster/listLogs), but uses server-side streaming, which allows for the `tail -f` command semantics.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to stream logs for.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from the logs table to request. If no columns are specified, complete log records are returned.</p> 
serviceType | <p>The log type.</p> <ul> <li>MYSQL_ERROR: MySQL error log.</li> <li>MYSQL_GENERAL: MySQL general query log.</li> <li>MYSQL_SLOW_QUERY: MySQL slow query log.</li> <li>MYSQL_AUDIT: MySQL audit log.</li> </ul> 
fromTime | <p>Start timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
toTime | <p>End timestamp for the logs request. If this field is not set, all existing log records beginning from <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs#query_params">fromTime</a> will be returned first, and then the new records will be returned as they appear.</p> <p>In essence it has ``tail -f`` command semantics.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
recordToken | <p>Record token that can be used to control logs streaming.</p> <p>Set <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs#query_params">recordToken</a> to the ``nextRecordToken``, returned by the previous <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs">streamLogs</a> request to start streaming from the next log record.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that selects clusters logs listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can be applied to the [LogRecord.logs.hostname] field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Examples of a filter: ``message.hostname='node1.db.cloud.yandex.net'``</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
A single log record in the logs stream.
 
Field | Description
--- | ---
record | **object**<br><p>One of the requested log records.</p> <p>A single log record.</p> 
record.<br>timestamp | **string** (date-time)<br><p>Timestamp of the log record.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
record.<br>message | **object**<br><p>Contents of the log record.</p> 
nextRecordToken | **string**<br><p>The token that can be used to continue streaming logs starting from the exact same record. To continue streaming, specify value of ``nextRecordToken`` as the <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs#query_params">recordToken</a> value in the next <a href="/docs/managed-mysql/api-ref/Cluster/streamLogs">streamLogs</a> request.</p> <p>This value is interchangeable with <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> from <a href="/docs/managed-mysql/api-ref/Cluster/listLogs">listLogs</a> method.</p> 