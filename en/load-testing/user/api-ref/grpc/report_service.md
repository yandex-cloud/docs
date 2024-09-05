---
editable: false
sourcePath: en/_api-ref-grpc/load-testing/user/user/api-ref/grpc/report_service.md
---

# Load Testing API, gRPC: ReportService

A set of methods for managing test reports.

| Call | Description |
| --- | --- |
| [GetTable](#GetTable) | Returns a report table for the specified test. |
| [CalculateKpiValues](#CalculateKpiValues) | Returns a list of KPI values for tests matching the specified filter. |

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
status | enum **report.Status**<br>Status of report table. <ul><li>`STATUS_UNSPECIFIED`: Status is not specified.</li><li>`COLLECTING`: Report is being collected.</li><li>`CALCULATING`: Report is being calculated.</li><li>`READY`: Report is ready.</li></ul>
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


## CalculateKpiValues {#CalculateKpiValues}

Returns a list of KPI values for tests matching the specified filter.

**rpc CalculateKpiValues ([CalculateReportKpiValuesRequest](#CalculateReportKpiValuesRequest)) returns ([CalculateReportKpiValuesResponse](#CalculateReportKpiValuesResponse))**

### CalculateReportKpiValuesRequest {#CalculateReportKpiValuesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder containing tests. The maximum string length in characters is 50.
test_filter | **string**<br>Required. Test filter selector to calculate KPI values for. The maximum string length in characters is 1000.
test_case | **string**<br>Test case to calculate KPI values for. <br>If not specified, KPI values will be calculated for 'overall' case. The maximum string length in characters is 100.
kpi | **[report.Kpi](#Kpi)**<br>Required. KPI to be calculated. 


### Kpi {#Kpi}

Field | Description
--- | ---
selector | **[KpiSelector](#KpiSelector)**<br>Kind of KPI. 
threshold | **[KpiThreshold](#KpiThreshold)**<br>A condition that should be specified. 


### KpiSelector {#KpiSelector}

Field | Description
--- | ---
kind | **oneof:** `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute` or `network_codes_relative`<br>Imbalance RPS.
&nbsp;&nbsp;response_time | **[ResponseTime](#ResponseTime)**<br>Response time cummulative quantile (percentile). 
&nbsp;&nbsp;instances | **[Instances](#Instances)**<br>A number of instances throughout the test. 
&nbsp;&nbsp;imbalance_rps | **[ImbalanceRps](#ImbalanceRps)**<br>An RPS at the moment the test has been auto-stopped. 
&nbsp;&nbsp;protocol_codes_absolute | **[ProtocolCodesAbsolute](#ProtocolCodesAbsolute)**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;protocol_codes_relative | **[ProtocolCodesRelative](#ProtocolCodesRelative)**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;network_codes_absolute | **[NetworkCodesAbsolute](#NetworkCodesAbsolute)**<br>A total number of requests completed with certain network codes. 
&nbsp;&nbsp;network_codes_relative | **[NetworkCodesRelative](#NetworkCodesRelative)**<br>A percentage of requests completed with certain network codes. 


### ResponseTime {#ResponseTime}

Field | Description
--- | ---
quantile | enum **common.QuantileType**<br>Cummulative quantile (percentile). <ul><li>`QUANTILE_TYPE_UNSPECIFIED`: Unspecified percentile.</li><li>`QUANTILE_TYPE_50`: 50 percentile (median).</li><li>`QUANTILE_TYPE_75`: 75 percentile.</li><li>`QUANTILE_TYPE_80`: 80 percentile.</li><li>`QUANTILE_TYPE_85`: 85 percentile.</li><li>`QUANTILE_TYPE_90`: 90 percentile.</li><li>`QUANTILE_TYPE_95`: 95 percentile.</li><li>`QUANTILE_TYPE_98`: 98 percentile.</li><li>`QUANTILE_TYPE_99`: 99 percentile.</li><li>`QUANTILE_TYPE_100`: 100 percentile (maximum or minimum).</li></ul>


### Instances {#Instances}

Field | Description
--- | ---
agg | enum **Aggregation**<br>Aggregation function. <ul><li>`AGGREGATION_UNSPECIFIED`: Unspecified.</li><li>`AGGREGATION_MIN`: Minimum.</li><li>`AGGREGATION_MAX`: Maximum.</li><li>`AGGREGATION_AVG`: Average.</li><li>`AGGREGATION_MEDIAN`: Median.</li><li>`AGGREGATION_STD_DEV`: Standard deviation.</li></ul>


### ImbalanceRps {#ImbalanceRps}

Empty.

### ProtocolCodesAbsolute {#ProtocolCodesAbsolute}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### ProtocolCodesRelative {#ProtocolCodesRelative}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### NetworkCodesAbsolute {#NetworkCodesAbsolute}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### NetworkCodesRelative {#NetworkCodesRelative}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### KpiThreshold {#KpiThreshold}

Field | Description
--- | ---
value | **double**<br>Value for comparison with an actual KPI value. 
comparison | enum **Comparison**<br>Comparison operator for comparing actual with the threshold value. <br>Rule: actual (</<=/>/>=) reference <ul><li>`COMPARISON_UNSPECIFIED`: Unspecified.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li></ul>


### CalculateReportKpiValuesResponse {#CalculateReportKpiValuesResponse}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder. 
values[] | **[report.KpiValue](#KpiValue)**<br>Actual KPI values. 


### KpiValue {#KpiValue}

Field | Description
--- | ---
test_id | **string**<br>ID of a test. 
value | **double**<br>Value of KPI. 
is_ok | **bool**<br>A flag indicating whether the value satisfies KPI threshold condition. 


