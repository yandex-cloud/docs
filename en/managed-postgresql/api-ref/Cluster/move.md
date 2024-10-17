---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Cluster/move.md
---

# Managed Service for PostgreSQL API, REST: Cluster.Move {#Move}

Moves the specified PostgreSQL cluster to the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}:move
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster to move. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.MoveClusterRequest}

```json
{
  "destinationFolderId": "string"
}
```

#|
||Field | Description ||
|| destinationFolderId | **string**

Required field. ID of the destination folder. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "sourceFolderId": "string",
    "destinationFolderId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
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
      // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`
      "postgresqlConfig_9_6": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "sqlInheritance": "boolean",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "sqlInheritance": "boolean",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "sqlInheritance": "boolean",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        }
      },
      "postgresqlConfig_10_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "onlineAnalyzeEnable": "boolean",
          "plantunerFixEmptyTable": "boolean",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "onlineAnalyzeEnable": "boolean",
          "plantunerFixEmptyTable": "boolean",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "onlineAnalyzeEnable": "boolean",
          "plantunerFixEmptyTable": "boolean",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_10": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "replacementSortTuples": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_11": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_11_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_12": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_12_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_13": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_13_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "vacuumCleanupIndexScaleFactor": "number",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_14": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_14_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_15": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_15_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_16": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      "postgresqlConfig_16_1c": {
        "effectiveConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "maxPreparedTransactions": "string",
          "workMem": "string",
          "maintenanceWorkMem": "string",
          "autovacuumWorkMem": "string",
          "tempFileLimit": "string",
          "vacuumCostDelay": "string",
          "vacuumCostPageHit": "string",
          "vacuumCostPageMiss": "string",
          "vacuumCostPageDirty": "string",
          "vacuumCostLimit": "string",
          "bgwriterDelay": "string",
          "bgwriterLruMaxpages": "string",
          "bgwriterLruMultiplier": "number",
          "bgwriterFlushAfter": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "walLevel": "string",
          "synchronousCommit": "string",
          "checkpointTimeout": "string",
          "checkpointCompletionTarget": "number",
          "checkpointFlushAfter": "string",
          "maxWalSize": "string",
          "minWalSize": "string",
          "maxStandbyStreamingDelay": "string",
          "defaultStatisticsTarget": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "autovacuumMaxWorkers": "string",
          "autovacuumVacuumCostDelay": "string",
          "autovacuumVacuumCostLimit": "string",
          "autovacuumNaptime": "string",
          "archiveTimeout": "string",
          "trackActivityQuerySize": "string",
          "onlineAnalyzeEnable": "boolean",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxWorkerProcesses": "string",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "autovacuumVacuumScaleFactor": "number",
          "autovacuumAnalyzeScaleFactor": "number",
          "defaultTransactionReadOnly": "boolean",
          "timezone": "string",
          "enableParallelAppend": "boolean",
          "enableParallelHash": "boolean",
          "enablePartitionPruning": "boolean",
          "enablePartitionwiseAggregate": "boolean",
          "enablePartitionwiseJoin": "boolean",
          "jit": "boolean",
          "maxParallelMaintenanceWorkers": "string",
          "parallelLeaderParticipation": "boolean",
          "logTransactionSampleRate": "number",
          "planCacheMode": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string",
          "sharedPreloadLibraries": [
            "string"
          ],
          "autoExplainLogMinDuration": "string",
          "autoExplainLogAnalyze": "boolean",
          "autoExplainLogBuffers": "boolean",
          "autoExplainLogTiming": "boolean",
          "autoExplainLogTriggers": "boolean",
          "autoExplainLogVerbose": "boolean",
          "autoExplainLogNestedStatements": "boolean",
          "autoExplainSampleRate": "number",
          "pgHintPlanEnableHint": "boolean",
          "pgHintPlanEnableHintTable": "boolean",
          "pgHintPlanDebugPrint": "string",
          "pgHintPlanMessageLevel": "string",
          "hashMemMultiplier": "number",
          "logicalDecodingWorkMem": "string",
          "maintenanceIoConcurrency": "string",
          "maxSlotWalKeepSize": "string",
          "walKeepSize": "string",
          "enableIncrementalSort": "boolean",
          "autovacuumVacuumInsertThreshold": "string",
          "autovacuumVacuumInsertScaleFactor": "number",
          "logMinDurationSample": "string",
          "logStatementSampleRate": "number",
          "logParameterMaxLength": "string",
          "logParameterMaxLengthOnError": "string",
          "clientConnectionCheckInterval": "string",
          "enableAsyncAppend": "boolean",
          "enableGathermerge": "boolean",
          "enableMemoize": "boolean",
          "logRecoveryConflictWaits": "boolean",
          "vacuumFailsafeAge": "string",
          "vacuumMultixactFailsafeAge": "string",
          "pgQualstatsEnabled": "boolean",
          "pgQualstatsTrackConstants": "boolean",
          "pgQualstatsMax": "string",
          "pgQualstatsResolveOids": "boolean",
          "pgQualstatsSampleRate": "number",
          "plantunerFixEmptyTable": "boolean",
          "maxStackDepth": "string",
          "enableGroupByReordering": "boolean",
          "geqo": "boolean",
          "geqoThreshold": "string",
          "geqoEffort": "string",
          "geqoPoolSize": "string",
          "geqoGenerations": "string",
          "geqoSelectionBias": "number",
          "geqoSeed": "number",
          "pgTrgmSimilarityThreshold": "number",
          "pgTrgmWordSimilarityThreshold": "number",
          "pgTrgmStrictWordSimilarityThreshold": "number",
          "maxStandbyArchiveDelay": "string",
          "sessionDurationTimeout": "string",
          "logReplicationCommands": "boolean",
          "logAutovacuumMinDuration": "string",
          "passwordEncryption": "string"
        }
      },
      // end of the list of possible fields
      "poolerConfig": {
        "poolingMode": "string",
        "poolDiscard": "boolean"
      },
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "autofailover": "boolean",
      "backupWindowStart": {
        "hours": "integer",
        "minutes": "integer",
        "seconds": "integer",
        "nanos": "integer"
      },
      "backupRetainPeriodDays": "string",
      "access": {
        "dataLens": "boolean",
        "webSql": "boolean",
        "serverless": "boolean",
        "dataTransfer": "boolean",
        "yandexQuery": "boolean"
      },
      "performanceDiagnostics": {
        "enabled": "boolean",
        "sessionsSamplingInterval": "string",
        "statementsSamplingInterval": "string"
      },
      "diskSizeAutoscaling": {
        "plannedUsageThreshold": "string",
        "emergencyUsageThreshold": "string",
        "diskSizeLimit": "string"
      }
    },
    "networkId": "string",
    "health": "string",
    "status": "string",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string"
    },
    "securityGroupIds": [
      "string"
    ],
    "deletionProtection": "boolean",
    "hostGroupIds": [
      "string"
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[MoveClusterMetadata](#yandex.cloud.mdb.postgresql.v1.MoveClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.postgresql.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## MoveClusterMetadata {#yandex.cloud.mdb.postgresql.v1.MoveClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the PostgreSQL cluster being moved. ||
|| sourceFolderId | **string**

ID of the source folder. ||
|| destinationFolderId | **string**

ID of the destnation folder. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.mdb.postgresql.v1.Cluster}

A PostgreSQL Cluster resource. For more information, see
the [Concepts](/docs/managed-postgresql/concepts) section of the documentation.

#|
||Field | Description ||
|| id | **string**

ID of the PostgreSQL cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the PostgreSQL cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the PostgreSQL cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the PostgreSQL cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the PostgreSQL cluster as `` key:value `` pairs.
Maximum 64 per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the PostgreSQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.postgresql.v1.Monitoring)**

