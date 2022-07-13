---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/User/index.md
---

# User
A set of methods for managing MySQL users.

See [the documentation](/docs/managed-mysql/operations/cluster-users) for details.
## JSON Representation {#representation}
```json 
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
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the user.</p> 
clusterId | **string**<br><p>ID of the cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><p>Required. Roles granted to the user within the database.</p> <p>See <a href="/docs/managed-mysql/operations/grant">the documentation</a> for details.</p> <p>The minimum number of elements is 1.</p> <ul> <li> <p>ALL_PRIVILEGES: All privileges that can be made available to the user.</p> </li> <li> <p>ALTER: Altering tables.</p> </li> <li> <p>ALTER_ROUTINE: Altering stored routines and functions.</p> </li> <li> <p>CREATE: Creating tables or indexes.</p> </li> <li> <p>CREATE_ROUTINE: Creating stored routines.</p> </li> <li> <p>CREATE_TEMPORARY_TABLES: Creating temporary tables.</p> </li> <li> <p>CREATE_VIEW: Creating views.</p> </li> <li> <p>DELETE: Deleting tables.</p> </li> <li> <p>DROP: Removing tables or views.</p> </li> <li> <p>EVENT: Creating, altering, dropping, or displaying events for the Event Scheduler.</p> </li> <li> <p>EXECUTE: Executing stored routines.</p> </li> <li> <p>INDEX: Creating and removing indexes.</p> </li> <li> <p>INSERT: Inserting rows into the database.</p> </li> <li> <p>LOCK_TABLES: Using ``LOCK TABLES`` statement for tables available with ``SELECT`` privilege.</p> </li> <li> <p>SELECT: Selecting rows from tables.</p> <p>Some ``SELECT`` statements can be allowed without the ``SELECT`` privilege. All statements that read column values require the ``SELECT`` privilege.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select">MySQL documentation</a> for details.</p> </li> <li> <p>SHOW_VIEW: Using the ``SHOW CREATE VIEW`` statement. Also needed for views used with ``EXPLAIN``.</p> </li> <li> <p>TRIGGER: Creating, removing, executing, or displaying triggers for a table.</p> </li> <li> <p>UPDATE: Updating rows in the database.</p> </li> <li> <p>REFERENCES: Creation of a foreign key constraint for the parent table.</p> </li> </ul> 
globalPermissions[] | **string**<br><p>Set of global permissions to grant to the user.</p> <ul> <li> <p>REPLICATION_CLIENT: Enables use of the ``SHOW MASTER STATUS``, ``SHOW SLAVE STATUS``, and ``SHOW BINARY LOGS`` statements.</p> </li> <li> <p>REPLICATION_SLAVE: Enables the account to request updates that have been made to databases on the master server, using the ``SHOW SLAVE HOSTS``, ``SHOW RELAYLOG EVENTS`` and ``SHOW BINLOG EVENTS`` statements.</p> </li> <li> <p>PROCESS: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).</p> <p>The privilege enables use of ``SHOW PROCESSLIST`` or ``mysqladmin`` processlist to see threads belonging to other users. You can always see your own threads. The ``PROCESS`` privilege also enables use of ``SHOW ENGINE``.</p> </li> </ul> 
connectionLimits | **object**<br><p>Set of user connection limits.</p> 
connectionLimits.<br>maxQuestionsPerHour | **integer** (int64)<br><p>The maximum permitted number of user questions per hour.</p> <p>The minimum value is 0.</p> 
connectionLimits.<br>maxUpdatesPerHour | **integer** (int64)<br><p>The maximum permitted number of user updates per hour.</p> <p>The minimum value is 0.</p> 
connectionLimits.<br>maxConnectionsPerHour | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections per hour.</p> <p>The minimum value is 0.</p> 
connectionLimits.<br>maxUserConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections permitted to any given MySQL user account.</p> <p>The minimum value is 0.</p> 
authenticationPlugin | **string**<br><p>User authentication plugin.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a user in a cluster.
[delete](delete.md) | Deletes a user in a cluster.
[get](get.md) | Retrieves information about the specified user.
[grantPermission](grantPermission.md) | Grants permission to access a database to a user in a cluster.
[list](list.md) | Retrieves the list of users in a cluster.
[revokePermission](revokePermission.md) | Revokes permission to access a database from a user in a cluster.
[update](update.md) | Updates a user in a cluster.