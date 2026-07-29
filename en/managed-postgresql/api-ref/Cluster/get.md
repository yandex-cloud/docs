---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL Cluster resource to return.
            To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for PostgreSQL API, REST: Cluster.Get

Returns the specified PostgreSQL Cluster resource.

To get the list of available PostgreSQL Cluster resources, make a [List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL Cluster resource to return.
To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.Cluster}

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
    // Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "pgHintPlanHintsAnywhere": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
      }
    },
    "postgresqlConfig_17": {
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
      }
    },
    "postgresqlConfig_17_1c": {
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string"
      }
    },
    "postgresqlConfig_18": {
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "vacuumTruncate": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string",
        "maxActiveReplicationOrigins": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "vacuumTruncate": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string",
        "maxActiveReplicationOrigins": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "vacuumTruncate": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string",
        "maxActiveReplicationOrigins": "string"
      }
    },
    "postgresqlConfig_18_1c": {
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "vacuumTruncate": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string",
        "maxActiveReplicationOrigins": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "vacuumTruncate": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string",
        "maxActiveReplicationOrigins": "string"
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
        "passwordEncryption": "string",
        "autoExplainLogFormat": "string",
        "trackCommitTimestamp": "boolean",
        "maxLogicalReplicationWorkers": "string",
        "maxWalSenders": "string",
        "maxReplicationSlots": "string",
        "idleSessionTimeout": "string",
        "checkpointWarning": "string",
        "vacuumTruncate": "boolean",
        "autovacuumVacuumThreshold": "string",
        "autovacuumAnalyzeThreshold": "string",
        "maxActiveReplicationOrigins": "string"
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
      "statementsSamplingInterval": "string",
      "advancedMode": "boolean"
    },
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "string",
      "emergencyUsageThreshold": "string",
      "diskSizeLimit": "string"
    },
    "fullVersion": "string",
    "connectionManager": {
      "enabled": "boolean",
      "connectionsFolderId": "string",
      "secretsFolderId": "string"
    },
    "managedRepack": {
      "enabled": "boolean"
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
  ],
  "diskEncryptionKeyId": "string"
}
```

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
|| labels | **object** (map<**string**, **string**>)

Custom labels for the PostgreSQL cluster as `` key:value `` pairs.
Maximum 64 per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the PostgreSQL cluster.

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
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
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
|| postgresqlConfig_11 | **[PostgresqlConfigSet11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11)**

Configuration of a PostgreSQL 11 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_12 | **[PostgresqlConfigSet12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12)**

Configuration of a PostgreSQL 12 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_13 | **[PostgresqlConfigSet13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13)**

Configuration of a PostgreSQL 13 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_13_1c | **[PostgresqlConfigSet13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C)**

Configuration of a PostgreSQL 13 1C server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_14 | **[PostgresqlConfigSet14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14)**

Configuration of a PostgreSQL 14 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_14_1c | **[PostgresqlConfigSet14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C)**

Configuration of a PostgreSQL 14 1C server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_15 | **[PostgresqlConfigSet15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15)**

Configuration of a PostgreSQL 15 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_15_1c | **[PostgresqlConfigSet15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C)**

Configuration of a PostgreSQL 15 1C server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_16 | **[PostgresqlConfigSet16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16)**

Configuration of a PostgreSQL 16 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_16_1c | **[PostgresqlConfigSet16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C)**

Configuration of a PostgreSQL 16 1C server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_17 | **[PostgresqlConfigSet17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17)**

Configuration of a PostgreSQL 17 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_17_1c | **[PostgresqlConfigSet17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C)**

Configuration of a PostgreSQL 17 1C server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_18 | **[PostgresqlConfigSet18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18)**

Configuration of a PostgreSQL 18 server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_18_1c | **[PostgresqlConfigSet18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18_1C)**

Configuration of a PostgreSQL 18 1C server.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

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

Retention policy of automated backups.

Acceptable values are 7 to 60, inclusive. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access)**

Access policy to DB ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling)**

Disk size autoscaling ||
|| fullVersion | **string**

Full version ||
|| connectionManager | **[ClusterConnectionManager](#yandex.cloud.mdb.v1.ClusterConnectionManager)**

Cluster-wide Connection Manager integration configuration ||
|| managedRepack | **[ManagedRepack](#yandex.cloud.mdb.postgresql.v1.ManagedRepack)**

Configuration of managed pg_repack. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| vacuumCleanupIndexScaleFactor | **number** (double)

Number of tuple inserts prior to index cleanup as a fraction of reltuples. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| vacuumCleanupIndexScaleFactor | **number** (double)

Number of tuple inserts prior to index cleanup as a fraction of reltuples. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| vacuumCleanupIndexScaleFactor | **number** (double)

Number of tuple inserts prior to index cleanup as a fraction of reltuples. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| onlineAnalyzeEnable | **boolean**

Enables automatic table-statistics updates by online_analyze after data-modifying operations. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| vacuumCleanupIndexScaleFactor | **number** (double)

Number of tuple inserts prior to index cleanup as a fraction of reltuples. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| plantunerFixEmptyTable | **boolean**

Controls whether plantuner sets estimated page and row counts to zero for tables that have no storage blocks. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| onlineAnalyzeEnable | **boolean**

Enables automatic table-statistics updates by online_analyze after data-modifying operations. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| plantunerFixEmptyTable | **boolean**

Controls whether plantuner sets estimated page and row counts to zero for tables that have no storage blocks. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Use constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Do not use constraints.
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Required for the [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM) extension.
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| pgHintPlanHintsAnywhere | **boolean**

Allows pg_hint_plan to read hint comments from any position in the query text,
without regard to SQL syntax. This may cause false hint matches. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| onlineAnalyzeEnable | **boolean**

Enables automatic table-statistics updates by online_analyze after data-modifying operations. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| plantunerFixEmptyTable | **boolean**

Controls whether plantuner sets estimated page and row counts to zero for tables that have no storage blocks. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| pgHintPlanHintsAnywhere | **boolean**

Allows pg_hint_plan to read hint comments from any position in the query text,
without regard to SQL syntax. This may cause false hint matches. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner to use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_AGE`: Required for the [age](https://age.apache.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| pgHintPlanHintsAnywhere | **boolean**

Allows pg_hint_plan to read hint comments from any position in the query text,
without regard to SQL syntax. This may cause false hint matches. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner to use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| onlineAnalyzeEnable | **boolean**

Enables automatic table-statistics updates by online_analyze after data-modifying operations. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_AGE`: Required for the [age](https://age.apache.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| plantunerFixEmptyTable | **boolean**

Controls whether plantuner sets estimated page and row counts to zero for tables that have no storage blocks. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12.

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_MD5 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| pgHintPlanHintsAnywhere | **boolean**

Allows pg_hint_plan to read hint comments from any position in the query text,
without regard to SQL syntax. This may cause false hint matches. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17)**

Effective settings for a PostgreSQL 17 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17)**

User-defined settings for a PostgreSQL 17 cluster. ||
|| defaultConfig | **[PostgresqlConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17)**

Default configuration for a PostgreSQL 17 cluster. ||
|#

## PostgresqlConfig17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_AGE`: Required for the [age](https://age.apache.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| trackCommitTimestamp | **boolean**

Collects transaction commit time. ||
|| maxLogicalReplicationWorkers | **string** (int64)

Maximum number of logical replication worker processes.

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Sets the maximum number of simultaneously running WAL sender processes.

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Sets the maximum number of simultaneously defined replication slots.

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C)**

Effective settings for a PostgreSQL 17 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C)**

