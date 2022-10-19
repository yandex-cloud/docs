---
editable: false
---

# Method addMetric
Saves monitoring events for specified job
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/monitorings/reportMetrics
```
 
## Body parameters {#body_params}
 
```json 
{
  "computeInstanceId": "string",
  "instanceHost": "string",
  "jobId": "string",
  "chunks": [
    {
      "data": [
        {
          "metricType": "string",
          "metricName": "string",
          "metricValue": "number"
        }
      ],
      "timestamp": "string",
      "comment": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
computeInstanceId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
instanceHost | **string**<br><p>Required.</p> 
jobId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
chunks[] | **object**<br><p>Required. Must contain at least one element.</p> 
chunks[].<br>data[] | **object**<br><p>Required. Must contain at least one element.</p> 
chunks[].<br>data[].<br>metricType | **string**<br><p>Required.</p> 
chunks[].<br>data[].<br>metricName | **string**<br><p>Required.</p> 
chunks[].<br>data[].<br>metricValue | **number** (double)
chunks[].<br>timestamp | **string** (int64)
chunks[].<br>comment | **string**
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metricTrailId": "string",
  "code": "string"
}
```

 
Field | Description
--- | ---
metricTrailId | **string**
code | **string** (int64)