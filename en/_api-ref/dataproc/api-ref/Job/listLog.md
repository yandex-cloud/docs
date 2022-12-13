---
editable: false
---

# Data Proc API, REST: Job.listLog
Returns a log for specified job.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/jobs/{jobId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that the job is being created for.</p> <p>The maximum string length in characters is 50.</p> 
jobId | <p>ID of the job being created.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum bytes of job log per response to return. If the number of available bytes is larger than <a href="/docs/data-proc/api-ref/Job/listLog#query_params">pageSize</a>, the service returns a <a href="/docs/data-proc/api-ref/Job/listLog#responses">nextPageToken</a> that can be used to get the next page of output in subsequent list requests. Default value: 1048576.</p> <p>The maximum value is 1048576.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/data-proc/api-ref/Job/listLog#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "content": "string",
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
content | **string**<br><p>Requested part of Data Proc Job log.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListLog requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListLog request. Subsequent ListLog requests will have their own ``next_page_token`` to continue paging through the results.</p> 