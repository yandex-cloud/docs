---
editable: false
---

# Managed Service for ClickHouse Audit Trails Events: RevokeUserPermission

## Event JSON schema {#yandex.cloud.audit.mdb.clickhouse.RevokeUserPermission2-schema}

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
    "userName": "string",
    "user": {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "databaseName": "string"
        }
      ],
      "settings": {
        "readonly": "string",
        "allowDdl": "boolean",
        "allowIntrospectionFunctions": "boolean",
        "connectTimeout": "string",
        "connectTimeoutWithFailover": "string",
        "receiveTimeout": "string",
        "sendTimeout": "string",
        "idleConnectionTimeout": "string",
        "timeoutBeforeCheckingExecutionSpeed": "string",
        "insertQuorum": "string",
        "insertQuorumTimeout": "string",
        "insertQuorumParallel": "boolean",
        "selectSequentialConsistency": "boolean",
        "replicationAlterPartitionsSync": "string",
        "maxReplicaDelayForDistributedQueries": "string",
        "fallbackToStaleReplicasForDistributedQueries": "boolean",
        "distributedProductMode": "string",
        "distributedAggregationMemoryEfficient": "boolean",
        "distributedDdlTaskTimeout": "string",
        "distributedDdlOutputMode": "string",
        "skipUnavailableShards": "boolean",
        "useHedgedRequests": "boolean",
        "hedgedConnectionTimeoutMs": "string",
        "loadBalancing": "string",
        "preferLocalhostReplica": "boolean",
        "compileExpressions": "boolean",
        "minCountToCompileExpression": "string",
        "maxBlockSize": "string",
        "minInsertBlockSizeRows": "string",
        "minInsertBlockSizeBytes": "string",
        "maxInsertBlockSize": "string",
        "maxPartitionsPerInsertBlock": "string",
        "minBytesToUseDirectIo": "string",
        "useUncompressedCache": "boolean",
        "mergeTreeMaxRowsToUseCache": "string",
        "mergeTreeMaxBytesToUseCache": "string",
        "mergeTreeMinRowsForConcurrentRead": "string",
        "mergeTreeMinBytesForConcurrentRead": "string",
        "maxBytesBeforeExternalGroupBy": "string",
        "maxBytesBeforeExternalSort": "string",
        "groupByTwoLevelThreshold": "string",
        "groupByTwoLevelThresholdBytes": "string",
        "deduplicateBlocksInDependentMaterializedViews": "boolean",
        "localFilesystemReadMethod": "string",
        "remoteFilesystemReadMethod": "string",
        "priority": "string",
        "maxThreads": "string",
        "maxInsertThreads": "string",
        "maxMemoryUsage": "string",
        "maxMemoryUsageForUser": "string",
        "memoryOvercommitRatioDenominator": "string",
        "memoryOvercommitRatioDenominatorForUser": "string",
        "memoryUsageOvercommitMaxWaitMicroseconds": "string",
        "maxNetworkBandwidth": "string",
        "maxNetworkBandwidthForUser": "string",
        "maxTemporaryDataOnDiskSizeForQuery": "string",
        "maxTemporaryDataOnDiskSizeForUser": "string",
        "maxConcurrentQueriesForUser": "string",
        "forceIndexByDate": "boolean",
        "forcePrimaryKey": "boolean",
        "maxRowsToRead": "string",
        "maxBytesToRead": "string",
        "readOverflowMode": "string",
        "maxRowsToGroupBy": "string",
        "groupByOverflowMode": "string",
        "maxRowsToSort": "string",
        "maxBytesToSort": "string",
        "sortOverflowMode": "string",
        "maxResultRows": "string",
        "maxResultBytes": "string",
        "resultOverflowMode": "string",
        "maxRowsInDistinct": "string",
        "maxBytesInDistinct": "string",
        "distinctOverflowMode": "string",
        "maxRowsToTransfer": "string",
        "maxBytesToTransfer": "string",
        "transferOverflowMode": "string",
        "maxExecutionTime": "string",
        "timeoutOverflowMode": "string",
        "maxRowsInSet": "string",
        "maxBytesInSet": "string",
        "setOverflowMode": "string",
        "maxRowsInJoin": "string",
        "maxBytesInJoin": "string",
        "joinOverflowMode": "string",
        "maxColumnsToRead": "string",
        "maxTemporaryColumns": "string",
        "maxTemporaryNonConstColumns": "string",
        "maxQuerySize": "string",
        "maxAstDepth": "string",
        "maxAstElements": "string",
        "maxExpandedAstElements": "string",
        "maxParserDepth": "string",
        "minExecutionSpeed": "string",
        "minExecutionSpeedBytes": "string",
        "inputFormatValuesInterpretExpressions": "boolean",
        "inputFormatDefaultsForOmittedFields": "boolean",
        "inputFormatNullAsDefault": "boolean",
        "inputFormatWithNamesUseHeader": "boolean",
        "outputFormatJsonQuote_64bitIntegers": "boolean",
        "outputFormatJsonQuoteDenormals": "boolean",
        "dateTimeInputFormat": "string",
        "dateTimeOutputFormat": "string",
        "lowCardinalityAllowInNativeFormat": "boolean",
        "emptyResultForAggregationByEmptySet": "boolean",
        "formatRegexp": "string",
        "formatRegexpEscapingRule": "string",
        "formatRegexpSkipUnmatched": "boolean",
        "inputFormatParallelParsing": "boolean",
        "inputFormatImportNestedJson": "boolean",
        "formatAvroSchemaRegistryUrl": "string",
        "dataTypeDefaultNullable": "boolean",
        "httpConnectionTimeout": "string",
        "httpReceiveTimeout": "string",
        "httpSendTimeout": "string",
        "enableHttpCompression": "boolean",
        "sendProgressInHttpHeaders": "boolean",
        "httpHeadersProgressInterval": "string",
        "addHttpCorsHeader": "boolean",
        "cancelHttpReadonlyQueriesOnClientClose": "boolean",
        "maxHttpGetRedirects": "string",
        "httpMaxFieldNameSize": "string",
        "httpMaxFieldValueSize": "string",
        "quotaMode": "string",
        "asyncInsert": "boolean",
        "waitForAsyncInsert": "boolean",
        "waitForAsyncInsertTimeout": "string",
        "asyncInsertMaxDataSize": "string",
        "asyncInsertBusyTimeout": "string",
        "asyncInsertUseAdaptiveBusyTimeout": "boolean",
        "logQueryThreads": "boolean",
        "logQueryViews": "boolean",
        "logQueriesProbability": "number",
        "logProcessorsProfiles": "boolean",
        "useQueryCache": "boolean",
        "enableReadsFromQueryCache": "boolean",
        "enableWritesToQueryCache": "boolean",
        "queryCacheMinQueryRuns": "string",
        "queryCacheMinQueryDuration": "string",
        "queryCacheTtl": "string",
        "queryCacheMaxEntries": "string",
        "queryCacheMaxSizeInBytes": "string",
        "queryCacheTag": "string",
        "queryCacheShareBetweenUsers": "boolean",
        "queryCacheNondeterministicFunctionHandling": "string",
        "queryCacheSystemTableHandling": "string",
        "countDistinctImplementation": "string",
        "joinedSubqueryRequiresAlias": "boolean",
        "joinUseNulls": "boolean",
        "transformNullIn": "boolean",
        "insertNullAsDefault": "boolean",
        "joinAlgorithm": [
          "string"
        ],
        "anyJoinDistinctRightTableKeys": "boolean",
        "allowSuspiciousLowCardinalityTypes": "boolean",
        "flattenNested": "boolean",
        "memoryProfilerStep": "string",
        "memoryProfilerSampleProbability": "number",
        "maxFinalThreads": "string",
        "maxReadBufferSize": "string",
        "insertKeeperMaxRetries": "string",
        "doNotMergeAcrossPartitionsSelectFinal": "boolean",
        "ignoreMaterializedViewsWithDroppedTargetTable": "boolean",
        "enableAnalyzer": "boolean",
        "s3UseAdaptiveTimeouts": "boolean",
        "final": "boolean",
        "useHivePartitioning": "boolean",
        "showDataLakeCatalogsInSystemTables": "boolean",
        "compile": "boolean",
        "minCountToCompile": "string",
        "asyncInsertThreads": "string",
        "asyncInsertStaleTimeout": "string"
      },
      "quotas": [
        {
          "intervalDuration": "string",
          "queries": "string",
          "errors": "string",
          "resultRows": "string",
          "readRows": "string",
          "executionTime": "string"
        }
      ],
      "connectionManager": {
        "connectionId": "string"
      }
    },
    "clusterName": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.clickhouse.RevokeUserPermission2}

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
|| details | **[UserEventDetails](#yandex.cloud.audit.mdb.clickhouse.UserEventDetails)** ||
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

## UserEventDetails {#yandex.cloud.audit.mdb.clickhouse.UserEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| userName | **string** ||
|| user | **[User](#yandex.cloud.mdb.clickhouse.v1.User)** ||
|| clusterName | **string** ||
|#

## User {#yandex.cloud.mdb.clickhouse.v1.User}

#|
||Field | Description ||
|| name | **string** ||
|| clusterId | **string** ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission)** ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings)** ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota)** ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.mdb.clickhouse.v1.ConnectionManager)** ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string** ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings}

