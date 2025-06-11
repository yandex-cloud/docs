---
editable: false
---

# read method
Returns metric data.



## HTTP request {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v2/data/read
```

## Query parameters {#query_params}

Parameter | Description
--- | ---
folderId | This is a required field. Metric folder ID. The maximum string length is 50 characters.

## Request body parameters {#body_params}

```json
{
  "query": "string",
  "fromTime": "string",
  "toTime": "string",
  "downsampling": {
    "gridAggregation": "string",
    "gapFilling": "string",

    // `downsampling` only includes one of these fields: `maxPoints`, `gridInterval`, or `disabled`
    "maxPoints": "string",
    "gridInterval": "string",
    "disabled": true,
    // end of the list of possible `downsampling` fields

  }
}
```


Field | Description
--- | ---
query | **string**<br><p>This is a required field. Query text. To learn about its syntax, see [{#T}](../../concepts/querying.md).</p>
fromTime | **string** (date-time)<br><p>This is a required field. Time interval starting point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p><p>e.g., `2025-05-15T15:30:00Z`.</p><p>Where:<br><ul><li>`2025-05-15`: Date (year, month, day).</li><li>`T`: Separator between date and time.</li><li>`15:30:00`: Time (hours, minutes, seconds).</li><li>`Z`: Time zone in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).</li></ul></p>
toTime | **string** (date-time)<br><p>This is a required field. Time interval end point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p><p>e.g., `2025-05-15T15:30:00Z`.</p><p>Where:<br><ul><li>`2025-05-15`: Date (year, month, day).</li><li>`T`: Separator between date and time.</li><li>`15:30:00`: Time (hours, minutes, seconds).</li><li>`Z`: Time zone in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).</li></ul></p>
downsampling | **object**<br><p>This is a required field. Downsampling parameters.</p>
downsampling.<br>gridAggregation | **string**<br>Downsampling aggregation function.<br><br><p>Available downsampling aggregation functions.</p> <ul> <li>MAX: Maximum</li> <li>MIN: Minimum</li> <li>SUM: Total</li> <li>AVG: Average value, default value.</li> <li>LAST: Last value</li> <li>COUNT: Point count</li> </ul>
downsampling.<br>gapFilling | **string**<br>Parameters for filling in missing data.<br><br><p>Methods for filling gaps in data during downsampling.</p> <ul> <li>NULL: Returns <code>null</code> as the metric value and <code>timestamp</code> as the timestamp value. This is a default value.</li> <li>NONE: Returns no values.</li> <li>PREVIOUS: Returns the value of the previous data point.</li> </ul>
downsampling.<br>maxPoints | **string** (int64) <br>`downsampling` only includes one of these fields: `maxPoints`, `gridInterval`, or `disabled`<br><br><p>Maximum number of points per request.</p> <p>This value must be greater than 10.</p>
downsampling.<br>gridInterval | **string** (int64) <br>`downsampling` only includes one of these fields: `maxPoints`, `gridInterval`, or `disabled`<br><br><p>Time window, i.e., grid, size in milliseconds. Used for downsampling. Data points within this time window are merged into a single value using the selected aggregation function.</p> <p>This value must be greater than 0.</p>
downsampling.<br>disabled | **boolean** (boolean) <br>`downsampling` only includes one of these fields: `maxPoints`, `gridInterval`, or `disabled`<br><br><p>Indicates that the response data will not be downsampled.</p>

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
          "number"
        ],
        "doubleValues": [
          "number"
        ],
        "int64Values": [
          "number"
        ]
      }
    }
  ]
}
```


Field | Description
--- | ---
metrics[] | **object**<br><p>Metrics with timestamps.</p>
metrics[].<br>name | **string**<br><p>Metric name.</p>
metrics[].<br>labels | **object**<br><p>Metric labels in <code>key:value format</code>.</p>
metrics[].<br>type | **string**<br><p>Metric type.</p> <ul> <li>DGAUGE: Numeric value. Set as a fraction.</li> <li>IGAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li> <li>RATE: Derivative value.</li> </ul>
metrics[].<br>timeseries | **object**<br><p>Metric values.</p>
metrics[].<br>timeseries.<br>timestamps[] | **number** (int64)<br><p>List of timestamps in Unix millisecond format.</p>
metrics[].<br>timeseries.<br>doubleValues[] | **number** (double)<br><p>List of fractional metric values.</p>
metrics[].<br>timeseries.<br>int64Values[] | **number** (int64)<br><p>List of integer metric values. Only available for <code>IGAUGE</code> type metrics.</p>