---
editable: false
---

# Method read
Returns metric data from Monitoring.
 

 
## HTTP request {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v3/data/read
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
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
folderId | **string**<br><p>Required. ID of the folder that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p> 
query | **string**<br><p>Required. Query text.</p> 
fromTime | **string** (date-time)<br><p>Required. The beginning of the time interval, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
toTime | **string** (date-time)<br><p>Required. The end of the time interval, in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
downsampling | **object**<br><p>Required. Downsampling parameters.</p> <p>List of available aggregate functions for downsampling.</p> 
downsampling.<br>gridAggregation | **string**<br>Function that is used for downsampling.<br><ul> <li>GRID_AGGREGATION_MAX: Max value.</li> <li>GRID_AGGREGATION_MIN: Min value.</li> <li>GRID_AGGREGATION_SUM: Sum of values.</li> <li>GRID_AGGREGATION_AVG: Average value.</li> <li>GRID_AGGREGATION_LAST: Last value.</li> <li>GRID_AGGREGATION_COUNT: Total count of points.</li> </ul> 
downsampling.<br>gapFilling | **string**<br>Parameters for filling gaps in data.<br><ul> <li>GAP_FILLING_NULL: Returns ``null`` as a metric value and ``timestamp`` as a time series value.</li> <li>GAP_FILLING_NONE: Returns no value and no timestamp.</li> <li>GAP_FILLING_PREVIOUS: Returns the value from the previous time interval.</li> </ul> 
downsampling.<br>maxPoints | **string** (int64) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Maximum number of points to be returned.</p> 
downsampling.<br>gridInterval | **string** (int64) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point.</p> 
downsampling.<br>disabled | **boolean** (boolean) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Disable downsampling.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metrics": [
    {
      "alias": "string",
      "name": "string",
      "labels": "object",
      "type": "string",
      "timeseries": {
        "timestamps": [
          "string"
        ],

        // `metrics[].timeseries` includes only one of the fields `doubleValues`, `int64Values`
        "doubleValues": {
          "values": [
            "number"
          ]
        },
        "int64Values": {
          "values": [
            "string"
          ]
        },
        // end of the list of possible fields`metrics[].timeseries`

      }
    }
  ]
}
```

 
Field | Description
--- | ---
metrics[] | **object**<br><p>List of metrics with timeseries.</p> 
metrics[].<br>alias | **string**<br><p>Alias.</p> 
metrics[].<br>name | **string**<br><p>Name of the metric.</p> 
metrics[].<br>labels | **object**<br><p>List of metric labels as ``key:value`` pairs.</p> 
metrics[].<br>type | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
metrics[].<br>timeseries | **object**<br><p>Metric timeseries.</p> 
metrics[].<br>timeseries.<br>timestamps[] | **string** (date-time)<br><p>List of timestamps.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
metrics[].<br>timeseries.<br>doubleValues | **object**<br>List of double values. <br>`metrics[].timeseries` includes only one of the fields `doubleValues`, `int64Values`<br>
metrics[].<br>timeseries.<br>doubleValues.<br>values[] | **number** (double)
metrics[].<br>timeseries.<br>int64Values | **object**<br>List of int64 values. Only for `IGAUGE` or 'COUNTER' metric type. <br>`metrics[].timeseries` includes only one of the fields `doubleValues`, `int64Values`<br>
metrics[].<br>timeseries.<br>int64Values.<br>values[] | **string** (int64)