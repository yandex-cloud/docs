---
editable: false
---

# Method write
Writes metric data to Monitoring.
 

 
## HTTP request {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v1/data/write
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cloudId | Required. ID of the cloud that the metric belongs to.  The maximum string length in characters is 50.
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
service | Required. ID of the service that the metric belongs to. Use `service=custom` for custom metrics.
 
## Body parameters {#body_params}
 
```json 
{
  "ts": "string",
  "labels": "object",
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "kind": "string",
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
ts | **string** (int64)<br><p>Common timestamp for all metrics.</p> 
labels | **object**<br><p>Common labels for all metrics as <code>key:value</code> pairs.</p> 
metrics[] | **object**<br><p>List of metrics.</p> 
metrics[].<br>name | **string**<br><p>Name of the metric.</p> 
metrics[].<br>labels | **object**<br><p>Metric labels as <code>key:value</code> pairs.</p> 
metrics[].<br>kind | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
metrics[].<br>ts | **string** (int64)<br><p>Time point in the <code>timestamp</code> format. If it is not specified, the current time is used.</p> 
metrics[].<br>value | **number** (double)<br><p>Metric value in the time point.</p> 
metrics[].<br>timeseries[] | **object**<br><p>List of several points.</p> 
metrics[].<br>timeseries[].<br>ts | **string** (int64)<br><p>Time point in the <code>timestamp</code> format.</p> 
metrics[].<br>timeseries[].<br>value | **number** (double)<br><p>Metric value.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metricsPushed": "string",
  "errorMessage": "string"
}
```

 
Field | Description
--- | ---
metricsPushed | **string** (int64)<br><p>Number of successfully written metrics.</p> 
errorMessage | **string**<br><p>Error message if the writing failed.</p> 