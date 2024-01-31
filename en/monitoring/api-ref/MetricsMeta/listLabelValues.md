---
editable: false
---

# listLabelValues method
Returns a list of values for the specified label key.



## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/metrics/labels/{labelKey}/values
```

## Path parameters {#path_params}

| Parameter | Description |
--- | ---
| labelKey | This is a required field. Label key that a search is performed by. |

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | This is a required field. ID of the folder that the metric belongs to. The maximum string length is 50 characters. |
| selectors | Metric selectors to search by label. |
| valueFilter | Substring text used for filtering by label value. |
| pageSize | Maximum number of results per request response page. Defaults to 30, meaning that 30 results are displayed per page. The maximum value is 10,000. |
| pageToken | Page token. Set [pageToken](#query_params) to the [nextPageToken](#responses) returned by a previous request to get the next page of results. |

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


| Field | Description |
--- | ---
| values[] | **string**<br><p>List of label values by the specified key.</p> |
| metricsCount | **string** (int64)<br><p>Number of metrics found by the specified selectors.</p> |
| absent | **boolean** (boolean)<br><p>Indicates that a selection contains metrics without the specified label.</p> |
| nextPageToken | **string**<br><p>Token to get the next page of results in a response.</p> |