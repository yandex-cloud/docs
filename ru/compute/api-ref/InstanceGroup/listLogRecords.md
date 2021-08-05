---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method listLogRecords
Lists logs for the specified instance group.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups/{instanceGroupId}:logs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceGroupId | Required. ID of the InstanceGroup resource to list logs for. To get the instance group ID, use a [list](/docs/compute/api-ref/InstanceGroup/list) request.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/InstanceGroup/listLogRecords#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params) to the [nextPageToken](/docs/compute/api-ref/InstanceGroup/listLogRecords#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](/docs/compute/api-ref/InstanceGroup#representation) field.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logRecords": [
    {
      "timestamp": "string",
      "message": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
logRecords[] | **object**<br><p>Lists logs for the specified instance group.</p> 
logRecords[].<br>timestamp | **string** (date-time)<br><p>Log timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logRecords[].<br>message | **string**<br><p>The log message.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> to continue paging through the results.</p> 