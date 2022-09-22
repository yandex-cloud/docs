---
editable: false
---

# Method update
Updates the specified PostgreSQL user.
 

 
## HTTP request {#https-request}
```
PATCH https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
userName | <p>Required. Name of the user to be updated. To get the name of the user use a <a href="/docs/managed-postgresql/api-ref/User/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "password": "string",
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
    "tempFileLimit": "integer",
    "logStatement": "string"
  },
  "login": true,
  "grants": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the PostgreSQL User resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
password | **string**<br><p>New password for the user.</p> <p>The string length in characters must be 8-128.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user to access specific databases.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
connLimit | **string** (int64)<br><p>Maximum number of database connections available to the user.</p> <p>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config.max_connections] setting.</p> <p>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only ``N`` concurrent connections will be opened, where ``N`` is the value of the setting.</p> <p>Minimum value: ``10`` (default: ``50``), when used in session pooling.</p> <p>The minimum value is 10.</p> 
settings | **object**<br><p>PostgreSQL user settings.</p> 
settings.<br>defaultTransactionIsolation | **string**<br><p>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions.</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/transaction-iso.html">PostgreSQL documentation</a>.</p> <ul> <li>TRANSACTION_ISOLATION_READ_UNCOMMITTED: this level behaves like ``TRANSACTION_ISOLATION_READ_COMMITTED`` in PostgreSQL.</li> <li>TRANSACTION_ISOLATION_READ_COMMITTED: (default) on this level query sees only data committed before the query began.</li> <li>TRANSACTION_ISOLATION_REPEATABLE_READ: on this level all subsequent queries in a transaction will see the same rows, that were read by the first ``SELECT`` or ``INSERT`` query in this transaction, unchanged (these rows are locked during the first query).</li> <li>TRANSACTION_ISOLATION_SERIALIZABLE: this level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first ``SELECT`` or ``INSERT`` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li> </ul> 
settings.<br>lockTimeout | **integer** (int64)<br><p>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted.</p> <p>Default value: ``0`` (no control is enforced, a statement waiting time is unlimited).</p> 
settings.<br>logMinDurationStatement | **integer** (int64)<br><p>This setting controls logging of the duration of statements.</p> <p>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to ``500``, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged.</p> <p>Value of ``0`` forces PostgreSQL to log the duration of all statements.</p> <p>Value of ``-1`` (default) disables logging of the duration of statements.</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/runtime-config-logging.html">PostgreSQL documentation</a>.</p> 
settings.<br>synchronousCommit | **string**<br><p>This setting defines whether DBMS will commit transaction in a synchronous way.</p> <p>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting ``success`` to the client. These operations guarantee different levels of the data safety and visibility in the cluster.</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT">PostgreSQL documentation</a>.</p> <ul> <li>SYNCHRONOUS_COMMIT_ON: (default value) success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server.</li> <li>SYNCHRONOUS_COMMIT_OFF: success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li> <li>SYNCHRONOUS_COMMIT_LOCAL: success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li> <li>SYNCHRONOUS_COMMIT_REMOTE_WRITE: success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li> <li>SYNCHRONOUS_COMMIT_REMOTE_APPLY: success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li> </ul> 
settings.<br>tempFileLimit | **integer** (int64)<br><p>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted.</p> <p>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files.</p> 
settings.<br>logStatement | **string**<br><p>This setting specifies which SQL statements should be logged (on the user level).</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/runtime-config-logging.html">PostgreSQL documentation</a>.</p> <ul> <li>LOG_STATEMENT_NONE: (default) logs none of SQL statements.</li> <li>LOG_STATEMENT_DDL: logs all data definition statements (such as ``CREATE``, ``ALTER``, ``DROP`` and others).</li> <li>LOG_STATEMENT_MOD: logs all statements that fall in the ``LOG_STATEMENT_DDL`` category plus data-modifying statements (such as ``INSERT``, ``UPDATE`` and others).</li> <li>LOG_STATEMENT_ALL: logs all SQL statements.</li> </ul> 
login | **boolean** (boolean)<br><p>This flag defines whether the user can login to a PostgreSQL database.</p> <p>Default value: ``true`` (login is allowed).</p> 
grants[] | **string**<br><p>Roles and privileges that are granted to the user (``GRANT &lt;role&gt; TO &lt;user&gt;``).</p> <p>For more information, see <a href="/docs/managed-postgresql/operations/grant">the documentation</a>.</p> <p>The maximum string length in characters for each value is 63. Each value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
 
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
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 