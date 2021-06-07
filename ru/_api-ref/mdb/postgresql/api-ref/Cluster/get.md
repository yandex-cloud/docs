---
editable: false
---

# Метод get
Возвращает указанный ресурс Cluster для PostgreSQL.
 
Чтобы получить список доступных ресурсов Cluster для PostgreSQL, отправьте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор возвращаемого ресурса Cluster для PostgreSQL. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
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

    // `config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`
    "postgresqlConfig_9_6": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "postgresqlConfig_10_1C": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "postgresqlConfig_10": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "postgresqlConfig_11": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "postgresqlConfig_11_1C": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "postgresqlConfig_12": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "postgresqlConfig_12_1C": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    // конец списка возможных полей`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
Ресурс Cluster для PostgreSQL. Подробнее читайте в разделе [Concepts](/docs/managed-postgresql/concepts)
документации.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер PostgreSQL.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов.</p> 
description | **string**<br><p>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера PostgreSQL в виде пар ``key:value``. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания для кластера PostgreSQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Система мониторинга.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для данного кластера PostgreSQL.</p> 
config | **object**<br><p>Конфигурация кластера PostgreSQL.</p> 
config.<br>version | **string**<br><p>Версия серверного программного обеспечения PostgreSQL.</p> 
config.<br>poolerConfig | **object**<br>Конфигурация менеджера соединений.<br>
config.<br>poolerConfig.<br>poolingMode | **string**<br><p>Режим, в котором работает менеджер подключений. См. описание всех режимов в <a href="https://pgbouncer.github.io/usage">документации PgBouncer</a>.</p> <ul> <li>SESSION: Сессионный режим управления подключениями.</li> <li>TRANSACTION: Транзакционный режим управления подключениями.</li> <li>STATEMENT: Операторный режим управления подключениями.</li> </ul> 
config.<br>poolerConfig.<br>poolDiscard | **boolean** (boolean)<br><p>Установка параметра ``server_reset_query_always`` в PgBouncer.</p> 
config.<br>resources | **object**<br>Ресурсы, выделенные хостам PostgreSQL.<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-postgresql/concepts/instance-types">документации</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>autofailover | **boolean** (boolean)<br><p>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере.</p> 
config.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
config.<br>access | **object**<br>Политика доступа к БД<br>
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
config.<br>access.<br>serverless | **boolean** (boolean)<br><p>Разрешить доступ для Serverless</p> 
config.<br>postgresqlConfig_9_6 | **object**<br>Конфигурация сервера PostgreSQL 9.6. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера PostgreSQL 9.6 (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена с выходом PostgreSQL 10.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 9.6.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена с выходом PostgreSQL 10.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 9.6.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена с выходом PostgreSQL 10.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10_1C | **object**<br>Конфигурация сервера PostgreSQL 10 1С. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера PostgreSQL 10 1С (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 10 1С.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 10 1С.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10 | **object**<br>Конфигурация сервера PostgreSQL 10. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_10.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера PostgreSQL 10 (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 10.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 10.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11 | **object**<br>Конфигурация сервера PostgreSQL 11. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_11.<br>effectiveConfig | **object**<br><p>Действующие настройки для кластера PostgreSQL 11 (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 11.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 11.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C | **object**<br>Конфигурация сервера PostgreSQL 11 1C. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig | **object**<br><p>Действующие настройки для кластера PostgreSQL 11 1C (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 11 1C.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 11 1C.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12 | **object**<br>Конфигурация сервера PostgreSQL 12. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_12.<br>effectiveConfig | **object**<br><p>Действующие настройки для кластера PostgreSQL 12 (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>jit | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>planCacheMode | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 12.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>jit | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>planCacheMode | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 12.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>jit | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>planCacheMode | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_12_1C | **object**<br>Конфигурация сервера PostgreSQL 12 1C. <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig | **object**<br><p>Действующие настройки для кластера PostgreSQL 12 1C (сочетание настроек, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>jit | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>planCacheMode | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 12 1C</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>jit | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>planCacheMode | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 12 1C.</p> <p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>backslashQuote | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Допустимые значения — от 1 до 32 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Допустимые значения — от -1 до 100 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Допустимые значения — от -1 до 10000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Допустимые значения — от 1000 до 86400000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Допустимые значения — от 10000 до 600000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Допустимые значения — от 100 до 102400 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>timezone | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>jit | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>Минимальное значение — 0.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Допустимые значения — от 0 до 10000000000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>planCacheMode | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Допустимые значения — от -1 до 2147483647 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Допустимые значения — от 0 до 1 включительно.</p> 
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**<br>
config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**<br>
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (``health`` для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (``health`` для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (``health`` по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 