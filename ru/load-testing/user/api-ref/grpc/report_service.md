---
editable: false
sourcePath: en/_api-ref-grpc/load-testing/user/user/api-ref/grpc/report_service.md
---

# Load Testing API, gRPC: ReportService

A set of methods for managing test reports.

| Call | Description |
| --- | --- |
| [GetTable](#GetTable) | Returns a report table for the specified test. |

## Calls ReportService {#calls}

## GetTable {#GetTable}

Returns a report table for the specified test.

**rpc GetTable ([GetTableReportRequest](#GetTableReportRequest)) returns ([GetTableReportResponse](#GetTableReportResponse))**

### GetTableReportRequest {#GetTableReportRequest}

Field | Description
--- | ---
test_id | **string**<br>Required. ID of the test for which report table will be returned. 


### GetTableReportResponse {#GetTableReportResponse}

Field | Description
--- | ---
status | **[report.Status](./#report)**<br>Status of report table. 
overall | **[report.table.Report](#Report)**<br>Result for all test cases combined ("overall" test case). 
cases | **map<string,report.table.Report>**<br>Results for individual test cases, mapped as `case_name:report`. 


### Report {#Report}

Field | Description
--- | ---
http_codes | **map<int64,int64>**<br>Total count of HTTP responses, grouped by HTTP response code. 
net_codes | **map<int64,int64>**<br>Total count of network responses, grouped by response code. 
quantiles | **[common.Quantiles](#Quantiles)**<br>Response time statistics, aggregated by quantiles. 


### Quantiles {#Quantiles}

Field | Description
--- | ---
q50 | **double**<br>50 percentile (median). 
q75 | **double**<br>75 percentile. 
q80 | **double**<br>80 percentile. 
q85 | **double**<br>85 percentile. 
q90 | **double**<br>90 percentile. 
q95 | **double**<br>95 percentile. 
q98 | **double**<br>98 percentile. 
q99 | **double**<br>99 percentile. 
q100 | **double**<br>100 percentile (maximum or minimum). 


