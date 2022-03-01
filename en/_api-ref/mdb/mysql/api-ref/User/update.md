---
editable: false
---

# Method update
Updates a user in a cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to update the user in.  To get this ID, make a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Name of the user to update.  To get this name, make a [list](/docs/managed-mysql/api-ref/User/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "password": "string",
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
updateMask | **string**<br><p>Field mask that specifies which settings of the user should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
password | **string**<br><p>New password for the user.</p> <p>The string length in characters must be 8-128.</p> 
permissions[] | **object**<br><p>A new set of permissions that should be granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: All privileges that can be made available to the user.</li> <li>ALTER: Altering tables.</li> <li>ALTER_ROUTINE: Altering stored routines and functions.</li> <li>CREATE: Creating tables or indexes.</li> <li>CREATE_ROUTINE: Creating stored routines.</li> <li>CREATE_TEMPORARY_TABLES: Creating temporary tables.</li> <li>CREATE_VIEW: Creating views.</li> <li>DELETE: Deleting tables.</li> <li>DROP: Removing tables or views.</li> <li>EVENT: Creating, altering, dropping, or displaying events for the Event Scheduler.</li> <li>EXECUTE: Executing stored routines.</li> <li>INDEX: Creating and removing indexes.</li> <li>INSERT: Inserting rows into the database.</li> <li>LOCK_TABLES: Using ``LOCK TABLES`` statement for tables available with ``SELECT`` privilege.</li> <li>SELECT: Selecting rows from tables.</li> </ul> <p>Some ``SELECT`` statements can be allowed without the ``SELECT`` privilege. All statements that read column values require the ``SELECT`` privilege.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select">MySQL documentation</a> for details.</p> <ul> <li>SHOW_VIEW: Using the ``SHOW CREATE VIEW`` statement. Also needed for views used with ``EXPLAIN``.</li> <li>TRIGGER: Creating, removing, executing, or displaying triggers for a table.</li> <li>UPDATE: Updating rows in the database.</li> <li>REFERENCES: Creation of a foreign key constraint for the parent table.</li> </ul> 
globalPermissions[] | **string**<br><ul> <li>REPLICATION_CLIENT: Enables use of the ``SHOW MASTER STATUS``, ``SHOW SLAVE STATUS``, and ``SHOW BINARY LOGS`` statements.</li> <li>REPLICATION_SLAVE: Enables the account to request updates that have been made to databases on the master server, using the ``SHOW SLAVE HOSTS``, ``SHOW RELAYLOG EVENTS`` and ``SHOW BINLOG EVENTS`` statements.</li> <li>PROCESS: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).</li> </ul> <p>The privilege enables use of ``SHOW PROCESSLIST`` or ``mysqladmin`` processlist to see threads belonging to other users. You can always see your own threads. The ``PROCESS`` privilege also enables use of ``SHOW ENGINE``.</p> 
connectionLimits | **object**<br><p>Set of changed user connection limits.</p> 
connectionLimits.<br>maxQuestionsPerHour | **integer** (int64)<br><p>The maximum permitted number of user questions per hour.</p> <p>The minimum value is 0.</p> 
connectionLimits.<br>maxUpdatesPerHour | **integer** (int64)<br><p>The maximum permitted number of user updates per hour.</p> <p>The minimum value is 0.</p> 
connectionLimits.<br>maxConnectionsPerHour | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections per hour.</p> <p>The minimum value is 0.</p> 
connectionLimits.<br>maxUserConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections permitted to any given MySQL user account.</p> <p>The minimum value is 0.</p> 
authenticationPlugin | **string**<br><p>New user authentication plugin.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Use <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 