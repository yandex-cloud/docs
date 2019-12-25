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
          "databaseName": "string",
          "dataFilters": [
            {
              "tableName": "string",
              "filter": "string"
            }
          ]
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
users[].<br>permissions[].<br>dataFilters[] | **object**<br>
users[].<br>permissions[].<br>dataFilters[].<br>tableName | **string**<br>
users[].<br>permissions[].<br>dataFilters[].<br>filter | **string**<br>
users[].<br>settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.yandex/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. Possible values:</p> <ul> <li>0 (default) —  no restrictions.</li> <li>1 — only read data queries are allowed.</li> <li>2 — read data and change settings queries are allowed. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_readonly">ClickHouse documentation</a>.</li> </ul> <p>Acceptable values are 0 to 2, inclusive.</p> 
users[].<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Whether DDL queries are allowed. Default value: <code>false</code>. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_allow_ddl">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>insertQuorum | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds. Default value: 60000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum_timeout">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
users[].<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-select_sequential_consistency">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used. Default value: 300000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
users[].<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/query_language/alter/#synchronicity-of-alter-queries">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
users[].<br>settings.<br>distributedProductMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#distributed-product-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Whether the memory-saving mode of distributed aggregation is enabled.</p> 
users[].<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
users[].<br>settings.<br>compile | **boolean** (boolean)<br><p>Whether query compilation is enabled. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#compile">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>The number of structurally identical queries before they are compiled. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#min-count-to-compile">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Whether expression compilation is enabled.</p> 
users[].<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>The number of identical expressions before they are compiled.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#max-block-size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to <code>0</code>, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough.  If set to <code>0</code>, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_insert_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-min_bytes_to_use_direct_io">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-use_uncompressed_cache">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_max_rows_to_use_cache">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>The minimum number of rows to be read from a file to enable concurrent read. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_min_rows_for_concurrent_read">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>The minimum number of bytes to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br>
users[].<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br>
users[].<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br>
users[].<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br>
users[].<br>settings.<br>priority | **integer** (int64)<br><p>Priority of the query.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxThreads | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_threads">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#settings_max_memory_usage">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-memory-usage-for-user">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth_for_user">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-force_index_by_date">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#force-primary-key">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>readOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#read-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-group-by">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>groupByOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#group-by-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-sort">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-sort">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>sortOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#sort-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxResultRows | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-rows">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-bytes">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>resultOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#result-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-in-distinct">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-in-distinct">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>distinctOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#distinct-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-transfer">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-transfer">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>transferOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#transfer-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>Maximum query execution time in milliseconds. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-execution-time">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>timeoutOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#timeout-overflow-mode">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Maximum number of columns that can be read from a table in a single query. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-columns-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-columns">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-non-const-columns">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>The maximum part of a query that can be taken to RAM for parsing with the SQL parser, in bytes. Default value: 262144. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_query_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>Maximum depth of query syntax tree. Default value: 1000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-ast-depth">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxAstElements | **integer** (int64)<br><p>Maximum size of query syntax tree in number of nodes. Default value: 50000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-ast-elements">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Whether quoting of 64-bit integers is enabled in JSON output format. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-output_format_json_quote_64bit_integers">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Whether output of special floating-point values (<code>+nan</code>, <code>-nan</code>, <code>+inf</code> and <code>-inf</code>) is enabled in JSON output format.</p> 
users[].<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br>
users[].<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br>
users[].<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> 
users[].<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> 
users[].<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> 
users[].<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-enable_http_compression">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: <code>false</code>. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-send_progress_in_http_headers">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications, in milliseconds. Default value: 100.</p> 
users[].<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Whether CORS header in HTTP responses is enabled. Default value: <code>false</code>.</p> 
users[].<br>quotas[] | **object**<br><p>ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval. See in-depth description <a href="https://clickhouse.yandex/docs/en/operations/quotas/">ClickHouse documentation</a>.</p> 
users[].<br>quotas[].<br>intervalDuration | **integer** (int64)<br><p>Duration of interval for quota in milliseconds. Minimal value is 1 minute.</p> <p>The minimum value is 60000.</p> 
users[].<br>quotas[].<br>queries | **integer** (int64)<br><p>The total number of queries. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>errors | **integer** (int64)<br><p>The number of queries that threw exception. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>resultRows | **integer** (int64)<br><p>The total number of rows given as the result.. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>readRows | **integer** (int64)<br><p>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>executionTime | **integer** (int64)<br><p>The total query execution time, in milliseconds (wall time). 0 - unlimited.</p> <p>The minimum value is 0.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 