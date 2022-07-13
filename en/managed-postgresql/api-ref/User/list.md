---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/api-ref/User/list.md
---

# Method list
Retrieves the list of PostgreSQL User resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-postgresql/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list PostgreSQL users in. To get the cluster ID, use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/managed-postgresql/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/managed-postgresql/api-ref/User/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
        "tempFileLimit": "integer",
        "logStatement": "string"
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
users[] | **object**<br><p>List of PostgreSQL User resources.</p> 
users[].<br>name | **string**<br><p>Name of the PostgreSQL user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the PostgreSQL cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user to access specific databases.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>connLimit | **string** (int64)<br><p>Maximum number of database connections available to the user.</p> <p>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the <a href="/docs/managed-postgresql/api-ref/Cluster#representation">Cluster.config.postgresqlConfig_12.effectiveConfig.maxConnections</a> setting.</p> <p>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only ``N`` concurrent connections will be opened, where ``N`` is the value of the setting.</p> <p>Minimum value: ``10`` (default: ``50``), when used in session pooling.</p> 
users[].<br>settings | **object**<br><p>PostgreSQL user settings.</p> 
users[].<br>settings.<br>defaultTransactionIsolation | **string**<br><p>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions.</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/transaction-iso.html">PostgreSQL documentation</a>.</p> <ul> <li>TRANSACTION_ISOLATION_READ_UNCOMMITTED: this level behaves like ``TRANSACTION_ISOLATION_READ_COMMITTED`` in PostgreSQL.</li> <li>TRANSACTION_ISOLATION_READ_COMMITTED: (default) on this level query sees only data committed before the query began.</li> <li>TRANSACTION_ISOLATION_REPEATABLE_READ: on this level all subsequent queries in a transaction will see the same rows, that were read by the first ``SELECT`` or ``INSERT`` query in this transaction, unchanged (these rows are locked during the first query).</li> <li>TRANSACTION_ISOLATION_SERIALIZABLE: this level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first ``SELECT`` or ``INSERT`` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li> </ul> 
users[].<br>settings.<br>lockTimeout | **integer** (int64)<br><p>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted.</p> <p>Default value: ``0`` (no control is enforced, a statement waiting time is unlimited).</p> 
users[].<br>settings.<br>logMinDurationStatement | **integer** (int64)<br><p>This setting controls logging of the duration of statements.</p> <p>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to ``500``, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged.</p> <p>Value of ``0`` forces PostgreSQL to log the duration of all statements.</p> <p>Value of ``-1`` (default) disables logging of the duration of statements.</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/runtime-config-logging.html">PostgreSQL documentation</a>.</p> 
users[].<br>settings.<br>synchronousCommit | **string**<br><p>This setting defines whether DBMS will commit transaction in a synchronous way.</p> <p>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting ``success`` to the client. These operations guarantee different levels of the data safety and visibility in the cluster.</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT">PostgreSQL documentation</a>.</p> <ul> <li>SYNCHRONOUS_COMMIT_ON: (default value) success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server.</li> <li>SYNCHRONOUS_COMMIT_OFF: success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li> <li>SYNCHRONOUS_COMMIT_LOCAL: success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li> <li>SYNCHRONOUS_COMMIT_REMOTE_WRITE: success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li> <li>SYNCHRONOUS_COMMIT_REMOTE_APPLY: success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li> </ul> 
users[].<br>settings.<br>tempFileLimit | **integer** (int64)<br><p>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted.</p> <p>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files.</p> 
users[].<br>settings.<br>logStatement | **string**<br><p>This setting specifies which SQL statements should be logged (on the user level).</p> <p>See in-depth description in <a href="https://www.postgresql.org/docs/current/runtime-config-logging.html">PostgreSQL documentation</a>.</p> <ul> <li>LOG_STATEMENT_NONE: (default) logs none of SQL statements.</li> <li>LOG_STATEMENT_DDL: logs all data definition statements (such as ``CREATE``, ``ALTER``, ``DROP`` and others).</li> <li>LOG_STATEMENT_MOD: logs all statements that fall in the ``LOG_STATEMENT_DDL`` category plus data-modifying statements (such as ``INSERT``, ``UPDATE`` and others).</li> <li>LOG_STATEMENT_ALL: logs all SQL statements.</li> </ul> 
users[].<br>login | **boolean** (boolean)<br><p>This flag defines whether the user can login to a PostgreSQL database.</p> <p>Default value: ``true`` (login is allowed).</p> 
users[].<br>grants[] | **string**<br><p>Roles and privileges that are granted to the user (``GRANT &lt;role&gt; TO &lt;user&gt;``).</p> <p>For more information, see <a href="/docs/managed-postgresql/operations/grant">the documentation</a>.</p> <p>The maximum string length in characters for each value is 63. Each value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/User/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-postgresql/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 