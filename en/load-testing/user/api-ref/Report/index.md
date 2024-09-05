---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Report/index.md
---

# Load Testing API, REST: Report methods
A set of methods for managing test reports.
## JSON Representation {#representation}
```json 
{
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
}
```
 
Field | Description
--- | ---
httpCodes | **object**<br><p>Total count of HTTP responses, grouped by HTTP response code.</p> 
netCodes | **object**<br><p>Total count of network responses, grouped by response code.</p> 
quantiles | **object**<br><p>Response time statistics, aggregated by quantiles.</p> <p>Statistical data aggregated by predefined set of quantiles.</p> 
quantiles.<br>q50 | **number** (double)<br><p>50 percentile (median).</p> 
quantiles.<br>q75 | **number** (double)<br><p>75 percentile.</p> 
quantiles.<br>q80 | **number** (double)<br><p>80 percentile.</p> 
quantiles.<br>q85 | **number** (double)<br><p>85 percentile.</p> 
quantiles.<br>q90 | **number** (double)<br><p>90 percentile.</p> 
quantiles.<br>q95 | **number** (double)<br><p>95 percentile.</p> 
quantiles.<br>q98 | **number** (double)<br><p>98 percentile.</p> 
quantiles.<br>q99 | **number** (double)<br><p>99 percentile.</p> 
quantiles.<br>q100 | **number** (double)<br><p>100 percentile (maximum or minimum).</p> 

## Methods {#methods}
Method | Description
--- | ---
[calculateKpiValues](calculateKpiValues.md) | Returns a list of KPI values for tests matching the specified filter.
[getTable](getTable.md) | Returns a report table for the specified test.