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
| folderId | Required field. ID of the folder that the metric belongs to. Maximum string length: 50 characters. |
| selectors | Metric selectors to search by label. |
| nameFilter | Substring text used for filtering by metric name. |
| pageSize | Maximum number of results per request response page. Defaults to 30, meaning that 30 results are displayed per page. The maximum value is 10000. |
| pageToken | Page token. Set [pageToken](/docs/monitoring/api-ref/MetricsMeta/listMetricNames#query_params) to the [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listMetricNames#responses) returned by a previous request to get the next page of results. |

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "names": [
    "string"
  ],
  "nextPageToken": "string"
}
```


| Field | Description |
--- | ---
| names[] | **string**<br><p>List of metric names.</p> |
| nextPageToken | **string**<br><p>Token to get the next page of results in a response.</p> |