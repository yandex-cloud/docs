---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method listMetricNames
Retrieves the list of metric names.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/names
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
selectors | Metric selectors.
nameFilter | Substring name filter text.
pageSize | Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/monitoring/api-ref/MetricsMeta/listMetricNames#query_params) to the [nextPageToken](/docs/monitoring/api-ref/MetricsMeta/listMetricNames#responses) returned by a previous list request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "names": [
    "string"
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
names[] | **string**<br><p>List of metric names.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> 