---
editable: false
---

# Method listLabelValues
Retries the list of values for a given label key.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/labels/{labelKey}/values
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
labelKey | Required. For which label key perform values lookup.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
selectors | Metric selectors.
valueFilter | Substring value filter text.
pageSize | Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/monitoring/api-ref/MetricsMeta/listLabelValues#query_params) to the [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listLabelValues#responses) returned by a previous list request.
 
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