User-defined settings for a PostgreSQL 17 cluster. ||
|| defaultConfig | **[PostgresqlConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C)**

Default configuration for a PostgreSQL 17 cluster. ||
|#

## PostgresqlConfig17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| onlineAnalyzeEnable | **boolean**

Enables automatic table-statistics updates by online_analyze after data-modifying operations. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_AGE`: Required for the [age](https://age.apache.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| plantunerFixEmptyTable | **boolean**

Controls whether plantuner sets estimated page and row counts to zero for tables that have no storage blocks. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| trackCommitTimestamp | **boolean**

Collects transaction commit time. ||
|| maxLogicalReplicationWorkers | **string** (int64)

Maximum number of logical replication worker processes.

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Sets the maximum number of simultaneously running WAL sender processes.

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Sets the maximum number of simultaneously defined replication slots.

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18)**

Effective settings for a PostgreSQL 18 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18)**

User-defined settings for a PostgreSQL 18 cluster. ||
|| defaultConfig | **[PostgresqlConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18)**

Default configuration for a PostgreSQL 18 cluster. ||
|#

## PostgresqlConfig18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_AGE`: Required for the [age](https://age.apache.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| trackCommitTimestamp | **boolean**

Collects transaction commit time. ||
|| maxLogicalReplicationWorkers | **string** (int64)

Maximum number of logical replication worker processes.

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Sets the maximum number of simultaneously running WAL sender processes.

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Sets the maximum number of simultaneously defined replication slots.

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| vacuumTruncate | **boolean**

Enables vacuum to truncate empty pages at the end of the table. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
|| maxActiveReplicationOrigins | **string** (int64)

Sets the maximum number of active replication origins.

Acceptable values are 20 to 100, inclusive. ||
|#

## PostgresqlConfigSet18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C)**

Effective settings for a PostgreSQL 18 1C cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[PostgresqlConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C)**

User-defined settings for a PostgreSQL 18 cluster. ||
|| defaultConfig | **[PostgresqlConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C)**

Default configuration for a PostgreSQL 18 cluster. ||
|#

## PostgresqlConfig18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Sets the maximum number of concurrent connections.

The minimum value is 16. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of simultaneously prepared transactions. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| maintenanceWorkMem | **string** (int64)

Sets the maximum memory to be used for maintenance operations.
This includes operations such as VACUUM and CREATE INDEX. In bytes. ||
|| autovacuumWorkMem | **string** (int64)

Sets the maximum memory to be used by each autovacuum worker process. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| vacuumCostDelay | **string** (int64)

Vacuum cost delay. In milliseconds. ||
|| vacuumCostPageHit | **string** (int64)

Vacuum cost for a page found in the buffer cache. ||
|| vacuumCostPageMiss | **string** (int64)

Vacuum cost for a page not found in the buffer cache. ||
|| vacuumCostPageDirty | **string** (int64)

Vacuum cost for a page dirtied by vacuum. ||
|| vacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping. ||
|| bgwriterDelay | **string** (int64)

Background writer sleep time between rounds. In milliseconds.

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64)

