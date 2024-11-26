---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Report/getTable.md
---

# Load Testing API, REST: Report.GetTable

Returns a report table for the specified test.

## HTTP request

```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/reports/{testId}/table
```

## Path parameters

#|
||Field | Description ||
|| testId | **string**

Required field. ID of the test for which report table will be returned. ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.GetTableReportResponse}

**HTTP Code: 200 - OK**

```json
{
  "status": "string",
  "overall": {
    "httpCodes": "string",
    "netCodes": "string",
    "quantiles": {
      "q50": "string",
      "q75": "string",
      "q80": "string",
      "q85": "string",
      "q90": "string",
      "q95": "string",
      "q98": "string",
      "q99": "string",
      "q100": "string"
    }
  },
  "cases": {
    "httpCodes": "string",
    "netCodes": "string",
    "quantiles": {
      "q50": "string",
      "q75": "string",
      "q80": "string",
      "q85": "string",
      "q90": "string",
      "q95": "string",
      "q98": "string",
      "q99": "string",
      "q100": "string"
    }
  }
}
```

#|
||Field | Description ||
|| status | **enum** (Status)

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
|| httpCodes | **string** (int64)

Total count of HTTP responses, grouped by HTTP response code. ||
|| netCodes | **string** (int64)

Total count of network responses, grouped by response code. ||
|| quantiles | **[Quantiles](#yandex.cloud.loadtesting.api.v1.common.Quantiles)**

Response time statistics, aggregated by quantiles. ||
|#

## Quantiles {#yandex.cloud.loadtesting.api.v1.common.Quantiles}

Statistical data aggregated by predefined set of quantiles.

#|
||Field | Description ||
|| q50 | **string**

50 percentile (median). ||
|| q75 | **string**

75 percentile. ||
|| q80 | **string**

80 percentile. ||
|| q85 | **string**

85 percentile. ||
|| q90 | **string**

90 percentile. ||
|| q95 | **string**

95 percentile. ||
|| q98 | **string**

98 percentile. ||
|| q99 | **string**

99 percentile. ||
|| q100 | **string**

100 percentile (maximum or minimum). ||
|#