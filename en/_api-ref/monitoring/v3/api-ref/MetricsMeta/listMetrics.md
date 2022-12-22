---
editable: false
---

# Monitoring API, REST: MetricsMeta.listMetrics
Retrieves the list of metrics.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/metrics
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p> 
selectors | <p>Metric selectors.</p> 
pageSize | <p>Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/monitoring/api-ref/MetricsMeta/listMetrics#query_params">pageToken</a> to the <a href="/docs/monitoring/api-ref/MetricsMeta/listMetrics#responses">nextPageToken</a> returned by a previous list request. (Pagination works in concrete zone ID and concrete shard)</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
metrics[] | **object**<br><p>List of metrics.</p> 
metrics[].<br>name | **string**<br><p>Name of the metric.</p> 
metrics[].<br>labels | **object**<br><p>Metric labels as ``key:value`` pairs.</p> 
metrics[].<br>type | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
metrics[].<br>createdAt | **string** (date-time)<br><p>When metric was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> 