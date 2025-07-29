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
 
Parameter | Description
--- | ---
folderId | This is a required field. Metric folder ID. The maximum string length is 50 characters.
selectors | Label selectors for metrics.
fromTime | An optional parameter that selects metrics that contain data within the time interval. Indicates the start of the interval. A <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format is used.
toTime | An optional parameter that selects metrics that contain data within the time interval. Indicates the end of the interval. A <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format is used.

The `fromTime` and `toTime` parameters only work if both are specified. When used, only metrics that have data in the specified time interval are returned. To keep the index compact and performant for such queries, the following assumptions are made:

- Only the metric creation time and the time of the last data point are used to build the index. This means that irregular data recording will lead to false positives.
- The index is updated every 4-6 hours for existing metrics. New metric records are displayed immediately.
 
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

 
Field | Description
--- | ---
metrics[] | **object**<br><p>List of metrics.</p> 
metrics[].<br>name | **string**<br><p>Metric name.</p> 
metrics[].<br>labels | **object**<br><p>Metric labels in <code>key:value format</code>.</p> 
metrics[].<br>type | **string**<br><p>Metric type.</p> <ul> <li>DGAUGE: Numeric value. Set as a fraction.</li> <li>IGAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li> <li>RATE: Derivative value.</li> </ul>