---
editable: false
---

# Method read
Returns metric data from Monitoring.
 

 
## HTTP request {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v1/data/read
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cloudId | Required. ID of the cloud that the metric belongs to.  The maximum string length in characters is 50.
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "program": "string",
  "fromTime": "string",
  "toTime": "string",
  "downsampling": {
    "maxPoints": "string",
    "gridMillis": "string",
    "aggregation": "string",
    "fill": "string"
  }
}
```

 
Field | Description
--- | ---
program | **string**<br><p>Required. Query text.</p> 
fromTime | **string** (int64)<br><p>Required. The beginning of the time interval. String in <a href="https://ru.wikipedia.org/wiki/ISO_8601">ISO8601</a> format.</p> 
toTime | **string** (int64)<br><p>Required. The end of the time interval. String in <a href="https://ru.wikipedia.org/wiki/ISO_8601">ISO8601</a> format.</p> 
downsampling | **object**<br><p>Downsampling parameters.</p> 
downsampling.<br>maxPoints | **string** (int64)<br><p>Maximum number of points to be returned.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
downsampling.<br>gridMillis | **string** (int64)<br><p>Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point.</p> <p>Value must be greater than 0.</p> 
downsampling.<br>aggregation | **string**<br><p>Function that is used for downsampling.</p> <p>List of available aggregate functions for downsampling.</p> <ul> <li>MAX: Max function.</li> <li>MIN: Min function.</li> <li>SUM: Sum function.</li> <li>AVG: Average value.</li> <li>LAST: Last value.</li> <li>COUNT: Total count of points.</li> </ul> 
downsampling.<br>fill | **string**<br><p>Parameters for filling gaps in data.</p> <ul> <li>NULL: Returns <code>null</code> as a metric value and <code>timestamp</code> as a time series value.</li> <li>NONE: Returns no value and no timestamp.</li> <li>PREVIOUS: Returns the value from the previous time interval.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "vector": [
    {
      "kind": "string",
      "name": "string",
      "labels": "object",
      "timestamps": [
        "string"
      ],
      "values": [
        "number"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
vector[] | **object**<br><p>List of metrics.</p> 
vector[].<br>kind | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
vector[].<br>name | **string**<br><p>Name of the metric.</p> 
vector[].<br>labels | **object**<br><p>List of metric labels as <code>key:value</code> pairs.</p> 
vector[].<br>timestamps[] | **string** (int64)<br><p>List of timestamps.</p> 
vector[].<br>values[] | **number** (double)<br><p>List of metric values.</p> 