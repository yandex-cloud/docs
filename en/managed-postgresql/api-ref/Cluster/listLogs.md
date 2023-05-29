---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Cluster/listLogs.md
---

# Managed Service for PostgreSQL API, REST: Cluster.listLogs
Retrieves logs for the specified PostgreSQL cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the PostgreSQL cluster to request logs for. To get the PostgreSQL cluster ID use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
columnFilter | <p>Columns from the logs table to request. If no columns are specified, entire log records are returned.</p> 
serviceType | <p>Type of the service to request logs about.</p> <ul> <li>POSTGRESQL: Logs of PostgreSQL activity.</li> <li>POOLER: Logs of connection pooler activity.</li> </ul> 
fromTime | <p>Start timestamp for the logs request, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
toTime | <p>End timestamp for the logs request, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#query_params">pageSize</a>, the service returns a <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#query_params">pageToken</a> to the <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
alwaysNextPageToken | <p>Always return ``next_page_token``, even if current page is empty.</p> 
 
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
logs[] | **object**<br><p>Requested log records.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Log record timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
logs[].<br>message | **object**<br><p>Contents of the log record.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/Cluster/listLogs#responses">nextPageToken</a> to continue paging through the results. This value is interchangeable with ``next_record_token`` from StreamLogs method.</p> 