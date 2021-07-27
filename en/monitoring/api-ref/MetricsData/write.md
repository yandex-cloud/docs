---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method write
Writes metric data to Monitoring.
 

 
## HTTP request {#https-request}
```
POST https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write
```

## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p>
service | <p>Required. ID of the service that the metric belongs to. Use <code>service=custom</code> for custom metrics.</p> <p>The maximum string length in characters is 50.</p>
 
## Body parameters {#body_params}
 
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
ts | **string** (date-time)<br><p>Common timestamp for all metrics in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
labels | **object**<br><p>Common labels for all metrics as <code>key:value</code> pairs.</p> 
metrics[] | **object**<br><p>List of metrics.</p> 
metrics[].<br>name | **string**<br><p>Required. Name of the metric.</p> 
metrics[].<br>labels | **object**<br><p>Metric labels as  <code>key:value</code> pairs.</p> 
metrics[].<br>type | **string**<br><p>Type of the metric. The default value is <code>DGAUGE</code>.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
metrics[].<br>ts | **string** (date-time)<br><p>Time point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. If it is not specified, the current time is used.</p> 
metrics[].<br>value | **number** (double)<br><p>Required. Metric value in the time point.</p> 
metrics[].<br>timeseries[] | **object**<br><p>List of several points.</p> 
metrics[].<br>timeseries[].<br>ts | **string** (date-time)<br><p>Time point in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
metrics[].<br>timeseries[].<br>value | **number** (double)<br><p>Metric value.</p>
 
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
errorMessage | **string**<br><p>Error message if the writing failed.</p> 
