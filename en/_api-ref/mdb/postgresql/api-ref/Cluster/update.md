---
editable: false
---

# Method update
Updates the specified PostgreSQL cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL Cluster resource to update. To get the PostgreSQL cluster ID, use a [list](/docs/managed-postgresql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "poolerConfig": {
      "poolingMode": "string",
      "poolDiscard": true
    },
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "autofailover": true,
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true,
      "webSql": true
    },
    "performanceDiagnostics": {
      "enabled": true,
      "sessionsSamplingInterval": "string",
      "statementsSamplingInterval": "string"
    },

    // `configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`
    "postgresqlConfig_9_6": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "replacementSortTuples": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer"
    },
    "postgresqlConfig_10_1C": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "replacementSortTuples": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string",
      "onlineAnalyzeEnable": true,
      "plantunerFixEmptyTable": true
    },
    "postgresqlConfig_10": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "replacementSortTuples": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string"
    },
    "postgresqlConfig_11": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "enableParallelAppend": true,
      "enableParallelHash": true,
      "enablePartitionPruning": true,
      "enablePartitionwiseAggregate": true,
      "enablePartitionwiseJoin": true,
      "jit": true,
      "maxParallelMaintenanceWorkers": "integer",
      "parallelLeaderParticipation": true,
      "vacuumCleanupIndexScaleFactor": "number",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string"
    },
    "postgresqlConfig_11_1C": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "enableParallelAppend": true,
      "enableParallelHash": true,
      "enablePartitionPruning": true,
      "enablePartitionwiseAggregate": true,
      "enablePartitionwiseJoin": true,
      "jit": true,
      "maxParallelMaintenanceWorkers": "integer",
      "parallelLeaderParticipation": true,
      "vacuumCleanupIndexScaleFactor": "number",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string"
    },
    "postgresqlConfig_12": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "enableParallelAppend": true,
      "enableParallelHash": true,
      "enablePartitionPruning": true,
      "enablePartitionwiseAggregate": true,
      "enablePartitionwiseJoin": true,
      "jit": true,
      "maxParallelMaintenanceWorkers": "integer",
      "parallelLeaderParticipation": true,
      "vacuumCleanupIndexScaleFactor": "number",
      "logTransactionSampleRate": "number",
      "planCacheMode": "string",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string"
    },
    "postgresqlConfig_12_1C": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "enableParallelAppend": true,
      "enableParallelHash": true,
      "enablePartitionPruning": true,
      "enablePartitionwiseAggregate": true,
      "enablePartitionwiseJoin": true,
      "jit": true,
      "maxParallelMaintenanceWorkers": "integer",
      "parallelLeaderParticipation": true,
      "vacuumCleanupIndexScaleFactor": "number",
      "logTransactionSampleRate": "number",
      "planCacheMode": "string",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string"
    },
    "postgresqlConfig_13": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
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
      "autovacuumMaxWorkers": "integer",
      "autovacuumVacuumCostDelay": "integer",
      "autovacuumVacuumCostLimit": "integer",
      "autovacuumNaptime": "integer",
      "archiveTimeout": "integer",
      "trackActivityQuerySize": "integer",
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
      "maxWorkerProcesses": "integer",
      "maxParallelWorkers": "integer",
      "maxParallelWorkersPerGather": "integer",
      "autovacuumVacuumScaleFactor": "number",
      "autovacuumAnalyzeScaleFactor": "number",
      "defaultTransactionReadOnly": true,
      "timezone": "string",
      "enableParallelAppend": true,
      "enableParallelHash": true,
      "enablePartitionPruning": true,
      "enablePartitionwiseAggregate": true,
      "enablePartitionwiseJoin": true,
      "jit": true,
      "maxParallelMaintenanceWorkers": "integer",
      "parallelLeaderParticipation": true,
      "vacuumCleanupIndexScaleFactor": "number",
      "logTransactionSampleRate": "number",
      "planCacheMode": "string",
      "effectiveIoConcurrency": "integer",
      "effectiveCacheSize": "integer",
      "sharedPreloadLibraries": [
        "string"
      ],
      "autoExplainLogMinDuration": "integer",
      "autoExplainLogAnalyze": true,
      "autoExplainLogBuffers": true,
      "autoExplainLogTiming": true,
      "autoExplainLogTriggers": true,
      "autoExplainLogVerbose": true,
      "autoExplainLogNestedStatements": true,
      "autoExplainSampleRate": "number",
      "pgHintPlanEnableHint": true,
      "pgHintPlanEnableHintTable": true,
      "pgHintPlanDebugPrint": "string",
      "pgHintPlanMessageLevel": "string",
      "hashMemMultiplier": "number",
      "logicalDecodingWorkMem": "integer",
      "maintenanceIoConcurrency": "integer",
      "maxSlotWalKeepSize": "integer",
      "walKeepSize": "integer",
      "enableIncrementalSort": true,
      "autovacuumVacuumInsertThreshold": "integer",
      "autovacuumVacuumInsertScaleFactor": "number",
      "logMinDurationSample": "integer",
      "logStatementSampleRate": "number",
      "logParameterMaxLength": "integer",
      "logParameterMaxLengthOnError": "integer"
    },
    // end of the list of possible fields`configSpec`

  },
  "name": "string",
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "securityGroupIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the PostgreSQL Cluster resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in `` updateMask `` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If `` updateMask `` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the PostgreSQL cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-postgresql/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-postgresql/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression `` [a-z][-_0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-_0-9a-z]* ``.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`, `13`.</p> 
configSpec.<br>poolerConfig | **object**<br>Configuration of the connection pooler.<br>
configSpec.<br>poolerConfig.<br>poolingMode | **string**<br><p>Mode that the connection pooler is working in. See descriptions of all modes in the <a href="https://pgbouncer.github.io/usage">documentation for PgBouncer</a>.</p> <ul> <li>SESSION: Session pooling mode.</li> <li>TRANSACTION: Transaction pooling mode.</li> <li>STATEMENT: Statement pooling mode.</li> </ul> 
configSpec.<br>poolerConfig.<br>poolDiscard | **boolean** (boolean)<br><p>Setting `server_reset_query_always` parameter in PgBouncer.</p> 
configSpec.<br>resources | **object**<br>Resources allocated to PostgreSQL hosts.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-postgresql/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
configSpec.<br>autofailover | **boolean** (boolean)<br><p>Configuration setting which enables/disables autofailover in cluster.</p> 
configSpec.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br>Access policy to DB<br>
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
configSpec.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the Yandex.Cloud management console.</p> <p>See <a href="/docs/managed-postgresql/operations/web-sql-query">SQL queries in the management console</a> for more details.</p> 
configSpec.<br>performanceDiagnostics | **object**<br>Configuration of the performance diagnostics service.<br>
configSpec.<br>performanceDiagnostics.<br>enabled | **boolean** (boolean)<br><p>Configuration setting which enables/disables performance diagnostics service in cluster.</p> 
configSpec.<br>performanceDiagnostics.<br>sessionsSamplingInterval | **string** (int64)<br><p>Interval (in seconds) for pg_stat_activity sampling</p> <p>Acceptable values are 1 to 86400, inclusive.</p> 
configSpec.<br>performanceDiagnostics.<br>statementsSamplingInterval | **string** (int64)<br><p>Interval (in seconds) for pg_stat_statements sampling</p> <p>Acceptable values are 1 to 86400, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6 | **object**<br>Configuration for a PostgreSQL 9.6 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C | **object**<br>Configuration for a PostgreSQL 10 1C cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>replacementSortTuples | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>onlineAnalyzeEnable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>plantunerFixEmptyTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10 | **object**<br>Configuration for a PostgreSQL 10 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_10.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_11 | **object**<br>Configuration for a PostgreSQL 11 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
configSpec.<br>postgresqlConfig_11.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_11.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_11_1C | **object**<br>Configuration for a PostgreSQL 11 1C cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_12 | **object**<br>Configuration for a PostgreSQL 12 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
configSpec.<br>postgresqlConfig_12.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>planCacheMode | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_12_1C | **object**<br>Configuration for a PostgreSQL 12 1C cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>planCacheMode | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_13 | **object**<br>Configuration for a PostgreSQL 13 1C cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`<br><br><p>Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
configSpec.<br>postgresqlConfig_13.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_13.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_13.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_13.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_13.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>backslashQuote | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_13.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_13.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>enableBitmapscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableHashagg | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableHashjoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableIndexscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableIndexonlyscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableMaterial | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableMergejoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableNestloop | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableSeqscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableTidscan | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
configSpec.<br>postgresqlConfig_13.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>planCacheMode | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_13.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>enableIncrementalSort | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_13.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
configSpec.<br>postgresqlConfig_13.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
name | **string**<br><p>New name for the cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
 
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