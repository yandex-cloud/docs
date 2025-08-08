---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/regressionDashboards/{dashboardId}
    method: get
    path:
      type: object
      properties:
        dashboardId:
          description: |-
            **string**
            Required field. ID of the dashboard to return.
          type: string
      required:
        - dashboardId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/RegressionDashboard/get.md
---

# Load Testing API, REST: RegressionDashboard.Get

Returns the specified regression dashboard.

To get the list of all available regression dashboards, make a [List](/docs/load-testing/user/api-ref/RegressionDashboard/list#List) request.

## HTTP request

```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/regressionDashboards/{dashboardId}
```

## Path parameters

#|
||Field | Description ||
|| dashboardId | **string**

Required field. ID of the dashboard to return. ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.regression.Dashboard}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "createdBy": "string",
  "updatedBy": "string",
  "etag": "string",
  "content": {
    "widgets": [
      {
        "position": {
          "x": "string",
          "y": "string",
          "width": "string",
          "height": "string"
        },
        // Includes only one of the fields `chart`, `text`, `title`
        "chart": {
          "id": "string",
          "name": "string",
          "description": "string",
          "filterStr": "string",
          "testCase": "string",
          "kpis": [
            {
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
          ]
        },
        "text": {
          "text": "string"
        },
        "title": {
          "text": "string",
          "size": "string"
        }
        // end of the list of possible fields
      }
    ]
  }
}
```

Regression dashboard.

#|
||Field | Description ||
|| id | **string**

ID of the dashboard. ||
|| name | **string**

Name of the dashboard. ||
|| description | **string**

Description of the dashboard. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Last update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

UA or SA that created the dashboard. ||
|| updatedBy | **string**

UA or SA that updated the dashboard last time. ||
|| etag | **string**

Etag of the dashboard. ||
|| content | **[Content](#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content)**

Dashboard content. ||
|#

## Content {#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content}

Content of regression dashboard.

#|
||Field | Description ||
|| widgets[] | **[Widget](#yandex.cloud.loadtesting.api.v1.regression.Widget)**

Widgets. ||
|#

## Widget {#yandex.cloud.loadtesting.api.v1.regression.Widget}

Regression dashboard widget.

#|
||Field | Description ||
|| position | **[LayoutPosition](#yandex.cloud.loadtesting.api.v1.regression.Widget.LayoutPosition)**

Widget position. ||
|| chart | **[ChartWidget](#yandex.cloud.loadtesting.api.v1.regression.ChartWidget)**

Chart widget.

Includes only one of the fields `chart`, `text`, `title`. ||
|| text | **[TextWidget](#yandex.cloud.loadtesting.api.v1.regression.TextWidget)**

Text widget.

Includes only one of the fields `chart`, `text`, `title`. ||
|| title | **[TitleWidget](#yandex.cloud.loadtesting.api.v1.regression.TitleWidget)**

Title widget.

Includes only one of the fields `chart`, `text`, `title`. ||
|#

## LayoutPosition {#yandex.cloud.loadtesting.api.v1.regression.Widget.LayoutPosition}

Widget position.

#|
||Field | Description ||
|| x | **string** (int64)

X. ||
|| y | **string** (int64)

Y. ||
|| width | **string** (int64)

Width. ||
|| height | **string** (int64)

Height. ||
|#

## ChartWidget {#yandex.cloud.loadtesting.api.v1.regression.ChartWidget}

Regression chart.

#|
||Field | Description ||
|| id | **string**

ID of the chart. ||
|| name | **string**

Name of the chart. ||
|| description | **string**

Description of the chart. ||
|| filterStr | **string**

Test filter selector to show KPI values for. ||
|| testCase | **string**

Test case to show KPI values for. ||
|| kpis[] | **[Kpi](#yandex.cloud.loadtesting.api.v1.report.Kpi)**

KPIs to show. ||
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

## TextWidget {#yandex.cloud.loadtesting.api.v1.regression.TextWidget}

Text widget.

#|
||Field | Description ||
|| text | **string**

Text string. ||
|#

## TitleWidget {#yandex.cloud.loadtesting.api.v1.regression.TitleWidget}

Title widget.

#|
||Field | Description ||
|| text | **string**

Title string. ||
|| size | **enum** (TitleSize)

Title size.

- `TITLE_SIZE_UNSPECIFIED`: Unspecified.
- `TITLE_SIZE_XS`: Extra small.
- `TITLE_SIZE_S`: Small.
- `TITLE_SIZE_M`: Medium.
- `TITLE_SIZE_L`: Large. ||
|#