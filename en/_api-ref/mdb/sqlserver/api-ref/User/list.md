---
editable: false
---

# Managed Service for SQL Server API, REST: User.list
Retrieves a list of SQL Server users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/mdb/sqlserver/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list SQL Server users in.</p> <p>To get the cluster ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-sqlserver/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageToken</a> to the <a href="/docs/managed-sqlserver/api-ref/User/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      ],
      "serverRoles": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>Requested list of SQL Server users.</p> 
users[].<br>name | **string**<br><p>Name of the SQL Server user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the SQL Server cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database the permission grants access to.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><p>Required. Roles granted to the user within the database.</p> <p>The minimum number of elements is 1.</p> <ul> <li>DB_OWNER: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li> <li>DB_SECURITYADMIN: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li> <li>DB_ACCESSADMIN: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li> <li>DB_BACKUPOPERATOR: Members of this fixed database role can back up the database.</li> <li>DB_DDLADMIN: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li> <li>DB_DATAWRITER: Members of this fixed database role can add, delete, or change data in all user tables.</li> <li>DB_DATAREADER: Members of this fixed database role can read all data from all user tables.</li> <li>DB_DENYDATAWRITER: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> <li>DB_DENYDATAREADER: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> </ul> 
users[].<br>serverRoles[] | **string**<br><p>Set of server roles granted to the login.</p> <ul> <li> <p>MDB_MONITOR: Effectively grants VIEW SERVER STATE to the login.</p> <p>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS.</p> <p>No intrusive actions are allowed, so this is pretty safe to grant.</p> </li> </ul> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-sqlserver/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-sqlserver/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 