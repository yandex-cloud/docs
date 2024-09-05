---
editable: false
sourcePath: en/_api-ref-grpc/load-testing/user/user/api-ref/grpc/regression_dashboard_service.md
---

# Load Testing API, gRPC: RegressionDashboardService

A set of methods for managing Load Testing Regression Dashboards.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a regression dashboard in the specified folder. |
| [Get](#Get) | Returns the specified regression dashboard. |
| [List](#List) | Retrieves the list of regression dashboards in the specified folder. |
| [Delete](#Delete) | Deletes the specified regression dashboard. |
| [Update](#Update) | Updates the specified regression dashboard. |

## Calls RegressionDashboardService {#calls}

## Create {#Create}

Creates a regression dashboard in the specified folder.

**rpc Create ([CreateRegressionDashboardRequest](#CreateRegressionDashboardRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateRegressionDashboardMetadata](#CreateRegressionDashboardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[regression.Dashboard](#Dashboard)<br>

### CreateRegressionDashboardRequest {#CreateRegressionDashboardRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a regression dashboard in. The maximum string length in characters is 50.
name | **string**<br>Name of the dashboard. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the dashboard. The maximum string length in characters is 1024.
content | **[regression.Dashboard.Content](./regression/dashboard#Dashboard)**<br>Content of the dashboard. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateRegressionDashboardMetadata](#CreateRegressionDashboardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[regression.Dashboard](#Dashboard)>**<br>if operation finished successfully. 


### CreateRegressionDashboardMetadata {#CreateRegressionDashboardMetadata}

Field | Description
--- | ---
dashboard_id | **string**<br>ID of the dashboard that is being created. 


### Dashboard {#Dashboard}

Field | Description
--- | ---
id | **string**<br>ID of the dashboard. 
name | **string**<br>Name of the dashboard. 
description | **string**<br>Description of the dashboard. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last update timestamp. 
created_by | **string**<br>UA or SA that created the dashboard. 
updated_by | **string**<br>UA or SA that updated the dashboard last time. 
etag | **string**<br>Etag of the dashboard. 
content | **[Content](#Content)**<br>Dashboard content. 


### Content {#Content}

Field | Description
--- | ---
widgets[] | **[Widget](#Widget)**<br>Widgets. 


### Widget {#Widget}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition)**<br>Widget position. 
widget | **oneof:** `chart`, `text` or `title`<br>
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget)**<br>Chart widget. 
&nbsp;&nbsp;text | **[TextWidget](#TextWidget)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget)**<br>Title widget. 


### LayoutPosition {#LayoutPosition}

Field | Description
--- | ---
x | **int64**<br>X. 
y | **int64**<br>Y. 
width | **int64**<br>Width. 
height | **int64**<br>Height. 


### ChartWidget {#ChartWidget}

Field | Description
--- | ---
id | **string**<br>ID of the chart. 
name | **string**<br>Name of the chart. 
description | **string**<br>Description of the chart. 
filter_str | **string**<br>Test filter selector to show KPI values for. 
test_case | **string**<br>Test case to show KPI values for. 
kpis[] | **[report.Kpi](#Kpi)**<br>KPIs to show. 


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


### TextWidget {#TextWidget}

Field | Description
--- | ---
text | **string**<br>Text string. 


### TitleWidget {#TitleWidget}

Field | Description
--- | ---
text | **string**<br>Title string. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_UNSPECIFIED`: Unspecified.</li><li>`TITLE_SIZE_XS`: Extra small.</li><li>`TITLE_SIZE_S`: Small.</li><li>`TITLE_SIZE_M`: Medium.</li><li>`TITLE_SIZE_L`: Large.</li></ul>


## Get {#Get}

Returns the specified regression dashboard. <br>To get the list of all available regression dashboards, make a [List](#List) request.

**rpc Get ([GetRegressionDashboardRequest](#GetRegressionDashboardRequest)) returns ([regression.Dashboard](#Dashboard1))**

### GetRegressionDashboardRequest {#GetRegressionDashboardRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. ID of the dashboard to return. The maximum string length in characters is 50.


### Dashboard {#Dashboard1}

Field | Description
--- | ---
id | **string**<br>ID of the dashboard. 
name | **string**<br>Name of the dashboard. 
description | **string**<br>Description of the dashboard. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last update timestamp. 
created_by | **string**<br>UA or SA that created the dashboard. 
updated_by | **string**<br>UA or SA that updated the dashboard last time. 
etag | **string**<br>Etag of the dashboard. 
content | **[Content](#Content1)**<br>Dashboard content. 


### Content {#Content1}

Field | Description
--- | ---
widgets[] | **[Widget](#Widget1)**<br>Widgets. 


### Widget {#Widget1}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition1)**<br>Widget position. 
widget | **oneof:** `chart`, `text` or `title`<br>
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget1)**<br>Chart widget. 
&nbsp;&nbsp;text | **[TextWidget](#TextWidget1)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget1)**<br>Title widget. 


### LayoutPosition {#LayoutPosition1}

Field | Description
--- | ---
x | **int64**<br>X. 
y | **int64**<br>Y. 
width | **int64**<br>Width. 
height | **int64**<br>Height. 


### ChartWidget {#ChartWidget1}

Field | Description
--- | ---
id | **string**<br>ID of the chart. 
name | **string**<br>Name of the chart. 
description | **string**<br>Description of the chart. 
filter_str | **string**<br>Test filter selector to show KPI values for. 
test_case | **string**<br>Test case to show KPI values for. 
kpis[] | **[report.Kpi](#Kpi1)**<br>KPIs to show. 


### Kpi {#Kpi1}

Field | Description
--- | ---
selector | **[KpiSelector](#KpiSelector1)**<br>Kind of KPI. 
threshold | **[KpiThreshold](#KpiThreshold1)**<br>A condition that should be specified. 


### KpiSelector {#KpiSelector1}

Field | Description
--- | ---
kind | **oneof:** `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute` or `network_codes_relative`<br>Imbalance RPS.
&nbsp;&nbsp;response_time | **[ResponseTime](#ResponseTime1)**<br>Response time cummulative quantile (percentile). 
&nbsp;&nbsp;instances | **[Instances](#Instances1)**<br>A number of instances throughout the test. 
&nbsp;&nbsp;imbalance_rps | **[ImbalanceRps](#ImbalanceRps1)**<br>An RPS at the moment the test has been auto-stopped. 
&nbsp;&nbsp;protocol_codes_absolute | **[ProtocolCodesAbsolute](#ProtocolCodesAbsolute1)**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;protocol_codes_relative | **[ProtocolCodesRelative](#ProtocolCodesRelative1)**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;network_codes_absolute | **[NetworkCodesAbsolute](#NetworkCodesAbsolute1)**<br>A total number of requests completed with certain network codes. 
&nbsp;&nbsp;network_codes_relative | **[NetworkCodesRelative](#NetworkCodesRelative1)**<br>A percentage of requests completed with certain network codes. 


### ResponseTime {#ResponseTime1}

Field | Description
--- | ---
quantile | enum **common.QuantileType**<br>Cummulative quantile (percentile). <ul><li>`QUANTILE_TYPE_UNSPECIFIED`: Unspecified percentile.</li><li>`QUANTILE_TYPE_50`: 50 percentile (median).</li><li>`QUANTILE_TYPE_75`: 75 percentile.</li><li>`QUANTILE_TYPE_80`: 80 percentile.</li><li>`QUANTILE_TYPE_85`: 85 percentile.</li><li>`QUANTILE_TYPE_90`: 90 percentile.</li><li>`QUANTILE_TYPE_95`: 95 percentile.</li><li>`QUANTILE_TYPE_98`: 98 percentile.</li><li>`QUANTILE_TYPE_99`: 99 percentile.</li><li>`QUANTILE_TYPE_100`: 100 percentile (maximum or minimum).</li></ul>


### Instances {#Instances1}

Field | Description
--- | ---
agg | enum **Aggregation**<br>Aggregation function. <ul><li>`AGGREGATION_UNSPECIFIED`: Unspecified.</li><li>`AGGREGATION_MIN`: Minimum.</li><li>`AGGREGATION_MAX`: Maximum.</li><li>`AGGREGATION_AVG`: Average.</li><li>`AGGREGATION_MEDIAN`: Median.</li><li>`AGGREGATION_STD_DEV`: Standard deviation.</li></ul>


### ImbalanceRps {#ImbalanceRps1}

Empty.

### ProtocolCodesAbsolute {#ProtocolCodesAbsolute1}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### ProtocolCodesRelative {#ProtocolCodesRelative1}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### NetworkCodesAbsolute {#NetworkCodesAbsolute1}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### NetworkCodesRelative {#NetworkCodesRelative1}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### KpiThreshold {#KpiThreshold1}

Field | Description
--- | ---
value | **double**<br>Value for comparison with an actual KPI value. 
comparison | enum **Comparison**<br>Comparison operator for comparing actual with the threshold value. <br>Rule: actual (</<=/>/>=) reference <ul><li>`COMPARISON_UNSPECIFIED`: Unspecified.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li></ul>


### TextWidget {#TextWidget1}

Field | Description
--- | ---
text | **string**<br>Text string. 


### TitleWidget {#TitleWidget1}

Field | Description
--- | ---
text | **string**<br>Title string. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_UNSPECIFIED`: Unspecified.</li><li>`TITLE_SIZE_XS`: Extra small.</li><li>`TITLE_SIZE_S`: Small.</li><li>`TITLE_SIZE_M`: Medium.</li><li>`TITLE_SIZE_L`: Large.</li></ul>


## List {#List}

Retrieves the list of regression dashboards in the specified folder.

**rpc List ([ListRegressionDashboardsRequest](#ListRegressionDashboardsRequest)) returns ([ListRegressionDashboardsResponse](#ListRegressionDashboardsResponse))**

### ListRegressionDashboardsRequest {#ListRegressionDashboardsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list dashboards in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRegressionDashboardsResponse.next_page_token](#ListRegressionDashboardsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRegressionDashboardsResponse.next_page_token](#ListRegressionDashboardsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters dashboards listed in the response. <br>The filter expression may contain multiple field expressions joined by `AND`. The field expression must specify: <ol><li>The field name. </li><li>An operator: </li><li>`=`, `!=`, `CONTAINS`, for single values. </li><li>`IN` or `NOT IN` for lists of values. </li><li>The value. String values must be encosed in `"`, boolean values are {`true`, `false`}, timestamp values in ISO-8601. </li></ol><br>Currently supported fields: <ul><li>`id` `yandex.cloud.loadtesting.api.v1.regression.Dashboard.id` </li><li>operators: `=`, `!=`, `IN`, `NOT IN` </li><li>`name` `yandex.cloud.loadtesting.api.v1.regression.Dashboard.name` </li><li>operators: `=`, `!=`, `IN`, `NOT IN`, `CONTAINS` </li></ul><br>Examples: <ul><li>`id IN ("1", "2", "3")` </li><li>`name CONTAINS "my-dashboard" AND id NOT IN ("4", "5")`</li></ul> The maximum string length in characters is 1000.


### ListRegressionDashboardsResponse {#ListRegressionDashboardsResponse}

Field | Description
--- | ---
dashboards[] | **[regression.Dashboard](#Dashboard2)**<br>List of dashboards in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListRegressionDashboardsRequest.page_size](#ListRegressionDashboardsRequest), use `next_page_token` as the value for the [ListRegressionDashboardsRequest.page_token](#ListRegressionDashboardsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. The maximum string length in characters is 100.


### Dashboard {#Dashboard2}

Field | Description
--- | ---
id | **string**<br>ID of the dashboard. 
name | **string**<br>Name of the dashboard. 
description | **string**<br>Description of the dashboard. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last update timestamp. 
created_by | **string**<br>UA or SA that created the dashboard. 
updated_by | **string**<br>UA or SA that updated the dashboard last time. 
etag | **string**<br>Etag of the dashboard. 
content | **[Content](#Content2)**<br>Dashboard content. 


### Content {#Content2}

Field | Description
--- | ---
widgets[] | **[Widget](#Widget2)**<br>Widgets. 


### Widget {#Widget2}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition2)**<br>Widget position. 
widget | **oneof:** `chart`, `text` or `title`<br>
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget2)**<br>Chart widget. 
&nbsp;&nbsp;text | **[TextWidget](#TextWidget2)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget2)**<br>Title widget. 


### LayoutPosition {#LayoutPosition2}

Field | Description
--- | ---
x | **int64**<br>X. 
y | **int64**<br>Y. 
width | **int64**<br>Width. 
height | **int64**<br>Height. 


### ChartWidget {#ChartWidget2}

Field | Description
--- | ---
id | **string**<br>ID of the chart. 
name | **string**<br>Name of the chart. 
description | **string**<br>Description of the chart. 
filter_str | **string**<br>Test filter selector to show KPI values for. 
test_case | **string**<br>Test case to show KPI values for. 
kpis[] | **[report.Kpi](#Kpi2)**<br>KPIs to show. 


### Kpi {#Kpi2}

Field | Description
--- | ---
selector | **[KpiSelector](#KpiSelector2)**<br>Kind of KPI. 
threshold | **[KpiThreshold](#KpiThreshold2)**<br>A condition that should be specified. 


### KpiSelector {#KpiSelector2}

Field | Description
--- | ---
kind | **oneof:** `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute` or `network_codes_relative`<br>Imbalance RPS.
&nbsp;&nbsp;response_time | **[ResponseTime](#ResponseTime2)**<br>Response time cummulative quantile (percentile). 
&nbsp;&nbsp;instances | **[Instances](#Instances2)**<br>A number of instances throughout the test. 
&nbsp;&nbsp;imbalance_rps | **[ImbalanceRps](#ImbalanceRps2)**<br>An RPS at the moment the test has been auto-stopped. 
&nbsp;&nbsp;protocol_codes_absolute | **[ProtocolCodesAbsolute](#ProtocolCodesAbsolute2)**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;protocol_codes_relative | **[ProtocolCodesRelative](#ProtocolCodesRelative2)**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;network_codes_absolute | **[NetworkCodesAbsolute](#NetworkCodesAbsolute2)**<br>A total number of requests completed with certain network codes. 
&nbsp;&nbsp;network_codes_relative | **[NetworkCodesRelative](#NetworkCodesRelative2)**<br>A percentage of requests completed with certain network codes. 


### ResponseTime {#ResponseTime2}

Field | Description
--- | ---
quantile | enum **common.QuantileType**<br>Cummulative quantile (percentile). <ul><li>`QUANTILE_TYPE_UNSPECIFIED`: Unspecified percentile.</li><li>`QUANTILE_TYPE_50`: 50 percentile (median).</li><li>`QUANTILE_TYPE_75`: 75 percentile.</li><li>`QUANTILE_TYPE_80`: 80 percentile.</li><li>`QUANTILE_TYPE_85`: 85 percentile.</li><li>`QUANTILE_TYPE_90`: 90 percentile.</li><li>`QUANTILE_TYPE_95`: 95 percentile.</li><li>`QUANTILE_TYPE_98`: 98 percentile.</li><li>`QUANTILE_TYPE_99`: 99 percentile.</li><li>`QUANTILE_TYPE_100`: 100 percentile (maximum or minimum).</li></ul>


### Instances {#Instances2}

Field | Description
--- | ---
agg | enum **Aggregation**<br>Aggregation function. <ul><li>`AGGREGATION_UNSPECIFIED`: Unspecified.</li><li>`AGGREGATION_MIN`: Minimum.</li><li>`AGGREGATION_MAX`: Maximum.</li><li>`AGGREGATION_AVG`: Average.</li><li>`AGGREGATION_MEDIAN`: Median.</li><li>`AGGREGATION_STD_DEV`: Standard deviation.</li></ul>


### ImbalanceRps {#ImbalanceRps2}

Empty.

### ProtocolCodesAbsolute {#ProtocolCodesAbsolute2}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### ProtocolCodesRelative {#ProtocolCodesRelative2}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### NetworkCodesAbsolute {#NetworkCodesAbsolute2}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### NetworkCodesRelative {#NetworkCodesRelative2}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### KpiThreshold {#KpiThreshold2}

Field | Description
--- | ---
value | **double**<br>Value for comparison with an actual KPI value. 
comparison | enum **Comparison**<br>Comparison operator for comparing actual with the threshold value. <br>Rule: actual (</<=/>/>=) reference <ul><li>`COMPARISON_UNSPECIFIED`: Unspecified.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li></ul>


### TextWidget {#TextWidget2}

Field | Description
--- | ---
text | **string**<br>Text string. 


### TitleWidget {#TitleWidget2}

Field | Description
--- | ---
text | **string**<br>Title string. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_UNSPECIFIED`: Unspecified.</li><li>`TITLE_SIZE_XS`: Extra small.</li><li>`TITLE_SIZE_S`: Small.</li><li>`TITLE_SIZE_M`: Medium.</li><li>`TITLE_SIZE_L`: Large.</li></ul>


## Delete {#Delete}

Deletes the specified regression dashboard.

**rpc Delete ([DeleteRegressionDashboardRequest](#DeleteRegressionDashboardRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegressionDashboardMetadata](#DeleteRegressionDashboardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegressionDashboardRequest {#DeleteRegressionDashboardRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. ID of the dashboard to delete. The maximum string length in characters is 50.
etag | **string**<br>The current etag of the dashboard. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegressionDashboardMetadata](#DeleteRegressionDashboardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteRegressionDashboardMetadata {#DeleteRegressionDashboardMetadata}

Field | Description
--- | ---
dashboard_id | **string**<br>ID of the dashboard that is being deleted. 


## Update {#Update}

Updates the specified regression dashboard.

**rpc Update ([UpdateRegressionDashboardRequest](#UpdateRegressionDashboardRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRegressionDashboardMetadata](#UpdateRegressionDashboardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[regression.Dashboard](#Dashboard3)<br>

### UpdateRegressionDashboardRequest {#UpdateRegressionDashboardRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. ID of the dashboards to update. 
etag | **string**<br>The current etag of the dashboard. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the dashboard are going to be updated. 
name | **string**<br>New name of the dashboard. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the dashboard. The maximum string length in characters is 1024.
content | **[regression.Dashboard.Content](./regression/dashboard#Dashboard)**<br>New content of the dashboard. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRegressionDashboardMetadata](#UpdateRegressionDashboardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[regression.Dashboard](#Dashboard3)>**<br>if operation finished successfully. 


### UpdateRegressionDashboardMetadata {#UpdateRegressionDashboardMetadata}

Field | Description
--- | ---
dashboard_id | **string**<br>ID of the dashboard that is being updated. 


### Dashboard {#Dashboard3}

Field | Description
--- | ---
id | **string**<br>ID of the dashboard. 
name | **string**<br>Name of the dashboard. 
description | **string**<br>Description of the dashboard. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last update timestamp. 
created_by | **string**<br>UA or SA that created the dashboard. 
updated_by | **string**<br>UA or SA that updated the dashboard last time. 
etag | **string**<br>Etag of the dashboard. 
content | **[Content](#Content3)**<br>Dashboard content. 


### Content {#Content3}

Field | Description
--- | ---
widgets[] | **[Widget](#Widget3)**<br>Widgets. 


### Widget {#Widget3}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition3)**<br>Widget position. 
widget | **oneof:** `chart`, `text` or `title`<br>
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget3)**<br>Chart widget. 
&nbsp;&nbsp;text | **[TextWidget](#TextWidget3)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget3)**<br>Title widget. 


### LayoutPosition {#LayoutPosition3}

Field | Description
--- | ---
x | **int64**<br>X. 
y | **int64**<br>Y. 
width | **int64**<br>Width. 
height | **int64**<br>Height. 


### ChartWidget {#ChartWidget3}

Field | Description
--- | ---
id | **string**<br>ID of the chart. 
name | **string**<br>Name of the chart. 
description | **string**<br>Description of the chart. 
filter_str | **string**<br>Test filter selector to show KPI values for. 
test_case | **string**<br>Test case to show KPI values for. 
kpis[] | **[report.Kpi](#Kpi3)**<br>KPIs to show. 


### Kpi {#Kpi3}

Field | Description
--- | ---
selector | **[KpiSelector](#KpiSelector3)**<br>Kind of KPI. 
threshold | **[KpiThreshold](#KpiThreshold3)**<br>A condition that should be specified. 


### KpiSelector {#KpiSelector3}

Field | Description
--- | ---
kind | **oneof:** `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute` or `network_codes_relative`<br>Imbalance RPS.
&nbsp;&nbsp;response_time | **[ResponseTime](#ResponseTime3)**<br>Response time cummulative quantile (percentile). 
&nbsp;&nbsp;instances | **[Instances](#Instances3)**<br>A number of instances throughout the test. 
&nbsp;&nbsp;imbalance_rps | **[ImbalanceRps](#ImbalanceRps3)**<br>An RPS at the moment the test has been auto-stopped. 
&nbsp;&nbsp;protocol_codes_absolute | **[ProtocolCodesAbsolute](#ProtocolCodesAbsolute3)**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;protocol_codes_relative | **[ProtocolCodesRelative](#ProtocolCodesRelative3)**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. 
&nbsp;&nbsp;network_codes_absolute | **[NetworkCodesAbsolute](#NetworkCodesAbsolute3)**<br>A total number of requests completed with certain network codes. 
&nbsp;&nbsp;network_codes_relative | **[NetworkCodesRelative](#NetworkCodesRelative3)**<br>A percentage of requests completed with certain network codes. 


### ResponseTime {#ResponseTime3}

Field | Description
--- | ---
quantile | enum **common.QuantileType**<br>Cummulative quantile (percentile). <ul><li>`QUANTILE_TYPE_UNSPECIFIED`: Unspecified percentile.</li><li>`QUANTILE_TYPE_50`: 50 percentile (median).</li><li>`QUANTILE_TYPE_75`: 75 percentile.</li><li>`QUANTILE_TYPE_80`: 80 percentile.</li><li>`QUANTILE_TYPE_85`: 85 percentile.</li><li>`QUANTILE_TYPE_90`: 90 percentile.</li><li>`QUANTILE_TYPE_95`: 95 percentile.</li><li>`QUANTILE_TYPE_98`: 98 percentile.</li><li>`QUANTILE_TYPE_99`: 99 percentile.</li><li>`QUANTILE_TYPE_100`: 100 percentile (maximum or minimum).</li></ul>


### Instances {#Instances3}

Field | Description
--- | ---
agg | enum **Aggregation**<br>Aggregation function. <ul><li>`AGGREGATION_UNSPECIFIED`: Unspecified.</li><li>`AGGREGATION_MIN`: Minimum.</li><li>`AGGREGATION_MAX`: Maximum.</li><li>`AGGREGATION_AVG`: Average.</li><li>`AGGREGATION_MEDIAN`: Median.</li><li>`AGGREGATION_STD_DEV`: Standard deviation.</li></ul>


### ImbalanceRps {#ImbalanceRps3}

Empty.

### ProtocolCodesAbsolute {#ProtocolCodesAbsolute3}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### ProtocolCodesRelative {#ProtocolCodesRelative3}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Protocol (HTTP, GRPC) code patterns to match. <br>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx']. 


### NetworkCodesAbsolute {#NetworkCodesAbsolute3}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### NetworkCodesRelative {#NetworkCodesRelative3}

Field | Description
--- | ---
codes_patterns[] | **string**<br>Network code patterns to match. <br>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx']. 


### KpiThreshold {#KpiThreshold3}

Field | Description
--- | ---
value | **double**<br>Value for comparison with an actual KPI value. 
comparison | enum **Comparison**<br>Comparison operator for comparing actual with the threshold value. <br>Rule: actual (</<=/>/>=) reference <ul><li>`COMPARISON_UNSPECIFIED`: Unspecified.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li></ul>


### TextWidget {#TextWidget3}

Field | Description
--- | ---
text | **string**<br>Text string. 


### TitleWidget {#TitleWidget3}

Field | Description
--- | ---
text | **string**<br>Title string. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_UNSPECIFIED`: Unspecified.</li><li>`TITLE_SIZE_XS`: Extra small.</li><li>`TITLE_SIZE_S`: Small.</li><li>`TITLE_SIZE_M`: Medium.</li><li>`TITLE_SIZE_L`: Large.</li></ul>