Background writer maximum number of LRU pages to flush per round. ||
|| bgwriterLruMultiplier | **number** (double)

Multiple of the average buffer usage to free per round. ||
|| bgwriterFlushAfter | **string** (int64)

Specifies how much data the background writer can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

Sets the level of information written to the WAL.

- `WAL_LEVEL_REPLICA`: Supports WAL archiving and physical replication.
- `WAL_LEVEL_LOGICAL`: Supports WAL archiving, physical replication, and logical decoding. ||
|| synchronousCommit | **enum** (SynchronousCommit)

Sets the current transaction's synchronization level.

- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| checkpointTimeout | **string** (int64)

Sets the maximum time between automatic WAL checkpoints. In milliseconds.

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double)

Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval. ||
|| checkpointFlushAfter | **string** (int64)

Specifies how much data can be written during a checkpoint before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64)

Sets the WAL size that triggers a checkpoint. In bytes. ||
|| minWalSize | **string** (int64)

Sets the minimum size to shrink the WAL to. In bytes. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| defaultStatisticsTarget | **string** (int64)

Sets the default statistics target. This applies to table columns that have not had a
column-specific target set via ALTER TABLE SET STATISTICS. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| autovacuumMaxWorkers | **string** (int64)

Sets the maximum number of simultaneously running autovacuum worker processes.

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64)

