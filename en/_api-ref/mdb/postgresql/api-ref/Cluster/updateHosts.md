---
editable: false
---

# Method updateHosts
Updates the specified hosts.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/hosts:batchUpdate
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL cluster to update hosts in. To get the PostgreSQL cluster ID, use a [list](/docs/managed-postgresql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateHostSpecs": [
    {
      "hostName": "string",
      "replicationSource": "string",
      "priority": "integer",
      "configSpec": {

        // `updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`
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
          "sqlInheritance": true,
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_10_1C": {
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
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
          "randomPageCost": "number",
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_11": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_11_1C": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_12": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_12_1C": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_13": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        // end of the list of possible fields`updateHostSpecs[].configSpec`

      }
    }
  ]
}
```

 
Field | Description
--- | ---
updateHostSpecs[] | **object**<br><p>Required. New configurations to apply to hosts.</p> <p>Must contain at least one element.</p> 
updateHostSpecs[].<br>hostName | **string**<br><p>Required. Name of the host to update. To get the PostgreSQL host name, use a <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts">listHosts</a> request.</p> 
updateHostSpecs[].<br>replicationSource | **string**<br><p>`name` of the host to be used as the replication source (for cascading replication). To get the PostgreSQL host name, use a <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts">listHosts</a> request.</p> 
updateHostSpecs[].<br>priority | **integer** (int64)<br><p>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed.</p> <p>When a replica becomes the master, its priority is ignored.</p> 
updateHostSpecs[].<br>configSpec | **object**<br><p>Configuration of a PostgreSQL server for the host.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6 | **object**<br>Configuration for a host with PostgreSQL 9.6 server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlHostConfig` reflects parameters of a PostgreSQL configuration file. Detailed description is available in <a href="https://www.postgresql.org/docs/9.6/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C | **object**<br>Configuration for a host with PostgreSQL 10 1C server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlHostConfig` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10 | **object**<br>Configuration for a host with PostgreSQL 10 server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlHostConfig` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11 | **object**<br>Configuration for a host with PostgreSQL 11 server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C | **object**<br>Configuration for a host with PostgreSQL 11 1C server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12 | **object**<br>Configuration for a host with PostgreSQL 12 server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C | **object**<br>Configuration for a host with PostgreSQL 12 1C server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13 | **object**<br>Configuration for a host with PostgreSQL 13 server deployed. <br>`updateHostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>workMem | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>constraintExclusion | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>forceParallelMode | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>clientMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logMinMessages | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logMinErrorStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logErrorVerbosity | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logStatement | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>searchPath | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>byteaOutput | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>xmlbinary | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>xmloption | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>backslashQuote | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>seqPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>randomPageCost | **number** (double)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableBitmapscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableHashagg | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableHashjoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableIndexscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableIndexonlyscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableMaterial | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableMergejoin | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableNestloop | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableSeqscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableSort | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>enableTidscan | **boolean** (boolean)<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>timezone | **string**<br>
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
updateHostSpecs[].<br>configSpec.<br>postgresqlConfig_13.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 