---
editable: false
---

# listLabelKeys method
Returns a list of label keys.



## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/labels
```

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | Required field. ID of the folder that the metric belongs to. Maximum string length: 50 characters. |
| selectors | Metric selectors to search by label. |

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "keys": [
    "string"
  ]
}
```


| Field | Description |
--- | ---
| keys[] | **string**<br><p>List of keys.</p> |