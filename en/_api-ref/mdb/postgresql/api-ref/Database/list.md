---
editable: false
---

# Managed Service for PostgreSQL API, REST: Database.list
Retrieves the list of PostgreSQL Database resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the PostgreSQL cluster to list databases in. To get the cluster ID use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, Set <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageToken</a> to the <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      ],
      "templateDb": "string",
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
databases[] | **object**<br><p>List of PostgreSQL Database resources.</p> 
databases[].<br>name | **string**<br><p>Name of the database.</p> 
databases[].<br>clusterId | **string**<br><p>ID of the PostgreSQL cluster that the database belongs to.</p> 
databases[].<br>owner | **string**<br><p>Name of the user assigned as the owner of the database.</p> 
databases[].<br>lcCollate | **string**<br><p>POSIX locale for string sorting order. Can only be set at creation time.</p> 
databases[].<br>lcCtype | **string**<br><p>POSIX locale for character classification. Can only be set at creation time.</p> 
databases[].<br>extensions[] | **object**<br><p>PostgreSQL extensions enabled for the database.</p> 
databases[].<br>extensions[].<br>name | **string**<br><p>Name of the extension, e.g. ``pg_trgm`` or ``pg_btree``. Extensions supported by Managed Service for PostgreSQL are <a href="/docs/managed-postgresql/operations/cluster-extensions">listed in the Developer's Guide</a>.</p> 
databases[].<br>extensions[].<br>version | **string**<br><p>Version of the extension.</p> 
databases[].<br>templateDb | **string**<br><p>Name of the database template.</p> 
databases[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the database</p> <p>Default value: ``unspecified`` (inherits cluster's deletion_protection)</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> to continue paging through the results.</p> 