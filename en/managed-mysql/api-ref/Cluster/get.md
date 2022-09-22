---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Cluster/get.md
---

# Method get
Retrieves information about a cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to return information about.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
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
      "dataLens": true,
      "webSql": true,
      "dataTransfer": true
    },
    "performanceDiagnostics": {
      "enabled": true,
      "sessionsSamplingInterval": "string",
      "statementsSamplingInterval": "string"
    },
    "backupRetainPeriodDays": "integer",

    // `config` includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`
    "mysqlConfig_5_7": {
      "effectiveConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string",
        "innodbFlushLogAtTrxCommit": "integer",
        "innodbLockWaitTimeout": "integer",
        "transactionIsolation": "string",
        "innodbPrintAllDeadlocks": true,
        "netReadTimeout": "integer",
        "netWriteTimeout": "integer",
        "groupConcatMaxLen": "integer",
        "tmpTableSize": "integer",
        "maxHeapTableSize": "integer",
        "defaultTimeZone": "string",
        "characterSetServer": "string",
        "collationServer": "string",
        "innodbAdaptiveHashIndex": true,
        "innodbNumaInterleave": true,
        "innodbLogBufferSize": "integer",
        "innodbLogFileSize": "integer",
        "innodbIoCapacity": "integer",
        "innodbIoCapacityMax": "integer",
        "innodbReadIoThreads": "integer",
        "innodbWriteIoThreads": "integer",
        "innodbPurgeThreads": "integer",
        "innodbThreadConcurrency": "integer",
        "innodbTempDataFileMaxSize": "integer",
        "threadCacheSize": "integer",
        "threadStack": "integer",
        "joinBufferSize": "integer",
        "sortBufferSize": "integer",
        "tableDefinitionCache": "integer",
        "tableOpenCache": "integer",
        "tableOpenCacheInstances": "integer",
        "explicitDefaultsForTimestamp": true,
        "autoIncrementIncrement": "integer",
        "autoIncrementOffset": "integer",
        "syncBinlog": "integer",
        "binlogCacheSize": "integer",
        "binlogGroupCommitSyncDelay": "integer",
        "binlogRowImage": "string",
        "binlogRowsQueryLogEvents": true,
        "rplSemiSyncMasterWaitForSlaveCount": "integer",
        "slaveParallelType": "string",
        "slaveParallelWorkers": "integer",
        "mdbPreserveBinlogBytes": "integer",
        "interactiveTimeout": "integer",
        "waitTimeout": "integer",
        "mdbOfflineModeEnableLag": "integer",
        "mdbOfflineModeDisableLag": "integer",
        "rangeOptimizerMaxMemSize": "integer",
        "slowQueryLog": true,
        "slowQueryLogAlwaysWriteTime": "number",
        "logSlowRateType": "string",
        "logSlowRateLimit": "integer",
        "logSlowSpStatements": true,
        "logSlowFilter": [
          "string"
        ],
        "mdbPriorityChoiceMaxLag": "integer",
        "innodbPageSize": "integer",
        "innodbOnlineAlterLogMaxSize": "integer",
        "innodbFtMinTokenSize": "integer",
        "innodbFtMaxTokenSize": "integer",
        "lowerCaseTableNames": "integer",
        "showCompatibility_56": true,
        "maxSpRecursionDepth": "integer",
        "innodbCompressionLevel": "integer",
        "binlogTransactionDependencyTracking": "string"
      },
      "userConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string",
        "innodbFlushLogAtTrxCommit": "integer",
        "innodbLockWaitTimeout": "integer",
        "transactionIsolation": "string",
        "innodbPrintAllDeadlocks": true,
        "netReadTimeout": "integer",
        "netWriteTimeout": "integer",
        "groupConcatMaxLen": "integer",
        "tmpTableSize": "integer",
        "maxHeapTableSize": "integer",
        "defaultTimeZone": "string",
        "characterSetServer": "string",
        "collationServer": "string",
        "innodbAdaptiveHashIndex": true,
        "innodbNumaInterleave": true,
        "innodbLogBufferSize": "integer",
        "innodbLogFileSize": "integer",
        "innodbIoCapacity": "integer",
        "innodbIoCapacityMax": "integer",
        "innodbReadIoThreads": "integer",
        "innodbWriteIoThreads": "integer",
        "innodbPurgeThreads": "integer",
        "innodbThreadConcurrency": "integer",
        "innodbTempDataFileMaxSize": "integer",
        "threadCacheSize": "integer",
        "threadStack": "integer",
        "joinBufferSize": "integer",
        "sortBufferSize": "integer",
        "tableDefinitionCache": "integer",
        "tableOpenCache": "integer",
        "tableOpenCacheInstances": "integer",
        "explicitDefaultsForTimestamp": true,
        "autoIncrementIncrement": "integer",
        "autoIncrementOffset": "integer",
        "syncBinlog": "integer",
        "binlogCacheSize": "integer",
        "binlogGroupCommitSyncDelay": "integer",
        "binlogRowImage": "string",
        "binlogRowsQueryLogEvents": true,
        "rplSemiSyncMasterWaitForSlaveCount": "integer",
        "slaveParallelType": "string",
        "slaveParallelWorkers": "integer",
        "mdbPreserveBinlogBytes": "integer",
        "interactiveTimeout": "integer",
        "waitTimeout": "integer",
        "mdbOfflineModeEnableLag": "integer",
        "mdbOfflineModeDisableLag": "integer",
        "rangeOptimizerMaxMemSize": "integer",
        "slowQueryLog": true,
        "slowQueryLogAlwaysWriteTime": "number",
        "logSlowRateType": "string",
        "logSlowRateLimit": "integer",
        "logSlowSpStatements": true,
        "logSlowFilter": [
          "string"
        ],
        "mdbPriorityChoiceMaxLag": "integer",
        "innodbPageSize": "integer",
        "innodbOnlineAlterLogMaxSize": "integer",
        "innodbFtMinTokenSize": "integer",
        "innodbFtMaxTokenSize": "integer",
        "lowerCaseTableNames": "integer",
        "showCompatibility_56": true,
        "maxSpRecursionDepth": "integer",
        "innodbCompressionLevel": "integer",
        "binlogTransactionDependencyTracking": "string"
      },
      "defaultConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string",
        "innodbFlushLogAtTrxCommit": "integer",
        "innodbLockWaitTimeout": "integer",
        "transactionIsolation": "string",
        "innodbPrintAllDeadlocks": true,
        "netReadTimeout": "integer",
        "netWriteTimeout": "integer",
        "groupConcatMaxLen": "integer",
        "tmpTableSize": "integer",
        "maxHeapTableSize": "integer",
        "defaultTimeZone": "string",
        "characterSetServer": "string",
        "collationServer": "string",
        "innodbAdaptiveHashIndex": true,
        "innodbNumaInterleave": true,
        "innodbLogBufferSize": "integer",
        "innodbLogFileSize": "integer",
        "innodbIoCapacity": "integer",
        "innodbIoCapacityMax": "integer",
        "innodbReadIoThreads": "integer",
        "innodbWriteIoThreads": "integer",
        "innodbPurgeThreads": "integer",
        "innodbThreadConcurrency": "integer",
        "innodbTempDataFileMaxSize": "integer",
        "threadCacheSize": "integer",
        "threadStack": "integer",
        "joinBufferSize": "integer",
        "sortBufferSize": "integer",
        "tableDefinitionCache": "integer",
        "tableOpenCache": "integer",
        "tableOpenCacheInstances": "integer",
        "explicitDefaultsForTimestamp": true,
        "autoIncrementIncrement": "integer",
        "autoIncrementOffset": "integer",
        "syncBinlog": "integer",
        "binlogCacheSize": "integer",
        "binlogGroupCommitSyncDelay": "integer",
        "binlogRowImage": "string",
        "binlogRowsQueryLogEvents": true,
        "rplSemiSyncMasterWaitForSlaveCount": "integer",
        "slaveParallelType": "string",
        "slaveParallelWorkers": "integer",
        "mdbPreserveBinlogBytes": "integer",
        "interactiveTimeout": "integer",
        "waitTimeout": "integer",
        "mdbOfflineModeEnableLag": "integer",
        "mdbOfflineModeDisableLag": "integer",
        "rangeOptimizerMaxMemSize": "integer",
        "slowQueryLog": true,
        "slowQueryLogAlwaysWriteTime": "number",
        "logSlowRateType": "string",
        "logSlowRateLimit": "integer",
        "logSlowSpStatements": true,
        "logSlowFilter": [
          "string"
        ],
        "mdbPriorityChoiceMaxLag": "integer",
        "innodbPageSize": "integer",
        "innodbOnlineAlterLogMaxSize": "integer",
        "innodbFtMinTokenSize": "integer",
        "innodbFtMaxTokenSize": "integer",
        "lowerCaseTableNames": "integer",
        "showCompatibility_56": true,
        "maxSpRecursionDepth": "integer",
        "innodbCompressionLevel": "integer",
        "binlogTransactionDependencyTracking": "string"
      }
    },
    "mysqlConfig_8_0": {
      "effectiveConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string",
        "innodbFlushLogAtTrxCommit": "integer",
        "innodbLockWaitTimeout": "integer",
        "transactionIsolation": "string",
        "innodbPrintAllDeadlocks": true,
        "netReadTimeout": "integer",
        "netWriteTimeout": "integer",
        "groupConcatMaxLen": "integer",
        "tmpTableSize": "integer",
        "maxHeapTableSize": "integer",
        "defaultTimeZone": "string",
        "characterSetServer": "string",
        "collationServer": "string",
        "innodbAdaptiveHashIndex": true,
        "innodbNumaInterleave": true,
        "innodbLogBufferSize": "integer",
        "innodbLogFileSize": "integer",
        "innodbIoCapacity": "integer",
        "innodbIoCapacityMax": "integer",
        "innodbReadIoThreads": "integer",
        "innodbWriteIoThreads": "integer",
        "innodbPurgeThreads": "integer",
        "innodbThreadConcurrency": "integer",
        "innodbTempDataFileMaxSize": "integer",
        "threadCacheSize": "integer",
        "threadStack": "integer",
        "joinBufferSize": "integer",
        "sortBufferSize": "integer",
        "tableDefinitionCache": "integer",
        "tableOpenCache": "integer",
        "tableOpenCacheInstances": "integer",
        "explicitDefaultsForTimestamp": true,
        "autoIncrementIncrement": "integer",
        "autoIncrementOffset": "integer",
        "syncBinlog": "integer",
        "binlogCacheSize": "integer",
        "binlogGroupCommitSyncDelay": "integer",
        "binlogRowImage": "string",
        "binlogRowsQueryLogEvents": true,
        "rplSemiSyncMasterWaitForSlaveCount": "integer",
        "slaveParallelType": "string",
        "slaveParallelWorkers": "integer",
        "regexpTimeLimit": "integer",
        "mdbPreserveBinlogBytes": "integer",
        "interactiveTimeout": "integer",
        "waitTimeout": "integer",
        "mdbOfflineModeEnableLag": "integer",
        "mdbOfflineModeDisableLag": "integer",
        "rangeOptimizerMaxMemSize": "integer",
        "slowQueryLog": true,
        "slowQueryLogAlwaysWriteTime": "number",
        "logSlowRateType": "string",
        "logSlowRateLimit": "integer",
        "logSlowSpStatements": true,
        "logSlowFilter": [
          "string"
        ],
        "mdbPriorityChoiceMaxLag": "integer",
        "innodbPageSize": "integer",
        "innodbOnlineAlterLogMaxSize": "integer",
        "innodbFtMinTokenSize": "integer",
        "innodbFtMaxTokenSize": "integer",
        "lowerCaseTableNames": "integer",
        "maxSpRecursionDepth": "integer",
        "innodbCompressionLevel": "integer",
        "binlogTransactionDependencyTracking": "string"
      },
      "userConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string",
        "innodbFlushLogAtTrxCommit": "integer",
        "innodbLockWaitTimeout": "integer",
        "transactionIsolation": "string",
        "innodbPrintAllDeadlocks": true,
        "netReadTimeout": "integer",
        "netWriteTimeout": "integer",
        "groupConcatMaxLen": "integer",
        "tmpTableSize": "integer",
        "maxHeapTableSize": "integer",
        "defaultTimeZone": "string",
        "characterSetServer": "string",
        "collationServer": "string",
        "innodbAdaptiveHashIndex": true,
        "innodbNumaInterleave": true,
        "innodbLogBufferSize": "integer",
        "innodbLogFileSize": "integer",
        "innodbIoCapacity": "integer",
        "innodbIoCapacityMax": "integer",
        "innodbReadIoThreads": "integer",
        "innodbWriteIoThreads": "integer",
        "innodbPurgeThreads": "integer",
        "innodbThreadConcurrency": "integer",
        "innodbTempDataFileMaxSize": "integer",
        "threadCacheSize": "integer",
        "threadStack": "integer",
        "joinBufferSize": "integer",
        "sortBufferSize": "integer",
        "tableDefinitionCache": "integer",
        "tableOpenCache": "integer",
        "tableOpenCacheInstances": "integer",
        "explicitDefaultsForTimestamp": true,
        "autoIncrementIncrement": "integer",
        "autoIncrementOffset": "integer",
        "syncBinlog": "integer",
        "binlogCacheSize": "integer",
        "binlogGroupCommitSyncDelay": "integer",
        "binlogRowImage": "string",
        "binlogRowsQueryLogEvents": true,
        "rplSemiSyncMasterWaitForSlaveCount": "integer",
        "slaveParallelType": "string",
        "slaveParallelWorkers": "integer",
        "regexpTimeLimit": "integer",
        "mdbPreserveBinlogBytes": "integer",
        "interactiveTimeout": "integer",
        "waitTimeout": "integer",
        "mdbOfflineModeEnableLag": "integer",
        "mdbOfflineModeDisableLag": "integer",
        "rangeOptimizerMaxMemSize": "integer",
        "slowQueryLog": true,
        "slowQueryLogAlwaysWriteTime": "number",
        "logSlowRateType": "string",
        "logSlowRateLimit": "integer",
        "logSlowSpStatements": true,
        "logSlowFilter": [
          "string"
        ],
        "mdbPriorityChoiceMaxLag": "integer",
        "innodbPageSize": "integer",
        "innodbOnlineAlterLogMaxSize": "integer",
        "innodbFtMinTokenSize": "integer",
        "innodbFtMaxTokenSize": "integer",
        "lowerCaseTableNames": "integer",
        "maxSpRecursionDepth": "integer",
        "innodbCompressionLevel": "integer",
        "binlogTransactionDependencyTracking": "string"
      },
      "defaultConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string",
        "innodbFlushLogAtTrxCommit": "integer",
        "innodbLockWaitTimeout": "integer",
        "transactionIsolation": "string",
        "innodbPrintAllDeadlocks": true,
        "netReadTimeout": "integer",
        "netWriteTimeout": "integer",
        "groupConcatMaxLen": "integer",
        "tmpTableSize": "integer",
        "maxHeapTableSize": "integer",
        "defaultTimeZone": "string",
        "characterSetServer": "string",
        "collationServer": "string",
        "innodbAdaptiveHashIndex": true,
        "innodbNumaInterleave": true,
        "innodbLogBufferSize": "integer",
        "innodbLogFileSize": "integer",
        "innodbIoCapacity": "integer",
        "innodbIoCapacityMax": "integer",
        "innodbReadIoThreads": "integer",
        "innodbWriteIoThreads": "integer",
        "innodbPurgeThreads": "integer",
        "innodbThreadConcurrency": "integer",
        "innodbTempDataFileMaxSize": "integer",
        "threadCacheSize": "integer",
        "threadStack": "integer",
        "joinBufferSize": "integer",
        "sortBufferSize": "integer",
        "tableDefinitionCache": "integer",
        "tableOpenCache": "integer",
        "tableOpenCacheInstances": "integer",
        "explicitDefaultsForTimestamp": true,
        "autoIncrementIncrement": "integer",
        "autoIncrementOffset": "integer",
        "syncBinlog": "integer",
        "binlogCacheSize": "integer",
        "binlogGroupCommitSyncDelay": "integer",
        "binlogRowImage": "string",
        "binlogRowsQueryLogEvents": true,
        "rplSemiSyncMasterWaitForSlaveCount": "integer",
        "slaveParallelType": "string",
        "slaveParallelWorkers": "integer",
        "regexpTimeLimit": "integer",
        "mdbPreserveBinlogBytes": "integer",
        "interactiveTimeout": "integer",
        "waitTimeout": "integer",
        "mdbOfflineModeEnableLag": "integer",
        "mdbOfflineModeDisableLag": "integer",
        "rangeOptimizerMaxMemSize": "integer",
        "slowQueryLog": true,
        "slowQueryLogAlwaysWriteTime": "number",
        "logSlowRateType": "string",
        "logSlowRateLimit": "integer",
        "logSlowSpStatements": true,
        "logSlowFilter": [
          "string"
        ],
        "mdbPriorityChoiceMaxLag": "integer",
        "innodbPageSize": "integer",
        "innodbOnlineAlterLogMaxSize": "integer",
        "innodbFtMinTokenSize": "integer",
        "innodbFtMaxTokenSize": "integer",
        "lowerCaseTableNames": "integer",
        "maxSpRecursionDepth": "integer",
        "innodbCompressionLevel": "integer",
        "binlogTransactionDependencyTracking": "string"
      }
    },
    // end of the list of possible fields`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string",
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "string"
  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true,
  "hostGroupIds": [
    "string"
  ]
}
```
An object that represents MySQL cluster.

See [the documentation](/docs/managed-mysql/concepts) for details.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the cluster.</p> <p>This ID is assigned by the platform at the time of creation.</p> 
folderId | **string**<br><p>ID of the folder that the cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp of the cluster.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the cluster.</p> 
description | **string**<br><p>Description of the cluster.</p> 
labels | **object**<br><p>Custom labels for the cluster as ``key:value`` pairs.</p> 
environment | **string**<br><p>Deployment environment of the cluster.</p> <ul> <li>PRODUCTION: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Monitoring systems data that is relevant to the cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the cluster.</p> 
config | **object**<br><p>Configuration of the cluster.</p> 
config.<br>version | **string**<br><p>Version of MySQL used in the cluster.</p> 
config.<br>resources | **object**<br>Resource preset for the cluster hosts.
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.</p> <p>All available presets are listed in <a href="/docs/managed-mysql/concepts/instance-types">the documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage (for each cluster host, in bytes).</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage.</p> <p>Possible values:</p> <ul> <li>``network-hdd`` - standard network storage</li> <li>``network-ssd`` - fast network storage</li> <li>``network-ssd-nonreplicated`` - fast network nonreplicated storage</li> <li>``local-ssd`` - fast local storage.</li> </ul> <p>See <a href="/docs/managed-mysql/concepts/storage">the documentation</a> for details.</p> 
config.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>access | **object**<br>Access policy for external services.
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allows access from DataLens.</p> <p>See <a href="/docs/managed-mysql/operations/datalens-connect">the documentation</a> for details.</p> 
config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allows SQL queries to the cluster databases from management console.</p> <p>See <a href="/docs/managed-mysql/operations/web-sql-query">the documentation</a> for details.</p> 
config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
config.<br>performanceDiagnostics | **object**<br>Configuration of the performance diagnostics service.
config.<br>performanceDiagnostics.<br>enabled | **boolean** (boolean)<br><p>Flag that shows if performance statistics gathering is enabled for the cluster.</p> 
config.<br>performanceDiagnostics.<br>sessionsSamplingInterval | **string** (int64)<br><p>Interval (in seconds) for ``my_session`` sampling.</p> <p>Acceptable values are 1 to 86400, inclusive.</p> 
config.<br>performanceDiagnostics.<br>statementsSamplingInterval | **string** (int64)<br><p>Interval (in seconds) for ``my_statements`` sampling.</p> <p>Acceptable values are 1 to 86400, inclusive.</p> 
config.<br>backupRetainPeriodDays | **integer** (int64)<br><p>Retention policy of automated backups.</p> <p>Acceptable values are 7 to 60, inclusive.</p> 
config.<br>mysqlConfig_5_7 | **object**<br>Configuration of a MySQL 5.7 server. <br>`config` includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`<br>
config.<br>mysqlConfig_5_7.<br>effectiveConfig | **object**<br><p>Effective settings for a MySQL 5.7 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``MysqlConfig5_7`` reflects MySQL 5.7 configuration file.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation</a> for details.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 3600, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin for details.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout for details.</p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len for details.</p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size for details.</p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size for details.</p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>collationServer | **string**<br><p>The server default collation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables InnoDB adaptive hash index.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single InnoDB Redo log file.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size for details.</p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency for details.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path for details.</p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>threadCacheSize | **integer** (int64)<br><p>A number of threads the server should cache for reuse.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation</a> for details.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 50000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>slaveParallelType | **string**<br><p>When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 1099511627776, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag value.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>slowQueryLog | **boolean** (boolean)<br><p>Manages slow query log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>slowQueryLogAlwaysWriteTime | **number** (double)<br><p>Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>logSlowRateType | **string**<br><p>Specifies slow log granularity for ``log_slow_rate_limit`` values QUERY or SESSION.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>logSlowRateLimit | **integer** (int64)<br><p>Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit">Percona documentation</a> for details.</p> <p>Acceptable values are 1 to 1000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>logSlowSpStatements | **boolean** (boolean)<br><p>When TRUE, statements executed by stored procedures are logged to the slow log.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>logSlowFilter[] | **string**<br><p>Filters the slow log by the query's execution plan.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbPriorityChoiceMaxLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbPageSize | **integer** (int64)<br><p>Specifies the page size for InnoDB tablespaces.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 65536, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbOnlineAlterLogMaxSize | **integer** (int64)<br><p>The limit in bytes on the size of the temporary log files used during online DDL operations</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 65536 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbFtMinTokenSize | **integer** (int64)<br><p>Minimum length of words that are stored in an InnoDB FULLTEXT index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbFtMaxTokenSize | **integer** (int64)<br><p>Maximum length of words that are stored in an InnoDB FULLTEXT index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 84, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>lowerCaseTableNames | **integer** (int64)<br><p>Table names storage and comparison strategy</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>showCompatibility_56 | **boolean** (boolean)<br><p>Manages MySQL 5.6 compatibility</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56">MySQL documentation for the variable</a>.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxSpRecursionDepth | **integer** (int64)<br><p>The number of times that any given stored procedure may be called recursively.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 255, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbCompressionLevel | **integer** (int64)<br><p>The level of zlib compression to use for InnoDB compressed tables and indexes.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 9, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogTransactionDependencyTracking | **string**<br><p>Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking">MySQL documentation for the variabl</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig | **object**<br><p>User-defined settings for a MySQL 5.7 cluster.</p> <p>Options and structure of ``MysqlConfig5_7`` reflects MySQL 5.7 configuration file.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation</a> for details.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 3600, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin for details.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout for details.</p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len for details.</p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size for details.</p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size for details.</p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>collationServer | **string**<br><p>The server default collation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables InnoDB adaptive hash index.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single InnoDB Redo log file.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size for details.</p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency for details.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path for details.</p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>threadCacheSize | **integer** (int64)<br><p>A number of threads the server should cache for reuse.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation</a> for details.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 50000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>slaveParallelType | **string**<br><p>When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 1099511627776, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag value.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>slowQueryLog | **boolean** (boolean)<br><p>Manages slow query log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>slowQueryLogAlwaysWriteTime | **number** (double)<br><p>Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>logSlowRateType | **string**<br><p>Specifies slow log granularity for ``log_slow_rate_limit`` values QUERY or SESSION.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>logSlowRateLimit | **integer** (int64)<br><p>Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit">Percona documentation</a> for details.</p> <p>Acceptable values are 1 to 1000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>logSlowSpStatements | **boolean** (boolean)<br><p>When TRUE, statements executed by stored procedures are logged to the slow log.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>logSlowFilter[] | **string**<br><p>Filters the slow log by the query's execution plan.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbPriorityChoiceMaxLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbPageSize | **integer** (int64)<br><p>Specifies the page size for InnoDB tablespaces.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 65536, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbOnlineAlterLogMaxSize | **integer** (int64)<br><p>The limit in bytes on the size of the temporary log files used during online DDL operations</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 65536 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbFtMinTokenSize | **integer** (int64)<br><p>Minimum length of words that are stored in an InnoDB FULLTEXT index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbFtMaxTokenSize | **integer** (int64)<br><p>Maximum length of words that are stored in an InnoDB FULLTEXT index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 84, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>lowerCaseTableNames | **integer** (int64)<br><p>Table names storage and comparison strategy</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>showCompatibility_56 | **boolean** (boolean)<br><p>Manages MySQL 5.6 compatibility</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56">MySQL documentation for the variable</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxSpRecursionDepth | **integer** (int64)<br><p>The number of times that any given stored procedure may be called recursively.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 255, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbCompressionLevel | **integer** (int64)<br><p>The level of zlib compression to use for InnoDB compressed tables and indexes.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 9, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogTransactionDependencyTracking | **string**<br><p>Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking">MySQL documentation for the variabl</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig | **object**<br><p>Default configuration for a MySQL 5.7 cluster.</p> <p>Options and structure of ``MysqlConfig5_7`` reflects MySQL 5.7 configuration file.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation</a> for details.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 3600, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin for details.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout for details.</p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len for details.</p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size for details.</p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size for details.</p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>collationServer | **string**<br><p>The server default collation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables InnoDB adaptive hash index.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single InnoDB Redo log file.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size for details.</p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency for details.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path for details.</p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>threadCacheSize | **integer** (int64)<br><p>A number of threads the server should cache for reuse.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation</a> for details.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 50000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>slaveParallelType | **string**<br><p>When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 1099511627776, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag value.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>See <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>slowQueryLog | **boolean** (boolean)<br><p>Manages slow query log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>slowQueryLogAlwaysWriteTime | **number** (double)<br><p>Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>logSlowRateType | **string**<br><p>Specifies slow log granularity for ``log_slow_rate_limit`` values QUERY or SESSION.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>logSlowRateLimit | **integer** (int64)<br><p>Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit">Percona documentation</a> for details.</p> <p>Acceptable values are 1 to 1000, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>logSlowSpStatements | **boolean** (boolean)<br><p>When TRUE, statements executed by stored procedures are logged to the slow log.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>logSlowFilter[] | **string**<br><p>Filters the slow log by the query's execution plan.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbPriorityChoiceMaxLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbPageSize | **integer** (int64)<br><p>Specifies the page size for InnoDB tablespaces.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 65536, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbOnlineAlterLogMaxSize | **integer** (int64)<br><p>The limit in bytes on the size of the temporary log files used during online DDL operations</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 65536 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbFtMinTokenSize | **integer** (int64)<br><p>Minimum length of words that are stored in an InnoDB FULLTEXT index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbFtMaxTokenSize | **integer** (int64)<br><p>Maximum length of words that are stored in an InnoDB FULLTEXT index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 84, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>lowerCaseTableNames | **integer** (int64)<br><p>Table names storage and comparison strategy</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>showCompatibility_56 | **boolean** (boolean)<br><p>Manages MySQL 5.6 compatibility</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56">MySQL documentation for the variable</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxSpRecursionDepth | **integer** (int64)<br><p>The number of times that any given stored procedure may be called recursively.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 255, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbCompressionLevel | **integer** (int64)<br><p>The level of zlib compression to use for InnoDB compressed tables and indexes.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 9, inclusive.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogTransactionDependencyTracking | **string**<br><p>Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking">MySQL documentation for the variabl</a>.</p> 
config.<br>mysqlConfig_8_0 | **object**<br>Configuration of a MySQL 8.0 server. <br>`config` includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`<br>
config.<br>mysqlConfig_8_0.<br>effectiveConfig | **object**<br><p>Effective settings for a MySQL 8.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``MysqlConfig8_0`` reflects MySQL 8.0 configuration file.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation</a> for details.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin for details.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout for details.</p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len for details.</p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size for details.</p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size for details.</p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>collationServer | **string**<br><p>The server default collation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables InnoDB adaptive hash index.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single InnoDB Redo log file.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size for details.</p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency for details.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path for details.</p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>threadCacheSize | **integer** (int64)<br><p>How many threads the server should cache for reuse.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation</a> for details.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 50000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>slaveParallelType | **string**<br><p>When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>regexpTimeLimit | **integer** (int64)<br><p>The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 1048576, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 1099511627776, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>slowQueryLog | **boolean** (boolean)<br><p>Manages slow query log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>slowQueryLogAlwaysWriteTime | **number** (double)<br><p>Query execution time, after which query to be logged unconditionally, that is, ``log_slow_rate_limit`` will not apply to it.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>logSlowRateType | **string**<br><p>Specifies slow log granularity for ``log_slow_rate_limit`` QUERY or SESSION value.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>logSlowRateLimit | **integer** (int64)<br><p>Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit">Percona documentation</a> for details.</p> <p>Acceptable values are 1 to 1000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>logSlowSpStatements | **boolean** (boolean)<br><p>When TRUE, statements executed by stored procedures are logged to the slow log.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>logSlowFilter[] | **string**<br><p>Filters the slow log by the query's execution plan.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbPriorityChoiceMaxLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbPageSize | **integer** (int64)<br><p>Specifies the page size for InnoDB tablespaces.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 65536, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbOnlineAlterLogMaxSize | **integer** (int64)<br><p>The limit in bytes on the size of the temporary log files used during online DDL operations</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 65536 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbFtMinTokenSize | **integer** (int64)<br><p>Minimum length of words that are stored in an InnoDB FULLTEXT index</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbFtMaxTokenSize | **integer** (int64)<br><p>Maximum length of words that are stored in an InnoDB FULLTEXT index</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 10 to 84, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>lowerCaseTableNames | **integer** (int64)<br><p>Table names storage and comparison strategy</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxSpRecursionDepth | **integer** (int64)<br><p>The number of times that any given stored procedure may be called recursively.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 255, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbCompressionLevel | **integer** (int64)<br><p>The level of zlib compression to use for InnoDB compressed tables and indexes.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 9, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogTransactionDependencyTracking | **string**<br><p>Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking">MySQL documentation for the variabl</a>.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig | **object**<br><p>User-defined settings for a MySQL 8.0 cluster.</p> <p>Options and structure of ``MysqlConfig8_0`` reflects MySQL 8.0 configuration file.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation</a> for details.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin for details.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout for details.</p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len for details.</p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size for details.</p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size for details.</p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>collationServer | **string**<br><p>The server default collation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables InnoDB adaptive hash index.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single InnoDB Redo log file.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size for details.</p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency for details.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path for details.</p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>threadCacheSize | **integer** (int64)<br><p>How many threads the server should cache for reuse.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation</a> for details.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 50000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>slaveParallelType | **string**<br><p>When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>regexpTimeLimit | **integer** (int64)<br><p>The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 1048576, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 1099511627776, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>slowQueryLog | **boolean** (boolean)<br><p>Manages slow query log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>slowQueryLogAlwaysWriteTime | **number** (double)<br><p>Query execution time, after which query to be logged unconditionally, that is, ``log_slow_rate_limit`` will not apply to it.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>logSlowRateType | **string**<br><p>Specifies slow log granularity for ``log_slow_rate_limit`` QUERY or SESSION value.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>logSlowRateLimit | **integer** (int64)<br><p>Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit">Percona documentation</a> for details.</p> <p>Acceptable values are 1 to 1000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>logSlowSpStatements | **boolean** (boolean)<br><p>When TRUE, statements executed by stored procedures are logged to the slow log.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>logSlowFilter[] | **string**<br><p>Filters the slow log by the query's execution plan.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbPriorityChoiceMaxLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbPageSize | **integer** (int64)<br><p>Specifies the page size for InnoDB tablespaces.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 65536, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbOnlineAlterLogMaxSize | **integer** (int64)<br><p>The limit in bytes on the size of the temporary log files used during online DDL operations</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 65536 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbFtMinTokenSize | **integer** (int64)<br><p>Minimum length of words that are stored in an InnoDB FULLTEXT index</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbFtMaxTokenSize | **integer** (int64)<br><p>Maximum length of words that are stored in an InnoDB FULLTEXT index</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 10 to 84, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>lowerCaseTableNames | **integer** (int64)<br><p>Table names storage and comparison strategy</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxSpRecursionDepth | **integer** (int64)<br><p>The number of times that any given stored procedure may be called recursively.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 255, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbCompressionLevel | **integer** (int64)<br><p>The level of zlib compression to use for InnoDB compressed tables and indexes.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 9, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogTransactionDependencyTracking | **string**<br><p>Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking">MySQL documentation for the variabl</a>.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig | **object**<br><p>Default configuration for a MySQL 8.0 cluster.</p> <p>Options and structure of ``MysqlConfig8_0`` reflects MySQL 8.0 configuration file.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation</a> for details.</p> <p>The minimum value is 5242880.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin for details.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout for details.</p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout for details.</p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len for details.</p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size for details.</p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size for details.</p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>collationServer | **string**<br><p>The server default collation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables InnoDB adaptive hash index.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single InnoDB Redo log file.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size for details.</p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max for details.</p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads for details.</p> <p>Acceptable values are 1 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency for details.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace.</p> <p>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path for details.</p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>threadCacheSize | **integer** (int64)<br><p>How many threads the server should cache for reuse.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation</a> for details.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation</a> for details.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 50000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation</a> for details.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>slaveParallelType | **string**<br><p>When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>regexpTimeLimit | **integer** (int64)<br><p>The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit">MySQL documentation</a> for details.</p> <p>Acceptable values are 0 to 1048576, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 1099511627776, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation</a> for details.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation</a> for details.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>slowQueryLog | **boolean** (boolean)<br><p>Manages slow query log.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log">MySQL documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>slowQueryLogAlwaysWriteTime | **number** (double)<br><p>Query execution time, after which query to be logged unconditionally, that is, ``log_slow_rate_limit`` will not apply to it.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>logSlowRateType | **string**<br><p>Specifies slow log granularity for ``log_slow_rate_limit`` QUERY or SESSION value.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>logSlowRateLimit | **integer** (int64)<br><p>Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit">Percona documentation</a> for details.</p> <p>Acceptable values are 1 to 1000, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>logSlowSpStatements | **boolean** (boolean)<br><p>When TRUE, statements executed by stored procedures are logged to the slow log.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>logSlowFilter[] | **string**<br><p>Filters the slow log by the query's execution plan.</p> <p>See <a href="https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter">Percona documentation</a> for details.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbPriorityChoiceMaxLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbPageSize | **integer** (int64)<br><p>Specifies the page size for InnoDB tablespaces.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 65536, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbOnlineAlterLogMaxSize | **integer** (int64)<br><p>The limit in bytes on the size of the temporary log files used during online DDL operations</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 65536 to 107374182400, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbFtMinTokenSize | **integer** (int64)<br><p>Minimum length of words that are stored in an InnoDB FULLTEXT index</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbFtMaxTokenSize | **integer** (int64)<br><p>Maximum length of words that are stored in an InnoDB FULLTEXT index</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 10 to 84, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>lowerCaseTableNames | **integer** (int64)<br><p>Table names storage and comparison strategy</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names">MySQL documentation for the variable</a> for details.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxSpRecursionDepth | **integer** (int64)<br><p>The number of times that any given stored procedure may be called recursively.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 255, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbCompressionLevel | **integer** (int64)<br><p>The level of zlib compression to use for InnoDB compressed tables and indexes.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 9, inclusive.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogTransactionDependencyTracking | **string**<br><p>Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking">MySQL documentation for the variabl</a>.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated health of the cluster.</p> <ul> <li>HEALTH_UNKNOWN: Health of the cluster is unknown (``health`` for every host in the cluster is ``UNKNOWN``).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ``ALIVE``).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is ``DEAD``).</li> <li>DEGRADED: Cluster is degraded (``health`` for at least one host in the cluster is not ``ALIVE``).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster is stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
maintenanceWindow | **object**<br><p>Maintenance window settings for the cluster.</p> <p>Configuration of a maintenance window in a MySQL cluster.</p> 
maintenanceWindow.<br>anytime | **object**<br>Maintenance operation can be scheduled anytime. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Maintenance operation can be scheduled on a weekly basis. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week (in ``DDD`` format).</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC (in ``HH`` format).</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
plannedOperation | **object**<br><p>Planned maintenance operation to be started for the cluster within the nearest <a href="/docs/managed-mysql/api-ref/Cluster#representation">maintenanceWindow</a>.</p> <p>A planned maintenance operation.</p> 
plannedOperation.<br>info | **string**<br><p>Information about this maintenance operation.</p> <p>The maximum string length in characters is 256.</p> 
plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Time until which this maintenance operation is delayed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
securityGroupIds[] | **string**<br><p>Effective list of security group IDs applied to the cluster.</p> 
deletionProtection | **boolean** (boolean)<br><p>This option prevents unintended deletion of the cluster.</p> 
hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 