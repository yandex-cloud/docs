---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL cluster.
            To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
            returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for PostgreSQL API, REST: Cluster.ListHosts

Retrieves a list of hosts for the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "role": "string",
      "health": "string",
      "services": [
        {
          "type": "string",
          "health": "string"
        }
      ],
      "subnetId": "string",
      "replicationSource": "string",
      "priority": "string",
      "config": {
        // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`
        "postgresqlConfig_9_6": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "replacementSortTuples": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_10_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "replacementSortTuples": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_10": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "replacementSortTuples": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_11": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_11_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_12": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_12_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_13": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_13_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_14": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_14_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_15": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_15_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_16": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_16_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_17": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_17_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "maxStandbyStreamingDelay": "string",
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
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        }
        // end of the list of possible fields
      },
      "assignPublicIp": "boolean",
      "replicaType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.postgresql.v1.Host)**

List of Host resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest), use the `nextPageToken` as the value
for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.postgresql.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the PostgreSQL host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

ID of the PostgreSQL host. The ID is assigned by MDB at creation time. ||
|| zoneId | **string**

ID of the availability zone where the PostgreSQL host resides. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)**

Resources allocated to the PostgreSQL host. ||
|| role | **enum** (Role)

Role of the host in the cluster. If the field has default value, it is not returned in the response.

- `ROLE_UNKNOWN`: Role of the host in the cluster is unknown. Default value.
- `MASTER`: Host is the master PostgreSQL server in the cluster.
- `REPLICA`: Host is a replica (standby) PostgreSQL server in the cluster. ||
|| health | **enum** (Health)

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions.
- `READONLY`: The host is alive, but in read-only mode. ||
|| services[] | **[Service](#yandex.cloud.mdb.postgresql.v1.Service)**

Services provided by the host. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| replicationSource | **string**

Name of the host to be used as the replication source for cascading replication. ||
|| priority | **string** (int64)

Priority of the host as a replica. Higher value means higher priority.

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| config | **[HostConfig](#yandex.cloud.mdb.postgresql.v1.HostConfig)**

Configuration of a PostgreSQL server for the host. ||
|| assignPublicIp | **boolean**

Flag showing public IP assignment status to this host. ||
|| replicaType | **enum** (ReplicaType)

- `REPLICA_TYPE_UNKNOWN`: Replica type is unknown (we have no data) or it's master
- `ASYNC`
- `SYNC`
- `QUORUM` ||
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

## Service {#yandex.cloud.mdb.postgresql.v1.Service}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.
- `POSTGRESQL`: The host is a PostgreSQL server.
- `POOLER`: The host is a PgBouncer server. ||
|| health | **enum** (Health)

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the server is unknown. Default value.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive.
- `READONLY`: The server is in read-only mode. ||
|#

## HostConfig {#yandex.cloud.mdb.postgresql.v1.HostConfig}

#|
||Field | Description ||
|| postgresqlConfig_9_6 | **[PostgresqlHostConfig9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6)**

Configuration for a host with PostgreSQL 9.6 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_10_1c | **[PostgresqlHostConfig10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C)**

Configuration for a host with PostgreSQL 10 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_10 | **[PostgresqlHostConfig10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10)**

Configuration for a host with PostgreSQL 10 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_11 | **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_11_1c | **[PostgresqlHostConfig11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C)**

Configuration for a host with PostgreSQL 11 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_12 | **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_12_1c | **[PostgresqlHostConfig12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C)**

Configuration for a host with PostgreSQL 12 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_13 | **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_13_1c | **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_14 | **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_14_1c | **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_15 | **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_15_1c | **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_16 | **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_16_1c | **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_17 | **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**

Configuration for a host with PostgreSQL 17 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_17_1c | **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|#

## PostgresqlHostConfig9_6 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6}

Options and structure of `PostgresqlHostConfig` reflects parameters of a PostgreSQL
configuration file. Detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/9.6/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig10_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C}

Options and structure of `PostgresqlHostConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/10/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig10 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10}

Options and structure of `PostgresqlHostConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/10/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig11_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig12_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
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
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#