Vacuum cost delay in milliseconds, for autovacuum. ||
|| autovacuumVacuumCostLimit | **string** (int64)

Vacuum cost amount available before napping, for autovacuum. ||
|| autovacuumNaptime | **string** (int64)

Time to sleep between autovacuum runs. In milliseconds.

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Forces a switch to the next WAL file if no new file has been started within the specified interval. In milliseconds.

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Sets the size reserved for pg_stat_activity.query, in bytes.

Acceptable values are 100 to 102400, inclusive. ||
|| onlineAnalyzeEnable | **boolean**

Enables automatic table-statistics updates by online_analyze after data-modifying operations. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxWorkerProcesses | **string** (int64)

Maximum number of concurrent worker processes.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| autovacuumVacuumScaleFactor | **number** (double)

Number of tuple updates or deletes prior to vacuum as a fraction of reltuples. ||
|| autovacuumAnalyzeScaleFactor | **number** (double)

Number of tuple inserts, updates, or deletes prior to analyze as a fraction of reltuples. ||
|| defaultTransactionReadOnly | **boolean**

Sets the default read-only status of new transactions. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| enableParallelAppend | **boolean**

Enables the planner's use of parallel append plans. ||
|| enableParallelHash | **boolean**

Enables the planner's use of parallel hash plans. ||
|| enablePartitionPruning | **boolean**

Enables plan-time and execution-time partition pruning. Allows the query planner and executor to
compare partition bounds to conditions in the query to determine which partitions must be scanned. ||
|| enablePartitionwiseAggregate | **boolean**

Enables partitionwise aggregation and grouping. ||
|| enablePartitionwiseJoin | **boolean**

Enables partitionwise join. ||
|| jit | **boolean**

Allow JIT compilation. ||
|| maxParallelMaintenanceWorkers | **string** (int64)

Sets the maximum number of parallel processes per maintenance operation.

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean**

Controls whether Gather and Gather Merge also run subplans. ||
|| logTransactionSampleRate | **number** (double)

Sets the fraction of transactions from which to log all statements. Use a
value between 0.0 (never log) and 1.0 (log all statements for all transactions). ||
|| planCacheMode | **enum** (PlanCacheMode)

Controls the planner's selection of custom or generic plan. Prepared statements can have custom and generic plans,
and the planner will attempt to choose which is better. This can be set to override the default behavior.

- `PLAN_CACHE_MODE_AUTO`: Automatic selection.
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`: Forces the use of custom plans.
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN`: Forces the use of generic plans. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

