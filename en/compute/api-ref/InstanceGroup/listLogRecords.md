---
editable: false
sourcePath: en/_api-ref/compute/api-ref/InstanceGroup/listLogRecords.md
---

# Compute Cloud Instance Groups API, REST: InstanceGroup.listLogRecords
Lists logs for the specified instance group.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/instanceGroups/{instanceGroupId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceGroupId | <p>Required. ID of the InstanceGroup resource to list logs for. To get the instance group ID, use a <a href="/docs/compute/api-ref/InstanceGroup/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the <a href="/docs/compute/api-ref/InstanceGroup#representation">InstanceGroup.name</a> field.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logRecords": [
    {
      "timestamp": "string",
      "message": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
logRecords[] | **object**<br><p>Lists logs for the specified instance group.</p> 
logRecords[].<br>timestamp | **string** (date-time)<br><p>Log timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
logRecords[].<br>message | **string**<br><p>The log message.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> to continue paging through the results.</p> 