---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/loadtesting/cli-ref-beta/report/calculate-kpi-values.md
---

# yc beta loadtesting report calculate-kpi-values

Returns a list of KPI values for tests matching the specified filter.

#### Command Usage

Syntax: 

`yc beta loadtesting report calculate-kpi-values <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--folder-id`|<b>`string`</b><br/>ID of the folder containing tests.|
|`--kpi`|<b>`shorthand/json`</b><br/>KPI to be calculated.<br/><br/>Example:|
|`--kpi`|<b>`selector={kind={imbalance-rps={}}},`</b><br/>threshold={comparison=COMPARISON_LT, value=1.0}<br/><br/>Shorthand Syntax:<br/>{selector={kind={imbalance-rps={} \| instances={agg=AGGREGATION_MIN\|AGGREGATION_MAX\|AGGREGATION_AVG\|AGGREGATION_MEDIAN\|AGGREGATION_STD_DEV} \| network-codes-absolute={codes-patterns=str,...} \| network-codes-relative={codes-patterns=str,...} \| protocol-codes-absolute={codes-patterns=str,...} \| protocol-codes-relative={codes-patterns=str,...} \| response-time={quantile=QUANTILE_TYPE_50\|QUANTILE_TYPE_75\|QUANTILE_TYPE_80\|QUANTILE_TYPE_85\|QUANTILE_TYPE_90\|QUANTILE_TYPE_95\|QUANTILE_TYPE_98\|QUANTILE_TYPE_99\|QUANTILE_TYPE_100}}}, threshold={comparison=COMPARISON_LT\|COMPARISON_LTE\|COMPARISON_GT\|COMPARISON_GTE, value=double}}<br/>Fields:<br/>selector   struct  — Kind of KPI.<br/>kind  oneof<imbalance-rps\|instances\|network-codes-absolute\|network-codes-relative\|protocol-codes-absolute\|protocol-codes-relative\|response-time>  — Oneof kind field<br/>response-time            struct  — Response time cummulative quantile (percentile).<br/>quantile  enum<QUANTILE_TYPE_100\|QUANTILE_TYPE_50\|QUANTILE_TYPE_75\|QUANTILE_TYPE_80\|QUANTILE_TYPE_85\|QUANTILE_TYPE_90\|QUANTILE_TYPE_95\|QUANTILE_TYPE_98\|QUANTILE_TYPE_99>  — Cummulative quantile (percentile).<br/>instances                struct  — A number of instances throughout the test.<br/>agg  enum<AGGREGATION_AVG\|AGGREGATION_MAX\|AGGREGATION_MEDIAN\|AGGREGATION_MIN\|AGGREGATION_STD_DEV>  — Aggregation function.<br/>imbalance-rps            struct  — An RPS at the moment the test has been auto-stopped.<br/>protocol-codes-absolute  struct  — A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.<br/>codes-patterns  []string  — Protocol (HTTP, GRPC) code patterns to match.<br/><br/>All successful HTTP responses: ['2xx', '3xx'].<br/>All failed HTTP responses: ['0', '4xx', '5xx'].<br/>protocol-codes-relative  struct  — A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.<br/>codes-patterns  []string  — Protocol (HTTP, GRPC) code patterns to match.<br/><br/>All successful HTTP responses: ['2xx', '3xx'].<br/>All failed HTTP responses: ['0', '4xx', '5xx'].<br/>network-codes-absolute   struct  — A total number of requests completed with certain network codes.<br/>codes-patterns  []string  — Network code patterns to match.<br/><br/>All successful network responses: ['0'].<br/>All failed network responses: ['xx', 'xxx'].<br/>network-codes-relative   struct  — A percentage of requests completed with certain network codes.<br/>codes-patterns  []string  — Network code patterns to match.<br/><br/>All successful network responses: ['0'].<br/>All failed network responses: ['xx', 'xxx'].<br/>threshold  struct  — A condition that should be specified.<br/>comparison  enum<COMPARISON_GT\|COMPARISON_GTE\|COMPARISON_LT\|COMPARISON_LTE>  — Comparison operator for comparing actual with the threshold value.<br/><br/>Rule: actual (</<=/>/>=) reference<br/>value       double                                                           — Value for comparison with an actual KPI value.<br/>|
|`--test-case`|<b>`string`</b><br/>Test case to calculate KPI values for.<br/><br/>If not specified, KPI values will be calculated for 'overall' case.|
|`--test-filter`|<b>`string`</b><br/>Test filter selector to calculate KPI values for.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
