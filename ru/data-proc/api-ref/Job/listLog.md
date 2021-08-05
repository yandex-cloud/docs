---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method listLog
Returns a log for specified job.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/jobs/{jobId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster that the job is being created for.  The maximum string length in characters is 50.
jobId | ID of the job being created.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum bytes of job log per response to return. If the number of available bytes is larger than [pageSize](/docs/data-proc/api-ref/Job/listLog#query_params), the service returns a [nextPageToken](/docs/data-proc/api-ref/Job/listLog#responses) that can be used to get the next page of output in subsequent list requests. Default value: 1048576.  The maximum value is 1048576.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/data-proc/api-ref/Job/listLog#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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