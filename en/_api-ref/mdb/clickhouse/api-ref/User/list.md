---
editable: false
---

# Method list
Retrieves the list of ClickHouse User resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list ClickHouse users in. To get the cluster ID, use a [list](/docs/managed-clickhouse/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-clickhouse/api-ref/User/list#query_params), the service returns a [nextPageToken](/docs/managed-clickhouse/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token.  To get the next page of results, set [pageToken](/docs/managed-clickhouse/api-ref/User/list#query_params) to the [nextPageToken](/docs/managed-clickhouse/api-ref/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
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
        "maxRowsInSet": "integer",
        "maxBytesInSet": "integer",
        "setOverflowMode": "string",
        "maxRowsInJoin": "integer",
        "maxBytesInJoin": "integer",
        "joinOverflowMode": "string",
        "maxColumnsToRead": "integer",
        "maxTemporaryColumns": "integer",
        "maxTemporaryNonConstColumns": "integer",
        "maxQuerySize": "integer",
        "maxAstDepth": "integer",
        "maxAstElements": "integer",
        "maxExpandedAstElements": "integer",
        "minExecutionSpeed": "integer",
        "minExecutionSpeedBytes": "integer",
        "countDistinctImplementation": "string",
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
        "addHttpCorsHeader": true,
        "quotaMode": "string"
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>A ClickHouse User resource. For more information, see the <a href="/docs/managed-clickhouse/concepts">Developer's guide</a>.</p> 
users[].<br>name | **string**<br><p>Name of the ClickHouse user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the ClickHouse cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.yandex/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. Possible values: 0 (default) — no restrictions, 1 — only read data queries are allowed, 2 — read data and change settings queries are allowed.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
users[].<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Whether DDL queries are allowed. Default value: false.</p> 
users[].<br>settings.<br>insertQuorum | **integer** (int64)<br><p>For INSERT queries in the replicated table, wait writing for the specified number of replicas and linearize the addition of the data.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds. Default value: 60000.</p> <p>The minimum value is 1000.</p> 
users[].<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>For SELECT queries from the replicated table, throw an exception if the replica does not have a chunk written with the quorum; do not read the parts that have not yet been written with the quorum.</p> 
users[].<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used. Default value: 300000.</p> <p>The minimum value is 1000.</p> 
users[].<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>Determine the behavior when all replicas for the queried table are stale. If enabled, the query will be performed anyway. Otherwise, the error will be thrown.</p> 
users[].<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>Wait mode for ALTER queries on replicated tables. Possible values: 0 - do not wait, 1 - wait for execution only of itself, 2 - wait for everyone.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
users[].<br>settings.<br>distributedProductMode | **string**<br><p>Determine the behavior of distributed subqueries. Possible values: DISTRIBUTED_PRODUCT_MODE_DENY, DISTRIBUTED_PRODUCT_MODE_LOCAL, DISTRIBUTED_PRODUCT_MODE_GLOBAL, DISTRIBUTED_PRODUCT_MODE_ALLOW.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Default value. Prohibits using these types of subqueries (returns the &quot;Double-distributed in/JOIN subqueries is denied&quot; exception).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Allows the use of these types of subqueries.</li> </ul> 
users[].<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Whether the memory-saving mode of distributed aggregation is enabled.</p> 
users[].<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
users[].<br>settings.<br>skipUnavailableShards | **boolean** (boolean)<br><p>Whether unavailable shards can be skipped.</p> 
users[].<br>settings.<br>compile | **boolean** (boolean)<br><p>Whether query compilation is enabled.</p> 
users[].<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>The number of structurally identical queries before they are compiled.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Whether expression compilation is enabled.</p> 
users[].<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>The number of identical expressions before they are compiled.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>The maximum block size for reading.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to 0, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough. If set to 0, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>The maximum block size for insertion.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>The minimum number of bytes for reading the data with O_DIRECT option during SELECT queries execution.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>Whether to use the cache of uncompressed blocks.</p> 
users[].<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>The minimum number of rows to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>The minimum number of bytes to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br>
users[].<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br>
users[].<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br>
users[].<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br>
users[].<br>settings.<br>priority | **integer** (int64)<br><p>Priority of the query.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxThreads | **integer** (int64)<br><p>The maximum number of threads to execute the request.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>The maximum memory usage for processing of a single query.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>The maximum memory usage for processing all concurrently running queries for the user.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for a query.</p> 
users[].<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.</p> 
users[].<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>Disables query execution if the index can’t be used by date.</p> 
users[].<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>Disables query execution if indexing by the primary key is not possible.</p> 
users[].<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>The maximum number of rows that can be read from a table when running a query.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>The maximum number of bytes (uncompressed data) that can be read from a table when running a query.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>readOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_read or max_bytes_to_read limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>The maximum number of unique keys received from aggregation.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>groupByOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_group_by limit. Possible values: GROUP_BY_OVERFLOW_MODE_THROW, GROUP_BY_OVERFLOW_MODE_BREAK, GROUP_BY_OVERFLOW_MODE_ANY.</p> 
users[].<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>The maximum number of rows before sorting.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>The maximum number of bytes before sorting.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>sortOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_sort or max_bytes_to_sort limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxResultRows | **integer** (int64)<br><p>Limit on the number of rows in the result.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>Limit on the number of bytes in the result.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>resultOverflowMode | **string**<br><p>Determine the behavior on exceeding max_result_rows or max_result_bytes limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>The maximum number of different rows when using DISTINCT.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>The maximum number of bytes used by a hash table when using DISTINCT.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>distinctOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_distinct or max_bytes_in_distinct limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>The maximum number of rows that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>The maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>transferOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_transfer or max_bytes_to_transfer limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>The maximum query execution time in milliseconds.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>timeoutOverflowMode | **string**<br><p>Determine the behavior on exceeding max_execution_time limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxRowsInSet | **integer** (int64)<br><p>Limit on the number of rows in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInSet | **integer** (int64)<br><p>Limit on the number of bytes in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>setOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxRowsInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in rows.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in bytes.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>joinOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>The maximum number of columns that can be read from a table in a single query.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>The maximum part of a query that can be taken to RAM for parsing with the SQL parser, in bytes. Default value: 262144.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>The maximum depth of query syntax tree. Default value: 1000.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxAstElements | **integer** (int64)<br><p>The maximum size of query syntax tree in number of nodes. Default value: 50000.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>The maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minExecutionSpeed | **integer** (int64)<br><p>Minimal execution speed in rows per second.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>minExecutionSpeedBytes | **integer** (int64)<br><p>Minimal execution speed in bytes per second.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>countDistinctImplementation | **string**<br><p>Aggregate function to use for implementation of count(DISTINCT ...).</p> 
users[].<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>Enables or disables the full SQL parser if the fast stream parser cannot parse the data.</p> 
users[].<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>When performing INSERT queries, replace omitted input column values with default values of the respective columns.</p> 
users[].<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Whether quoting of 64-bit integers is enabled in JSON output format.</p> 
users[].<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Whether output of special floating-point values (+nan, -nan, +inf and -inf) is enabled in JSON output format.</p> 
users[].<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br><p>Whether LowCardinality type is enabled in Native format.</p> 
users[].<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br><p>Return empty result when aggregating without keys on empty set.</p> 
users[].<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> 
users[].<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> 
users[].<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> 
users[].<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>Whether data compression is enabled in HTTP responses.</p> 
users[].<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: false.</p> 
users[].<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications, in milliseconds. Default value: 100.</p> 
users[].<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Whether CORS header in HTTP responses is enabled. Default value: false.</p> 
users[].<br>settings.<br>quotaMode | **string**<br><p>Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.</p> 
users[].<br>quotas[] | **object**<br><p>ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval. See in-depth description <a href="https://clickhouse.yandex/docs/en/operations/quotas/">ClickHouse documentation</a>.</p> 
users[].<br>quotas[].<br>intervalDuration | **integer** (int64)<br><p>Duration of interval for quota in milliseconds. Minimal value is 1 second.</p> <p>The minimum value is 1000.</p> 
users[].<br>quotas[].<br>queries | **integer** (int64)<br><p>The total number of queries. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>errors | **integer** (int64)<br><p>The number of queries that threw exception. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>resultRows | **integer** (int64)<br><p>The total number of rows given as the result.. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>readRows | **integer** (int64)<br><p>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>executionTime | **integer** (int64)<br><p>The total query execution time, in milliseconds (wall time). 0 - unlimited.</p> <p>The minimum value is 0.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 