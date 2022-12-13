---
editable: false
---

# Monitoring API, REST: Alert.getEvaluationStats

 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/alerts/{alertId}:getEvaluationStats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | <p>Required. ID of the alert.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "evaluationStats": {
    "okCount": "string",
    "warnCount": "string",
    "alarmCount": "string",
    "errorCount": "string",
    "noDataCount": "string"
  }
}
```

 
Field | Description
--- | ---
evaluationStats | **object**
evaluationStats.<br>okCount | **string** (int64)
evaluationStats.<br>warnCount | **string** (int64)
evaluationStats.<br>alarmCount | **string** (int64)
evaluationStats.<br>errorCount | **string** (int64)
evaluationStats.<br>noDataCount | **string** (int64)