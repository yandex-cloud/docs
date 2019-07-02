---
editable: false
---

# Method list
Retrieves the list of PostgreSQL User resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list PostgreSQL users in. To get the cluster ID, use a [list](/docs/managed-postgresql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-postgresql/api-ref/User/list#query_params), the service returns a [nextPageToken](/docs/managed-postgresql/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-postgresql/api-ref/User/list#query_params) to the [nextPageToken](/docs/managed-postgresql/api-ref/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "databaseName": "string"
        }
      ],
      "connLimit": "string",
      "settings": {
        "defaultTransactionIsolation": "string",
        "lockTimeout": "integer",
        "logMinDurationStatement": "integer",
        "synchronousCommit": "string",
        "tempFileLimit": "integer"
      },
      "login": true,
      "grants": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>A PostgreSQL User resource. For more information, see the <a href="/docs/managed-postgresql/concepts">Developer's Guide</a>.</p> 
users[].<br>name | **string**<br><p>Name of the PostgreSQL user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the PostgreSQL cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>connLimit | **string** (int64)<br><p>Number of database connections available to the user.</p> 
users[].<br>settings | **object**<br><p>Postgresql settings for this user</p> <p>Postgresql user settings config</p> 
users[].<br>settings.<br>defaultTransactionIsolation | **string**<br>
users[].<br>settings.<br>lockTimeout | **integer** (int64)<br><p>in milliseconds.</p> 
users[].<br>settings.<br>logMinDurationStatement | **integer** (int64)<br><p>in milliseconds.</p> 
users[].<br>settings.<br>synchronousCommit | **string**<br>
users[].<br>settings.<br>tempFileLimit | **integer** (int64)<br><p>in bytes.</p> 
users[].<br>login | **boolean** (boolean)<br><p>User can login (default True)</p> 
users[].<br>grants[] | **string**<br><p>User grants (GRANT <role> TO <user>), role must be other user</p> <p>The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[a-zA-Z0-9_]*</code>.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 