---
editable: false
---

# Method listLabelKeys
Retrieves the list of label keys.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v3/metrics/labels
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
selectors | Metric selectors.
 
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
keys[] | **string**<br><p>Found label keys.</p> 