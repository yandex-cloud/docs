---
editable: false
---

# Managed Service for MySQL Audit Trails Events: UpdateCluster

## Event JSON schema {#yandex.cloud.audit.mdb.mysql.UpdateCluster2-schema}

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
        // Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`
        "mysqlConfig_5_7": {
          "effectiveConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "generalLog": "boolean",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "defaultAuthenticationPlugin": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "showCompatibility_56": "boolean",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "binlogTransactionDependencyTracking": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "queryCacheLimit": "string",
            "queryCacheSize": "string",
            "queryCacheType": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "queryResponseTimeStats": "boolean",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "innodbLruScanDepth": "string",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          },
          "userConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "generalLog": "boolean",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "defaultAuthenticationPlugin": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "showCompatibility_56": "boolean",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "binlogTransactionDependencyTracking": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "queryCacheLimit": "string",
            "queryCacheSize": "string",
            "queryCacheType": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "queryResponseTimeStats": "boolean",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "innodbLruScanDepth": "string",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "generalLog": "boolean",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "defaultAuthenticationPlugin": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "showCompatibility_56": "boolean",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "binlogTransactionDependencyTracking": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "queryCacheLimit": "string",
            "queryCacheSize": "string",
            "queryCacheType": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "queryResponseTimeStats": "boolean",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "innodbLruScanDepth": "string",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          }
        },
        "mysqlConfig_8_0": {
          "effectiveConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "generalLog": "boolean",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "defaultAuthenticationPlugin": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "regexpTimeLimit": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "binlogTransactionDependencyTracking": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "replicationSenderObserveCommitOnly": "boolean",
            "replicationOptimizeForStaticPluginConfig": "boolean",
            "innodbLruScanDepth": "string",
            "sqlRequirePrimaryKey": "boolean",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          },
          "userConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "generalLog": "boolean",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "defaultAuthenticationPlugin": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "regexpTimeLimit": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "binlogTransactionDependencyTracking": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "replicationSenderObserveCommitOnly": "boolean",
            "replicationOptimizeForStaticPluginConfig": "boolean",
            "innodbLruScanDepth": "string",
            "sqlRequirePrimaryKey": "boolean",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "generalLog": "boolean",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "defaultAuthenticationPlugin": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "regexpTimeLimit": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "binlogTransactionDependencyTracking": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "replicationSenderObserveCommitOnly": "boolean",
            "replicationOptimizeForStaticPluginConfig": "boolean",
            "innodbLruScanDepth": "string",
            "sqlRequirePrimaryKey": "boolean",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          }
        },
        "mysqlConfig_8_4": {
          "effectiveConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "regexpTimeLimit": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "replicationSenderObserveCommitOnly": "boolean",
            "replicationOptimizeForStaticPluginConfig": "boolean",
            "innodbLruScanDepth": "string",
            "sqlRequirePrimaryKey": "boolean",
            "mdbUseAsyncReplication": "boolean",
            "mdbAsyncAllowedLag": "string",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          },
          "userConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "regexpTimeLimit": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "replicationSenderObserveCommitOnly": "boolean",
            "replicationOptimizeForStaticPluginConfig": "boolean",
            "innodbLruScanDepth": "string",
            "sqlRequirePrimaryKey": "boolean",
            "mdbUseAsyncReplication": "boolean",
            "mdbAsyncAllowedLag": "string",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "string",
            "maxConnections": "string",
            "longQueryTime": "number",
            "auditLog": "boolean",
            "sqlMode": [
              "string"
            ],
            "maxAllowedPacket": "string",
            "innodbFlushLogAtTrxCommit": "string",
            "innodbLockWaitTimeout": "string",
            "transactionIsolation": "string",
            "innodbPrintAllDeadlocks": "boolean",
            "netReadTimeout": "string",
            "netWriteTimeout": "string",
            "groupConcatMaxLen": "string",
            "tmpTableSize": "string",
            "maxHeapTableSize": "string",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "boolean",
            "innodbNumaInterleave": "boolean",
            "innodbLogBufferSize": "string",
            "innodbLogFileSize": "string",
            "innodbIoCapacity": "string",
            "innodbIoCapacityMax": "string",
            "innodbReadIoThreads": "string",
            "innodbWriteIoThreads": "string",
            "innodbPurgeThreads": "string",
            "innodbThreadConcurrency": "string",
            "innodbTempDataFileMaxSize": "string",
            "threadCacheSize": "string",
            "threadStack": "string",
            "joinBufferSize": "string",
            "sortBufferSize": "string",
            "tableDefinitionCache": "string",
            "tableOpenCache": "string",
            "tableOpenCacheInstances": "string",
            "explicitDefaultsForTimestamp": "boolean",
            "autoIncrementIncrement": "string",
            "autoIncrementOffset": "string",
            "syncBinlog": "string",
            "binlogCacheSize": "string",
            "binlogGroupCommitSyncDelay": "string",
            "binlogRowImage": "string",
            "binlogRowsQueryLogEvents": "boolean",
            "rplSemiSyncMasterWaitForSlaveCount": "string",
            "slaveParallelType": "string",
            "slaveParallelWorkers": "string",
            "regexpTimeLimit": "string",
            "mdbPreserveBinlogBytes": "string",
            "interactiveTimeout": "string",
            "waitTimeout": "string",
            "mdbOfflineModeEnableLag": "string",
            "mdbOfflineModeDisableLag": "string",
            "rangeOptimizerMaxMemSize": "string",
            "innodbOnlineAlterLogMaxSize": "string",
            "innodbFtMinTokenSize": "string",
            "innodbFtMaxTokenSize": "string",
            "lowerCaseTableNames": "string",
            "slowQueryLog": "boolean",
            "slowQueryLogAlwaysWriteTime": "number",
            "logSlowRateType": "string",
            "logSlowRateLimit": "string",
            "logSlowSpStatements": "boolean",
            "logSlowFilter": [
              "string"
            ],
            "mdbPriorityChoiceMaxLag": "string",
            "innodbPageSize": "string",
            "maxSpRecursionDepth": "string",
            "innodbCompressionLevel": "string",
            "autocommit": "boolean",
            "innodbStatusOutput": "boolean",
            "innodbStrictMode": "boolean",
            "innodbPrintLockWaitTimeoutInfo": "boolean",
            "logErrorVerbosity": "string",
            "maxDigestLength": "string",
            "lockWaitTimeout": "string",
            "maxPreparedStmtCount": "string",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "string",
            "userstat": "boolean",
            "maxExecutionTime": "string",
            "auditLogPolicy": "string",
            "replicationSenderObserveCommitOnly": "boolean",
            "replicationOptimizeForStaticPluginConfig": "boolean",
            "innodbLruScanDepth": "string",
            "sqlRequirePrimaryKey": "boolean",
            "mdbUseAsyncReplication": "boolean",
            "mdbAsyncAllowedLag": "string",
            "mdbForceSsl": "boolean",
            "innodbChangeBuffering": "string",
            "maxWriteLockCount": "string"
          }
        },
        // end of the list of possible fields
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "backupWindowStart": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        },
        "access": {
          "dataLens": "boolean",
          "webSql": "boolean",
          "dataTransfer": "boolean",
          "yandexQuery": "boolean"
        },
        "performanceDiagnostics": {
          "enabled": "boolean",
          "sessionsSamplingInterval": "string",
          "statementsSamplingInterval": "string"
        },
        "backupRetainPeriodDays": "string",
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

