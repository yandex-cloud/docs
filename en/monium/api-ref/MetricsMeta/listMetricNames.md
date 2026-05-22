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
 
Parameter | Description
--- | ---
folderId | This is a required field. Metric folder ID. The maximum string length is 50 characters.
selectors | Label selectors for metrics.
nameFilter | Substring for metric name filtering.
fromTime | Optional parameter for selecting metrics from a specified time interval. It specifies the time interval start point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.
toTime | Optional parameter for selecting metrics from a specified time interval. It specifies the time interval endpoint in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.

The `fromTime` and `toTime` parameters are only used together. The response returns metrics that have data in the specified interval. To keep the index for such queries concise and efficient, the system:

- Ensures each response contains metric data for the period between the metric’s creation and its last record, even if there are gaps in the data.
- Updates the index every four to six hours for existing metrics. Adds new metrics immediately.

 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "names": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
names[] | **string**<br><p>List of metric names.</p>