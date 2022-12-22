---
editable: false
---

# Monitoring API, REST: Alert.getNotificationStats

 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/alerts/{alertId}:getNotificationStats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | <p>Required. ID of the alert.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
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
notificationStats | **object**
notificationStats.<br>unknown | **string** (int64)
notificationStats.<br>success | **string** (int64)
notificationStats.<br>error | **string** (int64)
notificationStats.<br>invalidRequest | **string** (int64)
notificationStats.<br>absentNotificationChannel | **string** (int64)
notificationStats.<br>retryError | **string** (int64)
notificationStats.<br>resourceExhausted | **string** (int64)
notificationStats.<br>permissionDenied | **string** (int64)
notificationStats.<br>notSubscribed | **string** (int64)