## Field description {#yandex.cloud.audit.mdb.mysql.UpdateCluster2}

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
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.mysql.ClusterEventDetails)** ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.mysql.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string**

The maximum string length in characters is 50. ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.mysql.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.mysql.v1.Cluster}

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
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.mysql.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.mysql.v1.ClusterConfig)** ||
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
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.mysql.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.mysql.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| deletionProtection | **boolean** ||
|| hostGroupIds[] | **string** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.mysql.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.mysql.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string** ||
|| mysqlConfig_5_7 | **[MysqlConfigSet5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet5_7)**

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`. ||
|| mysqlConfig_8_0 | **[MysqlConfigSet8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_0)**

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`. ||
|| mysqlConfig_8_4 | **[MysqlConfigSet8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_4)**

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`. ||
|| resources | **[Resources](#yandex.cloud.mdb.mysql.v1.Resources)** ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| access | **[Access](#yandex.cloud.mdb.mysql.v1.Access)** ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics)** ||
|| backupRetainPeriodDays | **string** (int64)

Acceptable values are 7 to 60, inclusive. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling)** ||
|| fullVersion | **string** ||
|#

## MysqlConfigSet5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet5_7}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)** ||
|| userConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)** ||
|| defaultConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)** ||
|#

## MysqlConfig5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7}

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

The minimum value is 5242880. ||
|| maxConnections | **string** (int64)

Acceptable values are 10 to 16384, inclusive. ||
|| longQueryTime | **number** (double)

Acceptable values are 0 to 3600, inclusive. ||
|| generalLog | **boolean** ||
|| auditLog | **boolean** ||
|| sqlMode[] | **enum** (SQLMode)

- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `NO_FIELD_OPTIONS`
- `NO_KEY_OPTIONS`
- `NO_TABLE_OPTIONS`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `ANSI`
- `TRADITIONAL`
- `DB2`
- `MAXDB`
- `MSSQL`
- `MYSQL323`
- `MYSQL40`
- `ORACLE`
- `POSTGRESQL`
- `NO_AUTO_CREATE_USER`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

Acceptable values are 1024 to 1073741824, inclusive. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

- `MYSQL_NATIVE_PASSWORD`
- `CACHING_SHA2_PASSWORD`
- `SHA256_PASSWORD`
- `MYSQL_NO_LOGIN`
- `MDB_IAMPROXY_AUTH` ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Acceptable values are 1 to 2, inclusive. ||
|| innodbLockWaitTimeout | **string** (int64)

Acceptable values are 1 to 28800, inclusive. ||
|| transactionIsolation | **enum** (TransactionIsolation)

- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean** ||
|| netReadTimeout | **string** (int64)

Acceptable values are 1 to 1200, inclusive. ||
|| netWriteTimeout | **string** (int64)

Acceptable values are 1 to 1200, inclusive. ||
|| groupConcatMaxLen | **string** (int64)

Acceptable values are 4 to 33554432, inclusive. ||
|| tmpTableSize | **string** (int64)

Acceptable values are 1024 to 536870912, inclusive. ||
|| maxHeapTableSize | **string** (int64)

Acceptable values are 16384 to 536870912, inclusive. ||
|| defaultTimeZone | **string** ||
|| characterSetServer | **string** ||
|| collationServer | **string** ||
|| innodbAdaptiveHashIndex | **boolean** ||
|| innodbNumaInterleave | **boolean** ||
|| innodbLogBufferSize | **string** (int64)

Acceptable values are 1048576 to 268435456, inclusive. ||
|| innodbLogFileSize | **string** (int64)

Acceptable values are 268435456 to 4294967296, inclusive. ||
|| innodbIoCapacity | **string** (int64)

Acceptable values are 100 to 100000, inclusive. ||
|| innodbIoCapacityMax | **string** (int64)

Acceptable values are 100 to 100000, inclusive. ||
|| innodbReadIoThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbWriteIoThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbPurgeThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbThreadConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Acceptable values are 0 to 107374182400, inclusive. ||
|| threadCacheSize | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| threadStack | **string** (int64)

Acceptable values are 131072 to 16777216, inclusive. ||
|| joinBufferSize | **string** (int64)

Acceptable values are 1024 to 16777216, inclusive. ||
|| sortBufferSize | **string** (int64)

Acceptable values are 1024 to 16777216, inclusive. ||
|| tableDefinitionCache | **string** (int64)

Acceptable values are 400 to 524288, inclusive. ||
|| tableOpenCache | **string** (int64)

Acceptable values are 400 to 524288, inclusive. ||
|| tableOpenCacheInstances | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| explicitDefaultsForTimestamp | **boolean** ||
|| autoIncrementIncrement | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| autoIncrementOffset | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| syncBinlog | **string** (int64)

Acceptable values are 0 to 4096, inclusive. ||
|| binlogCacheSize | **string** (int64)

Acceptable values are 4096 to 67108864, inclusive. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Acceptable values are 0 to 50000, inclusive. ||
|| binlogRowImage | **enum** (BinlogRowImage)

- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean** ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

Acceptable values are 1 to 2, inclusive. ||
|| slaveParallelType | **enum** (SlaveParallelType)

- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Acceptable values are 0 to 64, inclusive. ||
|| mdbPreserveBinlogBytes | **string** (int64)

Acceptable values are 1073741824 to 1099511627776, inclusive. ||
|| interactiveTimeout | **string** (int64)

Acceptable values are 600 to 86400, inclusive. ||
|| waitTimeout | **string** (int64)

Acceptable values are 600 to 86400, inclusive. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Acceptable values are 30 to 86400, inclusive. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Acceptable values are 10 to 86400, inclusive. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

Acceptable values are 1048576 to 268435456, inclusive. ||
|| slowQueryLog | **boolean** ||
|| slowQueryLogAlwaysWriteTime | **number** (double) ||
|| logSlowRateType | **enum** (LogSlowRateType)

- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Acceptable values are 1 to 1000, inclusive. ||
|| logSlowSpStatements | **boolean** ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| innodbPageSize | **string** (int64)

Acceptable values are 4096 to 65536, inclusive. ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

Acceptable values are 65536 to 107374182400, inclusive. ||
|| innodbFtMinTokenSize | **string** (int64)

Acceptable values are 0 to 16, inclusive. ||
|| innodbFtMaxTokenSize | **string** (int64)

Acceptable values are 10 to 84, inclusive. ||
|| lowerCaseTableNames | **string** (int64)

Acceptable values are 0 to 1, inclusive. ||
|| showCompatibility_56 | **boolean** ||
|| maxSpRecursionDepth | **string** (int64)

Acceptable values are 0 to 255, inclusive. ||
|| innodbCompressionLevel | **string** (int64)

Acceptable values are 0 to 9, inclusive. ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean** ||
|| innodbStatusOutput | **boolean** ||
|| innodbStrictMode | **boolean** ||
|| innodbPrintLockWaitTimeoutInfo | **boolean** ||
|| logErrorVerbosity | **string** (int64)

Acceptable values are 1 to 3, inclusive. ||
|| maxDigestLength | **string** (int64)

Acceptable values are 0 to 1048576, inclusive. ||
|| queryCacheLimit | **string** (int64) ||
|| queryCacheSize | **string** (int64) ||
|| queryCacheType | **string** (int64)

Acceptable values are 0 to 2, inclusive. ||
|| lockWaitTimeout | **string** (int64)

Acceptable values are 1 to 31536000, inclusive. ||
|| maxPreparedStmtCount | **string** (int64)

Acceptable values are 0 to 1048576, inclusive. ||
|| optimizerSwitch | **string** ||
|| optimizerSearchDepth | **string** (int64)

Acceptable values are 0 to 62, inclusive. ||
|| queryResponseTimeStats | **boolean** ||
|| userstat | **boolean** ||
|| maxExecutionTime | **string** (int64)

Acceptable values are 0 to 4294967295, inclusive. ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| innodbLruScanDepth | **string** (int64)

Acceptable values are 100 to 4294967295, inclusive. ||
|| mdbForceSsl | **boolean** ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

The minimum value is 1. ||
|#

## MysqlConfigSet8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_0}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)** ||
|| userConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)** ||
|| defaultConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)** ||
|#

## MysqlConfig8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0}

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

The minimum value is 5242880. ||
|| maxConnections | **string** (int64)

Acceptable values are 10 to 16384, inclusive. ||
|| longQueryTime | **number** (double) ||
|| generalLog | **boolean** ||
|| auditLog | **boolean** ||
|| sqlMode[] | **enum** (SQLMode)

- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `TIME_TRUNCATE_FRACTIONAL`
- `ANSI`
- `TRADITIONAL`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

Acceptable values are 1024 to 1073741824, inclusive. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

- `MYSQL_NATIVE_PASSWORD`
- `CACHING_SHA2_PASSWORD`
- `SHA256_PASSWORD`
- `MYSQL_NO_LOGIN`
- `MDB_IAMPROXY_AUTH` ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Acceptable values are 1 to 2, inclusive. ||
|| innodbLockWaitTimeout | **string** (int64)

Acceptable values are 1 to 28800, inclusive. ||
|| transactionIsolation | **enum** (TransactionIsolation)

- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean** ||
|| netReadTimeout | **string** (int64)

Acceptable values are 1 to 1200, inclusive. ||
|| netWriteTimeout | **string** (int64)

Acceptable values are 1 to 1200, inclusive. ||
|| groupConcatMaxLen | **string** (int64)

Acceptable values are 4 to 33554432, inclusive. ||
|| tmpTableSize | **string** (int64)

Acceptable values are 1024 to 536870912, inclusive. ||
|| maxHeapTableSize | **string** (int64)

Acceptable values are 16384 to 536870912, inclusive. ||
|| defaultTimeZone | **string** ||
|| characterSetServer | **string** ||
|| collationServer | **string** ||
|| innodbAdaptiveHashIndex | **boolean** ||
|| innodbNumaInterleave | **boolean** ||
|| innodbLogBufferSize | **string** (int64)

Acceptable values are 1048576 to 268435456, inclusive. ||
|| innodbLogFileSize | **string** (int64)

Acceptable values are 268435456 to 4294967296, inclusive. ||
|| innodbIoCapacity | **string** (int64)

Acceptable values are 100 to 100000, inclusive. ||
|| innodbIoCapacityMax | **string** (int64)

Acceptable values are 100 to 100000, inclusive. ||
|| innodbReadIoThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbWriteIoThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbPurgeThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbThreadConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Acceptable values are 0 to 107374182400, inclusive. ||
|| threadCacheSize | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| threadStack | **string** (int64)

Acceptable values are 131072 to 16777216, inclusive. ||
|| joinBufferSize | **string** (int64)

Acceptable values are 1024 to 16777216, inclusive. ||
|| sortBufferSize | **string** (int64)

Acceptable values are 1024 to 16777216, inclusive. ||
|| tableDefinitionCache | **string** (int64)

Acceptable values are 400 to 524288, inclusive. ||
|| tableOpenCache | **string** (int64)

Acceptable values are 400 to 524288, inclusive. ||
|| tableOpenCacheInstances | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| explicitDefaultsForTimestamp | **boolean** ||
|| autoIncrementIncrement | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| autoIncrementOffset | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| syncBinlog | **string** (int64)

Acceptable values are 0 to 4096, inclusive. ||
|| binlogCacheSize | **string** (int64)

Acceptable values are 4096 to 67108864, inclusive. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Acceptable values are 0 to 50000, inclusive. ||
|| binlogRowImage | **enum** (BinlogRowImage)

- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean** ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

Acceptable values are 1 to 2, inclusive. ||
|| slaveParallelType | **enum** (SlaveParallelType)

- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Acceptable values are 0 to 64, inclusive. ||
|| regexpTimeLimit | **string** (int64)

Acceptable values are 0 to 1048576, inclusive. ||
|| mdbPreserveBinlogBytes | **string** (int64)

Acceptable values are 1073741824 to 1099511627776, inclusive. ||
|| interactiveTimeout | **string** (int64)

Acceptable values are 600 to 86400, inclusive. ||
|| waitTimeout | **string** (int64)

Acceptable values are 600 to 86400, inclusive. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Acceptable values are 30 to 86400, inclusive. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Acceptable values are 10 to 86400, inclusive. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

Acceptable values are 1048576 to 268435456, inclusive. ||
|| slowQueryLog | **boolean** ||
|| slowQueryLogAlwaysWriteTime | **number** (double) ||
|| logSlowRateType | **enum** (LogSlowRateType)

- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Acceptable values are 1 to 1000, inclusive. ||
|| logSlowSpStatements | **boolean** ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| innodbPageSize | **string** (int64)

Acceptable values are 4096 to 65536, inclusive. ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

Acceptable values are 65536 to 107374182400, inclusive. ||
|| innodbFtMinTokenSize | **string** (int64)

Acceptable values are 0 to 16, inclusive. ||
|| innodbFtMaxTokenSize | **string** (int64)

Acceptable values are 10 to 84, inclusive. ||
|| lowerCaseTableNames | **string** (int64)

Acceptable values are 0 to 1, inclusive. ||
|| maxSpRecursionDepth | **string** (int64)

Acceptable values are 0 to 255, inclusive. ||
|| innodbCompressionLevel | **string** (int64)

Acceptable values are 0 to 9, inclusive. ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean** ||
|| innodbStatusOutput | **boolean** ||
|| innodbStrictMode | **boolean** ||
|| innodbPrintLockWaitTimeoutInfo | **boolean** ||
|| logErrorVerbosity | **string** (int64)

Acceptable values are 1 to 3, inclusive. ||
|| maxDigestLength | **string** (int64)

Acceptable values are 0 to 1048576, inclusive. ||
|| lockWaitTimeout | **string** (int64)

Acceptable values are 1 to 31536000, inclusive. ||
|| maxPreparedStmtCount | **string** (int64)

Acceptable values are 0 to 4194304, inclusive. ||
|| optimizerSwitch | **string** ||
|| optimizerSearchDepth | **string** (int64)

Acceptable values are 0 to 62, inclusive. ||
|| userstat | **boolean** ||
|| maxExecutionTime | **string** (int64)

Acceptable values are 0 to 4294967295, inclusive. ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| replicationSenderObserveCommitOnly | **boolean** ||
|| replicationOptimizeForStaticPluginConfig | **boolean** ||
|| innodbLruScanDepth | **string** (int64)

Acceptable values are 100 to 4294967295, inclusive. ||
|| sqlRequirePrimaryKey | **boolean** ||
|| mdbForceSsl | **boolean** ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

The minimum value is 1. ||
|#

## MysqlConfigSet8_4 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_4}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4)** ||
|| userConfig | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4)** ||
|| defaultConfig | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4)** ||
|#

## MysqlConfig8_4 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4}

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

The minimum value is 134217728. ||
|| maxConnections | **string** (int64)

Acceptable values are 10 to 100000, inclusive. ||
|| longQueryTime | **number** (double)

Acceptable values are 0 to 3600, inclusive. ||
|| auditLog | **boolean** ||
|| sqlMode[] | **enum** (SQLMode)

- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `TIME_TRUNCATE_FRACTIONAL`
- `ANSI`
- `TRADITIONAL`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

Acceptable values are 1048576 to 1073741824, inclusive. ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Acceptable values are 1 to 2, inclusive. ||
|| innodbLockWaitTimeout | **string** (int64)

Acceptable values are 1 to 28800, inclusive. ||
|| transactionIsolation | **enum** (TransactionIsolation)

- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean** ||
|| netReadTimeout | **string** (int64)

Acceptable values are 1 to 1200, inclusive. ||
|| netWriteTimeout | **string** (int64)

Acceptable values are 1 to 1200, inclusive. ||
|| groupConcatMaxLen | **string** (int64)

Acceptable values are 4 to 33554432, inclusive. ||
|| tmpTableSize | **string** (int64)

Acceptable values are 1024 to 536870912, inclusive. ||
|| maxHeapTableSize | **string** (int64)

Acceptable values are 16384 to 536870912, inclusive. ||
|| defaultTimeZone | **string** ||
|| characterSetServer | **string** ||
|| collationServer | **string** ||
|| innodbAdaptiveHashIndex | **boolean** ||
|| innodbNumaInterleave | **boolean** ||
|| innodbLogBufferSize | **string** (int64)

Acceptable values are 1048576 to 268435456, inclusive. ||
|| innodbLogFileSize | **string** (int64)

Acceptable values are 268435456 to 8589934592, inclusive. ||
|| innodbIoCapacity | **string** (int64)

Acceptable values are 100 to 100000, inclusive. ||
|| innodbIoCapacityMax | **string** (int64)

Acceptable values are 100 to 100000, inclusive. ||
|| innodbReadIoThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbWriteIoThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbPurgeThreads | **string** (int64)

Acceptable values are 1 to 16, inclusive. ||
|| innodbThreadConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Acceptable values are 1073741824 to 107374182400, inclusive. ||
|| threadCacheSize | **string** (int64)

Acceptable values are 10 to 10000, inclusive. ||
|| threadStack | **string** (int64)

Acceptable values are 131072 to 16777216, inclusive. ||
|| joinBufferSize | **string** (int64)

Acceptable values are 1024 to 16777216, inclusive. ||
|| sortBufferSize | **string** (int64)

Acceptable values are 1024 to 16777216, inclusive. ||
|| tableDefinitionCache | **string** (int64)

Acceptable values are 400 to 524288, inclusive. ||
|| tableOpenCache | **string** (int64)

Acceptable values are 400 to 524288, inclusive. ||
|| tableOpenCacheInstances | **string** (int64)

Acceptable values are 1 to 32, inclusive. ||
|| explicitDefaultsForTimestamp | **boolean** ||
|| autoIncrementIncrement | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| autoIncrementOffset | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| syncBinlog | **string** (int64)

Acceptable values are 0 to 4096, inclusive. ||
|| binlogCacheSize | **string** (int64)

Acceptable values are 4096 to 67108864, inclusive. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Acceptable values are 0 to 50000, inclusive. ||
|| binlogRowImage | **enum** (BinlogRowImage)

- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean** ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

Acceptable values are 1 to 2, inclusive. ||
|| slaveParallelType | **enum** (SlaveParallelType)

- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Acceptable values are 0 to 64, inclusive. ||
|| regexpTimeLimit | **string** (int64)

Acceptable values are 0 to 1048576, inclusive. ||
|| mdbPreserveBinlogBytes | **string** (int64)

Acceptable values are 1073741824 to 1099511627776, inclusive. ||
|| interactiveTimeout | **string** (int64)

Acceptable values are 600 to 86400, inclusive. ||
|| waitTimeout | **string** (int64)

Acceptable values are 600 to 86400, inclusive. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Acceptable values are 30 to 86400, inclusive. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Acceptable values are 10 to 86400, inclusive. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

Acceptable values are 60 to 268435456, inclusive. ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

Acceptable values are 60 to 107374182400, inclusive. ||
|| innodbFtMinTokenSize | **string** (int64)

Acceptable values are 0 to 16, inclusive. ||
|| innodbFtMaxTokenSize | **string** (int64)

Acceptable values are 10 to 84, inclusive. ||
|| lowerCaseTableNames | **string** (int64)

Acceptable values are 0 to 1, inclusive. ||
|| slowQueryLog | **boolean** ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Acceptable values are 0 to 3600, inclusive. ||
|| logSlowRateType | **enum** (LogSlowRateType)

- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Acceptable values are 1 to 1000, inclusive. ||
|| logSlowSpStatements | **boolean** ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| innodbPageSize | **string** (int64)

Acceptable values are 1 to 65536, inclusive. ||
|| maxSpRecursionDepth | **string** (int64)

Acceptable values are 0 to 255, inclusive. ||
|| innodbCompressionLevel | **string** (int64)

Acceptable values are 0 to 9, inclusive. ||
|| autocommit | **boolean** ||
|| innodbStatusOutput | **boolean** ||
|| innodbStrictMode | **boolean** ||
|| innodbPrintLockWaitTimeoutInfo | **boolean** ||
|| logErrorVerbosity | **string** (int64)

Acceptable values are 2 to 3, inclusive. ||
|| maxDigestLength | **string** (int64)

Acceptable values are 1024 to 8192, inclusive. ||
|| lockWaitTimeout | **string** (int64)

Acceptable values are 1 to 31536000, inclusive. ||
|| maxPreparedStmtCount | **string** (int64)

Acceptable values are 0 to 4194304, inclusive. ||
|| optimizerSwitch | **string** ||
|| optimizerSearchDepth | **string** (int64)

Acceptable values are 0 to 62, inclusive. ||
|| userstat | **boolean** ||
|| maxExecutionTime | **string** (int64)

Acceptable values are 0 to 4294967295, inclusive. ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| replicationSenderObserveCommitOnly | **boolean** ||
|| replicationOptimizeForStaticPluginConfig | **boolean** ||
|| innodbLruScanDepth | **string** (int64)

Acceptable values are 100 to 4294967295, inclusive. ||
|| sqlRequirePrimaryKey | **boolean** ||
|| mdbUseAsyncReplication | **boolean** ||
|| mdbAsyncAllowedLag | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| mdbForceSsl | **boolean** ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

The minimum value is 1. ||
|#

## Resources {#yandex.cloud.mdb.mysql.v1.Resources}

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

## Access {#yandex.cloud.mdb.mysql.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|| dataTransfer | **boolean** ||
|| yandexQuery | **boolean** ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| sessionsSamplingInterval | **string** (int64)

Acceptable values are 1 to 86400, inclusive. ||
|| statementsSamplingInterval | **string** (int64)

Acceptable values are 1 to 86400, inclusive. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mysql.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.mysql.v1.MaintenanceOperation}

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