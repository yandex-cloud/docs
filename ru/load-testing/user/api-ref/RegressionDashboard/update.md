---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/regressionDashboards/{dashboardId}
    method: patch
    path:
      type: object
      properties:
        dashboardId:
          description: |-
            **string**
            Required field. ID of the dashboards to update.
          type: string
      required:
        - dashboardId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        etag:
          description: |-
            **string**
            The current etag of the dashboard.
          type: string
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name of the dashboard.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            New description of the dashboard.
          type: string
        content:
          description: |-
            **[Content](#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content)**
            New content of the dashboard.
          $ref: '#/definitions/Content'
      additionalProperties: false
    definitions:
      LayoutPosition:
        type: object
        properties:
          x:
            description: |-
              **string** (int64)
              X.
            type: string
            format: int64
          'y':
            description: |-
              **string** (int64)
              Y.
            type: string
            format: int64
          width:
            description: |-
              **string** (int64)
              Width.
            type: string
            format: int64
          height:
            description: |-
              **string** (int64)
              Height.
            type: string
            format: int64
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
      KpiSelector:
        type: object
        properties:
          responseTime:
            description: |-
              **[ResponseTime](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime)**
              Response time cummulative quantile (percentile).
              Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
            $ref: '#/definitions/ResponseTime'
          instances:
            description: |-
              **[Instances](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances)**
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
              **[ProtocolCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute)**
              A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.
              Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
            $ref: '#/definitions/ProtocolCodesAbsolute'
          protocolCodesRelative:
            description: |-
              **[ProtocolCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative)**
              A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.
              Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
            $ref: '#/definitions/ProtocolCodesRelative'
          networkCodesAbsolute:
            description: |-
              **[NetworkCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute)**
              A total number of requests completed with certain network codes.
              Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
            $ref: '#/definitions/NetworkCodesAbsolute'
          networkCodesRelative:
            description: |-
              **[NetworkCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative)**
              A percentage of requests completed with certain network codes.
              Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`.
            $ref: '#/definitions/NetworkCodesRelative'
        oneOf:
          - required:
              - responseTime
          - required:
              - instances
          - required:
              - imbalanceRps
          - required:
              - protocolCodesAbsolute
          - required:
              - protocolCodesRelative
          - required:
              - networkCodesAbsolute
          - required:
              - networkCodesRelative
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
              Rule: actual (&lt;/<=/&gt;/>=) reference
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
              **[KpiSelector](#yandex.cloud.loadtesting.api.v1.report.KpiSelector)**
              Kind of KPI.
            $ref: '#/definitions/KpiSelector'
          threshold:
            description: |-
              **[KpiThreshold](#yandex.cloud.loadtesting.api.v1.report.KpiThreshold)**
              A condition that should be specified.
            $ref: '#/definitions/KpiThreshold'
      ChartWidget:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the chart.
            type: string
          name:
            description: |-
              **string**
              Name of the chart.
            type: string
          description:
            description: |-
              **string**
              Description of the chart.
            type: string
          filterStr:
            description: |-
              **string**
              Test filter selector to show KPI values for.
            type: string
          testCase:
            description: |-
              **string**
              Test case to show KPI values for.
            type: string
          kpis:
            description: |-
              **[Kpi](#yandex.cloud.loadtesting.api.v1.report.Kpi)**
              KPIs to show.
            type: array
            items:
              $ref: '#/definitions/Kpi'
      TextWidget:
        type: object
        properties:
          text:
            description: |-
              **string**
              Text string.
            type: string
      TitleWidget:
        type: object
        properties:
          text:
            description: |-
              **string**
              Title string.
            type: string
          size:
            description: |-
              **enum** (TitleSize)
              Title size.
              - `TITLE_SIZE_UNSPECIFIED`: Unspecified.
              - `TITLE_SIZE_XS`: Extra small.
              - `TITLE_SIZE_S`: Small.
              - `TITLE_SIZE_M`: Medium.
              - `TITLE_SIZE_L`: Large.
            type: string
            enum:
              - TITLE_SIZE_UNSPECIFIED
              - TITLE_SIZE_XS
              - TITLE_SIZE_S
              - TITLE_SIZE_M
              - TITLE_SIZE_L
      Widget:
        type: object
        properties:
          position:
            description: |-
              **[LayoutPosition](#yandex.cloud.loadtesting.api.v1.regression.Widget.LayoutPosition)**
              Widget position.
            $ref: '#/definitions/LayoutPosition'
          chart:
            description: |-
              **[ChartWidget](#yandex.cloud.loadtesting.api.v1.regression.ChartWidget)**
              Chart widget.
              Includes only one of the fields `chart`, `text`, `title`.
            $ref: '#/definitions/ChartWidget'
          text:
            description: |-
              **[TextWidget](#yandex.cloud.loadtesting.api.v1.regression.TextWidget)**
              Text widget.
              Includes only one of the fields `chart`, `text`, `title`.
            $ref: '#/definitions/TextWidget'
          title:
            description: |-
              **[TitleWidget](#yandex.cloud.loadtesting.api.v1.regression.TitleWidget)**
              Title widget.
              Includes only one of the fields `chart`, `text`, `title`.
            $ref: '#/definitions/TitleWidget'
        oneOf:
          - required:
              - chart
          - required:
              - text
          - required:
              - title
      Content:
        type: object
        properties:
          widgets:
            description: |-
              **[Widget](#yandex.cloud.loadtesting.api.v1.regression.Widget)**
              Widgets.
            type: array
            items:
              $ref: '#/definitions/Widget'
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/RegressionDashboard/update.md
---

# Load Testing API, REST: RegressionDashboard.Update

Updates the specified regression dashboard.

## HTTP request

```
PATCH https://loadtesting.{{ api-host }}/loadtesting/api/v1/regressionDashboards/{dashboardId}
```

## Path parameters

#|
||Field | Description ||
|| dashboardId | **string**

Required field. ID of the dashboards to update. ||
|#

## Body parameters {#yandex.cloud.loadtesting.api.v1.UpdateRegressionDashboardRequest}

```json
{
  "etag": "string",
  "updateMask": "string",
  "name": "string",
  "description": "string",
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

#|
||Field | Description ||
|| etag | **string**

The current etag of the dashboard. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the dashboard. ||
|| description | **string**

New description of the dashboard. ||
|| content | **[Content](#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content)**

New content of the dashboard. ||
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

Rule: actual (&lt;/<=/&gt;/>=) reference

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "dashboardId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateRegressionDashboardMetadata](#yandex.cloud.loadtesting.api.v1.UpdateRegressionDashboardMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Dashboard](#yandex.cloud.loadtesting.api.v1.regression.Dashboard)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateRegressionDashboardMetadata {#yandex.cloud.loadtesting.api.v1.UpdateRegressionDashboardMetadata}

#|
||Field | Description ||
|| dashboardId | **string**

ID of the dashboard that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Dashboard {#yandex.cloud.loadtesting.api.v1.regression.Dashboard}

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
|| content | **[Content](#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content2)**

Dashboard content. ||
|#

## Content {#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content2}

Content of regression dashboard.

#|
||Field | Description ||
|| widgets[] | **[Widget](#yandex.cloud.loadtesting.api.v1.regression.Widget2)**

Widgets. ||
|#

## Widget {#yandex.cloud.loadtesting.api.v1.regression.Widget2}

Regression dashboard widget.

#|
||Field | Description ||
|| position | **[LayoutPosition](#yandex.cloud.loadtesting.api.v1.regression.Widget.LayoutPosition2)**

Widget position. ||
|| chart | **[ChartWidget](#yandex.cloud.loadtesting.api.v1.regression.ChartWidget2)**

Chart widget.

Includes only one of the fields `chart`, `text`, `title`. ||
|| text | **[TextWidget](#yandex.cloud.loadtesting.api.v1.regression.TextWidget2)**

Text widget.

Includes only one of the fields `chart`, `text`, `title`. ||
|| title | **[TitleWidget](#yandex.cloud.loadtesting.api.v1.regression.TitleWidget2)**

Title widget.

Includes only one of the fields `chart`, `text`, `title`. ||
|#

## LayoutPosition {#yandex.cloud.loadtesting.api.v1.regression.Widget.LayoutPosition2}

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

## ChartWidget {#yandex.cloud.loadtesting.api.v1.regression.ChartWidget2}

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
|| kpis[] | **[Kpi](#yandex.cloud.loadtesting.api.v1.report.Kpi2)**

KPIs to show. ||
|#

## Kpi {#yandex.cloud.loadtesting.api.v1.report.Kpi2}

KPI (Key Performance Indicator) represents some integral indicator measured during test.

#|
||Field | Description ||
|| selector | **[KpiSelector](#yandex.cloud.loadtesting.api.v1.report.KpiSelector2)**

Kind of KPI. ||
|| threshold | **[KpiThreshold](#yandex.cloud.loadtesting.api.v1.report.KpiThreshold2)**

A condition that should be specified. ||
|#

## KpiSelector {#yandex.cloud.loadtesting.api.v1.report.KpiSelector2}

KPI selector.

#|
||Field | Description ||
|| responseTime | **[ResponseTime](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime2)**

Response time cummulative quantile (percentile).

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| instances | **[Instances](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances2)**

A number of instances throughout the test.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| imbalanceRps | **object**

An RPS at the moment the test has been auto-stopped.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| protocolCodesAbsolute | **[ProtocolCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute2)**

A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| protocolCodesRelative | **[ProtocolCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative2)**

A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| networkCodesAbsolute | **[NetworkCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute2)**

A total number of requests completed with certain network codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|| networkCodesRelative | **[NetworkCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative2)**

A percentage of requests completed with certain network codes.

Includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`. ||
|#

## ResponseTime {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime2}

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

## Instances {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances2}

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

## ProtocolCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute2}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## ProtocolCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative2}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## NetworkCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute2}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## NetworkCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative2}

#|
||Field | Description ||
|| codesPatterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## KpiThreshold {#yandex.cloud.loadtesting.api.v1.report.KpiThreshold2}

KPI threshold represents a condition that an actual value of test's KPI should satisfy.

#|
||Field | Description ||
|| value | **string**

Value for comparison with an actual KPI value. ||
|| comparison | **enum** (Comparison)

Comparison operator for comparing actual with the threshold value.

Rule: actual (&lt;/<=/&gt;/>=) reference

- `COMPARISON_UNSPECIFIED`: Unspecified.
- `COMPARISON_LT`: Less than the specified value.
- `COMPARISON_LTE`: Less than or equal to the specified value.
- `COMPARISON_GT`: Greater than the specified value.
- `COMPARISON_GTE`: Greater than or equal to the specified value. ||
|#

## TextWidget {#yandex.cloud.loadtesting.api.v1.regression.TextWidget2}

Text widget.

#|
||Field | Description ||
|| text | **string**

Text string. ||
|#

## TitleWidget {#yandex.cloud.loadtesting.api.v1.regression.TitleWidget2}

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