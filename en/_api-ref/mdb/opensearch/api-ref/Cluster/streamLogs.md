---
editable: false
---

# Method streamLogs
Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}:stream_logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the OpenSearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from logs table to get in the response.</p> 
fromTime | <p>Start timestamp for the logs request.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | <p>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
recordToken | <p>Record token. Set ``record_token`` to the ``next_record_token`` returned by a previous StreamLogs request to start streaming from next log record.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently filtering can be applied to the [LogRecord.logs.hostname] field.</li> <li>A conditional operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be 3-63 characters long and match the regular expression ``^[a-z][-a-z0-9]{1,61}[a-z0-9]$``. Examples of a filter: ``message.hostname='node1.db.cloud.yandex.net'``</li> </ol> <p>The maximum string length in characters is 1000.</p> 
serviceType | <p>Type of the service to request logs about.</p> 
 
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
nextRecordToken | **string**<br><p>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of ``next_record_token`` as value for ``record_token`` parameter in the next StreamLogs request. This value is interchangeable with ``next_page_token`` from ListLogs method.</p> 