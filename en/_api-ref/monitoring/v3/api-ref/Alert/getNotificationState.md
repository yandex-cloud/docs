---
editable: false
---

# Monitoring API, REST: Alert.getNotificationState

 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/alerts/{alertId}:getNotificationState
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | <p>Required. ID of the alert.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "channelStates": [
    {
      "folderId": "string",
      "channelId": "string",
      "status": "string",
      "latestEval": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
channelStates[] | **object**
channelStates[].<br>folderId | **string**<br><p>Reference to folder that contains alert.</p> 
channelStates[].<br>channelId | **string**<br><p>Reference to notification channel.</p> 
channelStates[].<br>status | **string**<br><p>Latest notification status.</p> <ul> <li>SKIP_REPEAT: Send notification was skipped because already notified.</li> <li>SKIP_BY_STATUS: Skip notification because status absent in subscribe list.</li> <li>SUCCESS: Notification successfully delivered.</li> <li>ERROR: Not classified kind of error occurs.</li> <li>INVALID_REQUEST: Target service reject notification because it not valid or notification channel configured. not correctly</li> <li>OBSOLETE: Notification not valid any more.</li> <li>ABSENT_NOTIFICATION_CHANNEL: Notification was send to /dev/null because reference notificaiton channel not exists.</li> <li>ERROR_ABLE_TO_RETRY: Notification should be repeated because target destination not ready yet accept it.</li> <li>RESOURCE_EXHAUSTED: One of the quote exhausted.</li> <li>PERMISSION_DENIED: User have no rights to receive notifications.</li> <li>NOT_SUBSCRIBED: User unsubscribed or missing settings (e.g. no phone specified).</li> </ul> 
channelStates[].<br>latestEval | **string** (date-time)<br><p>Time when notification was triggered latest time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 