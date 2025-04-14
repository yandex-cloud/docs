---
editable: false
---

# listLabelKeys method
Returns a list of label keys.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/labels
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | This is a required field. Metric folder ID. The maximum string length is 50 characters.
selectors | Label selectors for metrics.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "keys": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
keys[] | **string**<br><p>Key list.</p> 