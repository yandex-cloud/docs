---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method listMetrics
Retrieves the list of metrics.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
selectors | Metric selectors.
pageSize | Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/monitoring/api-ref/MetricsMeta/listMetrics#query_params) to the [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listMetrics#responses) returned by a previous list request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "metrics": [
    {
      "name": "string",
      "labels": "object",
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
metrics[] | **object**<br><p>List of metrics.</p> 
metrics[].<br>name | **string**<br><p>Name of the metric.</p> 
metrics[].<br>labels | **object**<br><p>Metric labels as <code>key:value</code> pairs.</p> 
metrics[].<br>type | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> 