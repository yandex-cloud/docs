---
editable: false
---

# Method list
Retrieves the list of databases in a cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list databases in.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageSize</a>, the API returns a <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-mysql/api-ref/Database/list">list</a> requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageToken</a> to the <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-mysql/api-ref/Database/list">list</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
databases[] | **object**<br><p>List of databases.</p> 
databases[].<br>name | **string**<br><p>Name of the database.</p> 
databases[].<br>clusterId | **string**<br><p>ID of the cluster that the database belongs to.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Database/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Database/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> 