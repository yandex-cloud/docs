---
editable: false
---

# Managed Service for PostgreSQL Audit Trails Events: RestoreCluster

## Event JSON schema {#yandex.cloud.audit.mdb.postgresql.RestoreCluster2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "clusterName": "string",
    "cluster": {
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
            "idleSessionTimeout": "string"
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
        },
        "fullVersion": "string"
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
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.postgresql.RestoreCluster2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.postgresql.ClusterEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.postgresql.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.postgresql.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.postgresql.v1.Cluster}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| environment | **enum** (Environment)

- `PRODUCTION`
- `PRESTABLE` ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.postgresql.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.postgresql.v1.ClusterConfig)** ||
|| networkId | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `UPDATING`
- `STOPPING`
- `STOPPED`
- `STARTING` ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| deletionProtection | **boolean** ||
|| hostGroupIds[] | **string** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.postgresql.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.postgresql.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string** ||
|| postgresqlConfig_11 | **[PostgresqlConfigSet11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_12 | **[PostgresqlConfigSet12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13 | **[PostgresqlConfigSet13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13_1c | **[PostgresqlConfigSet13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14 | **[PostgresqlConfigSet14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14_1c | **[PostgresqlConfigSet14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15 | **[PostgresqlConfigSet15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15_1c | **[PostgresqlConfigSet15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16 | **[PostgresqlConfigSet16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16_1c | **[PostgresqlConfigSet16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17 | **[PostgresqlConfigSet17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17_1c | **[PostgresqlConfigSet17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18 | **[PostgresqlConfigSet18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18_1c | **[PostgresqlConfigSet18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| poolerConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig)** ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)** ||
|| autofailover | **boolean** ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| backupRetainPeriodDays | **string** (int64)

Acceptable values are 7 to 60, inclusive. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access)** ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling)** ||
|| fullVersion | **string** ||
|#

## PostgresqlConfigSet11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11)** ||
|| userConfig | **[PostgresqlConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11)** ||
|| defaultConfig | **[PostgresqlConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11)** ||
|#

## PostgresqlConfig11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12)** ||
|| userConfig | **[PostgresqlConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12)** ||
|| defaultConfig | **[PostgresqlConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12)** ||
|#

## PostgresqlConfig12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13)** ||
|| userConfig | **[PostgresqlConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13)** ||
|| defaultConfig | **[PostgresqlConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13)** ||
|#

## PostgresqlConfig13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C)** ||
|| userConfig | **[PostgresqlConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C)** ||
|| defaultConfig | **[PostgresqlConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C)** ||
|#

## PostgresqlConfig13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| vacuumCleanupIndexScaleFactor | **number** (double) ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|#

## PostgresqlConfigSet14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14)** ||
|| userConfig | **[PostgresqlConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14)** ||
|| defaultConfig | **[PostgresqlConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14)** ||
|#

## PostgresqlConfig14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C)** ||
|| userConfig | **[PostgresqlConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C)** ||
|| defaultConfig | **[PostgresqlConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C)** ||
|#

## PostgresqlConfig14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15)** ||
|| userConfig | **[PostgresqlConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15)** ||
|| defaultConfig | **[PostgresqlConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15)** ||
|#

## PostgresqlConfig15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C)** ||
|| userConfig | **[PostgresqlConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C)** ||
|| defaultConfig | **[PostgresqlConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C)** ||
|#

## PostgresqlConfig15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16)** ||
|| userConfig | **[PostgresqlConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16)** ||
|| defaultConfig | **[PostgresqlConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16)** ||
|#

## PostgresqlConfig16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON`
- `SHARED_PRELOAD_LIBRARIES_AGE` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C)** ||
|| userConfig | **[PostgresqlConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C)** ||
|| defaultConfig | **[PostgresqlConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C)** ||
|#

## PostgresqlConfig16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64) ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON`
- `SHARED_PRELOAD_LIBRARIES_AGE` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64)

Acceptable values are 2 to 2147483647, inclusive. ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17)** ||
|| userConfig | **[PostgresqlConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17)** ||
|| defaultConfig | **[PostgresqlConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17)** ||
|#

## PostgresqlConfig17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON`
- `SHARED_PRELOAD_LIBRARIES_AGE` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64) ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| trackCommitTimestamp | **boolean** ||
|| maxLogicalReplicationWorkers | **string** (int64)

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C)** ||
|| userConfig | **[PostgresqlConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C)** ||
|| defaultConfig | **[PostgresqlConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C)** ||
|#

## PostgresqlConfig17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON`
- `SHARED_PRELOAD_LIBRARIES_AGE` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64) ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| trackCommitTimestamp | **boolean** ||
|| maxLogicalReplicationWorkers | **string** (int64)

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18)** ||
|| userConfig | **[PostgresqlConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18)** ||
|| defaultConfig | **[PostgresqlConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18)** ||
|#

## PostgresqlConfig18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON`
- `SHARED_PRELOAD_LIBRARIES_AGE` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64) ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| trackCommitTimestamp | **boolean** ||
|| maxLogicalReplicationWorkers | **string** (int64)

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlConfigSet18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet18_1C}

#|
||Field | Description ||
|| effectiveConfig | **[PostgresqlConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C)** ||
|| userConfig | **[PostgresqlConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C)** ||
|| defaultConfig | **[PostgresqlConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C)** ||
|#

## PostgresqlConfig18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig18_1C}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

The minimum value is 16. ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| maxPreparedTransactions | **string** (int64) ||
|| workMem | **string** (int64) ||
|| maintenanceWorkMem | **string** (int64) ||
|| autovacuumWorkMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| vacuumCostDelay | **string** (int64) ||
|| vacuumCostPageHit | **string** (int64) ||
|| vacuumCostPageMiss | **string** (int64) ||
|| vacuumCostPageDirty | **string** (int64) ||
|| vacuumCostLimit | **string** (int64) ||
|| bgwriterDelay | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| bgwriterLruMaxpages | **string** (int64) ||
|| bgwriterLruMultiplier | **number** (double) ||
|| bgwriterFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| walLevel | **enum** (WalLevel)

- `WAL_LEVEL_REPLICA`
- `WAL_LEVEL_LOGICAL` ||
|| synchronousCommit | **enum** (SynchronousCommit)

- `SYNCHRONOUS_COMMIT_ON`
- `SYNCHRONOUS_COMMIT_OFF`
- `SYNCHRONOUS_COMMIT_LOCAL`
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY` ||
|| checkpointTimeout | **string** (int64)

Acceptable values are 30000 to 86400000, inclusive. ||
|| checkpointCompletionTarget | **number** (double) ||
|| checkpointFlushAfter | **string** (int64)

Acceptable values are 0 to 2097152, inclusive. ||
|| maxWalSize | **string** (int64) ||
|| minWalSize | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
|| defaultStatisticsTarget | **string** (int64) ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

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
|| logMinDurationStatement | **string** (int64) ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64) ||
|| lockTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64) ||
|| deadlockTimeout | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

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
|| autovacuumMaxWorkers | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| autovacuumVacuumCostDelay | **string** (int64) ||
|| autovacuumVacuumCostLimit | **string** (int64) ||
|| autovacuumNaptime | **string** (int64)

Acceptable values are 1000 to 86400000, inclusive. ||
|| archiveTimeout | **string** (int64)

Acceptable values are 10000 to 86400000, inclusive. ||
|| trackActivityQuerySize | **string** (int64)

Acceptable values are 100 to 102400, inclusive. ||
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
|| maxWorkerProcesses | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
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
|| maxParallelMaintenanceWorkers | **string** (int64)

The minimum value is 0. ||
|| parallelLeaderParticipation | **boolean** ||
|| logTransactionSampleRate | **number** (double) ||
|| planCacheMode | **enum** (PlanCacheMode)

- `PLAN_CACHE_MODE_AUTO`
- `PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN`
- `PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| sharedPreloadLibraries[] | **enum** (SharedPreloadLibraries)

- `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN`
- `SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN`
- `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`
- `SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS`
- `SHARED_PRELOAD_LIBRARIES_PG_CRON`
- `SHARED_PRELOAD_LIBRARIES_PGLOGICAL`
- `SHARED_PRELOAD_LIBRARIES_PG_PREWARM`
- `SHARED_PRELOAD_LIBRARIES_PGAUDIT`
- `SHARED_PRELOAD_LIBRARIES_ANON`
- `SHARED_PRELOAD_LIBRARIES_AGE` ||
|| autoExplainLogMinDuration | **string** (int64) ||
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

- `PG_HINT_PLAN_DEBUG_PRINT_OFF`
- `PG_HINT_PLAN_DEBUG_PRINT_ON`
- `PG_HINT_PLAN_DEBUG_PRINT_DETAILED`
- `PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` ||
|| pgHintPlanMessageLevel | **enum** (LogLevel)

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

Acceptable values are 65536 to 1099511627776, inclusive. ||
|| maintenanceIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64) ||
|| walKeepSize | **string** (int64) ||
|| enableIncrementalSort | **boolean** ||
|| autovacuumVacuumInsertThreshold | **string** (int64) ||
|| autovacuumVacuumInsertScaleFactor | **number** (double) ||
|| logMinDurationSample | **string** (int64) ||
|| logStatementSampleRate | **number** (double) ||
|| logParameterMaxLength | **string** (int64) ||
|| logParameterMaxLengthOnError | **string** (int64) ||
|| clientConnectionCheckInterval | **string** (int64) ||
|| enableAsyncAppend | **boolean** ||
|| enableGathermerge | **boolean** ||
|| enableMemoize | **boolean** ||
|| logRecoveryConflictWaits | **boolean** ||
|| vacuumFailsafeAge | **string** (int64) ||
|| vacuumMultixactFailsafeAge | **string** (int64) ||
|| pgQualstatsEnabled | **boolean** ||
|| pgQualstatsTrackConstants | **boolean** ||
|| pgQualstatsMax | **string** (int64) ||
|| pgQualstatsResolveOids | **boolean** ||
|| pgQualstatsSampleRate | **number** (double) ||
|| plantunerFixEmptyTable | **boolean** ||
|| maxStackDepth | **string** (int64)

