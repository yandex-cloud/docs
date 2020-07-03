---
editable: false
---

# Method create
Creates a ClickHouse user in the specified cluster.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the ClickHouse cluster to create a user in. To get the cluster ID, use a [list](/docs/managed-clickhouse/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "userSpec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "databaseName": "string"
      }
    ],
    "settings": {
      "readonly": "integer",
      "allowDdl": true,
      "insertQuorum": "integer",
      "connectTimeout": "integer",
      "receiveTimeout": "integer",
      "sendTimeout": "integer",
      "insertQuorumTimeout": "integer",
      "selectSequentialConsistency": true,
      "maxReplicaDelayForDistributedQueries": "integer",
      "fallbackToStaleReplicasForDistributedQueries": true,
      "replicationAlterPartitionsSync": "integer",
      "distributedProductMode": "string",
      "distributedAggregationMemoryEfficient": true,
      "distributedDdlTaskTimeout": "integer",
      "skipUnavailableShards": true,
      "compile": true,
      "minCountToCompile": "integer",
      "compileExpressions": true,
      "minCountToCompileExpression": "integer",
      "maxBlockSize": "integer",
      "minInsertBlockSizeRows": "integer",
      "minInsertBlockSizeBytes": "integer",
      "maxInsertBlockSize": "integer",
      "minBytesToUseDirectIo": "integer",
      "useUncompressedCache": true,
      "mergeTreeMaxRowsToUseCache": "integer",
      "mergeTreeMaxBytesToUseCache": "integer",
      "mergeTreeMinRowsForConcurrentRead": "integer",
      "mergeTreeMinBytesForConcurrentRead": "integer",
      "maxBytesBeforeExternalGroupBy": "integer",
      "maxBytesBeforeExternalSort": "integer",
      "groupByTwoLevelThreshold": "integer",
      "groupByTwoLevelThresholdBytes": "integer",
      "priority": "integer",
      "maxThreads": "integer",
      "maxMemoryUsage": "integer",
      "maxMemoryUsageForUser": "integer",
      "maxNetworkBandwidth": "integer",
      "maxNetworkBandwidthForUser": "integer",
      "forceIndexByDate": true,
      "forcePrimaryKey": true,
      "maxRowsToRead": "integer",
      "maxBytesToRead": "integer",
      "readOverflowMode": "string",
      "maxRowsToGroupBy": "integer",
      "groupByOverflowMode": "string",
      "maxRowsToSort": "integer",
      "maxBytesToSort": "integer",
      "sortOverflowMode": "string",
      "maxResultRows": "integer",
      "maxResultBytes": "integer",
      "resultOverflowMode": "string",
      "maxRowsInDistinct": "integer",
      "maxBytesInDistinct": "integer",
      "distinctOverflowMode": "string",
      "maxRowsToTransfer": "integer",
      "maxBytesToTransfer": "integer",
      "transferOverflowMode": "string",
      "maxExecutionTime": "integer",
      "timeoutOverflowMode": "string",
      "maxColumnsToRead": "integer",
      "maxTemporaryColumns": "integer",
      "maxTemporaryNonConstColumns": "integer",
      "maxQuerySize": "integer",
      "maxAstDepth": "integer",
      "maxAstElements": "integer",
      "maxExpandedAstElements": "integer",
      "inputFormatValuesInterpretExpressions": true,
      "inputFormatDefaultsForOmittedFields": true,
      "outputFormatJsonQuote_64BitIntegers": true,
      "outputFormatJsonQuoteDenormals": true,
      "lowCardinalityAllowInNativeFormat": true,
      "emptyResultForAggregationByEmptySet": true,
      "httpConnectionTimeout": "integer",
      "httpReceiveTimeout": "integer",
      "httpSendTimeout": "integer",
      "enableHttpCompression": true,
      "sendProgressInHttpHeaders": true,
      "httpHeadersProgressInterval": "integer",
      "addHttpCorsHeader": true
    },
    "quotas": [
      {
        "intervalDuration": "integer",
        "queries": "integer",
        "errors": "integer",
        "resultRows": "integer",
        "readRows": "integer",
        "executionTime": "integer"
      }
    ]
  }
}
```

 
Field | Description
--- | ---
userSpec | **object**<br><p>Required. Properties of the user to be created.</p> 
userSpec.<br>name | **string**<br><p>Required. Name of the ClickHouse user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_]*</code>.</p> 
userSpec.<br>password | **string**<br><p>Required. Password of the ClickHouse user.</p> <p>The string length in characters must be 8-128.</p> 
userSpec.<br>permissions[] | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpec.<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
userSpec.<br>settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.yandex/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
userSpec.<br>settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. Possible values: 0 (default) — no restrictions, 1 — only read data queries are allowed, 2 — read data and change settings queries are allowed.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
userSpec.<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Whether DDL queries are allowed. Default value: false.</p> 
userSpec.<br>settings.<br>insertQuorum | **integer** (int64)<br><p>For INSERT queries in the replicated table, wait writing for the specified number of replicas and linearize the addition of the data.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds. Default value: 60000.</p> <p>The minimum value is 1000.</p> 
userSpec.<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>For SELECT queries from the replicated table, throw an exception if the replica does not have a chunk written with the quorum; do not read the parts that have not yet been written with the quorum.</p> 
userSpec.<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used. Default value: 300000.</p> <p>The minimum value is 1000.</p> 
userSpec.<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>Determine the behavior when all replicas for the queried table are stale. If enabled, the query will be performed anyway. Otherwise, the error will be thrown.</p> 
userSpec.<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>Wait mode for ALTER queries on replicated tables. Possible values: 0 - do not wait, 1 - wait for execution only of itself, 2 - wait for everyone.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
userSpec.<br>settings.<br>distributedProductMode | **string**<br><p>Determine the behavior of distributed subqueries. Possible values: DISTRIBUTED_PRODUCT_MODE_DENY, DISTRIBUTED_PRODUCT_MODE_LOCAL, DISTRIBUTED_PRODUCT_MODE_GLOBAL, DISTRIBUTED_PRODUCT_MODE_ALLOW.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Default value. Prohibits using these types of subqueries (returns the &quot;Double-distributed in/JOIN subqueries is denied&quot; exception).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Allows the use of these types of subqueries.</li> </ul> 
userSpec.<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Whether the memory-saving mode of distributed aggregation is enabled.</p> 
userSpec.<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
userSpec.<br>settings.<br>skipUnavailableShards | **boolean** (boolean)<br><p>Whether unavailable shards can be skipped.</p> 
userSpec.<br>settings.<br>compile | **boolean** (boolean)<br><p>Whether query compilation is enabled.</p> 
userSpec.<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>The number of structurally identical queries before they are compiled.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Whether expression compilation is enabled.</p> 
userSpec.<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>The number of identical expressions before they are compiled.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>The maximum block size for reading.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to 0, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough. If set to 0, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>The maximum block size for insertion.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>The minimum number of bytes for reading the data with O_DIRECT option during SELECT queries execution.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>Whether to use the cache of uncompressed blocks.</p> 
userSpec.<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>The minimum number of rows to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>The minimum number of bytes to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br>
userSpec.<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br>
userSpec.<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br>
userSpec.<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br>
userSpec.<br>settings.<br>priority | **integer** (int64)<br><p>Priority of the query.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxThreads | **integer** (int64)<br><p>The maximum number of threads to execute the request.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>The maximum memory usage for processing of a single query.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>The maximum memory usage for processing all concurrently running queries for the user.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for a query.</p> 
userSpec.<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.</p> 
userSpec.<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>Disables query execution if the index can’t be used by date.</p> 
userSpec.<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>Disables query execution if indexing by the primary key is not possible.</p> 
userSpec.<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>The maximum number of rows that can be read from a table when running a query.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>The maximum number of bytes (uncompressed data) that can be read from a table when running a query.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>readOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_read or max_bytes_to_read limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpec.<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>The maximum number of unique keys received from aggregation.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>groupByOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_group_by limit. Possible values: GROUP_BY_OVERFLOW_MODE_THROW, GROUP_BY_OVERFLOW_MODE_BREAK, GROUP_BY_OVERFLOW_MODE_ANY.</p> 
userSpec.<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>The maximum number of rows before sorting.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>The maximum number of bytes before sorting.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>sortOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_sort or max_bytes_to_sort limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpec.<br>settings.<br>maxResultRows | **integer** (int64)<br><p>Limit on the number of rows in the result.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>Limit on the number of bytes in the result.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>resultOverflowMode | **string**<br><p>Determine the behavior on exceeding max_result_rows or max_result_bytes limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpec.<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>The maximum number of different rows when using DISTINCT.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>The maximum number of bytes used by a hash table when using DISTINCT.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>distinctOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_distinct or max_bytes_in_distinct limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpec.<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>The maximum number of rows that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>The maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>transferOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_transfer or max_bytes_to_transfer limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpec.<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>The maximum query execution time in milliseconds.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>timeoutOverflowMode | **string**<br><p>Determine the behavior on exceeding max_execution_time limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpec.<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>The maximum number of columns that can be read from a table in a single query.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.</p> <p>The minimum value is 0.</p> 
userSpec.<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>The maximum part of a query that can be taken to RAM for parsing with the SQL parser, in bytes. Default value: 262144.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>The maximum depth of query syntax tree. Default value: 1000.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>maxAstElements | **integer** (int64)<br><p>The maximum size of query syntax tree in number of nodes. Default value: 50000.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>The maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000.</p> <p>Value must be greater than 0.</p> 
userSpec.<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>Enables or disables the full SQL parser if the fast stream parser cannot parse the data.</p> 
userSpec.<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>When performing INSERT queries, replace omitted input column values with default values of the respective columns.</p> 
userSpec.<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Whether quoting of 64-bit integers is enabled in JSON output format.</p> 
userSpec.<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Whether output of special floating-point values (+nan, -nan, +inf and -inf) is enabled in JSON output format.</p> 
userSpec.<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br><p>Whether LowCardinality type is enabled in Native format.</p> 
userSpec.<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br><p>Return empty result when aggregating without keys on empty set.</p> 
userSpec.<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> 
userSpec.<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> 
userSpec.<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> 
userSpec.<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>Whether data compression is enabled in HTTP responses.</p> 
userSpec.<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: false.</p> 
userSpec.<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications, in milliseconds. Default value: 100.</p> 
userSpec.<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Whether CORS header in HTTP responses is enabled. Default value: false.</p> 
userSpec.<br>quotas[] | **object**<br><p>ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval. See in-depth description <a href="https://clickhouse.yandex/docs/en/operations/quotas/">ClickHouse documentation</a>.</p> 
userSpec.<br>quotas[].<br>intervalDuration | **integer** (int64)<br><p>Duration of interval for quota in milliseconds. Minimal value is 1 second.</p> <p>The minimum value is 1000.</p> 
userSpec.<br>quotas[].<br>queries | **integer** (int64)<br><p>The total number of queries. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpec.<br>quotas[].<br>errors | **integer** (int64)<br><p>The number of queries that threw exception. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpec.<br>quotas[].<br>resultRows | **integer** (int64)<br><p>The total number of rows given as the result.. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpec.<br>quotas[].<br>readRows | **integer** (int64)<br><p>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpec.<br>quotas[].<br>executionTime | **integer** (int64)<br><p>The total query execution time, in milliseconds (wall time). 0 - unlimited.</p> <p>The minimum value is 0.</p> 
 
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