Lists shared libraries to preload into server.

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`: Required for the [auto_explain](https://www.postgresql.org/docs/current/auto-explain.html) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`: Shared library of extension [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html#PGPREWARM), which ensures loading of extension on server start
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_ANON`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
- `SHARED_PRELOAD_LIBRARIES_AGE`: Required for the [age](https://age.apache.org/) extension.
- `SHARED_PRELOAD_LIBRARIES_SPQRGUARD`: Required for the [spqrguard](https://github.com/pg-sharding/spqrguard) extension. ||
|| autoExplainLogMinDuration | **string** (int64)

Sets the minimum statement execution time, that will cause the statement's plan to be logged.
Setting this to 0 logs all plans. -1 (the default) disables logging of plans. For example, if
you set it to 250ms then all statements that run 250ms or longer will be logged. In milliseconds.
 ||
|| autoExplainLogAnalyze | **boolean**

Causes EXPLAIN ANALYZE output, rather than just EXPLAIN output,to be printed
when an executionplan is logged. This parameter is off by default. ||
|| autoExplainLogBuffers | **boolean**

Controls whether buffer usage statistics are printed when an execution plan is logged;
it's equivalent to the BUFFERS option of EXPLAIN. This parameter has no effect unless
auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogTiming | **boolean**

Controls whether per-node timing information is printed when an execution plan is logged;
it's equivalent to the TIMING option of EXPLAIN. The overhead of repeatedly reading the system
clock can slow down queries significantly on some systems, so it may be useful to set this
parameter to off when only actual row counts, and not exact times, are needed. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is on by default. ||
|| autoExplainLogTriggers | **boolean**

Causes trigger execution statistics to be included when an execution plan is logged. This parameter
has no effect unless auto_explain.log_analyze is enabled. This parameter is off by default. ||
|| autoExplainLogVerbose | **boolean**

Controls whether verbose details are printed when an execution plan is logged; it's
equivalent to the VERBOSE option of EXPLAIN. This parameter is off by default. ||
|| autoExplainLogNestedStatements | **boolean**

Causes nested statements (statements executed inside a function) to be considered for logging.
When it is off, only top-level query plans are logged. This parameter is off by default. ||
|| autoExplainSampleRate | **number** (double)

Causes auto_explain to only explain a fraction of the statements in each session. The default is 1,
meaning explain all the queries. In case of nested statements, either all will be explained or none. ||
|| pgHintPlanEnableHint | **boolean**

Enables processing of query hints by pg_hint_plan. ||
|| pgHintPlanEnableHintTable | **boolean**

Enables lookup of hints in the hint table. ||
|| pgHintPlanDebugPrint | **enum** (PgHintPlanDebugPrint)

Controls whether and how verbosely hint parsing results are logged.

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`: Disables diagnostic logging.
- `PG_HINT_PLAN_DEBUG_PRINT_ON`: Logs hint-processing results grouped by used, unused, duplicate, and erroneous hints.
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`: Logs hint-processing results together with detailed planner diagnostics.
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE`: Logs the most detailed diagnostics, including query strings used to extract hints. ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

Sets the log level for pg_hint_plan debug messages.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| hashMemMultiplier | **number** (double)

Multiple of work_mem to use for hash tables. ||
|| logicalDecodingWorkMem | **string** (int64)

Sets the maximum memory to be used for logical decoding. This much memory can be
used by each internal reorder buffer before spilling to disk. In bytes.

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

A variant of effective_io_concurrency that is used for maintenance work.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Sets the maximum WAL size that can be reserved by replication slots. Replication slots will be marked as failed,
and segments released for deletion or recycling, if this much space is occupied by WAL on disk. In bytes. ||
|| walKeepSize | **string** (int64)

Sets the size of WAL files held for standby servers. In bytes. ||
|| enableIncrementalSort | **boolean**

Enables the planner's use of incremental sort steps. ||
|| autovacuumVacuumInsertThreshold | **string** (int64)

Minimum number of tuple inserts prior to vacuum, or -1 to disable insert vacuums. ||
|| autovacuumVacuumInsertScaleFactor | **number** (double)

Number of tuple inserts prior to vacuum as a fraction of reltuples. ||
|| logMinDurationSample | **string** (int64)

Sets the minimum execution time above which a sample of statements will be logged. Sampling is determined
by log_statement_sample_rate. Zero logs a sample of all queries. -1 turns this feature off. In milliseconds. ||
|| logStatementSampleRate | **number** (double)

Fraction of statements exceeding log_min_duration_sample to be logged. Use a value between 0.0 (never log) and 1.0 (always log). ||
|| logParameterMaxLength | **string** (int64)

When logging statements, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| logParameterMaxLengthOnError | **string** (int64)

When reporting an error, limit logged parameter values to first N bytes. -1 to print values in full. ||
|| clientConnectionCheckInterval | **string** (int64)

Sets the time interval between checks for disconnection while running queries. In milliseconds. ||
|| enableAsyncAppend | **boolean**

Enables the planner's use of async append plans. ||
|| enableGathermerge | **boolean**

Enables the planner's use of gather merge plans. ||
|| enableMemoize | **boolean**

Enables the planner's use of memoization. ||
|| logRecoveryConflictWaits | **boolean**

Logs standby recovery conflict waits. ||
|| vacuumFailsafeAge | **string** (int64)

Age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| vacuumMultixactFailsafeAge | **string** (int64)

Multixact age at which VACUUM should trigger failsafe to avoid a wraparound outage. ||
|| pgQualstatsEnabled | **boolean**

Controls whether pg_qualstats collects execution statistics for query predicates,
including filters and join conditions. ||
|| pgQualstatsTrackConstants | **boolean**

Controls whether pg_qualstats keeps separate statistics for predicates containing different constant values ||
|| pgQualstatsMax | **string** (int64)

Limits the number of predicate-statistics and query-text entries retained by pg_qualstats. ||
|| pgQualstatsResolveOids | **boolean**

Controls whether pg_qualstats resolves object OIDs and stores their names  when collecting statistics.
Enabling this increases memory usage and requires additional system-catalog lookups. ||
|| pgQualstatsSampleRate | **number** (double)

Sets the fraction of queries sampled by pg_qualstats. A value of -1 selects an automatic rate
of 1 / max_connections; 0 samples no queries, and 1 samples every query. ||
|| plantunerFixEmptyTable | **boolean**

Controls whether plantuner sets estimated page and row counts to zero for tables that have no storage blocks. ||
|| maxStackDepth | **string** (int64)

Sets the maximum stack depth, in bytes.

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean**

Controls if the query planner will produce a plan which will provide GROUP BY keys sorted in the order of keys of a
child node of the plan, such as an index scan. When disabled, the query planner will produce a plan with GROUP BY keys
only sorted to match the ORDER BY clause, if any. When enabled, the planner will try to produce a more efficient plan.
The default value is on. ||
|| geqo | **boolean**

Enables genetic query optimization. This algorithm attempts to do planning
without exhaustive searching, by default is on. ||
|| geqoThreshold | **string** (int64)

Sets the threshold of FROM items beyond which GEQO is used, default is 12. ||
|| geqoEffort | **string** (int64)

GEQO: effort is used to set the default for other GEQO parameters.
Tradeoff between planning time and query plan quality, default is 5.

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64)