Acceptable values are 65536 to 134217728, inclusive. ||
|| enableGroupByReordering | **boolean** ||
|| geqo | **boolean** ||
|| geqoThreshold | **string** (int64) ||
|| geqoEffort | **string** (int64)

Acceptable values are 1 to 10, inclusive. ||
|| geqoPoolSize | **string** (int64) ||
|| geqoGenerations | **string** (int64) ||
|| geqoSelectionBias | **number** (double) ||
|| geqoSeed | **number** (double) ||
|| pgTrgmSimilarityThreshold | **number** (double) ||
|| pgTrgmWordSimilarityThreshold | **number** (double) ||
|| pgTrgmStrictWordSimilarityThreshold | **number** (double) ||
|| maxStandbyArchiveDelay | **string** (int64) ||
|| sessionDurationTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| logReplicationCommands | **boolean** ||
|| logAutovacuumMinDuration | **string** (int64) ||
|| passwordEncryption | **enum** (PasswordEncryption)

- `PASSWORD_ENCRYPTION_MD5`
- `PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| autoExplainLogFormat | **enum** (AutoExplainLogFormat)

- `AUTO_EXPLAIN_LOG_FORMAT_TEXT`
- `AUTO_EXPLAIN_LOG_FORMAT_XML`
- `AUTO_EXPLAIN_LOG_FORMAT_JSON`
- `AUTO_EXPLAIN_LOG_FORMAT_YAML` ||
|| trackCommitTimestamp | **boolean** ||
|| maxLogicalReplicationWorkers | **string** (int64)

Acceptable values are 4 to 100, inclusive. ||
|| maxWalSenders | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| maxReplicationSlots | **string** (int64)

Acceptable values are 20 to 100, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| poolingMode | **enum** (PoolingMode)

- `SESSION`
- `TRANSACTION`
- `STATEMENT` ||
|| poolDiscard | **boolean** ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## Access {#yandex.cloud.mdb.postgresql.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|| serverless | **boolean** ||
|| dataTransfer | **boolean** ||
|| yandexQuery | **boolean** ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| sessionsSamplingInterval | **string** (int64)

Acceptable values are 1 to 86400, inclusive. ||
|| statementsSamplingInterval | **string** (int64)

Acceptable values are 1 to 86400, inclusive. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#