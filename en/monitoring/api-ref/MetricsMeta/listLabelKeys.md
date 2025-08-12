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
fromTime | An optional parameter for selecting metrics from a specified time interval. Specify the time interval start point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.
toTime | An optional parameter for selecting metrics from a specified time interval. Specify the time interval end point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.

The `fromTime` and `toTime` parameters are only used together. The response returns metrics that have data in the specified interval. To make sure the index is concise and optimized for such queries:

- Responses include metric data from the point when this metric was created to its last record, even if there are gaps in the data.
- For the existing metrics, the index gets updated every four to six hours. New metrics get added immediately. 

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
