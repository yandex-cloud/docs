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