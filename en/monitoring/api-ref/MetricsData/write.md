---
editable: false
---

# Write method
Writes data about metrics.


## HTTP request {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v2/data/write
```

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | Required field. ID of the folder that the metric belongs to. Maximum string length: 50 characters. |
| service | Required field. ID of the service that the metric belongs to. Use `service=custom` for custom metrics. Maximum string length: 50 characters. |

## Parameters in the request body {#body_params}

```json
{
  "ts": "string",
  "labels": "object",
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string",
      "ts": "string",
      "value": "number",
      "timeseries": [
        {
          "ts": "string",
          "value": "number"
        }
      ]
    }
  ]
}
```


| Field | Description |
--- | ---
| ts | **string** (date-time)<br><p>Timestamp common for all metrics in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> |
| labels | **object**<br><p>List of labels in <code>key:value</code> format, which are common for all metrics being passed.</p> |
| metrics[] | **object**<br><p>List of metrics.</p> |
| metrics[].<br>name | **string**<br><p>Required field. Metric name.</p> |
| metrics[].<br>labels | **object**<br><p>List of metric labels in <code>key:value format</code>.</p> |
| metrics[].<br>type | **string**<br><p>Type of metric. Default value: <code>DGAUGE</code>.</p> <ul> <li>DGAUGE: Numeric value. Set as a fractional number.</li> <li>GAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li> <li>RATE: Derivative.</li> </ul> |
| metrics[].<br>ts | **string** (date-time)<br><p>Timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format. If not specified, the current time is used.</p> |
| metrics[].<br>value | **number** (double)<br><p>Required field. Metric value in the specified point.</p> |
| metrics[].<br>timeseries[] | **object**<br><p>List of multiple points.</p> |
| metrics[].<br>timeseries[].<br>ts | **string** (date-time)<br><p>Point in time in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> |
| metrics[].<br>timeseries[].<br>value | **number** (double)<br><p>Metric value in the specified point.</p> |

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "writtenMetricsCount": "string",
  "errorMessage": "string"
}
```

| Field | Description |
--- | ---
| writtenMetricsCount | **string** (int64)<br><p>Number of metrics that are written successfully.</p> |
| errorMessage | **string**<br><p>Error message returned if a write fails.</p> |
