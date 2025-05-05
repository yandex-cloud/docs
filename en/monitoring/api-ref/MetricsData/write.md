---
editable: false
---

# Write method
Writes metric data.
 

## HTTP request {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v2/data/write
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | This is a required field. Metric folder ID. The maximum string length is 50 characters.
service | This is a required field. ID of the service associated with the metric. Use `service=custom` for custom metrics. The maximum string length is 50 characters.
 
## Request body parameters {#body_params}
 
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

 
Field | Description
--- | ---
ts | **string** (date-time)<br><p>Timestamp common for all metrics in the <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> 
labels | **object**<br><p>List of labels in <code>key:value</code> format, common for all metrics.</p> 
metrics[] | **object**<br><p>List of metrics.</p> 
metrics[].<br>name | **string**<br><p>This is a required field. Metric name.</p> 
metrics[].<br>labels | **object**<br><p>Metric labels in <code>key:value format</code>.</p> 
metrics[].<br>type | **string**<br><p>Metric type. Default value: <code>DGAUGE</code>.</p> <ul> <li>DGAUGE: Numeric value. Set as a fraction.</li> <li>IGAUGE: Numeric value. Set as an integer.</li> <li>COUNTER: Counter.</li></ul> 
metrics[].<br>ts | **string** (date-time)<br><p>Timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format. If not specified, the current time will be used.</p> 
metrics[].<br>value | **number** (double)<br><p>This is a required field. Metric value in the specified point.</p> 
metrics[].<br>timeseries[] | **object**<br><p>Point list.</p> 
metrics[].<br>timeseries[].<br>ts | **string** (date-time)<br><p>Timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> format.</p> 
metrics[].<br>timeseries[].<br>value | **number** (double)<br><p>Metric value in the specified point.</p> 

## Response {#responses}
**HTTP Code: 200 - OK**

```json
{
  "writtenMetricsCount": "string",
  "errorMessage": "string"
}
```

Field | Description
--- | ---
writtenMetricsCount | **string** (int64)<br><p>Number of successfully written metrics.</p> 
errorMessage | **string**<br><p>Error message if a write fails.</p> 
