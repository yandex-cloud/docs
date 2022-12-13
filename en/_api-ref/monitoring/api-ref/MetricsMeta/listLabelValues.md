---
editable: false
---

# Monitoring API, REST: MetricsMeta.listLabelValues
Retries the list of values for a given label key.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/labels/{labelKey}/values
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
labelKey | <p>Required. For which label key perform values lookup.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p> 
selectors | <p>Metric selectors.</p> 
valueFilter | <p>Substring value filter text.</p> 
pageSize | <p>Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/monitoring/api-ref/MetricsMeta/listLabelValues#query_params">pageToken</a> to the <a href="/docs/monitoring/api-ref/MetricsMeta/listMetrics#responses">nextPageToken</a> returned by a previous list request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "values": [
    "string"
  ],
  "metricsCount": "string",
  "absent": true,
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
values[] | **string**<br><p>List of values by given label key.</p> 
metricsCount | **string** (int64)<br><p>Metrics count given by selectors.</p> 
absent | **boolean** (boolean)<br><p>Flag determining that there are has some metrics without the given label.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> 