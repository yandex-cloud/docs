---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for PostgreSQL API, REST: Cluster.listHosts
Retrieves a list of hosts for the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the PostgreSQL cluster. To get the PostgreSQL cluster ID use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.  To get the next page of results, set <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "role": "string",
      "health": "string",
      "services": [
        {
          "type": "string",
          "health": "string"
        }
      ],
      "subnetId": "string",
      "replicationSource": "string",
      "priority": "integer",
      "config": {

        // `hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`
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
        "postgresqlConfig_13_1C": {
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
        "postgresqlConfig_14": {
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
        "postgresqlConfig_14_1C": {
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
        "postgresqlConfig_15": {
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
        "postgresqlConfig_15_1C": {
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
        "postgresqlConfig_16": {
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
          "debugParallelQuery": "string",
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
        "postgresqlConfig_16_1C": {
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
          "debugParallelQuery": "string",
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
        // end of the list of possible fields`hosts[].config`

      },
      "assignPublicIp": true,
      "replicaType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>List of Host resources.</p> 
hosts[].<br>name | **string**<br><p>Name of the PostgreSQL host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the PostgreSQL host. The ID is assigned by MDB at creation time.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the PostgreSQL host resides.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the PostgreSQL host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-postgresql/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
hosts[].<br>role | **string**<br><p>Role of the host in the cluster.</p> <ul> <li>ROLE_UNKNOWN: Role of the host in the cluster is unknown.</li> <li>MASTER: Host is the master PostgreSQL server in the cluster.</li> <li>REPLICA: Host is a replica (standby) PostgreSQL server in the cluster.</li> </ul> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>HEALTH_UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable, and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is degraded, and can perform only some of its essential functions.</li> <li>READONLY: The host is alive, but in read-only mode.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Services provided by the host.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>POSTGRESQL: The host is a PostgreSQL server.</li> <li>POOLER: The host is a PgBouncer server.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Status code of server availability.</p> <ul> <li>HEALTH_UNKNOWN: Health of the server is unknown.</li> <li>ALIVE: The server is working normally.</li> <li>DEAD: The server is dead or unresponsive.</li> <li>READONLY: The server is in read-only mode.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>replicationSource | **string**<br><p>Name of the host to be used as the replication source for cascading replication.</p> 
hosts[].<br>priority | **integer** (int64)<br><p>Priority of the host as a replica. Higher value means higher priority.</p> <p>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed.</p> <p>When a replica becomes the master, its priority is ignored.</p> 
hosts[].<br>config | **object**<br><p>Configuration of a PostgreSQL server for the host.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6 | **object**<br>Configuration for a host with PostgreSQL 9.6 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C | **object**<br>Configuration for a host with PostgreSQL 10 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>replacementSortTuples | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10 | **object**<br>Configuration for a host with PostgreSQL 10 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_10.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11 | **object**<br>Configuration for a host with PostgreSQL 11 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_11.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_11.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C | **object**<br>Configuration for a host with PostgreSQL 11 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12 | **object**<br>Configuration for a host with PostgreSQL 12 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_12.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_12.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_12.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C | **object**<br>Configuration for a host with PostgreSQL 12 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13 | **object**<br>Configuration for a host with PostgreSQL 13 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_13.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_13.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_13.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_13.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C | **object**<br>Configuration for a host with PostgreSQL 13 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14 | **object**<br>Configuration for a host with PostgreSQL 14 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_14.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_14.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_14.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_14.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C | **object**<br>Configuration for a host with PostgreSQL 14 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15 | **object**<br>Configuration for a host with PostgreSQL 15 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_15.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_15.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_15.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_15.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C | **object**<br>Configuration for a host with PostgreSQL 15 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>forceParallelMode | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_15_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16 | **object**<br>Configuration for a host with PostgreSQL 16 server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_16.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_16.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>debugParallelQuery | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_16.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_16.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C | **object**<br>Configuration for a host with PostgreSQL 16 1C server deployed. <br>`hosts[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`, `postgresqlConfig_15_1C`, `postgresqlConfig_16`, `postgresqlConfig_16_1C`<br>
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>recoveryMinApplyDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>sharedBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>tempBuffers | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>workMem | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>tempFileLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>maxStandbyStreamingDelay | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>constraintExclusion | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>cursorTupleFraction | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>debugParallelQuery | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>clientMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logMinMessages | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logMinErrorStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logMinDurationStatement | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logCheckpoints | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logConnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logDisconnections | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logDuration | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logErrorVerbosity | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logLockWaits | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logStatement | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>logTempFiles | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>searchPath | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>rowSecurity | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>defaultTransactionIsolation | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>statementTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>lockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br><p>Acceptable values are 0 to 2147483647, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>byteaOutput | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>xmlbinary | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>xmloption | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>ginPendingListLimit | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>deadlockTimeout | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>maxLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>maxPredLocksPerTransaction | **integer** (int64)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>arrayNulls | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>backslashQuote | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>defaultWithOids | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>escapeStringWarning | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>loCompatPrivileges | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>quoteAllIdentifiers | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>standardConformingStrings | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>synchronizeSeqscans | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>transformNullEquals | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>exitOnError | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>seqPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>randomPageCost | **number** (double)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableBitmapscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableHashagg | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableHashjoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableIndexscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableIndexonlyscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableMaterial | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableMergejoin | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableNestloop | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableSeqscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableSort | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>enableTidscan | **boolean** (boolean)
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>timezone | **string**
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
hosts[].<br>config.<br>postgresqlConfig_16_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Flag showing public IP assignment status to this host.</p> 
hosts[].<br>replicaType | **string**
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 