#|
||Field | Description ||
|| readonly | **string** (int64)

Acceptable values are 0 to 2, inclusive. ||
|| allowDdl | **boolean** ||
|| allowIntrospectionFunctions | **boolean** ||
|| connectTimeout | **string** (int64) ||
|| connectTimeoutWithFailover | **string** (int64) ||
|| receiveTimeout | **string** (int64) ||
|| sendTimeout | **string** (int64) ||
|| idleConnectionTimeout | **string** (int64) ||
|| timeoutBeforeCheckingExecutionSpeed | **string** (int64) ||
|| insertQuorum | **string** (int64)

The minimum value is 0. ||
|| insertQuorumTimeout | **string** (int64) ||
|| insertQuorumParallel | **boolean** ||
|| selectSequentialConsistency | **boolean** ||
|| replicationAlterPartitionsSync | **string** (int64)

Acceptable values are 0 to 2, inclusive. ||
|| maxReplicaDelayForDistributedQueries | **string** (int64) ||
|| fallbackToStaleReplicasForDistributedQueries | **boolean** ||
|| distributedProductMode | **enum** (DistributedProductMode)

- `DISTRIBUTED_PRODUCT_MODE_DENY`
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`
- `DISTRIBUTED_PRODUCT_MODE_ALLOW` ||
|| distributedAggregationMemoryEfficient | **boolean** ||
|| distributedDdlTaskTimeout | **string** (int64) ||
|| distributedDdlOutputMode | **enum** (DistributedDdlOutputMode)

- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE`
- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE` ||
|| skipUnavailableShards | **boolean** ||
|| useHedgedRequests | **boolean** ||
|| hedgedConnectionTimeoutMs | **string** (int64) ||
|| loadBalancing | **enum** (LoadBalancing)

- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| preferLocalhostReplica | **boolean** ||
|| compileExpressions | **boolean** ||
|| minCountToCompileExpression | **string** (int64)

The minimum value is 0. ||
|| maxBlockSize | **string** (int64)

The minimum value is 1. ||
|| minInsertBlockSizeRows | **string** (int64)

The minimum value is 0. ||
|| minInsertBlockSizeBytes | **string** (int64)

The minimum value is 0. ||
|| maxInsertBlockSize | **string** (int64)

The minimum value is 1. ||
|| maxPartitionsPerInsertBlock | **string** (int64)

The minimum value is 0. ||
|| minBytesToUseDirectIo | **string** (int64)

The minimum value is 0. ||
|| useUncompressedCache | **boolean** ||
|| mergeTreeMaxRowsToUseCache | **string** (int64)

The minimum value is 1. ||
|| mergeTreeMaxBytesToUseCache | **string** (int64)

The minimum value is 1. ||
|| mergeTreeMinRowsForConcurrentRead | **string** (int64)

The minimum value is 1. ||
|| mergeTreeMinBytesForConcurrentRead | **string** (int64)

The minimum value is 1. ||
|| maxBytesBeforeExternalGroupBy | **string** (int64)

The minimum value is 0. ||
|| maxBytesBeforeExternalSort | **string** (int64)

The minimum value is 0. ||
|| groupByTwoLevelThreshold | **string** (int64)

The minimum value is 0. ||
|| groupByTwoLevelThresholdBytes | **string** (int64)

The minimum value is 0. ||
|| deduplicateBlocksInDependentMaterializedViews | **boolean** ||
|| localFilesystemReadMethod | **enum** (LocalFilesystemReadMethod)

- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP`
- `LOCAL_FILESYSTEM_READ_METHOD_IO_URING` ||
|| remoteFilesystemReadMethod | **enum** (RemoteFilesystemReadMethod)

- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| priority | **string** (int64)

The minimum value is 0. ||
|| maxThreads | **string** (int64)

The minimum value is 0. ||
|| maxInsertThreads | **string** (int64)

The minimum value is 0. ||
|| maxMemoryUsage | **string** (int64)

The minimum value is 0. ||
|| maxMemoryUsageForUser | **string** (int64)

The minimum value is 0. ||
|| memoryOvercommitRatioDenominator | **string** (int64)

The minimum value is 0. ||
|| memoryOvercommitRatioDenominatorForUser | **string** (int64)

The minimum value is 0. ||
|| memoryUsageOvercommitMaxWaitMicroseconds | **string** (int64)

The minimum value is 0. ||
|| maxNetworkBandwidth | **string** (int64)

The minimum value is 0. ||
|| maxNetworkBandwidthForUser | **string** (int64)

The minimum value is 0. ||
|| maxTemporaryDataOnDiskSizeForQuery | **string** (int64)

The minimum value is 0. ||
|| maxTemporaryDataOnDiskSizeForUser | **string** (int64)

The minimum value is 0. ||
|| maxConcurrentQueriesForUser | **string** (int64) ||
|| forceIndexByDate | **boolean** ||
|| forcePrimaryKey | **boolean** ||
|| maxRowsToRead | **string** (int64)