Description of monitoring systems relevant to the PostgreSQL cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.postgresql.v1.ClusterConfig)**

Configuration of the PostgreSQL cluster. ||
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|#

## Monitoring {#yandex.cloud.mdb.postgresql.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the PostgreSQL cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.postgresql.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of PostgreSQL server software. ||
|| postgresqlConfig_9_6 | **[PostgresqlConfigSet9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet9_6)**

Configuration of a PostgreSQL 9.6 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_10_1c | **[PostgresqlConfigSet10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10_1C)**

Configuration of a PostgreSQL 10 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_10 | **[PostgresqlConfigSet10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10)**

Configuration of a PostgreSQL 10 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_11 | **[PostgresqlConfigSet11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11)**

Configuration of a PostgreSQL 11 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_11_1c | **[PostgresqlConfigSet11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11_1C)**

Configuration of a PostgreSQL 11 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_12 | **[PostgresqlConfigSet12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12)**

Configuration of a PostgreSQL 12 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_12_1c | **[PostgresqlConfigSet12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12_1C)**

Configuration of a PostgreSQL 12 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_13 | **[PostgresqlConfigSet13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13)**

Configuration of a PostgreSQL 13 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_13_1c | **[PostgresqlConfigSet13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C)**

Configuration of a PostgreSQL 13 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_14 | **[PostgresqlConfigSet14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14)**

