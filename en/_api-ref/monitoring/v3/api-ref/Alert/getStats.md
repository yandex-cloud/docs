---
editable: false
---

# Method getStats
Folder stats.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/alerts:getStats
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "alertCount": "string",
  "evaluationStats": {
    "okCount": "string",
    "warnCount": "string",
    "alarmCount": "string",
    "errorCount": "string",
    "noDataCount": "string"
  },
  "notificationStats": {
    "unknown": "string",
    "success": "string",
    "error": "string",
    "invalidRequest": "string",
    "absentNotificationChannel": "string",
    "retryError": "string",
    "resourceExhausted": "string",
    "permissionDenied": "string",
    "notSubscribed": "string"
  }
}
```

 
Field | Description
--- | ---
alertCount | **string** (int64)<br>
evaluationStats | **object**<br>
evaluationStats.<br>okCount | **string** (int64)<br>
evaluationStats.<br>warnCount | **string** (int64)<br>
evaluationStats.<br>alarmCount | **string** (int64)<br>
evaluationStats.<br>errorCount | **string** (int64)<br>
evaluationStats.<br>noDataCount | **string** (int64)<br>
notificationStats | **object**<br>
notificationStats.<br>unknown | **string** (int64)<br>
notificationStats.<br>success | **string** (int64)<br>
notificationStats.<br>error | **string** (int64)<br>
notificationStats.<br>invalidRequest | **string** (int64)<br>
notificationStats.<br>absentNotificationChannel | **string** (int64)<br>
notificationStats.<br>retryError | **string** (int64)<br>
notificationStats.<br>resourceExhausted | **string** (int64)<br>
notificationStats.<br>permissionDenied | **string** (int64)<br>
notificationStats.<br>notSubscribed | **string** (int64)<br>