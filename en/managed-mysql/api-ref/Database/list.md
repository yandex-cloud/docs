---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Database/list.md
---


# Method list
Retrieves the list of databases in a cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list databases in.  To get this ID, make a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/Database/list#query_params), the API returns a [nextPageToken](/docs/managed-mysql/api-ref/Database/list#responses) that can be used to get the next page of results in the subsequent [list](/docs/managed-mysql/api-ref/Database/list) requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token that can be used to iterate through multiple pages of results.  To get the next page of results, set [pageToken](/docs/managed-mysql/api-ref/Database/list#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/Database/list#responses) returned by the previous [list](/docs/managed-mysql/api-ref/Database/list) request.  The maximum string length in characters is 100.
 
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
databases[] | **object**<br><p>An object that represents MySQL database.</p> <p>See <a href="/docs/managed-mysql/operations/databases">the documentation</a> for details.</p> 
databases[].<br>name | **string**<br><p>Name of the database.</p> 
databases[].<br>clusterId | **string**<br><p>ID of the cluster that the database belongs to.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Database/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Database/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> 