Configuration of a PostgreSQL 14 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_14_1c | **[PostgresqlConfigSet14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C)**

Configuration of a PostgreSQL 14 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_15 | **[PostgresqlConfigSet15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15)**

Configuration of a PostgreSQL 15 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_15_1c | **[PostgresqlConfigSet15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C)**

Configuration of a PostgreSQL 15 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_16 | **[PostgresqlConfigSet16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16)**

Configuration of a PostgreSQL 16 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_16_1c | **[PostgresqlConfigSet16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C)**

Configuration of a PostgreSQL 16 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| poolerConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig)**

Configuration of the connection pooler. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)**

Resources allocated to PostgreSQL hosts. ||
|| autofailover | **boolean**

Configuration setting which enables/disables autofailover in cluster. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access)**

Access policy to DB ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling)**

Disk size autoscaling ||
|#

## PostgresqlConfigSet9_6 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet9_6}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6)**

Required field. Effective settings for a PostgreSQL 9.6 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6)**

User-defined settings for a PostgreSQL 9.6 cluster. ||
|| defaultConfig | **[PostgresqlConfig9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6)**

Default configuration for a PostgreSQL 9.6 cluster. ||
|#

## PostgresqlConfig9_6 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/9.6/static/runtime-config).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double)

Acceptable values are 0.0 to 1.0, inclusive. ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| sqlInheritance | **boolean**

This option has been removed in PostgreSQL 10. ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlConfigSet10_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C)**

Required field. Effective settings for a PostgreSQL 10 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C)**

User-defined settings for a PostgreSQL 10 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C)**

Default configuration for a PostgreSQL 10 1C cluster. ||
|#

## PostgresqlConfig10_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/10/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| onlineAnalyzeEnable | **boolean** ||
|| plantunerFixEmptyTable | **boolean** ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet10 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10)**

Required field. Effective settings for a PostgreSQL 10 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10)**

User-defined settings for a PostgreSQL 10 cluster. ||
|| defaultConfig | **[PostgresqlConfig10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10)**

Default configuration for a PostgreSQL 10 cluster. ||
|#

## PostgresqlConfig10 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/10/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11)**

Effective settings for a PostgreSQL 11 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11)**

User-defined settings for a PostgreSQL 11 cluster. ||
|| defaultConfig | **[PostgresqlConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11)**

Default configuration for a PostgreSQL 11 cluster. ||
|#

## PostgresqlConfig11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet11_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C)**

Effective settings for a PostgreSQL 11 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C)**

User-defined settings for a PostgreSQL 11 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C)**

Default configuration for a PostgreSQL 11 1C cluster. ||
|#

## PostgresqlConfig11_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| onlineAnalyzeEnable | **boolean** ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12)**

Effective settings for a PostgreSQL 12 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12)**

User-defined settings for a PostgreSQL 12 cluster. ||
|| defaultConfig | **[PostgresqlConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12)**

Default configuration for a PostgreSQL 12 cluster. ||
|#

## PostgresqlConfig12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet12_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C)**

