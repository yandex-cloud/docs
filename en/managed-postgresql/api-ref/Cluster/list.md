---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/api-ref/Cluster/list.md
---

# Method list
Retrieves the list of PostgreSQL Cluster resources that belong
to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list PostgreSQL clusters in. To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-postgresql/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-postgresql/api-ref/Cluster/list#query_params">pageToken</a> to the <a href="/docs/managed-postgresql/api-ref/Cluster/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can only use filtering with the <a href="/docs/managed-postgresql/api-ref/Cluster#representation">Cluster.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 1-63 characters long and match the regular expression ``[a-zA-Z0-9_-]+``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
        "backupRetainPeriodDays": "integer",
        "access": {
          "dataLens": true,
          "webSql": true,
          "serverless": true,
          "dataTransfer": true
        },
        "performanceDiagnostics": {
          "enabled": true,
          "sessionsSamplingInterval": "string",
          "statementsSamplingInterval": "string"
        },

        // `clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`
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
            "trackActivityQuerySize": "integer",
            "effectiveIoConcurrency": "integer",
            "effectiveCacheSize": "integer"
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
            "trackActivityQuerySize": "integer",
            "effectiveIoConcurrency": "integer",
            "effectiveCacheSize": "integer"
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
            "trackActivityQuerySize": "integer",
            "effectiveIoConcurrency": "integer",
            "effectiveCacheSize": "integer"
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
            "plantunerFixEmptyTable": true,
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "plantunerFixEmptyTable": true,
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "plantunerFixEmptyTable": true,
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
          }
        },
        "postgresqlConfig_13": {
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
          }
        },
        "postgresqlConfig_13_1C": {
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
          }
        },
        "postgresqlConfig_14": {
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
          }
        },
        "postgresqlConfig_14_1C": {
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
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
            "onlineAnalyzeEnable": true,
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "plantunerFixEmptyTable": true,
            "geqo": true,
            "geqoThreshold": "integer",
            "geqoEffort": "integer",
            "geqoPoolSize": "integer",
            "geqoGenerations": "integer",
            "geqoSelectionBias": "number",
            "geqoSeed": "number"
          }
        },
        "postgresqlConfig_15": {
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "enableGroupByReordering": true
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "enableGroupByReordering": true
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
            "pgHintPlanMessageLevel": "string",
            "hashMemMultiplier": "number",
            "logicalDecodingWorkMem": "integer",
            "maintenanceIoConcurrency": "integer",
            "maxSlotWalKeepSize": "integer",
            "walKeepSize": "integer",
            "enableIncrementalSort": true,
            "autovacuumVacuumInsertThreshold": "integer",
            "autovacuumVacuumInsertScaleFactor": "number",
            "logMinDurationSample": "integer",
            "logStatementSampleRate": "number",
            "logParameterMaxLength": "integer",
            "logParameterMaxLengthOnError": "integer",
            "clientConnectionCheckInterval": "integer",
            "enableAsyncAppend": true,
            "enableGathermerge": true,
            "enableMemoize": true,
            "logRecoveryConflictWaits": true,
            "vacuumFailsafeAge": "integer",
            "vacuumMultixactFailsafeAge": "integer",
            "pgQualstatsEnabled": true,
            "pgQualstatsTrackConstants": true,
            "pgQualstatsMax": "integer",
            "pgQualstatsResolveOids": true,
            "pgQualstatsSampleRate": "number",
            "maxStackDepth": "integer",
            "enableGroupByReordering": true
          }
        },
        // end of the list of possible fields`clusters[].config`

      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "maintenanceWindow": {

        // `clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": {},
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        },
        // end of the list of possible fields`clusters[].maintenanceWindow`

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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>List of PostgreSQL Cluster resources.</p> 
clusters[].<br>id | **string**<br><p>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the PostgreSQL cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the PostgreSQL cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the PostgreSQL cluster as ``key:value`` pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the PostgreSQL cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the PostgreSQL cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the PostgreSQL cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the PostgreSQL cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of PostgreSQL server software.</p> 
clusters[].<br>config.<br>poolerConfig | **object**<br>Configuration of the connection pooler.
clusters[].<br>config.<br>poolerConfig.<br>poolingMode | **string**<br><p>Mode that the connection pooler is working in. See descriptions of all modes in the <a href="https://pgbouncer.github.io/usage">documentation for PgBouncer</a>.</p> <ul> <li>SESSION: Session pooling mode.</li> <li>TRANSACTION: Transaction pooling mode.</li> <li>STATEMENT: Statement pooling mode.</li> </ul> 
clusters[].<br>config.<br>poolerConfig.<br>poolDiscard | **boolean** (boolean)<br><p>Setting ``server_reset_query_always`` parameter in PgBouncer.</p> 
clusters[].<br>config.<br>resources | **object**<br>Resources allocated to PostgreSQL hosts.
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-postgresql/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
clusters[].<br>config.<br>autofailover | **boolean** (boolean)<br><p>Configuration setting which enables/disables autofailover in cluster.</p> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>backupRetainPeriodDays | **integer** (int64)<br><p>Retention policy of automated backups.</p> <p>Acceptable values are 7 to 60, inclusive.</p> 
clusters[].<br>config.<br>access | **object**<br>Access policy to DB
clusters[].<br>config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
clusters[].<br>config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the management console.</p> <p>See <a href="/docs/managed-postgresql/operations/web-sql-query">SQL queries in the management console</a> for more details.</p> 
clusters[].<br>config.<br>access.<br>serverless | **boolean** (boolean)<br><p>Allow access for Serverless</p> 
clusters[].<br>config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
clusters[].<br>config.<br>performanceDiagnostics | **object**<br>Configuration of the performance diagnostics service.
clusters[].<br>config.<br>performanceDiagnostics.<br>enabled | **boolean** (boolean)<br><p>Configuration setting which enables/disables performance diagnostics service in cluster.</p> 
clusters[].<br>config.<br>performanceDiagnostics.<br>sessionsSamplingInterval | **string** (int64)<br><p>Interval (in seconds) for pg_stat_activity sampling</p> <p>Acceptable values are 1 to 86400, inclusive.</p> 
clusters[].<br>config.<br>performanceDiagnostics.<br>statementsSamplingInterval | **string** (int64)<br><p>Interval (in seconds) for pg_stat_statements sampling</p> <p>Acceptable values are 1 to 86400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6 | **object**<br>Configuration of a PostgreSQL 9.6 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 9.6 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 9.6 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 9.6 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C | **object**<br>Configuration of a PostgreSQL 10 1C server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 10 1C cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 10 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 10 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10 | **object**<br>Configuration of a PostgreSQL 10 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 10 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 10 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 10 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11 | **object**<br>Configuration of a PostgreSQL 11 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 11 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 11 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 11 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C | **object**<br>Configuration of a PostgreSQL 11 1C server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 11 1C cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 11 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 11 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12 | **object**<br>Configuration of a PostgreSQL 12 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 12 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 12 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 12 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C | **object**<br>Configuration of a PostgreSQL 12 1C server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 12 1C cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 12 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 12 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13 | **object**<br>Configuration of a PostgreSQL 13 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 13 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 13 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 13 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C | **object**<br>Configuration of a PostgreSQL 13 1C server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 13 1C cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 13 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 13 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>vacuumCleanupIndexScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 10000000000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_13_1C.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14 | **object**<br>Configuration of a PostgreSQL 14 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 14 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 14 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 14 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C | **object**<br>Configuration of a PostgreSQL 14 1C server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 14 1C cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>effectiveConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 14 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>userConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 14 1C cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>onlineAnalyzeEnable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>plantunerFixEmptyTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqo | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqoThreshold | **integer** (int64)<br><p>Acceptable values are 2 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqoEffort | **integer** (int64)<br><p>Acceptable values are 1 to 10, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqoPoolSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqoGenerations | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqoSelectionBias | **number** (double)<br><p>Acceptable values are 1.5 to 2, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_14_1C.<br>defaultConfig.<br>geqoSeed | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15 | **object**<br>Configuration of a PostgreSQL 15 server. <br>`clusters[].config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`, `postgresqlConfig_13`, `postgresqlConfig_13_1C`, `postgresqlConfig_14`, `postgresqlConfig_14_1C`, `postgresqlConfig_15`<br>
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig | **object**<br><p>Effective settings for a PostgreSQL 15 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>effectiveConfig.<br>enableGroupByReordering | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 15 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>userConfig.<br>enableGroupByReordering | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 15 cluster.</p> <p>Options and structure of ``PostgresqlConfig`` reflects PostgreSQL configuration file parameters which detailed description is available in <a href="https://www.postgresql.org/docs/11/runtime-config.html">PostgreSQL documentation</a>.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxConnections | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>tempBuffers | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>workMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>walLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>synchronousCommit | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>minWalSize | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>constraintExclusion | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>forceParallelMode | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>clientMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logMinMessages | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logMinErrorStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logConnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logDuration | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logErrorVerbosity | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logStatement | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logTempFiles | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>searchPath | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>defaultTransactionIsolation | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>statementTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>lockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>byteaOutput | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>xmlbinary | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>xmloption | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>backslashQuote | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>seqPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>randomPageCost | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumMaxWorkers | **integer** (int64)<br><p>Acceptable values are 1 to 32, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumVacuumCostDelay | **integer** (int64)<br><p>Acceptable values are -1 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumVacuumCostLimit | **integer** (int64)<br><p>Acceptable values are -1 to 10000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumNaptime | **integer** (int64)<br><p>Acceptable values are 1000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>archiveTimeout | **integer** (int64)<br><p>Acceptable values are 10000 to 86400000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>trackActivityQuerySize | **integer** (int64)<br><p>Acceptable values are 100 to 102400, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableBitmapscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableHashagg | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableHashjoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableIndexscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableIndexonlyscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableMaterial | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableMergejoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableNestloop | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableSeqscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableTidscan | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxWorkerProcesses | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxParallelWorkers | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Acceptable values are 0 to 1024, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumVacuumScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumAnalyzeScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>defaultTransactionReadOnly | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>timezone | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableParallelAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableParallelHash | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enablePartitionPruning | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enablePartitionwiseAggregate | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enablePartitionwiseJoin | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>jit | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxParallelMaintenanceWorkers | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>parallelLeaderParticipation | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logTransactionSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>planCacheMode | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>effectiveCacheSize | **integer** (int64)<br><p>Acceptable values are 0 to 549755813888, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>sharedPreloadLibraries[] | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogMinDuration | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogAnalyze | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogBuffers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogTiming | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogTriggers | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogVerbose | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainLogNestedStatements | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autoExplainSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgHintPlanEnableHint | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgHintPlanEnableHintTable | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgHintPlanDebugPrint | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgHintPlanMessageLevel | **string**
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>hashMemMultiplier | **number** (double)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logicalDecodingWorkMem | **integer** (int64)<br><p>Acceptable values are 65536 to 1099511627776, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maintenanceIoConcurrency | **integer** (int64)<br><p>Acceptable values are 0 to 1000, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>walKeepSize | **integer** (int64)<br><p>Acceptable values are -1 to 2251799812636672, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableIncrementalSort | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumVacuumInsertThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>autovacuumVacuumInsertScaleFactor | **number** (double)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logMinDurationSample | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logStatementSampleRate | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logParameterMaxLength | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logParameterMaxLengthOnError | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>clientConnectionCheckInterval | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableAsyncAppend | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableGathermerge | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableMemoize | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>logRecoveryConflictWaits | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>vacuumMultixactFailsafeAge | **integer** (int64)<br><p>Acceptable values are -1 to 2147483647, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgQualstatsEnabled | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgQualstatsTrackConstants | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgQualstatsMax | **integer** (int64)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgQualstatsResolveOids | **boolean** (boolean)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>pgQualstatsSampleRate | **number** (double)
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>maxStackDepth | **integer** (int64)<br><p>Acceptable values are 65536 to 134217728, inclusive.</p> 
clusters[].<br>config.<br>postgresqlConfig_15.<br>defaultConfig.<br>enableGroupByReordering | **boolean** (boolean)
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>maintenanceWindow | **object**<br><p>Maintenance window for the cluster.</p> <p>A maintenance window settings.</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object**<br>Maintenance operation can be scheduled anytime. <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Maintenance operation can be scheduled on a weekly basis. <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week (in ``DDD`` format).</p> 
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC (in ``HH`` format).</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Planned maintenance operation to be started for the cluster within the nearest <a href="/docs/managed-postgresql/api-ref/Cluster#representation">maintenanceWindow</a>.</p> <p>A planned maintenance operation.</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>Information about this maintenance operation.</p> <p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Time until which this maintenance operation is delayed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
clusters[].<br>hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-postgresql/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-postgresql/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-postgresql/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-postgresql/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 