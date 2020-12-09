---
editable: false
---

# Method list
Retrieves the list of PostgreSQL Database resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL cluster to list databases in. To get the cluster ID use a [list](/docs/managed-postgresql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | Page token. To get the next page of results, Set [pageToken](/docs/managed-postgresql/api-ref/Database/list#query_params) to the [nextPageToken](/docs/managed-postgresql/api-ref/Database/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
    {
      "name": "string",
      "clusterId": "string",
      "owner": "string",
      "lcCollate": "string",
      "lcCtype": "string",
      "extensions": [
        {
          "name": "string",
          "version": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
databases[] | **object**<br><p>A PostgreSQL Database resource. For more information, see the <a href="/docs/managed-postgresql/concepts">Developer's Guide</a>.</p> 
databases[].<br>name | **string**<br><p>Name of the database.</p> 
databases[].<br>clusterId | **string**<br><p>ID of the PostgreSQL cluster that the database belongs to.</p> 
databases[].<br>owner | **string**<br><p>Name of the user assigned as the owner of the database.</p> 
databases[].<br>lcCollate | **string**<br><p>POSIX locale for string sorting order. Can only be set at creation time.</p> 
databases[].<br>lcCtype | **string**<br><p>POSIX locale for character classification. Can only be set at creation time.</p> 
databases[].<br>extensions[] | **object**<br><p>PostgreSQL extensions enabled for the database.</p> 
databases[].<br>extensions[].<br>name | **string**<br><p>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are <a href="/docs/managed-postgresql/operations/cluster-extensions">listed in the Developer's Guide</a>.</p> 
databases[].<br>extensions[].<br>version | **string**<br><p>Version of the extension.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> to continue paging through the results.</p> 