GEQO: number of individuals in the population.
Useful values are typically 100 to 1000; default - 0 - choose based on based on geqo_effort. ||
|| geqoGenerations | **string** (int64)

GEQO: number of iterations of the algorithm. Zero selects a suitable default value.
Useful values are in the same range as the pool size. ||
|| geqoSelectionBias | **number** (double)

GEQO: selective pressure within the population. ||
|| geqoSeed | **number** (double)

GEQO: seed for random path selection. ||
|| pgTrgmSimilarityThreshold | **number** (double)

Sets the trigram similarity threshold used by the `%` operator
to determine whether two strings are similar. ||
|| pgTrgmWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<%` and `%>` operators when comparing
a string with the most similar continuous part of another string. ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double)

Sets the threshold used by the `<<%` and `%>>` operators when comparing
a string with parts of another string aligned to word boundaries. ||
|| maxStandbyArchiveDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing archived WAL data. In milliseconds. ||
|| sessionDurationTimeout | **string** (int64)

Terminate any session that exceeds the designated timeout, specified in milliseconds. If a timeout is
not specified, the default session timeout is set to 12 hours. To disable it, specify a value of 0.

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean**

Logs each replication command. ||
|| logAutovacuumMinDuration | **string** (int64)

Sets the minimum execution time above which autovacuum actions will be logged.
Zero prints all actions. -1 turns autovacuum logging off. In milliseconds. The default is 1000 (1 sec).
 ||
|| passwordEncryption | **enum** (PasswordEncryption)

A default value for `` user_password_encryption `` user-level setting, if it not specified for new users. Possible values are
`` PASSWORD_ENCRYPTION_MD5 `` or `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``. The default is `` PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.

