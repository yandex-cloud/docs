---
editable: false
---

# Method listMetrics
Returns a list of metrics.



## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics
```

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | Required field. ID of the folder that the metric belongs to. Maximum string length: 50 characters. |
| selectors | Metric selectors to search by label. |
| pageSize | Maximum number of results per request response page. Defaults to 30, meaning that 30 results are displayed per page. The maximum value is 10000. |
| pageToken | Page token. Set [pageToken](/docs/monitoring/api-ref/MetricsMeta/listMetrics#query_params) to the [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listMetrics#responses) returned by a previous request to get the next page of results. |

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
  ],
  "nextPageToken": "string"
}
```


| Field | Description |
--- | ---
| metrics[] | **object**<br><p>List of metrics.</p> |
| metrics[].<br>name | **string**<br><p>Metric name.</p> |
| metrics[].<br>labels | **object**<br><p>List of metric labels in <code>key:value format</code>.</p> |
| metrics[].<br>type | **string**<br><p>Type of metric.</p> <ul> <li>DGAUGE: Numeric value. Set as a fractional number.</li> <li>GAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li> <li>RATE: Derivative.</li> </ul> |
| nextPageToken | **string**<br><p>Token to get the next page of results in a response.</p> |