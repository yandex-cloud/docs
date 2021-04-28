---
editable: false
---

# Method getNotificationStats

 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v3/alerts/{alertId}:getNotificationStats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | Required. ID of the alert.  The maximum string length in characters is 50.
 
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