Effective settings for a PostgreSQL 12 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C)**

User-defined settings for a PostgreSQL 12 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C)**

Default configuration for a PostgreSQL 12 1C cluster. ||
|#

## PostgresqlConfig12_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| onlineAnalyzeEnable | **boolean** ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13)**

Effective settings for a PostgreSQL 13 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13)**

User-defined settings for a PostgreSQL 13 cluster. ||
|| defaultConfig | **[PostgresqlConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13)**

Default configuration for a PostgreSQL 13 cluster. ||
|#

## PostgresqlConfig13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C)**

Effective settings for a PostgreSQL 13 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C)**

User-defined settings for a PostgreSQL 13 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C)**

Default configuration for a PostgreSQL 13 1C cluster. ||
|#

## PostgresqlConfig13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| onlineAnalyzeEnable | **boolean** ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14)**

Effective settings for a PostgreSQL 14 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14)**

User-defined settings for a PostgreSQL 14 cluster. ||
|| defaultConfig | **[PostgresqlConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14)**

Default configuration for a PostgreSQL 14 cluster. ||
|#

## PostgresqlConfig14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| clientConnectionCheckInterval | **string** (int64)

in milliseconds. ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean**

in milliseconds. ||
|| vacuumFailsafeAge | **string** (int64)

in milliseconds. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

in milliseconds. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C)**

Effective settings for a PostgreSQL 14 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C)**

User-defined settings for a PostgreSQL 14 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C)**

Default configuration for a PostgreSQL 14 1C cluster. ||
|#

## PostgresqlConfig14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| onlineAnalyzeEnable | **boolean** ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| clientConnectionCheckInterval | **string** (int64)

in milliseconds. ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean**

in milliseconds. ||
|| vacuumFailsafeAge | **string** (int64)

in milliseconds. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

in milliseconds. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15)**

Effective settings for a PostgreSQL 15 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15)**

User-defined settings for a PostgreSQL 15 cluster. ||
|| defaultConfig | **[PostgresqlConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15)**

Default configuration for a PostgreSQL 15 cluster. ||
|#

## PostgresqlConfig15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| clientConnectionCheckInterval | **string** (int64)

in milliseconds. ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean**

in milliseconds. ||
|| vacuumFailsafeAge | **string** (int64)

in milliseconds. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

in milliseconds. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C)**

Effective settings for a PostgreSQL 15 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C)**

User-defined settings for a PostgreSQL 15 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C)**

Default configuration for a PostgreSQL 15 1C cluster. ||
|#

## PostgresqlConfig15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| onlineAnalyzeEnable | **boolean** ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| clientConnectionCheckInterval | **string** (int64)

in milliseconds. ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean**

in milliseconds. ||
|| vacuumFailsafeAge | **string** (int64)

in milliseconds. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

in milliseconds. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16)**

Effective settings for a PostgreSQL 16 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16)**

User-defined settings for a PostgreSQL 16 cluster. ||
|| defaultConfig | **[PostgresqlConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16)**

Default configuration for a PostgreSQL 16 cluster. ||
|#

## PostgresqlConfig16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| clientConnectionCheckInterval | **string** (int64)

in milliseconds. ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean**

in milliseconds. ||
|| vacuumFailsafeAge | **string** (int64)

in milliseconds. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

in milliseconds. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C)**

Effective settings for a PostgreSQL 16 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C)**

User-defined settings for a PostgreSQL 16 1C cluster. ||
|| defaultConfig | **[PostgresqlConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C)**

Default configuration for a PostgreSQL 16 1C cluster. ||
|#

## PostgresqlConfig16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64) ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64)

in bytes. ||
|| maintenanceWorkMem | **string** (int64)

in bytes. ||
|| autovacuumWorkMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| vacuumCostDelay | **string** (int64)

in milliseconds. ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

in milliseconds. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

in bytes ||
|| backendFlushAfter | **string** (int64)

