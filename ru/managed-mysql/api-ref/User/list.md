---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/User/list.md
---

# Managed Service for MySQL API, REST: User.list
Retrieves the list of users in a cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list the users in.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageSize</a>, the API returns a <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-mysql/api-ref/User/list">list</a> requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageToken</a> to the <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-mysql/api-ref/User/list">list</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "globalPermissions": [
        "string"
      ],
      "connectionLimits": {
        "maxQuestionsPerHour": "integer",
        "maxUpdatesPerHour": "integer",
        "maxConnectionsPerHour": "integer",
        "maxUserConnections": "integer"
      },
      "authenticationPlugin": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>List of users.</p> 
users[].<br>name | **string**<br><p>Name of the user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><p>Required. Roles granted to the user within the database.</p> <p>See <a href="/docs/managed-mysql/operations/grant">the documentation</a> for details.</p> <p>The minimum number of elements is 1.</p> <ul> <li> <p>ALL_PRIVILEGES: All privileges that can be made available to the user.</p> </li> <li> <p>ALTER: Altering tables.</p> </li> <li> <p>ALTER_ROUTINE: Altering stored routines and functions.</p> </li> <li> <p>CREATE: Creating tables or indexes.</p> </li> <li> <p>CREATE_ROUTINE: Creating stored routines.</p> </li> <li> <p>CREATE_TEMPORARY_TABLES: Creating temporary tables.</p> </li> <li> <p>CREATE_VIEW: Creating views.</p> </li> <li> <p>DELETE: Deleting tables.</p> </li> <li> <p>DROP: Removing tables or views.</p> </li> <li> <p>EVENT: Creating, altering, dropping, or displaying events for the Event Scheduler.</p> </li> <li> <p>EXECUTE: Executing stored routines.</p> </li> <li> <p>INDEX: Creating and removing indexes.</p> </li> <li> <p>INSERT: Inserting rows into the database.</p> </li> <li> <p>LOCK_TABLES: Using ``LOCK TABLES`` statement for tables available with ``SELECT`` privilege.</p> </li> <li> <p>SELECT: Selecting rows from tables.</p> <p>Some ``SELECT`` statements can be allowed without the ``SELECT`` privilege. All statements that read column values require the ``SELECT`` privilege.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select">MySQL documentation</a> for details.</p> </li> <li> <p>SHOW_VIEW: Using the ``SHOW CREATE VIEW`` statement. Also needed for views used with ``EXPLAIN``.</p> </li> <li> <p>TRIGGER: Creating, removing, executing, or displaying triggers for a table.</p> </li> <li> <p>UPDATE: Updating rows in the database.</p> </li> <li> <p>REFERENCES: Creation of a foreign key constraint for the parent table.</p> </li> </ul> 
users[].<br>globalPermissions[] | **string**<br><p>Set of global permissions to grant to the user.</p> <ul> <li> <p>REPLICATION_CLIENT: Enables use of the ``SHOW MASTER STATUS``, ``SHOW SLAVE STATUS``, and ``SHOW BINARY LOGS`` statements.</p> </li> <li> <p>REPLICATION_SLAVE: Enables the account to request updates that have been made to databases on the master server, using the ``SHOW SLAVE HOSTS``, ``SHOW RELAYLOG EVENTS`` and ``SHOW BINLOG EVENTS`` statements.</p> </li> <li> <p>PROCESS: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).</p> <p>The privilege enables use of ``SHOW PROCESSLIST`` or ``mysqladmin`` processlist to see threads belonging to other users. You can always see your own threads. The ``PROCESS`` privilege also enables use of ``SHOW ENGINE``.</p> </li> <li> <p>FLUSH_OPTIMIZER_COSTS: Enables use of the ``FLUSH OPTIMIZER_COSTS`` statement.</p> </li> <li> <p>SHOW_ROUTINE: Enables a user to access definitions and properties of all stored routines (stored procedures and functions), even those for which the user is not named as the routine DEFINER. This access includes: The contents of the Information Schema ``ROUTINES`` table. The ``SHOW CREATE FUNCTION`` and ``SHOW CREATE PROCEDURE`` statements. The ``SHOW FUNCTION CODE`` and ``SHOW PROCEDURE CODE`` statements. The SHOW ``FUNCTION STATUS`` and ``SHOW PROCEDURE STATUS`` statements.</p> </li> </ul> 
users[].<br>connectionLimits | **object**<br><p>Set of user connection limits.</p> 
users[].<br>connectionLimits.<br>maxQuestionsPerHour | **integer** (int64)<br><p>The maximum permitted number of user questions per hour.</p> <p>The minimum value is 0.</p> 
users[].<br>connectionLimits.<br>maxUpdatesPerHour | **integer** (int64)<br><p>The maximum permitted number of user updates per hour.</p> <p>The minimum value is 0.</p> 
users[].<br>connectionLimits.<br>maxConnectionsPerHour | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections per hour.</p> <p>The minimum value is 0.</p> 
users[].<br>connectionLimits.<br>maxUserConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections permitted to any given MySQL user account.</p> <p>The minimum value is 0.</p> 
users[].<br>authenticationPlugin | **string**<br><p>User authentication plugin.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/User/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/User/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> 