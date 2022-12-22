---
editable: false
---

# Monitoring API, REST: MetricsMeta.listMetricNames
Retrieves the list of metric names.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/names
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p> 
selectors | <p>Metric selectors.</p> 
nameFilter | <p>Substring name filter text.</p> 
pageSize | <p>Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/monitoring/api-ref/MetricsMeta/listMetricNames#query_params">pageToken</a> to the <a href="/docs/monitoring/api-ref/MetricsMeta/listMetrics#responses">nextPageToken</a> returned by a previous list request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "names": [
    "string"
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
names[] | **string**<br><p>List of metric names.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> 