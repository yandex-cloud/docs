---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/reports/calculateKpiValues
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder containing tests.
          type: string
        testFilter:
          description: |-
            **string**
            Required field. Test filter selector to calculate KPI values for.
          type: string
        testCase:
          description: |-
            **string**
            Test case to calculate KPI values for.
            If not specified, KPI values will be calculated for 'overall' case.
          type: string
        kpi:
          description: |-
            **`Kpi`**
            Required field. KPI to be calculated.
          $ref: '#/definitions/Kpi'
      required:
        - folderId
        - testFilter
        - kpi
      additionalProperties: false
    definitions:
      ResponseTime:
        type: object
        properties:
          quantile:
            description: |-
              **enum** (QuantileType)
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
              - `QUANTILE_TYPE_100`: 100 percentile (maximum or minimum).
            type: string
            enum:
              - QUANTILE_TYPE_UNSPECIFIED
              - QUANTILE_TYPE_50
              - QUANTILE_TYPE_75
              - QUANTILE_TYPE_80
              - QUANTILE_TYPE_85
              - QUANTILE_TYPE_90
              - QUANTILE_TYPE_95
              - QUANTILE_TYPE_98
              - QUANTILE_TYPE_99
              - QUANTILE_TYPE_100
      Instances:
        type: object
        properties:
          agg:
            description: |-
              **enum** (Aggregation)
              Aggregation function.
              - `AGGREGATION_UNSPECIFIED`: Unspecified.
              - `AGGREGATION_MIN`: Minimum.
              - `AGGREGATION_MAX`: Maximum.
              - `AGGREGATION_AVG`: Average.
              - `AGGREGATION_MEDIAN`: Median.
              - `AGGREGATION_STD_DEV`: Standard deviation.
            type: string
            enum:
              - AGGREGATION_UNSPECIFIED
              - AGGREGATION_MIN
              - AGGREGATION_MAX
              - AGGREGATION_AVG
              - AGGREGATION_MEDIAN
              - AGGREGATION_STD_DEV
      ImbalanceRps:
        type: object
        properties: {}
      ProtocolCodesAbsolute:
        type: object
        properties:
          codesPatterns:
            description: |-
              **string**
              Protocol (HTTP, GRPC) code patterns to match.
              All successful HTTP responses: ['2xx', '3xx'].
              All failed HTTP responses: ['0', '4xx', '5xx'].
            type: array
            items:
              type: string
      ProtocolCodesRelative:
        type: object
        properties:
          codesPatterns:
            description: |-
              **string**
              Protocol (HTTP, GRPC) code patterns to match.
              All successful HTTP responses: ['2xx', '3xx'].
              All failed HTTP responses: ['0', '4xx', '5xx'].
            type: array
            items:
              type: string
      NetworkCodesAbsolute:
        type: object
        properties:
          codesPatterns:
            description: |-
              **string**
              Network code patterns to match.
              All successful network responses: ['0'].
              All failed network responses: ['xx', 'xxx'].
            type: array
            items:
              type: string
      NetworkCodesRelative:
        type: object
        properties:
          codesPatterns:
            description: |-
              **string**
              Network code patterns to match.
              All successful network responses: ['0'].
              All failed network responses: ['xx', 'xxx'].
            type: array
            items:
              type: string
      KpiThreshold:
        type: object
        properties:
          value:
            description: |-
              **string**
              Value for comparison with an actual KPI value.
            type: string
          comparison:
            description: |-
              **enum** (Comparison)
              Comparison operator for comparing actual with the threshold value.
              Rule: actual (</<=/>/>=) reference
              - `COMPARISON_UNSPECIFIED`: Unspecified.
              - `COMPARISON_LT`: Less than the specified value.
              - `COMPARISON_LTE`: Less than or equal to the specified value.
              - `COMPARISON_GT`: Greater than the specified value.
              - `COMPARISON_GTE`: Greater than or equal to the specified value.
            type: string
            enum:
              - COMPARISON_UNSPECIFIED
              - COMPARISON_LT
              - COMPARISON_LTE
              - COMPARISON_GT
              - COMPARISON_GTE
      Kpi:
        type: object
        properties:
          selector:
            description: |-
              **`KpiSelector`**
              Kind of KPI.
            oneOf:
              - type: object
                properties:
                  responseTime:
                    description: |-
                      **`ResponseTime`**
                      Response time cummulative quantile (percentile).
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/ResponseTime'
                  instances:
                    description: |-
                      **`Instances`**
                      A number of instances throughout the test.
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/Instances'
                  imbalanceRps:
                    description: |-
                      **object**
                      An RPS at the moment the test has been auto-stopped.
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/ImbalanceRps'
                  protocolCodesAbsolute:
                    description: |-
                      **`ProtocolCodesAbsolute`**
                      A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/ProtocolCodesAbsolute'
                  protocolCodesRelative:
                    description: |-
                      **`ProtocolCodesRelative`**
                      A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/ProtocolCodesRelative'
                  networkCodesAbsolute:
                    description: |-
                      **`NetworkCodesAbsolute`**
                      A total number of requests completed with certain network codes.
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/NetworkCodesAbsolute'
                  networkCodesRelative:
                    description: |-
                      **`NetworkCodesRelative`**
                      A percentage of requests completed with certain network codes.
                      Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
                    $ref: '#/definitions/NetworkCodesRelative'
          threshold:
            description: |-
              **`KpiThreshold`**
              A condition that should be specified.
            $ref: '#/definitions/KpiThreshold'
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Report/calculateKpiValues.md
---

