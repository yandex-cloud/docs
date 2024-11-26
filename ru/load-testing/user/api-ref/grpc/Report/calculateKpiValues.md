---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Report/calculateKpiValues.md
---

# Load Testing API, gRPC: ReportService.CalculateKpiValues

Returns a list of KPI values for tests matching the specified filter.

## gRPC request

**rpc CalculateKpiValues ([CalculateReportKpiValuesRequest](#yandex.cloud.loadtesting.api.v1.CalculateReportKpiValuesRequest)) returns ([CalculateReportKpiValuesResponse](#yandex.cloud.loadtesting.api.v1.CalculateReportKpiValuesResponse))**

## CalculateReportKpiValuesRequest {#yandex.cloud.loadtesting.api.v1.CalculateReportKpiValuesRequest}

```json
{
  "folder_id": "string",
  "test_filter": "string",
  "test_case": "string",
  "kpi": {
    "selector": {
      // Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`
      "response_time": {
        "quantile": "QuantileType"
      },
      "instances": {
        "agg": "Aggregation"
      },
      "imbalance_rps": "ImbalanceRps",
      "protocol_codes_absolute": {
        "codes_patterns": [
          "string"
        ]
      },
      "protocol_codes_relative": {
        "codes_patterns": [
          "string"
        ]
      },
      "network_codes_absolute": {
        "codes_patterns": [
          "string"
        ]
      },
      "network_codes_relative": {
        "codes_patterns": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    "threshold": {
      "value": "double",
      "comparison": "Comparison"
    }
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder containing tests. ||
|| test_filter | **string**

Required field. Test filter selector to calculate KPI values for. ||
|| test_case | **string**

Test case to calculate KPI values for.

If not specified, KPI values will be calculated for 'overall' case. ||
|| kpi | **[Kpi](#yandex.cloud.loadtesting.api.v1.report.Kpi)**

Required field. KPI to be calculated. ||
|#

## Kpi {#yandex.cloud.loadtesting.api.v1.report.Kpi}

KPI (Key Performance Indicator) represents some integral indicator measured during test.

#|
||Field | Description ||
|| selector | **[KpiSelector](#yandex.cloud.loadtesting.api.v1.report.KpiSelector)**

Kind of KPI. ||
|| threshold | **[KpiThreshold](#yandex.cloud.loadtesting.api.v1.report.KpiThreshold)**

A condition that should be specified. ||
|#

## KpiSelector {#yandex.cloud.loadtesting.api.v1.report.KpiSelector}

KPI selector.

#|
||Field | Description ||
|| response_time | **[ResponseTime](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime)**

Response time cummulative quantile (percentile).

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| instances | **[Instances](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances)**

A number of instances throughout the test.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| imbalance_rps | **[ImbalanceRps](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ImbalanceRps)**

An RPS at the moment the test has been auto-stopped.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| protocol_codes_absolute | **[ProtocolCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute)**

A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| protocol_codes_relative | **[ProtocolCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative)**

A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| network_codes_absolute | **[NetworkCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute)**

A total number of requests completed with certain network codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| network_codes_relative | **[NetworkCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative)**

A percentage of requests completed with certain network codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|#

## ResponseTime {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime}

Response time.

#|
||Field | Description ||
|| quantile | enum **QuantileType**

Cummulative quantile (percentile).

- `QUANTILE_TYPE_UNSPECIFIED`: Unspecified percentile.
- `QUANTILE_TYPE_50`: 50 percentile (median).
- `QUANTILE_TYPE_75`: 75 percentile.
- `QUANTILE_TYPE_80`: 80 percentile.
- `QUANTILE_TYPE_85`: 85 percentile.
- `QUANTILE_TYPE_90`: 90 percentile.
- `QUANTILE_TYPE_95`: 95 percentile.
- `QUANTILE_TYPE_98`: 98 percentile.
- `QUANTILE_TYPE_99`: 99 percentile.
- `QUANTILE_TYPE_100`: 100 percentile (maximum or minimum). ||
|#

## Instances {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances}

Aggregated number of instances.

#|
||Field | Description ||
|| agg | enum **Aggregation**

Aggregation function.

- `AGGREGATION_UNSPECIFIED`: Unspecified.
- `AGGREGATION_MIN`: Minimum.
- `AGGREGATION_MAX`: Maximum.
- `AGGREGATION_AVG`: Average.
- `AGGREGATION_MEDIAN`: Median.
- `AGGREGATION_STD_DEV`: Standard deviation. ||
|#

## ImbalanceRps {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ImbalanceRps}

Imbalance RPS.

#|
||Field | Description ||
|| Empty | > ||
|#

## ProtocolCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## ProtocolCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## NetworkCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## NetworkCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## KpiThreshold {#yandex.cloud.loadtesting.api.v1.report.KpiThreshold}

KPI threshold represents a condition that an actual value of test's KPI should satisfy.

#|
||Field | Description ||
|| value | **double**

Value for comparison with an actual KPI value. ||
|| comparison | enum **Comparison**

Comparison operator for comparing actual with the threshold value.

Rule: actual (</<=/>/>=) reference

- `COMPARISON_UNSPECIFIED`: Unspecified.
- `COMPARISON_LT`: Less than the specified value.
- `COMPARISON_LTE`: Less than or equal to the specified value.
- `COMPARISON_GT`: Greater than the specified value.
- `COMPARISON_GTE`: Greater than or equal to the specified value. ||
|#

## CalculateReportKpiValuesResponse {#yandex.cloud.loadtesting.api.v1.CalculateReportKpiValuesResponse}

```json
{
  "folder_id": "string",
  "values": [
    {
      "test_id": "string",
      "value": "double",
      "is_ok": "bool"
    }
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder. ||
|| values[] | **[KpiValue](#yandex.cloud.loadtesting.api.v1.report.KpiValue)**

Actual KPI values. ||
|#

## KpiValue {#yandex.cloud.loadtesting.api.v1.report.KpiValue}

An actual value of test's KPI.

#|
||Field | Description ||
|| test_id | **string**

ID of a test. ||
|| value | **double**

Value of KPI. ||
|| is_ok | **bool**

A flag indicating whether the value satisfies KPI threshold condition. ||
|#