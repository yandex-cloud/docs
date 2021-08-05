---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method list
Retrieves the list of MySQL databases in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MySQL cluster to list databases in. To get the cluster ID use a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/Database/list#query_params), the service returns a [nextPageToken](/docs/managed-mysql/api-ref/Database/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, Set [pageToken](/docs/managed-mysql/api-ref/Database/list#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/Database/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
databases[] | **object**<br><p>A MySQL database. For more information, see the <a href="/docs/managed-mysql/concepts">documentation</a>.</p> 
databases[].<br>name | **string**<br><p>Name of the database.</p> 
databases[].<br>clusterId | **string**<br><p>ID of the MySQL cluster that the database belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> to continue paging through the results.</p> 