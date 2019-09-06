---
editable: false
---

# Method restore
Creates a new PostgreSQL cluster using the specified backup.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters:restore
```
 
## Body parameters {#body_params}
 
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
      "dataLens": true
    },

    // `configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`
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
      "timezone": "string"
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
      "vacuumCleanupIndexScaleFactor": "number"
    },
    // end of the list of possible fields`configSpec`

  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "replicationSource": "string",
      "priority": "integer",
      "configSpec": {

        // `hostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`
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
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string"
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
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string"
        },
        // end of the list of possible fields`hostSpecs[].configSpec`

      }
    }
  ],
  "networkId": "string",
  "folderId": "string"
}
```

 
Field | Description
--- | ---
backupId | **string**<br><p>Required. ID of the backup to create a cluster from. To get the backup ID, use a <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
time | **string** (date-time)<br><p>Required. Timestamp of the moment to which the PostgreSQL cluster should be restored.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
timeInclusive | **boolean** (boolean)<br><p>Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the <a href="/docs/managed-postgresql/api-ref/Cluster/restore#body_params">time</a> field instead of just before.</p> <p>Possible values:</p> <ul> <li>false (default) — the restore point refers to the first backup moment before <a href="/docs/managed-postgresql/api-ref/Cluster/restore#body_params">time</a>.</li> <li>true — the restore point refers to the first backup point after <a href="/docs/managed-postgresql/api-ref/Cluster/restore#body_params">time</a>.</li> </ul> 
name | **string**<br><p>Required. Name of the new PostgreSQL cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
description | **string**<br><p>Description of the new PostgreSQL cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the PostgreSQL cluster as <code>key:value</code> pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Deployment environment of the new PostgreSQL cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Configuration for the PostgreSQL cluster to be created.</p> 
configSpec.<br>version | **string**<br><p>Version of PostgreSQL used in the cluster. Possible values:</p> <ul> <li>9.6</li> <li>10</li> <li>11</li> </ul> 
configSpec.<br>poolerConfig | **object**<br>Configuration of the connection pooler.<br>
configSpec.<br>poolerConfig.<br>poolingMode | **string**<br><p>Mode that the connection pooler is working in. See descriptions of all modes in the <a href="https://pgbouncer.github.io/usage">documentation for PgBouncer</a>.</p> <ul> <li>SESSION: Session pooling mode.</li> <li>TRANSACTION: Transaction pooling mode.</li> <li>STATEMENT: Statement pooling mode.</li> </ul> 
configSpec.<br>poolerConfig.<br>poolDiscard | **boolean** (boolean)<br><p>Setting pool_discard in Odyssey; server_reset_query_always in PgBouncer</p> 
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
configSpec.<br>postgresqlConfig_9_6 | **object**<br>Configuration for a PostgreSQL 9.6 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`<br><br><p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
configSpec.<br>postgresqlConfig_9_6.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 600000, inclusive.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
configSpec.<br>postgresqlConfig_10 | **object**<br>Configuration for a PostgreSQL 10 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`<br><br><p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
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
configSpec.<br>postgresqlConfig_10.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 600000, inclusive.</p> 
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
configSpec.<br>postgresqlConfig_11 | **object**<br>Configuration for a PostgreSQL 11 cluster. <br>`configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`<br><br><p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
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
configSpec.<br>postgresqlConfig_11.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 600000, inclusive.</p> 
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
hostSpecs[] | **object**<br><p>Required. Configurations for PostgreSQL hosts that should be created for the cluster that is being created from the backup.</p> <p>Must contain at least one element.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-postgresql/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with assignPublicIp set as needed.</p> <p>Possible values:</p> <ul> <li>false — don't assign a public IP to the host.</li> <li>true — the host should have a public IP address.</li> </ul> 
hostSpecs[].<br>replicationSource | **string**<br><p>name of the host to be used as the replication source (for cascading replication).</p> 
hostSpecs[].<br>priority | **integer** (int64)<br><p>Priority of the host as a replica. A higher value corresponds to higher priority.</p> <p>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed.</p> <p>When a replica becomes the master, its priority is ignored.</p> 
hostSpecs[].<br>configSpec | **object**<br><p>Configuration of a PostgreSQL server for the host.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6 | **object**<br>Configuration for a host with PostgreSQL 9.6 server deployed. <br>`hostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`<br><br><p>Options and structure of <code>PostgresqlHostConfig</code> reflects parameters of a PostgreSQL configuration file. Detailed description is available in <a href="https://www.postgresql.org/docs/9.6/runtime-config.html">PostgreSQL documentation</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
hostSpecs[].<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10 | **object**<br>Configuration for a host with PostgreSQL 10 server deployed. <br>`hostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`<br><br><p>Options and structure of <code>PostgresqlHostConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_10.<br>timezone | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11 | **object**<br>Configuration for a host with PostgreSQL 11 server deployed. <br>`hostSpecs[].configSpec` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`, `postgresqlConfig_11`<br><br><p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>tempBuffers | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>workMem | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>constraintExclusion | **string**<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
hostSpecs[].<br>configSpec.<br>postgresqlConfig_11.<br>timezone | **string**<br>
networkId | **string**<br><p>Required. ID of the network to create the PostgreSQL cluster in.</p> <p>The maximum string length in characters is 50.</p> 
folderId | **string**<br><p>ID of the folder to create the PostgreSQL cluster in.</p> <p>The maximum string length in characters is 50.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 
