---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for MySQL API, gRPC: ClusterService.List {#List}

Retrieves the list of clusters in a folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.mdb.mysql.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.mdb.mysql.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.mdb.mysql.v1.ListClustersRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list clusters in.

To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClustersResponse) that can be used to get the next page of results in the subsequent [ClusterService.List](#List) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClustersResponse) returned by the previous [ClusterService.List](#List) request. ||
|| filter | **string**

A filter expression that selects clusters listed in the response.

The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.mdb.mysql.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## ListClustersResponse {#yandex.cloud.mdb.mysql.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "environment": "Environment",
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
            "innodbBufferPoolSize": "google.protobuf.Int64Value",
            "maxConnections": "google.protobuf.Int64Value",
            "longQueryTime": "google.protobuf.DoubleValue",
            "generalLog": "google.protobuf.BoolValue",
            "auditLog": "google.protobuf.BoolValue",
            "sqlMode": [
              "SQLMode"
            ],
            "maxAllowedPacket": "google.protobuf.Int64Value",
            "defaultAuthenticationPlugin": "AuthPlugin",
            "innodbFlushLogAtTrxCommit": "google.protobuf.Int64Value",
            "innodbLockWaitTimeout": "google.protobuf.Int64Value",
            "transactionIsolation": "TransactionIsolation",
            "innodbPrintAllDeadlocks": "google.protobuf.BoolValue",
            "netReadTimeout": "google.protobuf.Int64Value",
            "netWriteTimeout": "google.protobuf.Int64Value",
            "groupConcatMaxLen": "google.protobuf.Int64Value",
            "tmpTableSize": "google.protobuf.Int64Value",
            "maxHeapTableSize": "google.protobuf.Int64Value",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "google.protobuf.BoolValue",
            "innodbNumaInterleave": "google.protobuf.BoolValue",
            "innodbLogBufferSize": "google.protobuf.Int64Value",
            "innodbLogFileSize": "google.protobuf.Int64Value",
            "innodbIoCapacity": "google.protobuf.Int64Value",
            "innodbIoCapacityMax": "google.protobuf.Int64Value",
            "innodbReadIoThreads": "google.protobuf.Int64Value",
            "innodbWriteIoThreads": "google.protobuf.Int64Value",
            "innodbPurgeThreads": "google.protobuf.Int64Value",
            "innodbThreadConcurrency": "google.protobuf.Int64Value",
            "innodbTempDataFileMaxSize": "google.protobuf.Int64Value",
            "threadCacheSize": "google.protobuf.Int64Value",
            "threadStack": "google.protobuf.Int64Value",
            "joinBufferSize": "google.protobuf.Int64Value",
            "sortBufferSize": "google.protobuf.Int64Value",
            "tableDefinitionCache": "google.protobuf.Int64Value",
            "tableOpenCache": "google.protobuf.Int64Value",
            "tableOpenCacheInstances": "google.protobuf.Int64Value",
            "explicitDefaultsForTimestamp": "google.protobuf.BoolValue",
            "autoIncrementIncrement": "google.protobuf.Int64Value",
            "autoIncrementOffset": "google.protobuf.Int64Value",
            "syncBinlog": "google.protobuf.Int64Value",
            "binlogCacheSize": "google.protobuf.Int64Value",
            "binlogGroupCommitSyncDelay": "google.protobuf.Int64Value",
            "binlogRowImage": "BinlogRowImage",
            "binlogRowsQueryLogEvents": "google.protobuf.BoolValue",
            "rplSemiSyncMasterWaitForSlaveCount": "google.protobuf.Int64Value",
            "slaveParallelType": "SlaveParallelType",
            "slaveParallelWorkers": "google.protobuf.Int64Value",
            "mdbPreserveBinlogBytes": "google.protobuf.Int64Value",
            "interactiveTimeout": "google.protobuf.Int64Value",
            "waitTimeout": "google.protobuf.Int64Value",
            "mdbOfflineModeEnableLag": "google.protobuf.Int64Value",
            "mdbOfflineModeDisableLag": "google.protobuf.Int64Value",
            "rangeOptimizerMaxMemSize": "google.protobuf.Int64Value",
            "slowQueryLog": "google.protobuf.BoolValue",
            "slowQueryLogAlwaysWriteTime": "google.protobuf.DoubleValue",
            "logSlowRateType": "LogSlowRateType",
            "logSlowRateLimit": "google.protobuf.Int64Value",
            "logSlowSpStatements": "google.protobuf.BoolValue",
            "logSlowFilter": [
              "LogSlowFilterType"
            ],
            "mdbPriorityChoiceMaxLag": "google.protobuf.Int64Value",
            "innodbPageSize": "google.protobuf.Int64Value",
            "innodbOnlineAlterLogMaxSize": "google.protobuf.Int64Value",
            "innodbFtMinTokenSize": "google.protobuf.Int64Value",
            "innodbFtMaxTokenSize": "google.protobuf.Int64Value",
            "lowerCaseTableNames": "google.protobuf.Int64Value",
            "showCompatibility_56": "google.protobuf.BoolValue",
            "maxSpRecursionDepth": "google.protobuf.Int64Value",
            "innodbCompressionLevel": "google.protobuf.Int64Value",
            "binlogTransactionDependencyTracking": "BinlogTransactionDependencyTracking",
            "autocommit": "google.protobuf.BoolValue",
            "innodbStatusOutput": "google.protobuf.BoolValue",
            "innodbStrictMode": "google.protobuf.BoolValue",
            "innodbPrintLockWaitTimeoutInfo": "google.protobuf.BoolValue",
            "logErrorVerbosity": "google.protobuf.Int64Value",
            "maxDigestLength": "google.protobuf.Int64Value",
            "queryCacheLimit": "google.protobuf.Int64Value",
            "queryCacheSize": "google.protobuf.Int64Value",
            "queryCacheType": "google.protobuf.Int64Value",
            "lockWaitTimeout": "google.protobuf.Int64Value",
            "maxPreparedStmtCount": "google.protobuf.Int64Value",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "google.protobuf.Int64Value",
            "queryResponseTimeStats": "google.protobuf.BoolValue",
            "userstat": "google.protobuf.BoolValue",
            "maxExecutionTime": "google.protobuf.Int64Value"
          },
          "userConfig": {
            "innodbBufferPoolSize": "google.protobuf.Int64Value",
            "maxConnections": "google.protobuf.Int64Value",
            "longQueryTime": "google.protobuf.DoubleValue",
            "generalLog": "google.protobuf.BoolValue",
            "auditLog": "google.protobuf.BoolValue",
            "sqlMode": [
              "SQLMode"
            ],
            "maxAllowedPacket": "google.protobuf.Int64Value",
            "defaultAuthenticationPlugin": "AuthPlugin",
            "innodbFlushLogAtTrxCommit": "google.protobuf.Int64Value",
            "innodbLockWaitTimeout": "google.protobuf.Int64Value",
            "transactionIsolation": "TransactionIsolation",
            "innodbPrintAllDeadlocks": "google.protobuf.BoolValue",
            "netReadTimeout": "google.protobuf.Int64Value",
            "netWriteTimeout": "google.protobuf.Int64Value",
            "groupConcatMaxLen": "google.protobuf.Int64Value",
            "tmpTableSize": "google.protobuf.Int64Value",
            "maxHeapTableSize": "google.protobuf.Int64Value",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "google.protobuf.BoolValue",
            "innodbNumaInterleave": "google.protobuf.BoolValue",
            "innodbLogBufferSize": "google.protobuf.Int64Value",
            "innodbLogFileSize": "google.protobuf.Int64Value",
            "innodbIoCapacity": "google.protobuf.Int64Value",
            "innodbIoCapacityMax": "google.protobuf.Int64Value",
            "innodbReadIoThreads": "google.protobuf.Int64Value",
            "innodbWriteIoThreads": "google.protobuf.Int64Value",
            "innodbPurgeThreads": "google.protobuf.Int64Value",
            "innodbThreadConcurrency": "google.protobuf.Int64Value",
            "innodbTempDataFileMaxSize": "google.protobuf.Int64Value",
            "threadCacheSize": "google.protobuf.Int64Value",
            "threadStack": "google.protobuf.Int64Value",
            "joinBufferSize": "google.protobuf.Int64Value",
            "sortBufferSize": "google.protobuf.Int64Value",
            "tableDefinitionCache": "google.protobuf.Int64Value",
            "tableOpenCache": "google.protobuf.Int64Value",
            "tableOpenCacheInstances": "google.protobuf.Int64Value",
            "explicitDefaultsForTimestamp": "google.protobuf.BoolValue",
            "autoIncrementIncrement": "google.protobuf.Int64Value",
            "autoIncrementOffset": "google.protobuf.Int64Value",
            "syncBinlog": "google.protobuf.Int64Value",
            "binlogCacheSize": "google.protobuf.Int64Value",
            "binlogGroupCommitSyncDelay": "google.protobuf.Int64Value",
            "binlogRowImage": "BinlogRowImage",
            "binlogRowsQueryLogEvents": "google.protobuf.BoolValue",
            "rplSemiSyncMasterWaitForSlaveCount": "google.protobuf.Int64Value",
            "slaveParallelType": "SlaveParallelType",
            "slaveParallelWorkers": "google.protobuf.Int64Value",
            "mdbPreserveBinlogBytes": "google.protobuf.Int64Value",
            "interactiveTimeout": "google.protobuf.Int64Value",
            "waitTimeout": "google.protobuf.Int64Value",
            "mdbOfflineModeEnableLag": "google.protobuf.Int64Value",
            "mdbOfflineModeDisableLag": "google.protobuf.Int64Value",
            "rangeOptimizerMaxMemSize": "google.protobuf.Int64Value",
            "slowQueryLog": "google.protobuf.BoolValue",
            "slowQueryLogAlwaysWriteTime": "google.protobuf.DoubleValue",
            "logSlowRateType": "LogSlowRateType",
            "logSlowRateLimit": "google.protobuf.Int64Value",
            "logSlowSpStatements": "google.protobuf.BoolValue",
            "logSlowFilter": [
              "LogSlowFilterType"
            ],
            "mdbPriorityChoiceMaxLag": "google.protobuf.Int64Value",
            "innodbPageSize": "google.protobuf.Int64Value",
            "innodbOnlineAlterLogMaxSize": "google.protobuf.Int64Value",
            "innodbFtMinTokenSize": "google.protobuf.Int64Value",
            "innodbFtMaxTokenSize": "google.protobuf.Int64Value",
            "lowerCaseTableNames": "google.protobuf.Int64Value",
            "showCompatibility_56": "google.protobuf.BoolValue",
            "maxSpRecursionDepth": "google.protobuf.Int64Value",
            "innodbCompressionLevel": "google.protobuf.Int64Value",
            "binlogTransactionDependencyTracking": "BinlogTransactionDependencyTracking",
            "autocommit": "google.protobuf.BoolValue",
            "innodbStatusOutput": "google.protobuf.BoolValue",
            "innodbStrictMode": "google.protobuf.BoolValue",
            "innodbPrintLockWaitTimeoutInfo": "google.protobuf.BoolValue",
            "logErrorVerbosity": "google.protobuf.Int64Value",
            "maxDigestLength": "google.protobuf.Int64Value",
            "queryCacheLimit": "google.protobuf.Int64Value",
            "queryCacheSize": "google.protobuf.Int64Value",
            "queryCacheType": "google.protobuf.Int64Value",
            "lockWaitTimeout": "google.protobuf.Int64Value",
            "maxPreparedStmtCount": "google.protobuf.Int64Value",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "google.protobuf.Int64Value",
            "queryResponseTimeStats": "google.protobuf.BoolValue",
            "userstat": "google.protobuf.BoolValue",
            "maxExecutionTime": "google.protobuf.Int64Value"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "google.protobuf.Int64Value",
            "maxConnections": "google.protobuf.Int64Value",
            "longQueryTime": "google.protobuf.DoubleValue",
            "generalLog": "google.protobuf.BoolValue",
            "auditLog": "google.protobuf.BoolValue",
            "sqlMode": [
              "SQLMode"
            ],
            "maxAllowedPacket": "google.protobuf.Int64Value",
            "defaultAuthenticationPlugin": "AuthPlugin",
            "innodbFlushLogAtTrxCommit": "google.protobuf.Int64Value",
            "innodbLockWaitTimeout": "google.protobuf.Int64Value",
            "transactionIsolation": "TransactionIsolation",
            "innodbPrintAllDeadlocks": "google.protobuf.BoolValue",
            "netReadTimeout": "google.protobuf.Int64Value",
            "netWriteTimeout": "google.protobuf.Int64Value",
            "groupConcatMaxLen": "google.protobuf.Int64Value",
            "tmpTableSize": "google.protobuf.Int64Value",
            "maxHeapTableSize": "google.protobuf.Int64Value",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "google.protobuf.BoolValue",
            "innodbNumaInterleave": "google.protobuf.BoolValue",
            "innodbLogBufferSize": "google.protobuf.Int64Value",
            "innodbLogFileSize": "google.protobuf.Int64Value",
            "innodbIoCapacity": "google.protobuf.Int64Value",
            "innodbIoCapacityMax": "google.protobuf.Int64Value",
            "innodbReadIoThreads": "google.protobuf.Int64Value",
            "innodbWriteIoThreads": "google.protobuf.Int64Value",
            "innodbPurgeThreads": "google.protobuf.Int64Value",
            "innodbThreadConcurrency": "google.protobuf.Int64Value",
            "innodbTempDataFileMaxSize": "google.protobuf.Int64Value",
            "threadCacheSize": "google.protobuf.Int64Value",
            "threadStack": "google.protobuf.Int64Value",
            "joinBufferSize": "google.protobuf.Int64Value",
            "sortBufferSize": "google.protobuf.Int64Value",
            "tableDefinitionCache": "google.protobuf.Int64Value",
            "tableOpenCache": "google.protobuf.Int64Value",
            "tableOpenCacheInstances": "google.protobuf.Int64Value",
            "explicitDefaultsForTimestamp": "google.protobuf.BoolValue",
            "autoIncrementIncrement": "google.protobuf.Int64Value",
            "autoIncrementOffset": "google.protobuf.Int64Value",
            "syncBinlog": "google.protobuf.Int64Value",
            "binlogCacheSize": "google.protobuf.Int64Value",
            "binlogGroupCommitSyncDelay": "google.protobuf.Int64Value",
            "binlogRowImage": "BinlogRowImage",
            "binlogRowsQueryLogEvents": "google.protobuf.BoolValue",
            "rplSemiSyncMasterWaitForSlaveCount": "google.protobuf.Int64Value",
            "slaveParallelType": "SlaveParallelType",
            "slaveParallelWorkers": "google.protobuf.Int64Value",
            "mdbPreserveBinlogBytes": "google.protobuf.Int64Value",
            "interactiveTimeout": "google.protobuf.Int64Value",
            "waitTimeout": "google.protobuf.Int64Value",
            "mdbOfflineModeEnableLag": "google.protobuf.Int64Value",
            "mdbOfflineModeDisableLag": "google.protobuf.Int64Value",
            "rangeOptimizerMaxMemSize": "google.protobuf.Int64Value",
            "slowQueryLog": "google.protobuf.BoolValue",
            "slowQueryLogAlwaysWriteTime": "google.protobuf.DoubleValue",
            "logSlowRateType": "LogSlowRateType",
            "logSlowRateLimit": "google.protobuf.Int64Value",
            "logSlowSpStatements": "google.protobuf.BoolValue",
            "logSlowFilter": [
              "LogSlowFilterType"
            ],
            "mdbPriorityChoiceMaxLag": "google.protobuf.Int64Value",
            "innodbPageSize": "google.protobuf.Int64Value",
            "innodbOnlineAlterLogMaxSize": "google.protobuf.Int64Value",
            "innodbFtMinTokenSize": "google.protobuf.Int64Value",
            "innodbFtMaxTokenSize": "google.protobuf.Int64Value",
            "lowerCaseTableNames": "google.protobuf.Int64Value",
            "showCompatibility_56": "google.protobuf.BoolValue",
            "maxSpRecursionDepth": "google.protobuf.Int64Value",
            "innodbCompressionLevel": "google.protobuf.Int64Value",
            "binlogTransactionDependencyTracking": "BinlogTransactionDependencyTracking",
            "autocommit": "google.protobuf.BoolValue",
            "innodbStatusOutput": "google.protobuf.BoolValue",
            "innodbStrictMode": "google.protobuf.BoolValue",
            "innodbPrintLockWaitTimeoutInfo": "google.protobuf.BoolValue",
            "logErrorVerbosity": "google.protobuf.Int64Value",
            "maxDigestLength": "google.protobuf.Int64Value",
            "queryCacheLimit": "google.protobuf.Int64Value",
            "queryCacheSize": "google.protobuf.Int64Value",
            "queryCacheType": "google.protobuf.Int64Value",
            "lockWaitTimeout": "google.protobuf.Int64Value",
            "maxPreparedStmtCount": "google.protobuf.Int64Value",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "google.protobuf.Int64Value",
            "queryResponseTimeStats": "google.protobuf.BoolValue",
            "userstat": "google.protobuf.BoolValue",
            "maxExecutionTime": "google.protobuf.Int64Value"
          }
        },
        "mysqlConfig_8_0": {
          "effectiveConfig": {
            "innodbBufferPoolSize": "google.protobuf.Int64Value",
            "maxConnections": "google.protobuf.Int64Value",
            "longQueryTime": "google.protobuf.DoubleValue",
            "generalLog": "google.protobuf.BoolValue",
            "auditLog": "google.protobuf.BoolValue",
            "sqlMode": [
              "SQLMode"
            ],
            "maxAllowedPacket": "google.protobuf.Int64Value",
            "defaultAuthenticationPlugin": "AuthPlugin",
            "innodbFlushLogAtTrxCommit": "google.protobuf.Int64Value",
            "innodbLockWaitTimeout": "google.protobuf.Int64Value",
            "transactionIsolation": "TransactionIsolation",
            "innodbPrintAllDeadlocks": "google.protobuf.BoolValue",
            "netReadTimeout": "google.protobuf.Int64Value",
            "netWriteTimeout": "google.protobuf.Int64Value",
            "groupConcatMaxLen": "google.protobuf.Int64Value",
            "tmpTableSize": "google.protobuf.Int64Value",
            "maxHeapTableSize": "google.protobuf.Int64Value",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "google.protobuf.BoolValue",
            "innodbNumaInterleave": "google.protobuf.BoolValue",
            "innodbLogBufferSize": "google.protobuf.Int64Value",
            "innodbLogFileSize": "google.protobuf.Int64Value",
            "innodbIoCapacity": "google.protobuf.Int64Value",
            "innodbIoCapacityMax": "google.protobuf.Int64Value",
            "innodbReadIoThreads": "google.protobuf.Int64Value",
            "innodbWriteIoThreads": "google.protobuf.Int64Value",
            "innodbPurgeThreads": "google.protobuf.Int64Value",
            "innodbThreadConcurrency": "google.protobuf.Int64Value",
            "innodbTempDataFileMaxSize": "google.protobuf.Int64Value",
            "threadCacheSize": "google.protobuf.Int64Value",
            "threadStack": "google.protobuf.Int64Value",
            "joinBufferSize": "google.protobuf.Int64Value",
            "sortBufferSize": "google.protobuf.Int64Value",
            "tableDefinitionCache": "google.protobuf.Int64Value",
            "tableOpenCache": "google.protobuf.Int64Value",
            "tableOpenCacheInstances": "google.protobuf.Int64Value",
            "explicitDefaultsForTimestamp": "google.protobuf.BoolValue",
            "autoIncrementIncrement": "google.protobuf.Int64Value",
            "autoIncrementOffset": "google.protobuf.Int64Value",
            "syncBinlog": "google.protobuf.Int64Value",
            "binlogCacheSize": "google.protobuf.Int64Value",
            "binlogGroupCommitSyncDelay": "google.protobuf.Int64Value",
            "binlogRowImage": "BinlogRowImage",
            "binlogRowsQueryLogEvents": "google.protobuf.BoolValue",
            "rplSemiSyncMasterWaitForSlaveCount": "google.protobuf.Int64Value",
            "slaveParallelType": "SlaveParallelType",
            "slaveParallelWorkers": "google.protobuf.Int64Value",
            "regexpTimeLimit": "google.protobuf.Int64Value",
            "mdbPreserveBinlogBytes": "google.protobuf.Int64Value",
            "interactiveTimeout": "google.protobuf.Int64Value",
            "waitTimeout": "google.protobuf.Int64Value",
            "mdbOfflineModeEnableLag": "google.protobuf.Int64Value",
            "mdbOfflineModeDisableLag": "google.protobuf.Int64Value",
            "rangeOptimizerMaxMemSize": "google.protobuf.Int64Value",
            "slowQueryLog": "google.protobuf.BoolValue",
            "slowQueryLogAlwaysWriteTime": "google.protobuf.DoubleValue",
            "logSlowRateType": "LogSlowRateType",
            "logSlowRateLimit": "google.protobuf.Int64Value",
            "logSlowSpStatements": "google.protobuf.BoolValue",
            "logSlowFilter": [
              "LogSlowFilterType"
            ],
            "mdbPriorityChoiceMaxLag": "google.protobuf.Int64Value",
            "innodbPageSize": "google.protobuf.Int64Value",
            "innodbOnlineAlterLogMaxSize": "google.protobuf.Int64Value",
            "innodbFtMinTokenSize": "google.protobuf.Int64Value",
            "innodbFtMaxTokenSize": "google.protobuf.Int64Value",
            "lowerCaseTableNames": "google.protobuf.Int64Value",
            "maxSpRecursionDepth": "google.protobuf.Int64Value",
            "innodbCompressionLevel": "google.protobuf.Int64Value",
            "binlogTransactionDependencyTracking": "BinlogTransactionDependencyTracking",
            "autocommit": "google.protobuf.BoolValue",
            "innodbStatusOutput": "google.protobuf.BoolValue",
            "innodbStrictMode": "google.protobuf.BoolValue",
            "innodbPrintLockWaitTimeoutInfo": "google.protobuf.BoolValue",
            "logErrorVerbosity": "google.protobuf.Int64Value",
            "maxDigestLength": "google.protobuf.Int64Value",
            "lockWaitTimeout": "google.protobuf.Int64Value",
            "maxPreparedStmtCount": "google.protobuf.Int64Value",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "google.protobuf.Int64Value",
            "userstat": "google.protobuf.BoolValue",
            "maxExecutionTime": "google.protobuf.Int64Value"
          },
          "userConfig": {
            "innodbBufferPoolSize": "google.protobuf.Int64Value",
            "maxConnections": "google.protobuf.Int64Value",
            "longQueryTime": "google.protobuf.DoubleValue",
            "generalLog": "google.protobuf.BoolValue",
            "auditLog": "google.protobuf.BoolValue",
            "sqlMode": [
              "SQLMode"
            ],
            "maxAllowedPacket": "google.protobuf.Int64Value",
            "defaultAuthenticationPlugin": "AuthPlugin",
            "innodbFlushLogAtTrxCommit": "google.protobuf.Int64Value",
            "innodbLockWaitTimeout": "google.protobuf.Int64Value",
            "transactionIsolation": "TransactionIsolation",
            "innodbPrintAllDeadlocks": "google.protobuf.BoolValue",
            "netReadTimeout": "google.protobuf.Int64Value",
            "netWriteTimeout": "google.protobuf.Int64Value",
            "groupConcatMaxLen": "google.protobuf.Int64Value",
            "tmpTableSize": "google.protobuf.Int64Value",
            "maxHeapTableSize": "google.protobuf.Int64Value",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "google.protobuf.BoolValue",
            "innodbNumaInterleave": "google.protobuf.BoolValue",
            "innodbLogBufferSize": "google.protobuf.Int64Value",
            "innodbLogFileSize": "google.protobuf.Int64Value",
            "innodbIoCapacity": "google.protobuf.Int64Value",
            "innodbIoCapacityMax": "google.protobuf.Int64Value",
            "innodbReadIoThreads": "google.protobuf.Int64Value",
            "innodbWriteIoThreads": "google.protobuf.Int64Value",
            "innodbPurgeThreads": "google.protobuf.Int64Value",
            "innodbThreadConcurrency": "google.protobuf.Int64Value",
            "innodbTempDataFileMaxSize": "google.protobuf.Int64Value",
            "threadCacheSize": "google.protobuf.Int64Value",
            "threadStack": "google.protobuf.Int64Value",
            "joinBufferSize": "google.protobuf.Int64Value",
            "sortBufferSize": "google.protobuf.Int64Value",
            "tableDefinitionCache": "google.protobuf.Int64Value",
            "tableOpenCache": "google.protobuf.Int64Value",
            "tableOpenCacheInstances": "google.protobuf.Int64Value",
            "explicitDefaultsForTimestamp": "google.protobuf.BoolValue",
            "autoIncrementIncrement": "google.protobuf.Int64Value",
            "autoIncrementOffset": "google.protobuf.Int64Value",
            "syncBinlog": "google.protobuf.Int64Value",
            "binlogCacheSize": "google.protobuf.Int64Value",
            "binlogGroupCommitSyncDelay": "google.protobuf.Int64Value",
            "binlogRowImage": "BinlogRowImage",
            "binlogRowsQueryLogEvents": "google.protobuf.BoolValue",
            "rplSemiSyncMasterWaitForSlaveCount": "google.protobuf.Int64Value",
            "slaveParallelType": "SlaveParallelType",
            "slaveParallelWorkers": "google.protobuf.Int64Value",
            "regexpTimeLimit": "google.protobuf.Int64Value",
            "mdbPreserveBinlogBytes": "google.protobuf.Int64Value",
            "interactiveTimeout": "google.protobuf.Int64Value",
            "waitTimeout": "google.protobuf.Int64Value",
            "mdbOfflineModeEnableLag": "google.protobuf.Int64Value",
            "mdbOfflineModeDisableLag": "google.protobuf.Int64Value",
            "rangeOptimizerMaxMemSize": "google.protobuf.Int64Value",
            "slowQueryLog": "google.protobuf.BoolValue",
            "slowQueryLogAlwaysWriteTime": "google.protobuf.DoubleValue",
            "logSlowRateType": "LogSlowRateType",
            "logSlowRateLimit": "google.protobuf.Int64Value",
            "logSlowSpStatements": "google.protobuf.BoolValue",
            "logSlowFilter": [
              "LogSlowFilterType"
            ],
            "mdbPriorityChoiceMaxLag": "google.protobuf.Int64Value",
            "innodbPageSize": "google.protobuf.Int64Value",
            "innodbOnlineAlterLogMaxSize": "google.protobuf.Int64Value",
            "innodbFtMinTokenSize": "google.protobuf.Int64Value",
            "innodbFtMaxTokenSize": "google.protobuf.Int64Value",
            "lowerCaseTableNames": "google.protobuf.Int64Value",
            "maxSpRecursionDepth": "google.protobuf.Int64Value",
            "innodbCompressionLevel": "google.protobuf.Int64Value",
            "binlogTransactionDependencyTracking": "BinlogTransactionDependencyTracking",
            "autocommit": "google.protobuf.BoolValue",
            "innodbStatusOutput": "google.protobuf.BoolValue",
            "innodbStrictMode": "google.protobuf.BoolValue",
            "innodbPrintLockWaitTimeoutInfo": "google.protobuf.BoolValue",
            "logErrorVerbosity": "google.protobuf.Int64Value",
            "maxDigestLength": "google.protobuf.Int64Value",
            "lockWaitTimeout": "google.protobuf.Int64Value",
            "maxPreparedStmtCount": "google.protobuf.Int64Value",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "google.protobuf.Int64Value",
            "userstat": "google.protobuf.BoolValue",
            "maxExecutionTime": "google.protobuf.Int64Value"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "google.protobuf.Int64Value",
            "maxConnections": "google.protobuf.Int64Value",
            "longQueryTime": "google.protobuf.DoubleValue",
            "generalLog": "google.protobuf.BoolValue",
            "auditLog": "google.protobuf.BoolValue",
            "sqlMode": [
              "SQLMode"
            ],
            "maxAllowedPacket": "google.protobuf.Int64Value",
            "defaultAuthenticationPlugin": "AuthPlugin",
            "innodbFlushLogAtTrxCommit": "google.protobuf.Int64Value",
            "innodbLockWaitTimeout": "google.protobuf.Int64Value",
            "transactionIsolation": "TransactionIsolation",
            "innodbPrintAllDeadlocks": "google.protobuf.BoolValue",
            "netReadTimeout": "google.protobuf.Int64Value",
            "netWriteTimeout": "google.protobuf.Int64Value",
            "groupConcatMaxLen": "google.protobuf.Int64Value",
            "tmpTableSize": "google.protobuf.Int64Value",
            "maxHeapTableSize": "google.protobuf.Int64Value",
            "defaultTimeZone": "string",
            "characterSetServer": "string",
            "collationServer": "string",
            "innodbAdaptiveHashIndex": "google.protobuf.BoolValue",
            "innodbNumaInterleave": "google.protobuf.BoolValue",
            "innodbLogBufferSize": "google.protobuf.Int64Value",
            "innodbLogFileSize": "google.protobuf.Int64Value",
            "innodbIoCapacity": "google.protobuf.Int64Value",
            "innodbIoCapacityMax": "google.protobuf.Int64Value",
            "innodbReadIoThreads": "google.protobuf.Int64Value",
            "innodbWriteIoThreads": "google.protobuf.Int64Value",
            "innodbPurgeThreads": "google.protobuf.Int64Value",
            "innodbThreadConcurrency": "google.protobuf.Int64Value",
            "innodbTempDataFileMaxSize": "google.protobuf.Int64Value",
            "threadCacheSize": "google.protobuf.Int64Value",
            "threadStack": "google.protobuf.Int64Value",
            "joinBufferSize": "google.protobuf.Int64Value",
            "sortBufferSize": "google.protobuf.Int64Value",
            "tableDefinitionCache": "google.protobuf.Int64Value",
            "tableOpenCache": "google.protobuf.Int64Value",
            "tableOpenCacheInstances": "google.protobuf.Int64Value",
            "explicitDefaultsForTimestamp": "google.protobuf.BoolValue",
            "autoIncrementIncrement": "google.protobuf.Int64Value",
            "autoIncrementOffset": "google.protobuf.Int64Value",
            "syncBinlog": "google.protobuf.Int64Value",
            "binlogCacheSize": "google.protobuf.Int64Value",
            "binlogGroupCommitSyncDelay": "google.protobuf.Int64Value",
            "binlogRowImage": "BinlogRowImage",
            "binlogRowsQueryLogEvents": "google.protobuf.BoolValue",
            "rplSemiSyncMasterWaitForSlaveCount": "google.protobuf.Int64Value",
            "slaveParallelType": "SlaveParallelType",
            "slaveParallelWorkers": "google.protobuf.Int64Value",
            "regexpTimeLimit": "google.protobuf.Int64Value",
            "mdbPreserveBinlogBytes": "google.protobuf.Int64Value",
            "interactiveTimeout": "google.protobuf.Int64Value",
            "waitTimeout": "google.protobuf.Int64Value",
            "mdbOfflineModeEnableLag": "google.protobuf.Int64Value",
            "mdbOfflineModeDisableLag": "google.protobuf.Int64Value",
            "rangeOptimizerMaxMemSize": "google.protobuf.Int64Value",
            "slowQueryLog": "google.protobuf.BoolValue",
            "slowQueryLogAlwaysWriteTime": "google.protobuf.DoubleValue",
            "logSlowRateType": "LogSlowRateType",
            "logSlowRateLimit": "google.protobuf.Int64Value",
            "logSlowSpStatements": "google.protobuf.BoolValue",
            "logSlowFilter": [
              "LogSlowFilterType"
            ],
            "mdbPriorityChoiceMaxLag": "google.protobuf.Int64Value",
            "innodbPageSize": "google.protobuf.Int64Value",
            "innodbOnlineAlterLogMaxSize": "google.protobuf.Int64Value",
            "innodbFtMinTokenSize": "google.protobuf.Int64Value",
            "innodbFtMaxTokenSize": "google.protobuf.Int64Value",
            "lowerCaseTableNames": "google.protobuf.Int64Value",
            "maxSpRecursionDepth": "google.protobuf.Int64Value",
            "innodbCompressionLevel": "google.protobuf.Int64Value",
            "binlogTransactionDependencyTracking": "BinlogTransactionDependencyTracking",
            "autocommit": "google.protobuf.BoolValue",
            "innodbStatusOutput": "google.protobuf.BoolValue",
            "innodbStrictMode": "google.protobuf.BoolValue",
            "innodbPrintLockWaitTimeoutInfo": "google.protobuf.BoolValue",
            "logErrorVerbosity": "google.protobuf.Int64Value",
            "maxDigestLength": "google.protobuf.Int64Value",
            "lockWaitTimeout": "google.protobuf.Int64Value",
            "maxPreparedStmtCount": "google.protobuf.Int64Value",
            "optimizerSwitch": "string",
            "optimizerSearchDepth": "google.protobuf.Int64Value",
            "userstat": "google.protobuf.BoolValue",
            "maxExecutionTime": "google.protobuf.Int64Value"
          }
        },
        // end of the list of possible fields
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "int64",
          "diskTypeId": "string"
        },
        "backupWindowStart": "google.type.TimeOfDay",
        "access": {
          "dataLens": "bool",
          "webSql": "bool",
          "dataTransfer": "bool"
        },
        "performanceDiagnostics": {
          "enabled": "bool",
          "sessionsSamplingInterval": "int64",
          "statementsSamplingInterval": "int64"
        },
        "backupRetainPeriodDays": "google.protobuf.Int64Value"
      },
      "networkId": "string",
      "health": "Health",
      "status": "Status",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": "AnytimeMaintenanceWindow",
        "weeklyMaintenanceWindow": {
          "day": "WeekDay",
          "hour": "int64"
        }
        // end of the list of possible fields
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "google.protobuf.Timestamp"
      },
      "securityGroupIds": [
        "string"
      ],
      "deletionProtection": "bool",
      "hostGroupIds": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.mysql.v1.Cluster)**

