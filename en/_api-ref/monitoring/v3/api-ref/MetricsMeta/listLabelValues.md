---
editable: false
---

# Method listLabelValues
Retries the list of values for a given label key.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/metrics/labels/{labelKey}/values
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
pageSize | <p>Maximum number of label values for concrete key in response. 0 means default page size = 30, maximum page size = 10000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "values": [
    "string"
  ],
  "maxMetricsCount": "string",
  "absent": true,
  "truncated": true
}
```

 
Field | Description
--- | ---
values[] | **string**<br><p>List of values by given label key.</p> 
maxMetricsCount | **string** (int64)<br><p>Max metrics count given by selectors.</p> 
absent | **boolean** (boolean)<br><p>Flag determining that there are has some metrics without the given label.</p> 
truncated | **boolean** (boolean)<br><p>Flag determining that label values response is truncated.</p> 