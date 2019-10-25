---
editable: false
---

# Method read
Returns metric data from Monitoring.
 

 
## HTTP request {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "query": "string",
  "fromTime": "string",
  "toTime": "string",
  "downsampling": {
    "gridAggregation": "string",
    "gapFilling": "string",

    // `downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`
    "maxPoints": "string",
    "gridInterval": "string",
    "disabled": true,
    // end of the list of possible fields`downsampling`

  }
}
```

 
Field | Description
--- | ---
query | **string**<br><p>Required. Query text.</p> 
fromTime | **string** (date-time)<br><p>Required. The beginning of the time interval, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | **string** (date-time)<br><p>Required. The end of the time interval, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
downsampling | **object**<br><p>Required. Downsampling parameters.</p> <p>List of available aggregate functions for downsampling.</p> 
downsampling.<br>gridAggregation | **string**<br>Function that is used for downsampling.<br><p>List of available aggregate functions for downsampling.</p> <ul> <li>MAX: Max value.</li> <li>MIN: Min value.</li> <li>SUM: Sum of values.</li> <li>AVG: Average value.</li> <li>LAST: Last value.</li> <li>COUNT: Total count of points.</li> </ul> 
downsampling.<br>gapFilling | **string**<br>Parameters for filling gaps in data.<br><p>List of available gap filling policy for downsampling.</p> <ul> <li>NULL: Returns <code>null</code> as a metric value and <code>timestamp</code> as a time series value.</li> <li>NONE: Returns no value and no timestamp.</li> <li>PREVIOUS: Returns the value from the previous time interval.</li> </ul> 
downsampling.<br>maxPoints | **string** (int64) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Maximum number of points to be returned.</p> <p>Value must be greater than 10.</p> 
downsampling.<br>gridInterval | **string** (int64) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point.</p> <p>Value must be greater than 0.</p> 
downsampling.<br>disabled | **boolean** (boolean) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Disable downsampling.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string",
      "timeseries": {
        "timestamps": [
          "string"
        ],
        "doubleValues": [
          "number"
        ],
        "int64Values": [
          "string"
        ]
      }
    }
  ]
}
```

 
Field | Description
--- | ---
metrics[] | **object**<br><p>List of metrics with timeseries.</p> 
metrics[].<br>name | **string**<br><p>Name of the metric.</p> 
metrics[].<br>labels | **object**<br><p>List of metric labels as <code>key:value</code> pairs.</p> 
metrics[].<br>type | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
metrics[].<br>timeseries | **object**<br><p>Metric values.</p> 
metrics[].<br>timeseries.<br>timestamps[] | **string** (int64)<br><p>List of timestamps as unix-time milliseconds.</p> 
metrics[].<br>timeseries.<br>doubleValues[] | **number** (double)<br><p>List of double values.</p> 
metrics[].<br>timeseries.<br>int64Values[] | **string** (int64)<br><p>List of int64 values. Only for <code>IGAUGE</code> metric type.</p> 
