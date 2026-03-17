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
            The maximum string length in characters is 50.
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
            results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
            that can be used to get the next page of results in subsequent list requests.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
            returned by the previous list request.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
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
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests.

The maximum value is 1000. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
returned by the previous list request.

The maximum string length in characters is 100. ||
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
        // Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
        },
        "postgresqlConfig_18": {
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
        },
        "postgresqlConfig_18_1c": {
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
|| postgresqlConfig_11 | **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_12 | **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_13 | **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_13_1c | **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_14 | **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_14_1c | **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_15 | **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_15_1c | **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_16 | **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_16_1c | **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_17 | **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**

Configuration for a host with PostgreSQL 17 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_17_1c | **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_18 | **[PostgresqlHostConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18)**

Configuration for a host with PostgreSQL 18 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresqlConfig_18_1c | **[PostgresqlHostConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C)**

Configuration for a host with PostgreSQL 18 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.

Configuration of a PostgreSQL server for the host. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_ON`: Force parallel mode for all queries that can be executed safely in parallel.
- `FORCE_PARALLEL_MODE_OFF`: Enable parallel mode only if it is expected to increase performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Equivalent to on, but generates output identical to the off state. ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`: Force parallel query for all queries for which it is thought to be safe
- `DEBUG_PARALLEL_QUERY_OFF`: Use parallel mode only when it is expected to improve performance
- `DEBUG_PARALLEL_QUERY_REGRESS`: Like ON, but with additional changes for regression testing (suppresses context lines, hides Gather nodes in EXPLAIN) ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`: Force parallel query for all queries for which it is thought to be safe
- `DEBUG_PARALLEL_QUERY_OFF`: Use parallel mode only when it is expected to improve performance
- `DEBUG_PARALLEL_QUERY_REGRESS`: Like ON, but with additional changes for regression testing (suppresses context lines, hides Gather nodes in EXPLAIN) ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`: Force parallel query for all queries for which it is thought to be safe
- `DEBUG_PARALLEL_QUERY_OFF`: Use parallel mode only when it is expected to improve performance
- `DEBUG_PARALLEL_QUERY_REGRESS`: Like ON, but with additional changes for regression testing (suppresses context lines, hides Gather nodes in EXPLAIN) ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`: Force parallel query for all queries for which it is thought to be safe
- `DEBUG_PARALLEL_QUERY_OFF`: Use parallel mode only when it is expected to improve performance
- `DEBUG_PARALLEL_QUERY_REGRESS`: Like ON, but with additional changes for regression testing (suppresses context lines, hides Gather nodes in EXPLAIN) ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`: Force parallel query for all queries for which it is thought to be safe
- `DEBUG_PARALLEL_QUERY_OFF`: Use parallel mode only when it is expected to improve performance
- `DEBUG_PARALLEL_QUERY_REGRESS`: Like ON, but with additional changes for regression testing (suppresses context lines, hides Gather nodes in EXPLAIN) ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

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
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_ON`: Force parallel query for all queries for which it is thought to be safe
- `DEBUG_PARALLEL_QUERY_OFF`: Use parallel mode only when it is expected to improve performance
- `DEBUG_PARALLEL_QUERY_REGRESS`: Like ON, but with additional changes for regression testing (suppresses context lines, hides Gather nodes in EXPLAIN) ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_DEBUG5`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG4`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG3`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG2`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_DEBUG1`: Provides successively-more-detailed information for use by developers.
- `LOG_LEVEL_INFO`: Provides information implicitly requested by the user, e.g., output from VACUUM VERBOSE.
- `LOG_LEVEL_LOG`: Reports information of interest to administrators, e.g., checkpoint activity.
- `LOG_LEVEL_NOTICE`: Provides information that might be helpful to users, e.g., notice of truncation of long identifiers.
- `LOG_LEVEL_WARNING`: Provides warnings of likely problems, e.g., COMMIT outside a transaction block.
- `LOG_LEVEL_ERROR`: Reports an error that caused the current command to abort.
- `LOG_LEVEL_FATAL`: Reports an error that caused the current session to abort.
- `LOG_LEVEL_PANIC`: Reports an error that caused all database sessions to abort. ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_BASE64`: Base64 encoding.
- `XML_BINARY_HEX`: Hexadecimal encoding. ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_DOCUMENT`: XML document.
- `XML_OPTION_CONTENT`: XML fragment. ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE`: Quotation mark can be represented as \' (same as on).
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
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
|| maxParallelWorkers | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Acceptable values are 0 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

in milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#