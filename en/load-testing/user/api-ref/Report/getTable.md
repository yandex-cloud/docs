---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Report/getTable.md
---

# Load Testing API, REST: Report.getTable
Returns a report table for the specified test.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/reports/{testId}/table
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
testId | <p>Required. ID of the test for which report table will be returned.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "status": "string",
  "overall": {
    "httpCodes": "object",
    "netCodes": "object",
    "quantiles": {
      "q50": "number",
      "q75": "number",
      "q80": "number",
      "q85": "number",
      "q90": "number",
      "q95": "number",
      "q98": "number",
      "q99": "number",
      "q100": "number"
    }
  },
  "cases": "object"
}
```

 
Field | Description
--- | ---
status | **string**<br><p>Status of report table.</p> <p>Report status.</p> <ul> <li>STATUS_UNSPECIFIED: Status is not specified. - COLLECTING: Report is being collected.</li> <li>CALCULATING: Report is being calculated.</li> <li>READY: Report is ready.</li> </ul> 
overall | **object**<br><p>Result for all test cases combined ("overall" test case).</p> <p>Aggregated test results.</p> 
overall.<br>httpCodes | **object**<br><p>Total count of HTTP responses, grouped by HTTP response code.</p> 
overall.<br>netCodes | **object**<br><p>Total count of network responses, grouped by response code.</p> 
overall.<br>quantiles | **object**<br><p>Response time statistics, aggregated by quantiles.</p> <p>Statistical data aggregated by predefined set of quantiles.</p> 
overall.<br>quantiles.<br>q50 | **number** (double)<br><p>50 percentile (median).</p> 
overall.<br>quantiles.<br>q75 | **number** (double)<br><p>75 percentile.</p> 
overall.<br>quantiles.<br>q80 | **number** (double)<br><p>80 percentile.</p> 
overall.<br>quantiles.<br>q85 | **number** (double)<br><p>85 percentile.</p> 
overall.<br>quantiles.<br>q90 | **number** (double)<br><p>90 percentile.</p> 
overall.<br>quantiles.<br>q95 | **number** (double)<br><p>95 percentile.</p> 
overall.<br>quantiles.<br>q98 | **number** (double)<br><p>98 percentile.</p> 
overall.<br>quantiles.<br>q99 | **number** (double)<br><p>99 percentile.</p> 
overall.<br>quantiles.<br>q100 | **number** (double)<br><p>100 percentile (maximum or minimum).</p> 
cases | **object**<br><p>Results for individual test cases, mapped as ``case_name:report``.</p> 