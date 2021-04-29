---
editable: false
---

# Method listLabelValues
Retries the list of values for a given label key.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v3/metrics/labels/{labelKey}/values
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
pageSize | Maximum number of label values for concrete key in response. 0 means default page size = 30, maximum page size = 10000.
 
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