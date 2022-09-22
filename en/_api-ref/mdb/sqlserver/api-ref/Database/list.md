---
editable: false
---

# Method list
Retrieves the list of SQL Server databases in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/mdb/sqlserver/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the SQL Server cluster to list databases in.</p> <p>To get the cluster ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-sqlserver/api-ref/Database/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-sqlserver/api-ref/Database/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-sqlserver/api-ref/Database/list#query_params">pageToken</a> to the <a href="/docs/managed-sqlserver/api-ref/Database/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
databases[] | **object**<br><p>List of SQL Server databases.</p> 
databases[].<br>name | **string**<br><p>Name of the database.</p> 
databases[].<br>clusterId | **string**<br><p>ID of the SQL Server cluster that the database belongs to.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Database/list#query_params">pageSize</a>, use the <a href="/docs/managed-sqlserver/api-ref/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-sqlserver/api-ref/Database/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-sqlserver/api-ref/Database/list#responses">nextPageToken</a> to continue paging through the results.</p> 