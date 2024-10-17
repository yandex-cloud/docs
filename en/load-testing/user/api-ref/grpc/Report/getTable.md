---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Report/getTable.md
---

# Load Testing API, gRPC: ReportService.GetTable {#GetTable}

Returns a report table for the specified test.

## gRPC request

**rpc GetTable ([GetTableReportRequest](#yandex.cloud.loadtesting.api.v1.GetTableReportRequest)) returns ([GetTableReportResponse](#yandex.cloud.loadtesting.api.v1.GetTableReportResponse))**

## GetTableReportRequest {#yandex.cloud.loadtesting.api.v1.GetTableReportRequest}

```json
{
  "testId": "string"
}
```

#|
||Field | Description ||
|| testId | **string**

Required field. ID of the test for which report table will be returned. ||
|#

## GetTableReportResponse {#yandex.cloud.loadtesting.api.v1.GetTableReportResponse}

```json
{
  "status": "Status",
  "overall": {
    "httpCodes": "int64",
    "netCodes": "int64",
    "quantiles": {
      "q50": "double",
      "q75": "double",
      "q80": "double",
      "q85": "double",
      "q90": "double",
      "q95": "double",
      "q98": "double",
      "q99": "double",
      "q100": "double"
    }
  },
  "cases": {
    "httpCodes": "int64",
    "netCodes": "int64",
    "quantiles": {
      "q50": "double",
      "q75": "double",
      "q80": "double",
      "q85": "double",
      "q90": "double",
      "q95": "double",
      "q98": "double",
      "q99": "double",
      "q100": "double"
    }
  }
}
```

#|
||Field | Description ||
|| status | enum **Status**

Status of report table.

- `STATUS_UNSPECIFIED`: Status is not specified.
- `COLLECTING`: Report is being collected.
- `CALCULATING`: Report is being calculated.
- `READY`: Report is ready. ||
|| overall | **[Report](#yandex.cloud.loadtesting.api.v1.report.table.Report)**

Result for all test cases combined ("overall" test case). ||
|| cases | **[Report](#yandex.cloud.loadtesting.api.v1.report.table.Report)**

Results for individual test cases, mapped as `case_name:report`. ||
|#

## Report {#yandex.cloud.loadtesting.api.v1.report.table.Report}

Aggregated test results.

#|
||Field | Description ||
|| httpCodes | **int64**

Total count of HTTP responses, grouped by HTTP response code. ||
|| netCodes | **int64**

Total count of network responses, grouped by response code. ||
|| quantiles | **[Quantiles](#yandex.cloud.loadtesting.api.v1.common.Quantiles)**

Response time statistics, aggregated by quantiles. ||
|#

## Quantiles {#yandex.cloud.loadtesting.api.v1.common.Quantiles}

Statistical data aggregated by predefined set of quantiles.

#|
||Field | Description ||
|| q50 | **double**

50 percentile (median). ||
|| q75 | **double**

75 percentile. ||
|| q80 | **double**

80 percentile. ||
|| q85 | **double**

85 percentile. ||
|| q90 | **double**

90 percentile. ||
|| q95 | **double**

95 percentile. ||
|| q98 | **double**

98 percentile. ||
|| q99 | **double**

99 percentile. ||
|| q100 | **double**

100 percentile (maximum or minimum). ||
|#