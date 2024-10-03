---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Report/calculateKpiValues.md
---

# Load Testing API, REST: Report.calculateKpiValues
Returns a list of KPI values for tests matching the specified filter.
 

 
## HTTP request {#https-request}
```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/reports/calculateKpiValues
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "testFilter": "string",
  "testCase": "string",
  "kpi": {
    "selector": {

      // `kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`
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
      // end of the list of possible fields`kpi.selector`

    },
    "threshold": {
      "value": "number",
      "comparison": "string"
    }
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder containing tests.</p> <p>The maximum string length in characters is 50.</p> 
testFilter | **string**<br><p>Required. Test filter selector to calculate KPI values for.</p> <p>The maximum string length in characters is 1000.</p> 
testCase | **string**<br><p>Test case to calculate KPI values for.</p> <p>If not specified, KPI values will be calculated for 'overall' case.</p> <p>The maximum string length in characters is 100.</p> 
kpi | **object**<br><p>Required. KPI to be calculated.</p> <p>KPI (Key Performance Indicator) represents some integral indicator measured during test.</p> 
kpi.<br>selector | **object**<br><p>Kind of KPI.</p> <p>KPI selector.</p> 
kpi.<br>selector.<br>responseTime | **object**<br>Response time cummulative quantile (percentile). <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>responseTime.<br>quantile | **string**<br><p>Cummulative quantile (percentile).</p> <p>Quantiles (percentiles).</p> <ul> <li>QUANTILE_TYPE_UNSPECIFIED: Unspecified percentile. - QUANTILE_TYPE_50: 50 percentile (median).</li> <li>QUANTILE_TYPE_75: 75 percentile.</li> <li>QUANTILE_TYPE_80: 80 percentile.</li> <li>QUANTILE_TYPE_85: 85 percentile.</li> <li>QUANTILE_TYPE_90: 90 percentile.</li> <li>QUANTILE_TYPE_95: 95 percentile.</li> <li>QUANTILE_TYPE_98: 98 percentile.</li> <li>QUANTILE_TYPE_99: 99 percentile.</li> <li>QUANTILE_TYPE_100: 100 percentile (maximum or minimum).</li> </ul> 
kpi.<br>selector.<br>instances | **object**<br>A number of instances throughout the test. <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>instances.<br>agg | **string**<br><p>Aggregation function.</p> <p>Aggregation function.</p> <ul> <li>AGGREGATION_UNSPECIFIED: Unspecified. - AGGREGATION_MIN: Minimum.</li> <li>AGGREGATION_MAX: Maximum.</li> <li>AGGREGATION_AVG: Average.</li> <li>AGGREGATION_MEDIAN: Median.</li> <li>AGGREGATION_STD_DEV: Standard deviation.</li> </ul> 
kpi.<br>selector.<br>imbalanceRps | **object**<br>An RPS at the moment the test has been auto-stopped. <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>protocolCodesAbsolute | **object**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>protocolCodesAbsolute.<br>codesPatterns[] | **string**<br><p>Protocol (HTTP, GRPC) code patterns to match.</p> <p>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].</p> 
kpi.<br>selector.<br>protocolCodesRelative | **object**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>protocolCodesRelative.<br>codesPatterns[] | **string**<br><p>Protocol (HTTP, GRPC) code patterns to match.</p> <p>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].</p> 
kpi.<br>selector.<br>networkCodesAbsolute | **object**<br>A total number of requests completed with certain network codes. <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>networkCodesAbsolute.<br>codesPatterns[] | **string**<br><p>Network code patterns to match.</p> <p>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].</p> 
kpi.<br>selector.<br>networkCodesRelative | **object**<br>A percentage of requests completed with certain network codes. <br>`kpi.selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
kpi.<br>selector.<br>networkCodesRelative.<br>codesPatterns[] | **string**<br><p>Network code patterns to match.</p> <p>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].</p> 
kpi.<br>threshold | **object**<br><p>A condition that should be specified.</p> <p>KPI threshold represents a condition that an actual value of test's KPI should satisfy.</p> 
kpi.<br>threshold.<br>value | **number** (double)<br><p>Value for comparison with an actual KPI value.</p> 
kpi.<br>threshold.<br>comparison | **string**<br><p>Comparison operator for comparing actual with the threshold value.</p> <p>Rule: actual (&lt;/&lt;=/&gt;/&gt;=) reference</p> <p>Comparison operator.</p> <ul> <li>COMPARISON_UNSPECIFIED: Unspecified. - COMPARISON_LT: Less than the specified value.</li> <li>COMPARISON_LTE: Less than or equal to the specified value.</li> <li>COMPARISON_GT: Greater than the specified value.</li> <li>COMPARISON_GTE: Greater than or equal to the specified value.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "folderId": "string",
  "values": [
    {
      "testId": "string",
      "value": "number",
      "isOk": true
    }
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder.</p> 
values[] | **object**<br><p>Actual KPI values.</p> 
values[].<br>testId | **string**<br><p>ID of a test.</p> 
values[].<br>value | **number** (double)<br><p>Value of KPI.</p> 
values[].<br>isOk | **boolean** (boolean)<br><p>A flag indicating whether the value satisfies KPI threshold condition.</p> 