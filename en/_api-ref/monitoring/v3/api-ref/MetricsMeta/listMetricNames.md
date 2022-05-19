---
editable: false
---

# Method listMetricNames
Retrieves the list of metric names.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/metrics/names
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
selectors | Metric selectors (for new format of metrics only).
nameFilter | Substring name filter text.
pageSize | Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "names": [
    "string"
  ],
  "truncated": true
}
```

 
Field | Description
--- | ---
names[] | **string**<br><p>List of metric names.</p> 
truncated | **boolean** (boolean)<br><p>Flag determining that label values response is truncated.</p> 