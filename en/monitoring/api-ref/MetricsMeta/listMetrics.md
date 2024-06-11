---
editable: false
---

# listMetrics method
Returns a list of metrics.



## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics
```

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | This is a required field. ID of the folder that the metric belongs to. The maximum string length is 50 characters. |
| selectors | Metric selectors to search by label. |

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string"
    }
  ]
}
```


| Field | Description |
--- | ---
| metrics[] | **object**<br><p>List of metrics.</p> |
| metrics[].<br>name | **string**<br><p>Metric name.</p> |
| metrics[].<br>labels | **object**<br><p>List of metric labels in <code>key:value format</code>.</p> |
| metrics[].<br>type | **string**<br><p>Type of metric.</p> <ul> <li>DGAUGE: Numeric value. Set as a fractional number.</li> <li>GAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li> <li>RATE: Derivative.</li> </ul> |