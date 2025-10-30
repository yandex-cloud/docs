---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/RegressionDashboard/create.md
---

# Load Testing API, gRPC: RegressionDashboardService.Create

Creates a regression dashboard in the specified folder.

## gRPC request

**rpc Create ([CreateRegressionDashboardRequest](#yandex.cloud.loadtesting.api.v1.CreateRegressionDashboardRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateRegressionDashboardRequest {#yandex.cloud.loadtesting.api.v1.CreateRegressionDashboardRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "content": {
    "widgets": [
      {
        "position": {
          "x": "int64",
          "y": "int64",
          "width": "int64",
          "height": "int64"
        },
        // Includes only one of the fields `chart`, `text`, `title`
        "chart": {
          "id": "string",
          "name": "string",
          "description": "string",
          "filter_str": "string",
          "test_case": "string",
          "kpis": [
            {
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
          ]
        },
        "text": {
          "text": "string"
        },
        "title": {
          "text": "string",
          "size": "TitleSize"
        }
        // end of the list of possible fields
      }
    ]
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a regression dashboard in. ||
|| name | **string**

Name of the dashboard. ||
|| description | **string**

Description of the dashboard. ||
|| content | **[Content](#yandex.cloud.loadtesting.api.v1.regression.Dashboard.Content)**

Content of the dashboard. ||
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
|| x | **int64**

X. ||
|| y | **int64**

Y. ||
|| width | **int64**

Width. ||
|| height | **int64**

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
|| filter_str | **string**

Test filter selector to show KPI values for. ||
|| test_case | **string**

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
|| size | enum **TitleSize**

Title size.

- `TITLE_SIZE_UNSPECIFIED`: Unspecified.
- `TITLE_SIZE_XS`: Extra small.
- `TITLE_SIZE_S`: Small.
- `TITLE_SIZE_M`: Medium.
- `TITLE_SIZE_L`: Large. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "dashboard_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "created_by": "string",
    "updated_by": "string",
    "etag": "string",
    "content": {
      "widgets": [
        {
          "position": {
            "x": "int64",
            "y": "int64",
            "width": "int64",
            "height": "int64"
          },
          // Includes only one of the fields `chart`, `text`, `title`
          "chart": {
            "id": "string",
            "name": "string",
            "description": "string",
            "filter_str": "string",
            "test_case": "string",
            "kpis": [
              {
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
            ]
          },
          "text": {
            "text": "string"
          },
          "title": {
            "text": "string",
            "size": "TitleSize"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateRegressionDashboardMetadata](#yandex.cloud.loadtesting.api.v1.CreateRegressionDashboardMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## CreateRegressionDashboardMetadata {#yandex.cloud.loadtesting.api.v1.CreateRegressionDashboardMetadata}

#|
||Field | Description ||
|| dashboard_id | **string**

ID of the dashboard that is being created. ||
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last update timestamp. ||
|| created_by | **string**

UA or SA that created the dashboard. ||
|| updated_by | **string**

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
|| x | **int64**

X. ||
|| y | **int64**

Y. ||
|| width | **int64**

Width. ||
|| height | **int64**

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
|| filter_str | **string**

Test filter selector to show KPI values for. ||
|| test_case | **string**

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
|| response_time | **[ResponseTime](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime2)**

Response time cummulative quantile (percentile).

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| instances | **[Instances](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances2)**

A number of instances throughout the test.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| imbalance_rps | **[ImbalanceRps](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ImbalanceRps2)**

An RPS at the moment the test has been auto-stopped.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| protocol_codes_absolute | **[ProtocolCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute2)**

A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| protocol_codes_relative | **[ProtocolCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative2)**

A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| network_codes_absolute | **[NetworkCodesAbsolute](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute2)**

A total number of requests completed with certain network codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|| network_codes_relative | **[NetworkCodesRelative](#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative2)**

A percentage of requests completed with certain network codes.

Includes only one of the fields `response_time`, `instances`, `imbalance_rps`, `protocol_codes_absolute`, `protocol_codes_relative`, `network_codes_absolute`, `network_codes_relative`. ||
|#

## ResponseTime {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ResponseTime2}

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

## Instances {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.Instances2}

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

## ImbalanceRps {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ImbalanceRps2}

Imbalance RPS.

#|
||Field | Description ||
|| Empty | > ||
|#

## ProtocolCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesAbsolute2}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## ProtocolCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.ProtocolCodesRelative2}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Protocol (HTTP, GRPC) code patterns to match.

All successful HTTP responses: ['2xx', '3xx'].
All failed HTTP responses: ['0', '4xx', '5xx']. ||
|#

## NetworkCodesAbsolute {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesAbsolute2}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## NetworkCodesRelative {#yandex.cloud.loadtesting.api.v1.report.KpiSelector.NetworkCodesRelative2}

#|
||Field | Description ||
|| codes_patterns[] | **string**

Network code patterns to match.

All successful network responses: ['0'].
All failed network responses: ['xx', 'xxx']. ||
|#

## KpiThreshold {#yandex.cloud.loadtesting.api.v1.report.KpiThreshold2}

KPI threshold represents a condition that an actual value of test's KPI should satisfy.

#|
||Field | Description ||
|| value | **double**

Value for comparison with an actual KPI value. ||
|| comparison | enum **Comparison**

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
|| size | enum **TitleSize**

Title size.

- `TITLE_SIZE_UNSPECIFIED`: Unspecified.
- `TITLE_SIZE_XS`: Extra small.
- `TITLE_SIZE_S`: Small.
- `TITLE_SIZE_M`: Medium.
- `TITLE_SIZE_L`: Large. ||
|#