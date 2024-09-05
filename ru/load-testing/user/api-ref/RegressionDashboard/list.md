---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/RegressionDashboard/list.md
---

# Load Testing API, REST: RegressionDashboard.list
Retrieves the list of regression dashboards in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/regressionDashboards
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list dashboards in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/load-testing/user/api-ref/RegressionDashboard/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/load-testing/user/api-ref/RegressionDashboard/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters dashboards listed in the response.</p> <p>The filter expression may contain multiple field expressions joined by ``AND``. The field expression must specify:</p> <ol> <li>The field name.</li> <li>An operator: <ul> <li>``=``, ``!=``, ``CONTAINS``, for single values.</li> <li>``IN`` or ``NOT IN`` for lists of values.</li> </ul> </li> <li>The value. String values must be encosed in ``"``, boolean values are {``true``, ``false``}, timestamp values in ISO-8601.</li> </ol> <p>Currently supported fields:</p> <ul> <li>``id`` ``id`` <ul> <li>operators: ``=``, ``!=``, ``IN``, ``NOT IN``</li> </ul> </li> <li>``name`` ``name`` <ul> <li>operators: ``=``, ``!=``, ``IN``, ``NOT IN``, ``CONTAINS``</li> </ul> </li> </ul> <p>Examples:</p> <ul> <li>``id IN ("1", "2", "3")``</li> <li>``name CONTAINS "my-dashboard" AND id NOT IN ("4", "5")``</li> </ul> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "dashboards": [
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

            // `dashboards[].content.widgets[]` includes only one of the fields `chart`, `text`, `title`
            "chart": {
              "id": "string",
              "name": "string",
              "description": "string",
              "filterStr": "string",
              "testCase": "string",
              "kpis": [
                {
                  "selector": {

                    // `dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`
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
                    // end of the list of possible fields`dashboards[].content.widgets[].chart.kpis[].selector`

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
            // end of the list of possible fields`dashboards[].content.widgets[]`

          }
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
dashboards[] | **object**<br><p>List of dashboards in the specified folder.</p> 
dashboards[].<br>id | **string**<br><p>ID of the dashboard.</p> 
dashboards[].<br>name | **string**<br><p>Name of the dashboard.</p> 
dashboards[].<br>description | **string**<br><p>Description of the dashboard.</p> 
dashboards[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
dashboards[].<br>updatedAt | **string** (date-time)<br><p>Last update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
dashboards[].<br>createdBy | **string**<br><p>UA or SA that created the dashboard.</p> 
dashboards[].<br>updatedBy | **string**<br><p>UA or SA that updated the dashboard last time.</p> 
dashboards[].<br>etag | **string**<br><p>Etag of the dashboard.</p> 
dashboards[].<br>content | **object**<br><p>Dashboard content.</p> <p>Content of regression dashboard.</p> 
dashboards[].<br>content.<br>widgets[] | **object**<br><p>Widgets.</p> 
dashboards[].<br>content.<br>widgets[].<br>position | **object**<br>Widget position.
dashboards[].<br>content.<br>widgets[].<br>position.<br>x | **string** (int64)<br><p>X.</p> 
dashboards[].<br>content.<br>widgets[].<br>position.<br>y | **string** (int64)<br><p>Y.</p> 
dashboards[].<br>content.<br>widgets[].<br>position.<br>width | **string** (int64)<br><p>Width.</p> 
dashboards[].<br>content.<br>widgets[].<br>position.<br>height | **string** (int64)<br><p>Height.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart | **object**<br>Chart widget. <br>`dashboards[].content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>id | **string**<br><p>ID of the chart.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>name | **string**<br><p>Name of the chart.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>description | **string**<br><p>Description of the chart.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>filterStr | **string**<br><p>Test filter selector to show KPI values for.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>testCase | **string**<br><p>Test case to show KPI values for.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[] | **object**<br><p>KPIs to show.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector | **object**<br><p>Kind of KPI.</p> <p>KPI selector.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>responseTime | **object**<br>Response time cummulative quantile (percentile). <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>responseTime.<br>quantile | **string**<br><p>Cummulative quantile (percentile).</p> <p>Quantiles (percentiles).</p> <ul> <li>QUANTILE_TYPE_UNSPECIFIED: Unspecified percentile. - QUANTILE_TYPE_50: 50 percentile (median).</li> <li>QUANTILE_TYPE_75: 75 percentile.</li> <li>QUANTILE_TYPE_80: 80 percentile.</li> <li>QUANTILE_TYPE_85: 85 percentile.</li> <li>QUANTILE_TYPE_90: 90 percentile.</li> <li>QUANTILE_TYPE_95: 95 percentile.</li> <li>QUANTILE_TYPE_98: 98 percentile.</li> <li>QUANTILE_TYPE_99: 99 percentile.</li> <li>QUANTILE_TYPE_100: 100 percentile (maximum or minimum).</li> </ul> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>instances | **object**<br>A number of instances throughout the test. <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>instances.<br>agg | **string**<br><p>Aggregation function.</p> <p>Aggregation function.</p> <ul> <li>AGGREGATION_UNSPECIFIED: Unspecified. - AGGREGATION_MIN: Minimum.</li> <li>AGGREGATION_MAX: Maximum.</li> <li>AGGREGATION_AVG: Average.</li> <li>AGGREGATION_MEDIAN: Median.</li> <li>AGGREGATION_STD_DEV: Standard deviation.</li> </ul> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>imbalanceRps | **object**<br>An RPS at the moment the test has been auto-stopped. <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesAbsolute | **object**<br>A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes. <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesAbsolute.<br>codesPatterns[] | **string**<br><p>Protocol (HTTP, GRPC) code patterns to match.</p> <p>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesRelative | **object**<br>A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes. <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>protocolCodesRelative.<br>codesPatterns[] | **string**<br><p>Protocol (HTTP, GRPC) code patterns to match.</p> <p>All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesAbsolute | **object**<br>A total number of requests completed with certain network codes. <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesAbsolute.<br>codesPatterns[] | **string**<br><p>Network code patterns to match.</p> <p>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesRelative | **object**<br>A percentage of requests completed with certain network codes. <br>`dashboards[].content.widgets[].chart.kpis[].selector` includes only one of the fields `responseTime`, `instances`, `imbalanceRps`, `protocolCodesAbsolute`, `protocolCodesRelative`, `networkCodesAbsolute`, `networkCodesRelative`<br>
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>selector.<br>networkCodesRelative.<br>codesPatterns[] | **string**<br><p>Network code patterns to match.</p> <p>All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>threshold | **object**<br><p>A condition that should be specified.</p> <p>KPI threshold represents a condition that an actual value of test's KPI should satisfy.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>threshold.<br>value | **number** (double)<br><p>Value for comparison with an actual KPI value.</p> 
dashboards[].<br>content.<br>widgets[].<br>chart.<br>kpis[].<br>threshold.<br>comparison | **string**<br><p>Comparison operator for comparing actual with the threshold value.</p> <p>Rule: actual (&lt;/&lt;=/&gt;/&gt;=) reference</p> <p>Comparison operator.</p> <ul> <li>COMPARISON_UNSPECIFIED: Unspecified. - COMPARISON_LT: Less than the specified value.</li> <li>COMPARISON_LTE: Less than or equal to the specified value.</li> <li>COMPARISON_GT: Greater than the specified value.</li> <li>COMPARISON_GTE: Greater than or equal to the specified value.</li> </ul> 
dashboards[].<br>content.<br>widgets[].<br>text | **object**<br>Text widget. <br>`dashboards[].content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br>
dashboards[].<br>content.<br>widgets[].<br>text.<br>text | **string** <br>`dashboards[].content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br><br><p>Text string.</p> 
dashboards[].<br>content.<br>widgets[].<br>title | **object**<br>Title widget. <br>`dashboards[].content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br>
dashboards[].<br>content.<br>widgets[].<br>title.<br>text | **string** <br>`dashboards[].content.widgets[]` includes only one of the fields `chart`, `text`, `title`<br><br><p>Title string.</p> 
dashboards[].<br>content.<br>widgets[].<br>title.<br>size | **string**<br><p>Title size.</p> <p>Title size.</p> <ul> <li>TITLE_SIZE_UNSPECIFIED: Unspecified. - TITLE_SIZE_XS: Extra small.</li> <li>TITLE_SIZE_S: Small.</li> <li>TITLE_SIZE_M: Medium.</li> <li>TITLE_SIZE_L: Large.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/load-testing/user/api-ref/RegressionDashboard/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/load-testing/user/api-ref/RegressionDashboard/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 