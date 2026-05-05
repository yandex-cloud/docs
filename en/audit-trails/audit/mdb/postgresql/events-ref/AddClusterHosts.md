---
editable: false
---

# Managed Service for PostgreSQL Audit Trails Events: AddClusterHosts

## Event JSON schema {#yandex.cloud.audit.mdb.postgresql.AddClusterHosts2-schema}

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
    "hostNames": [
      "string"
    ],
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
        "replicaType": "string",
        "internalIpv4": [
          "string"
        ]
      }
    ],
    "clusterName": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.postgresql.AddClusterHosts2}

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
|| details | **[HostsEventDetails](#yandex.cloud.audit.mdb.postgresql.HostsEventDetails)** ||
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

## HostsEventDetails {#yandex.cloud.audit.mdb.postgresql.HostsEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| hostNames[] | **string**

The number of elements must be greater than 0. ||
|| hosts[] | **[HostDetails](#yandex.cloud.audit.mdb.postgresql.HostDetails)** ||
|| clusterName | **string** ||
|#

## HostDetails {#yandex.cloud.audit.mdb.postgresql.HostDetails}

#|
||Field | Description ||
|| name | **string** ||
|| clusterId | **string** ||
|| zoneId | **string** ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)** ||
|| role | **enum** (Role)

- `ROLE_UNKNOWN`
- `MASTER`
- `REPLICA` ||
|| services[] | **[Service](#yandex.cloud.mdb.postgresql.v1.Service)** ||
|| subnetId | **string** ||
|| replicationSource | **string** ||
|| priority | **string** (int64) ||
|| config | **[HostConfig](#yandex.cloud.mdb.postgresql.v1.HostConfig)** ||
|| assignPublicIp | **boolean** ||
|| replicaType | **enum** (ReplicaType)

- `REPLICA_TYPE_UNKNOWN`
- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| internalIpv4[] | **string** ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## Service {#yandex.cloud.mdb.postgresql.v1.Service}

#|
||Field | Description ||
|| type | **enum** (Type)

- `POSTGRESQL`
- `POOLER` ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `READONLY` ||
|#

## HostConfig {#yandex.cloud.mdb.postgresql.v1.HostConfig}

#|
||Field | Description ||
|| postgresqlConfig_11 | **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_12 | **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13 | **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13_1c | **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14 | **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14_1c | **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15 | **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15_1c | **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16 | **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16_1c | **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17 | **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17_1c | **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18 | **[PostgresqlHostConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18_1c | **[PostgresqlHostConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C)**

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|#

## PostgresqlHostConfig11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C}

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64) ||
|| sharedBuffers | **string** (int64) ||
|| tempBuffers | **string** (int64) ||
|| workMem | **string** (int64) ||
|| tempFileLimit | **string** (int64) ||
|| backendFlushAfter | **string** (int64)

Acceptable values are 0 to 2048, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64) ||
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

Acceptable values are 0 to 2147483647, inclusive. ||
|#