List of clusters. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListClustersRequest.pageSize](#yandex.cloud.mdb.mysql.v1.ListClustersRequest), use the `nextPageToken` as the value for the [ListClustersRequest.pageToken](#yandex.cloud.mdb.mysql.v1.ListClustersRequest) in the subsequent [ClusterService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [ClusterService.List](#List) requests should use the `nextPageToken` value returned by the previous request to continue paging through the results. ||
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp of the cluster. ||
|| name | **string**

Name of the cluster. ||
|| description | **string**

Description of the cluster. ||
|| labels | **string**

Custom labels for the cluster as `key:value` pairs. ||
|| environment | enum **Environment**

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
|| health | enum **Health**

Aggregated health of the cluster.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-mysql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `UNKNOWN`).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-mysql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `ALIVE`).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-mysql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `DEAD`).
- `DEGRADED`: Cluster is degraded ([Host.health](/docs/managed-mysql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for at least one host in the cluster is not `ALIVE`). ||
|| status | enum **Status**

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
|| deletionProtection | **bool**

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
|| backupWindowStart | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.mysql.v1.Access)**

Access policy for external services. ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| backupRetainPeriodDays | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| innodbBufferPoolSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | enum **SQLMode**

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
|| maxAllowedPacket | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | enum **AuthPlugin**

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html). ||
|| innodbFlushLogAtTrxCommit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | enum **TransactionIsolation**

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| innodbAdaptiveHashIndex | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

