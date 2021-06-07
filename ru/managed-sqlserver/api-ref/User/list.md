---
editable: false
---

# Method list
Retrieves a list of SQL Server users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list SQL Server users in.  To get the cluster ID, use a [list](/docs/managed-sqlserver/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-sqlserver/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-sqlserver/api-ref/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
users[] | **object**<br><p>An SQL Server user.</p> 
users[].<br>name | **string**<br><p>Name of the SQL Server user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the SQL Server cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database the permission grants access to.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Members of this fixed database role can perform all configuration and maintenance activities on the database, and can also drop the database in SQL Server.</li> <li>DB_SECURITYADMIN: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li> <li>DB_ACCESSADMIN: Members of this fixed database role can add or remove access to the database for Windows logins, Windows groups, and SQL Server logins.</li> <li>DB_BACKUPOPERATOR: Members of this fixed database role can back up the database.</li> <li>DB_DDLADMIN: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li> <li>DB_DATAWRITER: Members of this fixed database role can add, delete, or change data in all user tables.</li> <li>DB_DATAREADER: Members of this fixed database role can read all data from all user tables.</li> <li>DB_DENYDATAWRITER: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> <li>DB_DENYDATAREADER: Members of this fixed database role cannot read any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> </ul> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 