---
editable: false
---

# Method listAllLabelValues
Retries the list of values for a given label key.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/metrics/labelValues
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the fodler that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p> 
labels | <p>For which label key perform values lookup.</p> 
selectors | <p>Metric selectors.</p> 
valueFilter | <p>Substring value filter text.</p> 
pageSize | <p>Maximum number of label values for concrete key in response. 0 means default page size = 30, maximum page size = 10000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "labels": [
    {
      "key": "string",
      "values": [
        "string"
      ],
      "absent": true,
      "truncated": true
    }
  ],
  "maxMetricsCount": "string"
}
```

 
Field | Description
--- | ---
labels[] | **object**<br><p>List of labels with values.</p> 
labels[].<br>key | **string**<br><p>Label key.</p> 
labels[].<br>values[] | **string**<br><p>List of values by given label key.</p> 
labels[].<br>absent | **boolean** (boolean)<br><p>Flag determining that there are has some metrics without the given label.</p> 
labels[].<br>truncated | **boolean** (boolean)<br><p>Flag determining that label values response is truncated.</p> 
maxMetricsCount | **string** (int64)<br><p>Max metrics count given by selectors.</p> 