A number of threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | enum **BinlogRowImage**

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | enum **SlaveParallelType**

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| mdbPreserveBinlogBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size of the binary log to hold. ||
|| interactiveTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag value. ||
|| rangeOptimizerMaxMemSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | enum **LogSlowRateType**

Specifies slow log granularity for `log_slow_rate_limit` values QUERY or SESSION.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | enum **LogSlowFilterType**

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit in bytes on the size of the temporary log files used during online DDL operations

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size). ||
|| innodbFtMinTokenSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size). ||
|| innodbFtMaxTokenSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size). ||
|| lowerCaseTableNames | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Table names storage and comparison strategy

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names). ||
|| showCompatibility_56 | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Manages MySQL 5.6 compatibility

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56). ||
|| maxSpRecursionDepth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | enum **BinlogTransactionDependencyTracking**

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_digest_length). ||
|| queryCacheLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Do not cache results that are larger than this number of bytes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_limit). ||
|| queryCacheSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of memory allocated for caching query results.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_size). ||
|| queryCacheType | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Set the query cache type.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_type). ||
|| lockWaitTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html) ||
|| queryResponseTimeStats | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables and disables collection of query times

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html#query_response_time_stats). ||
|| userstat | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| innodbBufferPoolSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | enum **SQLMode**

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
|| maxAllowedPacket | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | enum **AuthPlugin**

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Using [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html). ||
|| innodbFlushLogAtTrxCommit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | enum **TransactionIsolation**

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| innodbAdaptiveHashIndex | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | enum **BinlogRowImage**

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | enum **SlaveParallelType**

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| regexpTimeLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit) for details. ||
|| mdbPreserveBinlogBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size of the binary log to hold. ||
|| interactiveTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag. ||
|| rangeOptimizerMaxMemSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | enum **LogSlowRateType**