# Load Testing API, REST: Report.CalculateKpiValues

Returns a list of KPI values for tests matching the specified filter.

## HTTP request

```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/reports/calculateKpiValues
```

## Body parameters {#yandex.cloud.loadtesting.api.v1.CalculateReportKpiValuesRequest}

```json
{
  "folderId": "string",
  "testFilter": "string",
  "testCase": "string",
  "kpi": {
    "selector": {
      // Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`
      "responseTime": {
        "quantile": "string"
      },
      "instances": {
        "agg": "string"
      },
      "imbalanceRps": "object",
      "protocolCodesAbsolute": {
        "codesPatterns": [
          "string"
        ]
      },
      "protocolCodesRelative": {
        "codesPatterns": [
          "string"
        ]
      },
      "networkCodesAbsolute": {
        "codesPatterns": [
          "string"
        ]
      },
      "networkCodesRelative": {
        "codesPatterns": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    "threshold": {
      "value": "string",
      "comparison": "string"
    }
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder containing tests. ||
|| testFilter | **string**

Required field. Test filter selector to calculate KPI values for. ||
|| testCase | **string**

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
|| responseTime | **[ResponseTime](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime)**

Response time cummulative quantile (percentile).

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| instances | **[Instances](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances)**

A number of instances throughout the test.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| imbalanceRps | **object**

An RPS at the moment the test has been auto-stopped.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| protocolCodesAbsolute | **[ProtocolCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute)**

A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| protocolCodesRelative | **[ProtocolCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative)**

A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| networkCodesAbsolute | **[NetworkCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute)**

A total number of requests completed with certain network codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| networkCodesRelative | **[NetworkCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative)**

A percentage of requests completed with certain network codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|#

## ResponseTime {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime}

Response time.

#|
||Field | Description ||
|| quantile | **enum** (QuantileType)

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
|| agg | **enum** (Aggregation)

Aggregation function.

- `AGGREGATION_UNSPECIFIED`: Unspecified.
- `AGGREGATION_MIN`: Minimum.
- `AGGREGATION_MAX`: Maximum.
- `AGGREGATION_AVG`: Average.
- `AGGREGATION_MEDIAN`: Median.
- `AGGREGATION_STD_DEV`: Standard deviation. ||
|#

## ProtocolCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## ProtocolCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## NetworkCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## NetworkCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## KpiThreshold {#yandex.cloud.loadtesting.api.v1.report.KpiThreshold}

KPI threshold represents a condition that an actual value of test's KPI should satisfy.

#|
||Field | Description ||
|| value | **string**

Value for comparison with an actual KPI value. ||
|| comparison | **enum** (Comparison)

Comparison operator for comparing actual with the threshold value.

Rule: actual (</<=/>/>=) reference

- `COMPARISON_UNSPECIFIED`: Unspecified.
- `COMPARISON_LT`: Less than the specified value.
- `COMPARISON_LTE`: Less than or equal to the specified value.
- `COMPARISON_GT`: Greater than the specified value.
- `COMPARISON_GTE`: Greater than or equal to the specified value. ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.CalculateReportKpiValuesResponse}

**HTTP Code: 200 - OK**

```json
{
  "folderId": "string",
  "values": [
    {
      "testId": "string",
      "value": "string",
      "isOk": "boolean"
    }
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder. ||
|| values[] | **[KpiValue](#yandex.cloud.loadtesting.api.v1.report.KpiValue)**

Actual KPI values. ||
|#

## KpiValue {#yandex.cloud.loadtesting.api.v1.report.KpiValue}

An actual value of test's KPI.

#|
||Field | Description ||
|| testId | **string**

ID of a test. ||
|| value | **string**

Value of KPI. ||
|| isOk | **boolean**

A flag indicating whether the value satisfies KPI threshold condition. ||
|#