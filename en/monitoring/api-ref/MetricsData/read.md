---
editable: false
---
# read method

Returns metric data.

## HTTP request {#https-request}

```
POST https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read
```

## Query parameters {#query_params}

| Parameter | Description |
| --- | --- |
| folderId | Required field. ID of the folder that the metric belongs to.  Maximum string length: 50 characters. |

## Parameters in the request body {#body_params}

```json
{
  "query": "string",
  "fromTime": "string",
  "toTime": "string",
  "downsampling": {
    "gridAggregation": "string",
    "gapFilling": "string",

    // `downsampling` only includes one of the `maxPoints`, `gridInterval`, or `disabled` fields
    "maxPoints": "string",
    "gridInterval": "string",
    "disabled": true,
    // end of the list of possible `downsampling` fields

  }
}
```

| Field | Description |
| --- | --- |
| query | **string**<br><p>Required field. Query text. The syntax is described in [{#T}](../../concepts/querying.md).</p> |
| fromTime | **string** (date-time)<br><p>Required field. Interval starting point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> |
| toTime | **string** (date-time)<br><p>Required field. Interval end point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> |
| downsampling | **object**<br><p>Required field. Downsampling parameters.</p> |
| downsampling.<br>gridAggregation | **string**<br>An aggregation function that is used for downsampling.<br><br><p>List of available aggregation functions that are used at downsampling.</p> <ul> <li>MAX: Maximum.</li> <li>MIN: Minimum.</li> <li>SUM: Sum.</li> <li>AVG: Average value. Default value.</li> <li>LAST: Last value.</li> <li>COUNT: Point count.</li> </ul> |
| downsampling.<br>gapFilling | **string**<br>Parameters for filling in data gaps.<br><br><p>List of methods for filling in data gaps at downsampling.</p> <ul> <li>NULL: Returns <code>null</code> as a metric value and <code>timestamp</code> as a timestamp. Default value.</li> <li>NONE: Returns no values.</li> <li>PREVIOUS: Returns a value from the previous point.</li> </ul> |
| downsampling.<br>maxPoints | **string** (int64) <br>`downsampling` includes only one of the fields `maxPoints`, `gridInterval`, or `disabled`<br><br><p>The maximum number of points to be returned in the response to the query.</p> <p>The value must be greater than 10.</p> |
| downsampling.<br>gridInterval | **string** (int64) <br>`downsampling` only includes one of the fields `maxPoints`, `gridInterval`, or `disabled`<br><br><p>The width of the time window (grid) in milliseconds. Used for downsampling. Points inside the window are combined into one using the aggregation function.</p> <p>The value must be greater than 0.</p> |
| downsampling.<br>disabled | **boolean** (boolean) <br>`downsampling` only includes one of the fields `maxPoints`, `gridInterval`, or `disabled`<br><br><p>Indicates that the data in the response to the query will be returned without downsampling.</p> |

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

| Field | Description |
| --- | --- |
| metrics[] | **object**<br><p>List of the metrics with time points.</p> |
| metrics[].<br>name | **string**<br><p>Metric name.</p> |
| metrics[].<br>labels | **object**<br><p>List of metric labels in <code>key:value</code> format.</p> |
| metrics[].<br>type | **string**<br><p>Metric type.</p> <ul> <li>DGAUGE: Numeric value. Set as a fractional number.</li> <li>GAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li> <li>RATE: Derivative.</li> </ul> |
| metrics[].<br>timeseries | **object**<br><p>Metric values.</p> |
| metrics[].<br>timeseries.<br>timestamps[] | **number** (int64)<br><p>List of time stamps in the format of Unix milliseconds.</p> |
| metrics[].<br>timeseries.<br>doubleValues[] | **number** (double)<br><p>List of fractional metric values.</p> |
| metrics[].<br>timeseries.<br>int64Values[] | **number** (int64)<br><p>List of integer metric values. Only available for metrics of the <code>IGAUGE</code> type.</p> |

