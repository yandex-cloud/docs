---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Cluster/move.md
---

# Managed Service for MySQL API, REST: Cluster.Move

Moves a cluster to a folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}:move
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to move.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.mysql.v1.MoveClusterRequest}

```json
{
  "destinationFolderId": "string"
}
```

#|
||Field | Description ||
|| destinationFolderId | **string**

Required field. ID of the destination folder.

To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
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
      // Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`
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
          "maxExecutionTime": "string"
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
          "maxExecutionTime": "string"
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
          "maxExecutionTime": "string"
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
          "maxExecutionTime": "string"
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
          "maxExecutionTime": "string"
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
          "maxExecutionTime": "string"
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
        "dataTransfer": "boolean"
      },
      "performanceDiagnostics": {
        "enabled": "boolean",
        "sessionsSamplingInterval": "string",
        "statementsSamplingInterval": "string"
      },
      "backupRetainPeriodDays": "string"
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
|| metadata | **[MoveClusterMetadata](#yandex.cloud.mdb.mysql.v1.MoveClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.mysql.v1.Cluster)**

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

## MoveClusterMetadata {#yandex.cloud.mdb.mysql.v1.MoveClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that is being moved. ||
|| sourceFolderId | **string**

ID of the source folder. ||
|| destinationFolderId | **string**

ID of the destination folder. ||
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

## Cluster {#yandex.cloud.mdb.mysql.v1.Cluster}

An object that represents MySQL cluster.

See [the documentation](/docs/managed-mysql/concepts) for details.

#|
||Field | Description ||
|| id | **string**

ID of the cluster.

This ID is assigned by the platform at the time of creation. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp of the cluster.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the cluster. ||
|| description | **string**

Description of the cluster. ||
|| labels | **string**

Custom labels for the cluster as `key:value` pairs. ||
|| environment | **enum** (Environment)

Deployment environment of the MySQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Environment for stable versions of your apps.
A conservative update policy is in effect: only bug fixes are applied during regular maintenance.
- `PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself.
This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment.
However, not every update ensures backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.mysql.v1.Monitoring)**

Monitoring systems data that is relevant to the cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.mysql.v1.ClusterConfig)**

Configuration of the cluster. ||
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated health of the cluster.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `UNKNOWN`).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `ALIVE`).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `DEAD`).
- `DEGRADED`: Cluster is degraded ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for at least one host in the cluster is not `ALIVE`). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.mysql.v1.MaintenanceWindow)**

Maintenance window settings for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.mysql.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

Effective list of security group IDs applied to the cluster. ||
|| deletionProtection | **boolean**

This option prevents unintended deletion of the cluster. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|#

## Monitoring {#yandex.cloud.mdb.mysql.v1.Monitoring}

Cluster-related monitoring system data.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.mysql.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of MySQL used in the cluster. ||
|| mysqlConfig_5_7 | **[MysqlConfigSet5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet5_7)**

Configuration of a MySQL 5.7 server.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`.

Cluster-wide MySQL configuration. ||
|| mysqlConfig_8_0 | **[MysqlConfigSet8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_0)**

Configuration of a MySQL 8.0 server.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`.

Cluster-wide MySQL configuration. ||
|| resources | **[Resources](#yandex.cloud.mdb.mysql.v1.Resources)**

Resource preset for the cluster hosts. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.mysql.v1.Access)**

Access policy for external services. ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups. ||
|#

## MysqlConfigSet5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet5_7}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)**

Effective settings for a MySQL 5.7 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)**

User-defined settings for a MySQL 5.7 cluster. ||
|| defaultConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)**

Default configuration for a MySQL 5.7 cluster. ||
|#

## MysqlConfig5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7}

Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file.

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **boolean**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting) for details.

- `SQLMODE_UNSPECIFIED`
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

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size) for details. ||
|| defaultTimeZone | **string**

The servers default time zone.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone) for details. ||
|| characterSetServer | **string**

The servers default character set.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server) for details. ||
|| collationServer | **string**

The server default collation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server) for details. ||
|| innodbAdaptiveHashIndex | **boolean**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **string** (int64)

A number of threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **boolean**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag value. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **boolean**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for `log_slow_rate_limit` values QUERY or SESSION.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size). ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size). ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size). ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names). ||
|| showCompatibility_56 | **boolean**

Manages MySQL 5.6 compatibility

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56). ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_digest_length). ||
|| queryCacheLimit | **string** (int64)

Do not cache results that are larger than this number of bytes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_limit). ||
|| queryCacheSize | **string** (int64)

The amount of memory allocated for caching query results.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_size). ||
|| queryCacheType | **string** (int64)

Set the query cache type.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_type). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html) ||
|| queryResponseTimeStats | **boolean**

Enables and disables collection of query times

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html#query_response_time_stats). ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_execution_time) ||
|#

## MysqlConfigSet8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_0}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)**

Effective settings for a MySQL 8.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)**

User-defined settings for a MySQL 8.0 cluster. ||
|| defaultConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)**

Default configuration for a MySQL 8.0 cluster. ||
|#

## MysqlConfig8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0}

Options and structure of `MysqlConfig8_0` reflects MySQL 8.0 configuration file.

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **boolean**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) for details.

- `SQLMODE_UNSPECIFIED`
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

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Using [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size) for details. ||
|| defaultTimeZone | **string**

The servers default time zone.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone) for details. ||
|| characterSetServer | **string**

The servers default character set.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server) for details. ||
|| collationServer | **string**

The server default collation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server) for details. ||
|| innodbAdaptiveHashIndex | **boolean**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **string** (int64)

How many threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **boolean**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| regexpTimeLimit | **string** (int64)

The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit) for details. ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **boolean**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for `log_slow_rate_limit` QUERY or SESSION value.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size) for details. ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size) for details. ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size) for details. ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names) for details. ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_execution_time) ||
|#

## Resources {#yandex.cloud.mdb.mysql.v1.Resources}

Cluster resource preset.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.

All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage (for each cluster host, in bytes). ||
|| diskTypeId | **string**

Type of the storage.

Possible values:
* `network-hdd` - standard network storage
* `network-ssd` - fast network storage
* `network-ssd-nonreplicated` - fast network nonreplicated storage
* `local-ssd` - fast local storage.

See [the documentation](/docs/managed-mysql/concepts/storage) for details. ||
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

## Access {#yandex.cloud.mdb.mysql.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows access from DataLens.

See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from management console.

See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **boolean**

Flag that shows if performance statistics gathering is enabled for the cluster. ||
|| sessionsSamplingInterval | **string** (int64)

Interval (in seconds) for `my_session` sampling. ||
|| statementsSamplingInterval | **string** (int64)

Interval (in seconds) for `my_statements` sampling. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mysql.v1.MaintenanceWindow}

Configuration of a maintenance window in a MySQL cluster.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.mysql.v1.MaintenanceOperation}

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