in bytes ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_UNSPECIFIED`
- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

in milliseconds. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

in bytes ||
|| maxWalSize | **string** (int64)

in bytes. ||
|| minWalSize | **string** (int64)

in bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| autovacuumMaxWorkers | **string** (int64) ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

in milliseconds. ||
|| archiveTimeout | **string** (int64)

in milliseconds. ||
|| trackActivityQuerySize | **string** (int64) ||
|| onlineAnalyzeEnable | **boolean** ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxWorkerProcesses | **string** (int64) ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| autovacuumVacuumScaleFactor | **number** (double) ||
|| autovacuumAnalyzeScaleFactor | **number** (double) ||
|| defaultTransactionReadOnly | **boolean** ||
|| timezone | **string** ||
|| enableParallelAppend | **boolean** ||
|| enableParallelHash | **boolean** ||
|| enablePartitionPruning | **boolean** ||
|| enablePartitionwiseAggregate | **boolean** ||
|| enablePartitionwiseJoin | **boolean** ||
|| jit | **boolean** ||
|| maxParallelMaintenanceWorkers | **string** (int64) ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_UNSPECIFIED`
- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_UNSPECIFIED`
- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON` ||
|| autoExplainLogMinDuration | **string** (int64)

in milliseconds. ||
|| autoExplainLogAnalyze | **boolean** ||
|| autoExplainLogBuffers | **boolean** ||
|| autoExplainLogTiming | **boolean** ||
|| autoExplainLogTriggers | **boolean** ||
|| autoExplainLogVerbose | **boolean** ||
|| autoExplainLogNestedStatements | **boolean** ||
|| autoExplainSampleRate | **number** (double) ||
|| pgHintPlanEnableHint | **boolean** ||
|| pgHintPlanEnableHintTable | **boolean** ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

- `PG_HINT_PLAN_DEBUG_PRINT_UNSPECIFIED`
- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| hashMemMultiplier | **number** (double) ||
|| logicalDecodingWorkMem | **string** (int64)

in bytes. ||
|| maintenanceIoConcurrency | **string** (int64) ||
|| maxSlotWalKeepSize | **string** (int64)

in bytes. ||
|| walKeepSize | **string** (int64)

in bytes. ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64)

in milliseconds. ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64)

in bytes. ||
|| logParameterMaxLengthOnError | **string** (int64)

in bytes. ||
|| clientConnectionCheckInterval | **string** (int64)

in milliseconds. ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean**

in milliseconds. ||
|| vacuumFailsafeAge | **string** (int64)

in milliseconds. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

in milliseconds. ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

in bytes. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean**

enable Genetic Query Optimizer, by default is on ||
|| geqoThreshold | **string** (int64)

The number of tables to use geqo, default is 12 ||
|| geqoEffort | **string** (int64)

tradeoff between planning time and query plan quality, default is 5 ||
|| geqoPoolSize | **string** (int64)

number of individuals in the genetic population, useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort ||
|| geqoGenerations | **string** (int64)

the number of generations used by GEQO, useful values are in the same range as the pool size ||
|| geqoSelectionBias | **number** (double)

selective pressure within the population ||
|| geqoSeed | **number** (double)

initial value of the random number generator used by GEQO ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64)

in milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64)

in milliseconds. The default is 1000 (1 sec). ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are `` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_UNSPECIFIED`
- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| poolingMode | **enum** (PoolingMode)

Mode that the connection pooler is working in.
See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Session pooling mode.
- `TRANSACTION`: Transaction pooling mode.
- `STATEMENT`: Statement pooling mode. ||
|| poolDiscard | **boolean**

Setting `server_reset_query_always` parameter in PgBouncer. ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.postgresql.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow access for DataLens ||
|| webSql | **boolean**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. ||
|| serverless | **boolean**

Allow access for Serverless ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **boolean**

Configuration setting which enables/disables performance diagnostics service in cluster. ||
|| sessionsSamplingInterval | **string** (int64)

Interval (in seconds) for pg_stat_activity sampling ||
|| statementsSamplingInterval | **string** (int64)

Interval (in seconds) for pg_stat_statements sampling ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergencyUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| diskSizeLimit | **string** (int64)

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#