---
editable: false
---

# Method getMonitoringReport

 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/tests/{testId}/hosts/{host}/monitoring
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
testId | <p>Required. The maximum string length in characters is 50.</p> 
host | <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "testId": "string",
  "charts": [
    {
      "monitoredHost": "string",
      "testId": "string",
      "name": "string",
      "description": "string",
      "ts": [
        "string"
      ],
      "responsesPerSecond": [
        "string"
      ],
      "threads": [
        "string"
      ],
      "metricData": [
        {
          "caseName": "string",
          "metricName": "string",
          "metricValue": [
            "number"
          ],
          "disabled": true
        }
      ],
      "xAxisLabel": "string",
      "yAxisLabel": "string"
    }
  ],
  "finished": true
}
```

 
Field | Description
--- | ---
testId | **string**
charts[] | **object**
charts[].<br>monitoredHost | **string**
charts[].<br>testId | **string**
charts[].<br>name | **string**
charts[].<br>description | **string**
charts[].<br>ts[] | **string** (int64)
charts[].<br>responsesPerSecond[] | **string** (int64)
charts[].<br>threads[] | **string** (int64)
charts[].<br>metricData[] | **object**
charts[].<br>metricData[].<br>caseName | **string**
charts[].<br>metricData[].<br>metricName | **string**
charts[].<br>metricData[].<br>metricValue[] | **number** (double)
charts[].<br>metricData[].<br>disabled | **boolean** (boolean)
charts[].<br>xAxisLabel | **string**
charts[].<br>yAxisLabel | **string**
finished | **boolean** (boolean)