The minimum value is 0. ||
|| maxBytesToRead | **string** (int64)

The minimum value is 0. ||
|| readOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToGroupBy | **string** (int64)

The minimum value is 0. ||
|| groupByOverflowMode | **enum** (GroupByOverflowMode)

- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| maxRowsToSort | **string** (int64)

The minimum value is 0. ||
|| maxBytesToSort | **string** (int64)

The minimum value is 0. ||
|| sortOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxResultRows | **string** (int64)

The minimum value is 0. ||
|| maxResultBytes | **string** (int64)

The minimum value is 0. ||
|| resultOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInDistinct | **string** (int64)

The minimum value is 0. ||
|| maxBytesInDistinct | **string** (int64)

The minimum value is 0. ||
|| distinctOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToTransfer | **string** (int64)

The minimum value is 0. ||
|| maxBytesToTransfer | **string** (int64)

The minimum value is 0. ||
|| transferOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxExecutionTime | **string** (int64)

The minimum value is 0. ||
|| timeoutOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInSet | **string** (int64)

The minimum value is 0. ||
|| maxBytesInSet | **string** (int64)

The minimum value is 0. ||
|| setOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInJoin | **string** (int64)

The minimum value is 0. ||
|| maxBytesInJoin | **string** (int64)

The minimum value is 0. ||
|| joinOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxColumnsToRead | **string** (int64)

The minimum value is 0. ||
|| maxTemporaryColumns | **string** (int64)

The minimum value is 0. ||
|| maxTemporaryNonConstColumns | **string** (int64)

The minimum value is 0. ||
|| maxQuerySize | **string** (int64)

The minimum value is 1. ||
|| maxAstDepth | **string** (int64)

The minimum value is 1. ||
|| maxAstElements | **string** (int64)

The minimum value is 1. ||
|| maxExpandedAstElements | **string** (int64)

The minimum value is 1. ||
|| maxParserDepth | **string** (int64)

The minimum value is 0. ||
|| minExecutionSpeed | **string** (int64)

The minimum value is 0. ||
|| minExecutionSpeedBytes | **string** (int64)

The minimum value is 0. ||
|| inputFormatValuesInterpretExpressions | **boolean** ||
|| inputFormatDefaultsForOmittedFields | **boolean** ||
|| inputFormatNullAsDefault | **boolean** ||
|| inputFormatWithNamesUseHeader | **boolean** ||
|| outputFormatJsonQuote_64bitIntegers | **boolean** ||
|| outputFormatJsonQuoteDenormals | **boolean** ||
|| dateTimeInputFormat | **enum** (DateTimeInputFormat)

- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| dateTimeOutputFormat | **enum** (DateTimeOutputFormat)

- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| lowCardinalityAllowInNativeFormat | **boolean** ||
|| emptyResultForAggregationByEmptySet | **boolean** ||
|| formatRegexp | **string** ||
|| formatRegexpEscapingRule | **enum** (FormatRegexpEscapingRule)

- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| formatRegexpSkipUnmatched | **boolean** ||
|| inputFormatParallelParsing | **boolean** ||
|| inputFormatImportNestedJson | **boolean** ||
|| formatAvroSchemaRegistryUrl | **string** ||
|| dataTypeDefaultNullable | **boolean** ||
|| httpConnectionTimeout | **string** (int64) ||
|| httpReceiveTimeout | **string** (int64) ||
|| httpSendTimeout | **string** (int64) ||
|| enableHttpCompression | **boolean** ||
|| sendProgressInHttpHeaders | **boolean** ||
|| httpHeadersProgressInterval | **string** (int64) ||
|| addHttpCorsHeader | **boolean** ||
|| cancelHttpReadonlyQueriesOnClientClose | **boolean** ||
|| maxHttpGetRedirects | **string** (int64) ||
|| httpMaxFieldNameSize | **string** (int64) ||
|| httpMaxFieldValueSize | **string** (int64) ||
|| quotaMode | **enum** (QuotaMode)

- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| asyncInsert | **boolean** ||
|| waitForAsyncInsert | **boolean** ||
|| waitForAsyncInsertTimeout | **string** (int64) ||
|| asyncInsertMaxDataSize | **string** (int64) ||
|| asyncInsertBusyTimeout | **string** (int64) ||
|| asyncInsertUseAdaptiveBusyTimeout | **boolean** ||
|| logQueryThreads | **boolean** ||
|| logQueryViews | **boolean** ||
|| logQueriesProbability | **number** (double) ||
|| logProcessorsProfiles | **boolean** ||
|| useQueryCache | **boolean** ||
|| enableReadsFromQueryCache | **boolean** ||
|| enableWritesToQueryCache | **boolean** ||
|| queryCacheMinQueryRuns | **string** (int64)

The minimum value is 0. ||
|| queryCacheMinQueryDuration | **string** (int64) ||
|| queryCacheTtl | **string** (int64) ||
|| queryCacheMaxEntries | **string** (int64) ||
|| queryCacheMaxSizeInBytes | **string** (int64) ||
|| queryCacheTag | **string** ||
|| queryCacheShareBetweenUsers | **boolean** ||
|| queryCacheNondeterministicFunctionHandling | **enum** (QueryCacheNondeterministicFunctionHandling)

- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE` ||
|| queryCacheSystemTableHandling | **enum** (QueryCacheSystemTableHandling)

- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW`
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE`
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE` ||
|| countDistinctImplementation | **enum** (CountDistinctImplementation)

- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| joinedSubqueryRequiresAlias | **boolean** ||
|| joinUseNulls | **boolean** ||
|| transformNullIn | **boolean** ||
|| insertNullAsDefault | **boolean** ||
|| joinAlgorithm[] | **enum** (JoinAlgorithm)

- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| anyJoinDistinctRightTableKeys | **boolean** ||
|| allowSuspiciousLowCardinalityTypes | **boolean** ||
|| flattenNested | **boolean** ||
|| memoryProfilerStep | **string** (int64)

The minimum value is 0. ||
|| memoryProfilerSampleProbability | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|| maxFinalThreads | **string** (int64)

The minimum value is 0. ||
|| maxReadBufferSize | **string** (int64)

The minimum value is 1. ||
|| insertKeeperMaxRetries | **string** (int64)

The minimum value is 0. ||
|| doNotMergeAcrossPartitionsSelectFinal | **boolean** ||
|| ignoreMaterializedViewsWithDroppedTargetTable | **boolean** ||
|| enableAnalyzer | **boolean** ||
|| s3UseAdaptiveTimeouts | **boolean** ||
|| final | **boolean** ||
|| useHivePartitioning | **boolean** ||
|| showDataLakeCatalogsInSystemTables | **boolean** ||
|| compile | **boolean** ||
|| minCountToCompile | **string** (int64) ||
|| asyncInsertThreads | **string** (int64) ||
|| asyncInsertStaleTimeout | **string** (int64) ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota}

#|
||Field | Description ||
|| intervalDuration | **string** (int64)

The minimum value is 1000. ||
|| queries | **string** (int64)

The minimum value is 0. ||
|| errors | **string** (int64)

The minimum value is 0. ||
|| resultRows | **string** (int64)

The minimum value is 0. ||
|| readRows | **string** (int64)

The minimum value is 0. ||
|| executionTime | **string** (int64)

The minimum value is 0. ||
|#

## ConnectionManager {#yandex.cloud.mdb.clickhouse.v1.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string** ||
|#