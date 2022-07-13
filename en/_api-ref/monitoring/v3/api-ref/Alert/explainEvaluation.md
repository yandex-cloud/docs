---
editable: false
---

# Method explainEvaluation

 

 
## HTTP request {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v3/alerts/{alertId}:explainEvaluation
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "time": "string"
}
```

 
Field | Description
--- | ---
time | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "evaluationStatus": "string",
  "series": [
    {
      "alias": "string",
      "labels": "object",
      "timestamps": [
        "string"
      ],
      "values": [
        "number"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
evaluationStatus | **string**<br><ul> <li>EVALUATION_STATUS_OK: OK.</li> <li>EVALUATION_STATUS_WARN: Warning.</li> <li>EVALUATION_STATUS_ALARM: Alarm.</li> <li>EVALUATION_STATUS_NO_DATA: No data.</li> <li>EVALUATION_STATUS_ERROR: Error.</li> </ul> 
series[] | **object**
series[].<br>alias | **string**<br><p>Alias of timeseries, or empty if not specified.</p> 
series[].<br>labels | **object**<br><p>Labels of timeseries, or empty if absent by any reason.</p> 
series[].<br>timestamps[] | **string** (int64)<br><p>Array with timestamps of timeseries.</p> 
series[].<br>values[] | **number** (double)<br><p>Array with values of timeseries.</p> 