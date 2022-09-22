---
editable: false
---

# Method addMetric
Saves monitoring events for specified job
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/monitorings
```
 
## Body parameters {#body_params}
 
```json 
{
  "computeInstanceId": "string",
  "instanceHost": "string",
  "data": [
    {
      "metricType": "string",
      "metricName": "string",
      "metricValue": "number"
    }
  ],
  "jobId": "string",
  "timestamp": "string",
  "comment": "string"
}
```

 
Field | Description
--- | ---
computeInstanceId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
instanceHost | **string**<br><p>Required.</p> 
data[] | **object**<br><p>Required. Must contain at least one element.</p> 
data[].<br>metricType | **string**<br><p>Required.</p> 
data[].<br>metricName | **string**<br><p>Required.</p> 
data[].<br>metricValue | **number** (double)
jobId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
timestamp | **string** (int64)
comment | **string**
 
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