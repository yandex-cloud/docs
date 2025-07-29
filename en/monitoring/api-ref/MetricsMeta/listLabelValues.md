---
editable: false
---

# listLabelValues method
Returns a list of values for the specified label key.



## HTTP request {#https-request}
```http
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/labels/{labelKey}/values
```

## Path parameters {#path_params}
 
Parameter | Description
--- | ---
labelKey | This is a required field. Label key used for the search.

## Query parameters {#query_params}

Parameter | Description
--- | ---
folderId | This is a required field. Metric folder ID. The maximum string length is 50 characters.
selectors | Label selectors for metrics.
valueFilter | Substring for label value filtering.
pageSize | Maximum number of results per response page. The default value is 30. The maximum value is 10,000.
pageToken | Page token. To get the next result page, set [pageToken](#query_params) to the [nextPageToken](#responses) value returned by the previous request.
fromTime | An optional parameter that selects metrics that contain data within the time interval. Indicates the start of the interval. A <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format is used.
toTime | An optional parameter that selects metrics that contain data within the time interval. Indicates the end of the interval. A <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format is used.

The `fromTime` and `toTime` parameters only work if both are specified. When used, only metrics that have data in the specified time interval are returned. To keep the index compact and performant for such queries, the following assumptions are made:

- Only the metric creation time and the time of the last data point are used to build the index. This means that irregular data recording will lead to false positives.
- The index is updated every 4-6 hours for existing metrics. New metric records are displayed immediately.

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "values": [
    "string"
  ],
  "metricsCount": "string",
  "absent": true,
  "nextPageToken": "string"
}
```


Field | Description
--- | ---
values[] | **string**<br><p>Labels for the specified key.</p> 
metricsCount | **string** (int64)<br><p>Number of metrics found by the specified selectors.</p> 
absent | **boolean** (boolean)<br><p>Indicates that the selection contains metrics without the specified label.</p> 
nextPageToken | **string**<br><p>Token to get the next result page.</p> 