Specifies slow log granularity for `log_slow_rate_limit` QUERY or SESSION value.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | enum **LogSlowFilterType**

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit in bytes on the size of the temporary log files used during online DDL operations

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size) for details. ||
|| innodbFtMinTokenSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size) for details. ||
|| innodbFtMaxTokenSize | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size) for details. ||
|| lowerCaseTableNames | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Table names storage and comparison strategy

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names) for details. ||
|| maxSpRecursionDepth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | enum **BinlogTransactionDependencyTracking**

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length). ||
|| lockWaitTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) ||
|| userstat | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| diskSize | **int64**

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

## Access {#yandex.cloud.mdb.mysql.v1.Access}

#|
||Field | Description ||
|| dataLens | **bool**

Allows access from DataLens.

See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. ||
|| webSql | **bool**

Allows SQL queries to the cluster databases from management console.

See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. ||
|| dataTransfer | **bool**

Allow access for DataTransfer. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **bool**

Flag that shows if performance statistics gathering is enabled for the cluster. ||
|| sessionsSamplingInterval | **int64**

Interval (in seconds) for `my_session` sampling. ||
|| statementsSamplingInterval | **int64**

Interval (in seconds) for `my_statements` sampling. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mysql.v1.MaintenanceWindow}

Configuration of a maintenance window in a MySQL cluster.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.mysql.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.mysql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#