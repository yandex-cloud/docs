---
editable: false
---

# Метод restore
Создает новый кластер PostgreSQL с использованием указанной резервной копии.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters:restore
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "backupId": "string",
  "time": "string",
  "timeInclusive": true,
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
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
      "serverless": true
    },

    // `configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`
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
      "trackActivityQuerySize": "integer"
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
      "maxParallelWorkersPerGather": "integer"
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
      "maxParallelWorkersPerGather": "integer"
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
      "maxParallelWorkersPerGather": "integer"
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
    // конец списка возможных полей`configSpec`

  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "replicationSource": "string",
      "priority": "integer",
      "configSpec": {

        // `hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`
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
          "maxParallelWorkersPerGather": "integer"
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
          "maxParallelWorkersPerGather": "integer"
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
          "maxParallelWorkersPerGather": "integer"
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
        // конец списка возможных полей`hostSpecs[].configSpec`

      }
    }
  ],
  "networkId": "string",
  "folderId": "string"
}
```

 
Поле | Описание
--- | ---
backupId | **string**<br><p>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups">listBackups</a>.</p> 
time | **string** (date-time)<br><p>Обязательное поле. Момент времени, на который должен быть восстановлен кластер PostgreSQL.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
timeInclusive | **boolean** (boolean)<br><p>Флаг, указывающий, должна ли база данных быть восстановлена до первой точки резервного копирования после момента <a href="/docs/managed-postgresql/api-ref/Cluster/restore#body_params">time</a>, или до последней точки перед ним.</p> <p>Возможные значения:</p> <ul> <li>false (по умолчанию) — точкой восстановления является первая точка резервного копирования перед <a href="/docs/managed-postgresql/api-ref/Cluster/restore#body_params">time</a>.</li> <li>true — точкой восстановления является первая точка резервного копирования после <a href="/docs/managed-postgresql/api-ref/Cluster/restore#body_params">time</a>.</li> </ul> 
name | **string**<br><p>Обязательное поле. Имя нового кластера PostgreSQL. Имя должно быть уникальным в каталоге.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Описание нового кластера PostgreSQL.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера PostgreSQL в виде пар ``key:value``. Не больше 64 меток на ресурс. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Среда развертывания для нового кластера PostgreSQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Конфигурация для создаваемого кластера PostgreSQL.</p> 
configSpec.<br>version | **string**<br><p>Версия PostgreSQL, используемая в кластере. Возможные значения ``9.6``, ``10``, ``10_1c``, ``11``, ``12``.</p> 
configSpec.<br>poolerConfig | **object**<br>Конфигурация менеджера соединений.<br>
configSpec.<br>poolerConfig.<br>poolingMode | **string**<br><p>Режим, в котором работает менеджер подключений. См. описание всех режимов в <a href="https://pgbouncer.github.io/usage">документации PgBouncer</a>.</p> <ul> <li>SESSION: Сессионный режим управления подключениями.</li> <li>TRANSACTION: Транзакционный режим управления подключениями.</li> <li>STATEMENT: Операторный режим управления подключениями.</li> </ul> 
configSpec.<br>poolerConfig.<br>poolDiscard | **boolean** (boolean)<br><p>Установка параметра ``server_reset_query_always`` в PgBouncer.</p> 
configSpec.<br>resources | **object**<br>Ресурсы, выделенные хостам PostgreSQL.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-postgresql/concepts/instance-types">документации</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>autofailover | **boolean** (boolean)<br><p>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере.</p> 
configSpec.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
configSpec.<br>access | **object**<br>Политика доступа к БД<br>
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
configSpec.<br>access.<br>serverless | **boolean** (boolean)<br><p>Разрешить доступ для Serverless</p> 
configSpec.<br>postgresqlConfig_9_6 | **object**<br>Конфигурация для кластера PostgreSQL 9.6. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена с выходом PostgreSQL 10.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C | **object**<br>Конфигурация для кластера PostgreSQL 10. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
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
configSpec.<br>postgresqlConfig_10_1C.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_10_1C.<br>onlineAnalyzeEnable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10_1C.<br>plantunerFixEmptyTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10 | **object**<br>Конфигурация для кластера PostgreSQL 10. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_10.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_10.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
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
configSpec.<br>postgresqlConfig_10.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_11 | **object**<br>Конфигурация для кластера PostgreSQL 11. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_11.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_11.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
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
configSpec.<br>postgresqlConfig_11.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C | **object**<br>Конфигурация для кластера PostgreSQL 11 1C. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_11_1C.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_11_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
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
configSpec.<br>postgresqlConfig_11_1C.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12 | **object**<br>Конфигурация для кластера PostgreSQL 12. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_12.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_12.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_12.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
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
configSpec.<br>postgresqlConfig_12.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
configSpec.<br>postgresqlConfig_12.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>planCacheMode | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_12.<br>pgHintPlanMessageLevel | **string**<br>
configSpec.<br>postgresqlConfig_12_1C | **object**<br>Конфигурация для кластера PostgreSQL 12 1C. <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
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
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
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
configSpec.<br>postgresqlConfig_12_1C.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>timezone | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableParallelAppend | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enableParallelHash | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enablePartitionPruning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>jit | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>planCacheMode | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>sharedPreloadLibraries[] | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogTiming | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanDebugPrint | **string**<br>
configSpec.<br>postgresqlConfig_12_1C.<br>pgHintPlanMessageLevel | **string**<br>
hostSpecs[] | **object**<br><p>Обязательное поле. Конфигурации для хостов PostgreSQL, которые должны быть созданы для кластера, создаваемого из резервной копии.</p> <p>Должен содержать хотя бы один элемент.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле <a href="/docs/managed-postgresql/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля ``assignPublicIp``.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
hostSpecs[].<br>replicationSource | **string**<br><p>``name`` of the host to be used as the replication source (for cascading replication).</p> 
hostSpecs[].<br>priority | **integer** (int64)<br><p>Приоритет хоста как реплики. Большее значение соответствует более высокому приоритету.</p> <p>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.</p> <p>Когда реплика становится мастером, ее приоритет игнорируется.</p> 
hostSpecs[].<br>configSpec | **object**<br><p>Конфигурация сервера PostgreSQL для хоста.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6 | **object**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlHostConfig`` отражает параметры конфигурационного файла PostgreSQL. Подробное описание доступно в <a href="https://www.postgresql.org/docs/9.6/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена с выходом PostgreSQL 10.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlHostConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableHashagg | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableHashjoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableIndexscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableMaterial | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableMergejoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableNestloop | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableSeqscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableSort | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>enableTidscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>timezone | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10 | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlHostConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableBitmapscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableHashagg | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableHashjoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableIndexscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableMaterial | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableMergejoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableNestloop | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableSeqscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableSort | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>enableTidscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11 | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableBitmapscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableHashagg | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableHashjoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableIndexscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableMaterial | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableMergejoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableNestloop | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableSeqscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableSort | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>enableTidscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableHashagg | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableHashjoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableIndexscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableMaterial | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableMergejoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableNestloop | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableSeqscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableSort | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>enableTidscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12 | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableBitmapscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableHashagg | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableHashjoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableIndexscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableMaterial | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableMergejoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableNestloop | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableSeqscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableSort | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>enableTidscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>timezone | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. <br>`hostSpecs[].configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>forceParallelMode | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>clientMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logMinMessages | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logMinErrorStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logConnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logDuration | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logErrorVerbosity | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logStatement | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>logTempFiles | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>searchPath | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>defaultTransactionIsolation | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>statementTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>lockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>byteaOutput | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>xmlbinary | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>xmloption | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>backslashQuote | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>seqPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>randomPageCost | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableHashagg | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableHashjoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableIndexscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableMaterial | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableMergejoin | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableNestloop | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableSeqscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableSort | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>enableTidscan | **boolean** (boolean)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>timezone | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_12_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
networkId | **string**<br><p>Обязательное поле. Идентификатор сети, в которой нужно создать PostgreSQL кластер.</p> <p>Максимальная длина строки в символах — 50.</p> 
folderId | **string**<br><p>Идентификатор каталога, в котором нужно создать кластер PostgreSQL.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
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

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 