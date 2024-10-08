---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/RegressionDashboard/create.md
---

# Load Testing API, REST: RegressionDashboard.create
Creates a regression dashboard in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/regressionDashboards
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
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

        // `content.widgets[]` includes only one of the fields `chart`, `text`, `title`
        "chart": {
          "id": "string",
          "name": "string",
          "description": "string",
          "filterStr": "string",
          "testCase": "string",
          "kpis": [
            {
              "selector": {

                // `content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`
                "responseTime": {
                  "quantile": "string"
                },
                "instances": {
                  "agg": "string"
                },
                "imbalanceRps": {},
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
                },
                // end of the list of possible fields`content.widgets[].chart.kpis[].selector`

              },
              "threshold": {
                "value": "number",
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
        },
        // end of the list of possible fields`content.widgets[]`

      }
    ]
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a regression dashboard in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the dashboard.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the dashboard.</p> <p>The maximum string length in characters is 1024.</p> 
content | **object**<br><p>Content of the dashboard.</p> <p>Content of regression dashboard.</p> 
content.<br>widgets[] | **object**<br><p>Widgets.</p> 
content.<br>widgets[].<br>position | **object**<br>Widget position.
content.<br>widgets[].<br>position.<br>x | **string** (int64)<br><p>X.</p> 
content.<br>widgets[].<br>position.<br>y | **string** (int64)<br><p>Y.</p> 
content.<br>widgets[].<br>position.<br>width | **string** (int64)<br><p>Width.</p> 
content.<br>widgets[].<br>position.<br>height | **string** (int64)<br><p>Height.</p> 
content.<br>widgets[].<br>chart | **object**<br>Chart widget. <br>`content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br>
content.<br>widgets[].<br>chart.<br>id | **string**<br><p>ID of the chart.</p> 
content.<br>widgets[].<br>chart.<br>name | **string**<br><p>Name of the chart.</p> 
content.<br>widgets[].<br>chart.<br>description | **string**<br><p>Description of the chart.</p> 
content.<br>widgets[].<br>chart.<br>filterStr | **string**<br><p>Test filter selector to show KPI values for.</p> 
content.<br>widgets[].<br>chart.<br>testCase | **string**<br><p>Test case to show KPI values for.</p> 
content.<br>widgets[].<br>chart.<br>kpis[] | **object**<br><p>KPIs to show.</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector | **object**<br><p>Kind of KPI.</p> <p>KPI selector.</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>responseTime | **object**<br>Response time cummulative quantile (percentile). <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>responseTime.<br>quantile | **string**<br><p>Cummulative quantile (percentile).</p> <p>Quantiles (percentiles).</p> <ul> <li>QUANTILE_TYPE_UNSPECIFIED: Unspecified percentile. - QUANTILE_TYPE_50: 50 percentile (median).</li> <li>QUANTILE_TYPE_75: 75 percentile.</li> <li>QUANTILE_TYPE_80: 80 percentile.</li> <li>QUANTILE_TYPE_85: 85 percentile.</li> <li>QUANTILE_TYPE_90: 90 percentile.</li> <li>QUANTILE_TYPE_95: 95 percentile.</li> <li>QUANTILE_TYPE_98: 98 percentile.</li> <li>QUANTILE_TYPE_99: 99 percentile.</li> <li>QUANTILE_TYPE_100: 100 percentile (maximum or minimum).</li> </ul> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>instances | **object**<br>A number of instances throughout the test. <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>instances.<br>agg | **string**<br><p>Aggregation function.</p> <p>Aggregation function.</p> <ul> <li>AGGREGATION_UNSPECIFIED: Unspecified. - AGGREGATION_MIN: Minimum.</li> <li>AGGREGATION_MAX: Maximum.</li> <li>AGGREGATION_AVG: Average.</li> <li>AGGREGATION_MEDIAN: Median.</li> <li>AGGREGATION_STD_DEV: Standard deviation.</li> </ul> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>imbalanceRps | **object**<br>An RPS at the moment the test has been auto-stopped. <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesAbsolute | **object**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesAbsolute.<br>codesPatterns[] | **string**<br><p>Protocol (HTTP, GRPC) code patterns to match.</p> <p>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesRelative | **object**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesRelative.<br>codesPatterns[] | **string**<br><p>Protocol (HTTP, GRPC) code patterns to match.</p> <p>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesAbsolute | **object**<br>A total number of requests completed with certain network codes. <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesAbsolute.<br>codesPatterns[] | **string**<br><p>Network code patterns to match.</p> <p>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesRelative | **object**<br>A percentage of requests completed with certain network codes. <br>`content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesRelative.<br>codesPatterns[] | **string**<br><p>Network code patterns to match.</p> <p>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>threshold | **object**<br><p>A condition that should be specified.</p> <p>KPI threshold represents a condition that an actual value of test's KPI should satisfy.</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>threshold.<br>value | **number** (double)<br><p>Value for comparison with an actual KPI value.</p> 
content.<br>widgets[].<br>chart.<br>kpis[].<br>threshold.<br>comparison | **string**<br><p>Comparison operator for comparing actual with the threshold value.</p> <p>Rule: actual (&lt;/&lt;=/&gt;/&gt;=) reference</p> <p>Comparison operator.</p> <ul> <li>COMPARISON_UNSPECIFIED: Unspecified. - COMPARISON_LT: Less than the specified value.</li> <li>COMPARISON_LTE: Less than or equal to the specified value.</li> <li>COMPARISON_GT: Greater than the specified value.</li> <li>COMPARISON_GTE: Greater than or equal to the specified value.</li> </ul> 
content.<br>widgets[].<br>text | **object**<br>Text widget. <br>`content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br>
content.<br>widgets[].<br>text.<br>text | **string** <br>`content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br><br><p>Text string.</p> 
content.<br>widgets[].<br>title | **object**<br>Title widget. <br>`content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br>
content.<br>widgets[].<br>title.<br>text | **string** <br>`content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br><br><p>Title string.</p> 
content.<br>widgets[].<br>title.<br>size | **string**<br><p>Title size.</p> <p>Title size.</p> <ul> <li>TITLE_SIZE_UNSPECIFIED: Unspecified. - TITLE_SIZE_XS: Extra small.</li> <li>TITLE_SIZE_S: Small.</li> <li>TITLE_SIZE_M: Medium.</li> <li>TITLE_SIZE_L: Large.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 