- `PASSWORD_ENCRYPTION_MD5`: The method md5 uses a custom less secure challenge-response mechanism. It prevents password sniffing and avoids storing passwords on the server in plain text but provides no protection if an attacker manages to steal the password hash from the server. Also, the MD5 hash algorithm is nowadays no longer considered secure against determined attacks.
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256`: The method scram-sha-256 performs SCRAM-SHA-256 authentication, as described in RFC 7677. It is a challenge-response scheme that prevents password sniffing on untrusted connections and supports storing passwords on the server in a cryptographically hashed form that is thought to be secure.
This is the most secure of the currently provided methods, but it is not supported by older client libraries. ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

Selects the `` EXPLAIN `` output format to be used. The allowed values are `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``,
`` AUTO_EXPLAIN_LOG_FORMAT_XML ``, `` AUTO_EXPLAIN_LOG_FORMAT_JSON ``, and `` AUTO_EXPLAIN_LOG_FORMAT_YAML ``.
The default is `` AUTO_EXPLAIN_LOG_FORMAT_TEXT ``.

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`: Formats logged execution plans as plain text.
- `AUTO_EXPLAIN_LOG_FORMAT_XML`: Formats logged execution plans as XML.
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`: Formats logged execution plans as JSON.
- `AUTO_EXPLAIN_LOG_FORMAT_YAML`: Formats logged execution plans as YAML. ||
|| trackCommitTimestamp | **boolean**

Collects transaction commit time. ||
|| maxLogicalReplicationWorkers | **string** (int64)

Maximum number of logical replication worker processes.

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Sets the maximum number of simultaneously running WAL sender processes.

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Sets the maximum number of simultaneously defined replication slots.

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| checkpointWarning | **string** (int64)

Sets the interval below which checkpoints triggered by filling WAL segment files cause a warning to be written to the server log.
A value of 0 disables the warning. In milliseconds.

Acceptable values are 0 to 2147483647000, inclusive. ||
|| vacuumTruncate | **boolean**

Enables vacuum to truncate empty pages at the end of the table. ||
|| autovacuumVacuumThreshold | **string** (int64)

Minimum number of tuple updates or deletes prior to vacuum.

Acceptable values are 0 to 2147483647, inclusive. ||
|| autovacuumAnalyzeThreshold | **string** (int64)

Minimum number of tuple inserts, updates, or deletes prior to analyze.

Acceptable values are 0 to 2147483647, inclusive. ||
|| maxActiveReplicationOrigins | **string** (int64)

Sets the maximum number of active replication origins.

Acceptable values are 20 to 100, inclusive. ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| poolingMode | **enum** (PoolingMode)

Mode that the connection pooler is working in.
See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage).

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

Interval (in seconds) for pg_stat_activity sampling

Acceptable values are 1 to 86400, inclusive. ||
|| statementsSamplingInterval | **string** (int64)

Interval (in seconds) for pg_stat_statements sampling

Acceptable values are 1 to 86400, inclusive. ||
|| advancedMode | **boolean**

Switches performance diagnostics from standard to advanced mode. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64)

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## ClusterConnectionManager {#yandex.cloud.mdb.v1.ClusterConnectionManager}

A message representing the Connection Manager integration status and settings for a cluster.

#|
||Field | Description ||
|| enabled | **boolean**

True if the integration for the cluster is enabled.
Set to true to enable the integration.
Disabling the integration is not supported. ||
|| connectionsFolderId | **string**

ID of the folder where connections for the cluster are created.
Optional. Defaults to the cluster's folder if not specified. ||
|| secretsFolderId | **string**

A Connection Manager setting for connections created by MDB integration.
ID of the folder where connection secrets are created.
Optional. Defaults to the cluster's folder if not specified. ||
|#

## ManagedRepack {#yandex.cloud.mdb.postgresql.v1.ManagedRepack}

Cluster-wide configuration of managed pg_repack.

#|
||Field | Description ||
|| enabled | **boolean**

Enables/disables managed pg_repack for the cluster. ||
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

Weekly maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `MON`: Monday.
- `TUE`: Tuesday.
- `WED`: Wednesday.
- `THU`: Thursday.
- `FRI`: Friday.
- `SAT`: Saturday.
- `SUN`: Sunday. ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format).

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation.

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#