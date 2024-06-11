---
editable: false
---

# listMetricNames method
Returns a list of metric names.



## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/names
```

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | This is a required field. ID of the folder that the metric belongs to. The maximum string length is 50 characters. |
| selectors | Metric selectors to search by label. |
| nameFilter | Substring text used for filtering by metric name. |

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "names": [
    "string"
  ]
}
```


| Field | Description |
--- | ---
| names[] | **string**<br><p>List of metric names.</p> |