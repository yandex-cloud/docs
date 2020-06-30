---
editable: false
---

# Method list
Retrieves a list of MySQL users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list MySQL users in. To get the cluster ID, use a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/User/list#query_params), the service returns a [nextPageToken](/docs/managed-mysql/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-mysql/api-ref/User/list#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>A MySQL user. For more information, see the <a href="/docs/managed-mysql/concepts">documentation</a>.</p> 
users[].<br>name | **string**<br><p>Name of the MySQL user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the MySQL cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: All privileges that can be made available to the user.</li> <li>ALTER: Altering tables.</li> <li>ALTER_ROUTINE: Altering stored routines (stored procedures and functions).</li> <li>CREATE: Creating tables or indexes.</li> <li>CREATE_ROUTINE: Creating stored routines.</li> <li>CREATE_TEMPORARY_TABLES: Creating temporary tables.</li> <li>CREATE_VIEW: Creating views.</li> <li>DELETE: Deleting tables.</li> <li>DROP: Removing tables or views.</li> <li>EVENT: Creating, altering, dropping, or displaying events for the Event Scheduler.</li> <li>EXECUTE: Executing stored routines.</li> <li>INDEX: Creating and removing indexes.</li> <li>INSERT: Inserting rows into the database.</li> <li>LOCK_TABLES: Using LOCK TABLES statement for tables available with SELECT privilege.</li> <li>SELECT: Selecting rows from tables.</li> </ul> <p>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in <a href="https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select">MySQL documentation</a>.</p> <ul> <li>SHOW_VIEW: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li> <li>TRIGGER: Creating, removing, executing, or displaying triggers for a table.</li> <li>UPDATE: Updating rows in the database.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 