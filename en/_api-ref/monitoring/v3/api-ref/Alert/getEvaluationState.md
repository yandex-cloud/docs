---
editable: false
---

# Monitoring API, REST: Alert.getEvaluationState

 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/alerts/{alertId}:getEvaluationState
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | <p>Required. ID of the Alert.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "folderId": "string",
  "alertId": "string",
  "alertVersion": "string",
  "status": "string",
  "since": "string",
  "latestEval": "string",
  "previousStatus": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Reference to folder that contains alert.</p> 
alertId | **string**<br><p>Unique identity for alert.</p> 
alertVersion | **string** (int64)<br><p>Version of alert that will be use to evaluate latest time. Each change of alert reset state.</p> 
status | **string**<br><p>Evaluation status and details. It's status of latest change between statuses, for example from OK to ALARM.</p> <ul> <li>EVALUATION_STATUS_OK: OK.</li> <li>EVALUATION_STATUS_WARN: Warning.</li> <li>EVALUATION_STATUS_ALARM: Alarm.</li> <li>EVALUATION_STATUS_NO_DATA: No data.</li> <li>EVALUATION_STATUS_ERROR: Error.</li> </ul> 
since | **string** (date-time)<br><p>Time when evaluation state will changed latest time, for example from OK to ALARM.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
latestEval | **string** (date-time)<br><p>UNIX time when latest alert evaluation occurs. Since - LatestEval = how much time alert in particular state.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
previousStatus | **string**<br><p>Evaluation status and details. It's status of previous change between statuses, for example from OK to ALARM.</p> <ul> <li>EVALUATION_STATUS_OK: OK.</li> <li>EVALUATION_STATUS_WARN: Warning.</li> <li>EVALUATION_STATUS_ALARM: Alarm.</li> <li>EVALUATION_STATUS_NO_DATA: No data.</li> <li>EVALUATION_STATUS_ERROR: Error.</li> </ul> 