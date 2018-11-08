# Method updateHosts
Updates the specified hosts.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/hosts:batchUpdate
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL cluster to update hosts in. To get the PostgreSQL cluster ID, use a [list](/docs/mdb/api-ref/postgresql/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
 {
  "updateHostSpecs": [
    {
      "hostName": "string",
      "replicationSource": "string",
      "priority": "integer",
      "configSpec": {

        // `updateHostSpecs.configSpec`includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`
        "postgresqlConfig_9_6": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
          "replacementSortTuples": "integer",
          "tempFileLimit": "integer",
          "backendFlushAfter": "integer",
          "oldSnapshotThreshold": "integer",
          "maxStandbyStreamingDelay": "integer",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "integer",
          "joinCollapseLimit": "integer",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "integer",
          "logCheckpoints": true,
          "logConnections": true,
          "logDisconnections": true,
          "logDuration": true,
          "logErrorVerbosity": "string",
          "logLockWaits": true,
          "logStatement": "string",
          "logTempFiles": "integer",
          "searchPath": "string",
          "rowSecurity": true,
          "defaultTransactionIsolation": "string",
          "statementTimeout": "integer",
          "lockTimeout": "integer",
          "idleInTransactionSessionTimeout": "integer",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "integer",
          "deadlockTimeout": "integer",
          "maxLocksPerTransaction": "integer",
          "maxPredLocksPerTransaction": "integer",
          "arrayNulls": true,
          "backslashQuote": "string",
          "defaultWithOids": true,
          "escapeStringWarning": true,
          "loCompatPrivileges": true,
          "operatorPrecedenceWarning": true,
          "quoteAllIdentifiers": true,
          "standardConformingStrings": true,
          "synchronizeSeqscans": true,
          "transformNullEquals": true,
          "exitOnError": true,
          "seqPageCost": "number",
          "randomPageCost": "number",
          "sqlInheritance": true
        },
        "postgresqlConfig_10": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
          "replacementSortTuples": "integer",
          "tempFileLimit": "integer",
          "backendFlushAfter": "integer",
          "oldSnapshotThreshold": "integer",
          "maxStandbyStreamingDelay": "integer",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "integer",
          "joinCollapseLimit": "integer",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "integer",
          "logCheckpoints": true,
          "logConnections": true,
          "logDisconnections": true,
          "logDuration": true,
          "logErrorVerbosity": "string",
          "logLockWaits": true,
          "logStatement": "string",
          "logTempFiles": "integer",
          "searchPath": "string",
          "rowSecurity": true,
          "defaultTransactionIsolation": "string",
          "statementTimeout": "integer",
          "lockTimeout": "integer",
          "idleInTransactionSessionTimeout": "integer",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "integer",
          "deadlockTimeout": "integer",
          "maxLocksPerTransaction": "integer",
          "maxPredLocksPerTransaction": "integer",
          "arrayNulls": true,
          "backslashQuote": "string",
          "defaultWithOids": true,
          "escapeStringWarning": true,
          "loCompatPrivileges": true,
          "operatorPrecedenceWarning": true,
          "quoteAllIdentifiers": true,
          "standardConformingStrings": true,
          "synchronizeSeqscans": true,
          "transformNullEquals": true,
          "exitOnError": true,
          "seqPageCost": "number",
          "randomPageCost": "number"
        },
        // end of the list of possible fields`updateHostSpecs.configSpec`

      }
    }
  ]
}
```

 
Field | Description
--- | ---
updateHostSpecs | **object**<br><p>Required. New configurations to apply to hosts.</p> <p>Must contain at least one element.</p> 
updateHostSpecs.<br>hostName | **string**<br><p>Required. Name of the host to update. To get the PostgreSQL host name, use a <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts">listHosts</a> request.</p> 
updateHostSpecs.<br>replicationSource | **string**<br><p>name of the host to be used as the replication source (for cascading replication). To get the PostgreSQL host name, use a <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts">listHosts</a> request.</p> 
updateHostSpecs.<br>priority | **integer** (int64)<br><p>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed.</p> <p>When a replica becomes the master, its priority is ignored.</p> 
updateHostSpecs.<br>configSpec | **object**<br><p>Configuration of a PostgreSQL server for the host.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6 | **object** <br>`updateHostSpecs.configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Options and structure of <code>PostgresqlHostConfig</code> reflects parameters of a PostgreSQL configuration file. Detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10 | **object** <br>`updateHostSpecs.configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Options and structure of <code>PostgresqlHostConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified. This value is in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 