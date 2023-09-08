---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/User/index.md
---

# Managed Service for ClickHouse API, REST: User methods
A set of methods for managing ClickHouse User resources.
NOTE: these methods are available only if user management through SQL is disabled.
## JSON Representation {#representation}
```json 
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
    "allowIntrospectionFunctions": true,
    "connectTimeout": "integer",
    "connectTimeoutWithFailover": "integer",
    "receiveTimeout": "integer",
    "sendTimeout": "integer",
    "timeoutBeforeCheckingExecutionSpeed": "integer",
    "insertQuorum": "integer",
    "insertQuorumTimeout": "integer",
    "insertQuorumParallel": true,
    "insertNullAsDefault": true,
    "selectSequentialConsistency": true,
    "deduplicateBlocksInDependentMaterializedViews": true,
    "replicationAlterPartitionsSync": "integer",
    "maxReplicaDelayForDistributedQueries": "integer",
    "fallbackToStaleReplicasForDistributedQueries": true,
    "distributedProductMode": "string",
    "distributedAggregationMemoryEfficient": true,
    "distributedDdlTaskTimeout": "integer",
    "skipUnavailableShards": true,
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
    "maxPartitionsPerInsertBlock": "integer",
    "maxConcurrentQueriesForUser": "integer",
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
    "joinAlgorithm": [
      "string"
    ],
    "anyJoinDistinctRightTableKeys": true,
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
    "inputFormatNullAsDefault": true,
    "dateTimeInputFormat": "string",
    "inputFormatWithNamesUseHeader": true,
    "outputFormatJsonQuote_64BitIntegers": true,
    "outputFormatJsonQuoteDenormals": true,
    "dateTimeOutputFormat": "string",
    "lowCardinalityAllowInNativeFormat": true,
    "allowSuspiciousLowCardinalityTypes": true,
    "emptyResultForAggregationByEmptySet": true,
    "httpConnectionTimeout": "integer",
    "httpReceiveTimeout": "integer",
    "httpSendTimeout": "integer",
    "enableHttpCompression": true,
    "sendProgressInHttpHeaders": true,
    "httpHeadersProgressInterval": "integer",
    "addHttpCorsHeader": true,
    "cancelHttpReadonlyQueriesOnClientClose": true,
    "maxHttpGetRedirects": "integer",
    "joinedSubqueryRequiresAlias": true,
    "joinUseNulls": true,
    "transformNullIn": true,
    "quotaMode": "string",
    "flattenNested": true,
    "formatRegexp": "string",
    "formatRegexpEscapingRule": "string",
    "formatRegexpSkipUnmatched": true,
    "asyncInsert": true,
    "asyncInsertThreads": "integer",
    "waitForAsyncInsert": true,
    "waitForAsyncInsertTimeout": "integer",
    "asyncInsertMaxDataSize": "integer",
    "asyncInsertBusyTimeout": "integer",
    "asyncInsertStaleTimeout": "integer",
    "memoryProfilerStep": "integer",
    "memoryProfilerSampleProbability": "number",
    "maxFinalThreads": "integer",
    "inputFormatParallelParsing": true,
    "inputFormatImportNestedJson": true,
    "localFilesystemReadMethod": "string",
    "maxReadBufferSize": "integer",
    "insertKeeperMaxRetries": "integer",
    "maxTemporaryDataOnDiskSizeForUser": "integer",
    "maxTemporaryDataOnDiskSizeForQuery": "integer",
    "maxParserDepth": "integer",
    "remoteFilesystemReadMethod": "string",
    "memoryOvercommitRatioDenominator": "integer",
    "memoryOvercommitRatioDenominatorForUser": "integer",
    "memoryUsageOvercommitMaxWaitMicroseconds": "integer",
    "compile": true,
    "minCountToCompile": "integer"
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
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the ClickHouse user.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.com/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use ``allowDdl`` instead.</p> <ul> <li><strong>0</strong> (default)-no restrictions.</li> <li><strong>1</strong>-only read data queries are allowed.</li> <li><strong>2</strong>-read data and change settings queries are allowed.</li> </ul> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
settings.<br>allowDdl | **boolean** (boolean)<br><p>Determines whether DDL queries are allowed (e.g., <strong>CREATE</strong>, <strong>ALTER</strong>, <strong>RENAME</strong>, etc).</p> <p>Default value: <strong>true</strong>.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl">ClickHouse documentation</a>.</p> 
settings.<br>allowIntrospectionFunctions | **boolean** (boolean)<br><p>Enables <a href="https://clickhouse.com/docs/en/sql-reference/functions/introspection">introspections functions</a> for query profiling.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions">ClickHouse documentation</a>.</p> 
settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>10000</strong>, 10 seconds).</p> <p>Value must be greater than 0.</p> 
settings.<br>connectTimeoutWithFailover | **integer** (int64)<br><p>The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.</p> <p>Default value: <strong>50</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>Value must be greater than 0.</p> 
settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>Value must be greater than 0.</p> 
settings.<br>timeoutBeforeCheckingExecutionSpeed | **integer** (int64)<br><p>Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in ``minExecutionSpeed`` parameter.</p> <p>Default value: <strong>10</strong>.</p> 
settings.<br>insertQuorum | **integer** (int64)<br><p>Enables or disables write quorum for ClickHouse cluster. If the value is less than <strong>2</strong>, then write quorum is disabled, otherwise it is enabled.</p> <p>When used, write quorum guarantees that ClickHouse has written data to the quorum of <strong>insert_quorum</strong> replicas with no errors until the ``insertQuorumTimeout`` expires. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous <strong>INSERT</strong> queries. Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.</p> <p>You can use ``selectSequentialConsistency`` setting to read the data written with write quorum.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds.</p> <p>If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the ``insertQuorum`` replicas, then ClickHouse will abort the execution of <strong>INSERT</strong> query and return an error. In this case, the client must send the query again to write the data block into the same or another replica.</p> <p>Minimum value: <strong>1000</strong>, 1 second (default: <strong>60000</strong>, 1 minute).</p> <p>The minimum value is 1000.</p> 
settings.<br>insertQuorumParallel | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel">ClickHouse documentation</a>.</p> 
settings.<br>insertNullAsDefault | **boolean** (boolean)<br><p>Enables the insertion of default values instead of NULL into columns with not nullable data type.</p> <p>Default value: <strong>true</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default">ClickHouse documentation</a>.</p> 
settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>Determines the behavior of <strong>SELECT</strong> queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.</p> <p>Default value: <strong>false</strong> (sequential consistency is disabled).</p> 
settings.<br>deduplicateBlocksInDependentMaterializedViews | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views">ClickHouse documentation</a>.</p> 
settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>Wait mode for asynchronous actions in <strong>ALTER</strong> queries on replicated tables:</p> <ul> <li><strong>0</strong>-do not wait for replicas.</li> <li><strong>1</strong>-only wait for own execution (default).</li> <li><strong>2</strong>-wait for all replicas.</li> </ul> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.</p> <p>Minimum value: <strong>1000</strong>, 1 second (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>Enables or disables query forcing to a stale replica in case the actual data is unavailable. If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when doing <strong>SELECT</strong> query from a distributed table that points to replicated tables.</p> <p>Default value: <strong>true</strong> (query forcing is enabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">ClickHouse documentation</a>.</p> 
settings.<br>distributedProductMode | **string**<br><p>Determine the behavior of distributed subqueries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode">ClickHouse documentation</a>.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Allows the use of these types of subqueries.</li> </ul> 
settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Enables of disables memory saving mode when doing distributed aggregation.</p> <p>When ClickHouse works with a distributed query, external aggregation is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.</p> <p>Default value: <strong>false</strong> (memory saving mode is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory">ClickHouse documentation</a>.</p> 
settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
settings.<br>skipUnavailableShards | **boolean** (boolean)<br><p>Enables or disables silent skipping of unavailable shards.</p> <p>A shard is considered unavailable if all its replicas are also unavailable.</p> <p>Default value: <strong>false</strong> (silent skipping is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards">ClickHouse documentation</a>.</p> 
settings.<br>compileExpressions | **boolean** (boolean)<br><p>Enables or disables expression compilation. If you execute a lot of queries that contain identical expressions, then enable this setting. As a result, such queries may be executed faster due to use of compiled expressions.</p> <p>Use this setting in combination with ``minCountToCompileExpression`` setting.</p> <p>Default value: <strong>false</strong> (expression compilation is disabled).</p> 
settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>How many identical expressions ClickHouse has to encounter before they are compiled.</p> <p>Minimum value: <strong>0</strong> (default: <strong>3</strong>).</p> <p>For the <strong>0</strong> value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution. It is recommended to set this value only for testing purposes.</p> <p>For all other values, compilation is asynchronous: the compilation process executes in a separate thread. When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBlockSize | **integer** (int64)<br><p>The maximum block size for reading.</p> <p>Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts). The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.</p> <p>This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>65536</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Limits the minimum number of rows in a block to be inserted in a table by <strong>INSERT</strong> query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.</p> <p>Minimal value: <strong>0</strong>, block squashing is disabled (default: <strong>1048576</strong>).</p> <p>The minimum value is 0.</p> 
settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Limits the minimum number of bytes in a block to be inserted in a table by <strong>INSERT</strong> query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.</p> <p>Minimal value: <strong>0</strong>, block squashing is disabled (default: <strong>268435456</strong>, 256 MB).</p> <p>The minimum value is 0.</p> 
settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>Allows to form blocks of the specified size (in bytes) when inserting data in a table. This setting has effect only if server is creating such blocks by itself.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1048576</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).</p> <p>By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.</p> <p>If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.</p> <p>Minimal value and default value: <strong>0</strong>, Direct I/O is disabled.</p> <p>The minimum value is 0.</p> 
settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>Determines whether to use the cache of uncompressed blocks, or not. Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed. Enable this setting for the users who instantiates small queries frequently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (uncompressed cache is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache">ClickHouse documentation</a>.</p> 
settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Use this setting in combination with ``useUncompressedCache`` setting.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>128x8192</strong>).</p> <p>Value must be greater than 0.</p> 
settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Use this setting in combination with ``useUncompressedCache`` setting.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>192x10x1024x1024</strong>).</p> <p>Value must be greater than 0.</p> 
settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>20x8192</strong>).</p> <p>Value must be greater than 0.</p> 
settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>Limits the number of bytes to be read from a file to enable concurrent read. If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>24x10x1024x1024</strong>).</p> <p>Value must be greater than 0.</p> 
settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br><p>Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the <strong>GROUP BY</strong> operation, should be flushed to disk to limit the RAM comsumption.</p> <p>By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the ``maxMemoryUsage`` setting). For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.</p> <p>Minimal value and default value: <strong>0</strong>, <strong>GROUP BY</strong> in the external memory is disabled.</p> <p>When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the ``maxMemoryUsage`` setting value (by default, the maximum memory usage is limited to ten gigabytes).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory">ClickHouse documentation</a>.</p> <p>See also: the ``distributedAggregationMemoryEfficient`` setting.</p> 
settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br><p>This setting is equivalent of the ``maxBytesBeforeExternalGroupBy`` setting, except for it is for sort operation (<strong>ORDER BY</strong>), not aggregation.</p> 
settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br><p>Sets the threshold of the number of keys, after that the two-level aggregation should be used.</p> <p>Minimal value: <strong>0</strong>, threshold is not set (default: <strong>10000</strong>).</p> 
settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br><p>Sets the threshold of the number of bytes, after that the two-level aggregation should be used.</p> <p>Minimal value: <strong>0</strong>, threshold is not set (default: <strong>100000000</strong>).</p> 
settings.<br>priority | **integer** (int64)<br><p>Sets the priority of a query.</p> <ul> <li><strong>0</strong>-priority is not used.</li> <li><strong>1</strong>-the highest priority.</li> <li>and so on. The higher the number, the lower a query's priority.</li> </ul> <p>This setting should be set up for each query individually.</p> <p>If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.</p> <p>Minimal value and default value: <strong>0</strong>, priority is not used.</p> <p>The minimum value is 0.</p> 
settings.<br>maxThreads | **integer** (int64)<br><p>Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).</p> <p>This setting applies to threads that perform the same stages of the query processing pipeline in parallel.</p> <p>Minimal value and default value: <strong>0</strong> (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxMemoryUsage | **integer** (int64)<br><p>Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. This setting does not take server's free RAM amount or total RAM amount into account.</p> <p>This limitation is enforced for any user's single query on a single server.</p> <p>Minimal value: <strong>0</strong>, no limitation is set. Value that is set in the ClickHouse default config file: <strong>10737418240</strong> (10 GB).</p> <p>If you use ``maxBytesBeforeExternalGroupBy`` or ``maxBytesBeforeExternalSort`` setting, then it is recommended to set their values twice as low as ``maxMemoryUsage`` setting value.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. This setting does not take server's free RAM amount or total RAM amount into account.</p> <p>This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> 
settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> 
settings.<br>maxPartitionsPerInsertBlock | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block">ClickHouse documentation</a>.</p> 
settings.<br>maxConcurrentQueriesForUser | **integer** (int64)<br><p>The maximum number of concurrent requests per user. Default value: 0 (no limit).</p> 
settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>If enabled, query is not executed if the ClickHouse can't use index by date. This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (setting is disabled, query executes even if ClickHouse can't use index by date).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date">ClickHouse documentation</a>.</p> 
settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>If enabled, query is not executed if the ClickHouse can't use index by primary key. This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (setting is disabled, query executes even if ClickHouse can't use index by primary key).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key">ClickHouse documentation</a>.</p> 
settings.<br>maxRowsToRead | **integer** (int64)<br><p>Limits the maximum number of rows that can be read from a table when running a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesToRead | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>readOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while reading the data.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>Limits the maximum number of unique keys received from aggregation function. This setting helps to reduce RAM consumption while doing aggregation.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>groupByOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing aggregation.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> <li><strong>any</strong>-perform approximate <strong>GROUP BY</strong> operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.</li> </ul> 
settings.<br>maxRowsToSort | **integer** (int64)<br><p>Limits the maximum number of rows that can be read from a table for sorting. This setting helps to reduce RAM consumption.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesToSort | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. This setting helps to reduce RAM consumption.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>sortOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while sorting.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
settings.<br>maxResultRows | **integer** (int64)<br><p>Limits the number of rows in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxResultBytes | **integer** (int64)<br><p>Limits the number of bytes in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>resultOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while forming result.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>Limits the maximum number of different rows when using <strong>DISTINCT</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>Limits the maximum size of a hash table in bytes (uncompressed data) when using <strong>DISTINCT</strong>.</p> <p>The minimum value is 0.</p> 
settings.<br>distinctOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing <strong>DISCTINCT</strong>.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using <strong>GLOBAL IN</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using <strong>GLOBAL IN</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>transferOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing transfers.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
settings.<br>maxExecutionTime | **integer** (int64)<br><p>Limits the maximum query execution time in milliseconds. At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>timeoutOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> of execution time.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
settings.<br>maxRowsInSet | **integer** (int64)<br><p>Limit on the number of rows in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesInSet | **integer** (int64)<br><p>Limit on the number of bytes in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
settings.<br>setOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
settings.<br>maxRowsInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in rows.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in bytes.</p> <p>The minimum value is 0.</p> 
settings.<br>joinOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
settings.<br>joinAlgorithm[] | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm">ClickHouse documentation</a>.</p> 
settings.<br>anyJoinDistinctRightTableKeys | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys">ClickHouse documentation</a>.</p> 
settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Limits the maximum number of columns that can be read from a table in a single query. If the query requires to read more columns to complete, then it will be aborted.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
settings.<br>maxQuerySize | **integer** (int64)<br><p>Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>262144</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxAstDepth | **integer** (int64)<br><p>Limits the maximum depth of query syntax tree.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous depth. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the <strong>SELECT ... WHERE ...</strong> query, containing constraints and conditions, in the most cases. A user can be forced to construct more optimized queries, if this setting is used.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxAstElements | **integer** (int64)<br><p>Limits the maximum size of query syntax tree in number of nodes.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>50000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>500000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>Value must be greater than 0.</p> 
settings.<br>minExecutionSpeed | **integer** (int64)<br><p>Minimal execution speed in rows per second.</p> <p>The minimum value is 0.</p> 
settings.<br>minExecutionSpeedBytes | **integer** (int64)<br><p>Minimal execution speed in bytes per second.</p> <p>The minimum value is 0.</p> 
settings.<br>countDistinctImplementation | **string**<br><p>Aggregate function to use for implementation of count(DISTINCT ...).</p> 
settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>Enables or disables SQL parser if the fast stream parser cannot parse the data.</p> <p>Enable this setting, if the data that you want to insert into a table contains SQL expressions.</p> <p>For example, the stream parser is unable to parse a value that contains <strong>now()</strong> expression; therefore an <strong>INSERT</strong> query for this value will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the <strong>now()</strong> expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.</p> <p>This setting has effect only if you use <a href="https://clickhouse.com/docs/en/interfaces/formats/#data-format-values">Values</a> format when inserting data.</p> <p>Default value: <strong>true</strong> (SQL parser is enabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions">ClickHouse documentation</a>.</p> 
settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>Enables or disables replacing omitted input values with default values of the respective columns when performing <strong>INSERT</strong> queries.</p> <p>Default value: <strong>true</strong> (replacing is enabled).</p> 
settings.<br>inputFormatNullAsDefault | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default">ClickHouse documentation</a>.</p> 
settings.<br>dateTimeInputFormat | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format">ClickHouse documentation</a>.</p> 
settings.<br>inputFormatWithNamesUseHeader | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header">ClickHouse documentation</a>.</p> 
settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Enables quoting of 64-bit integers in JSON output format.</p> <p>If this setting is enabled, then 64-bit integers (<strong>UInt64</strong> and <strong>Int64</strong>) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted.</p> <p>Default value: <strong>false</strong> (quoting 64-bit integers is disabled).</p> 
settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Enables special floating-point values (<strong>+nan</strong>, <strong>-nan</strong>, <strong>+inf</strong> and <strong>-inf</strong>) in JSON output format.</p> <p>Default value: <strong>false</strong> (special values do not present in output).</p> 
settings.<br>dateTimeOutputFormat | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format">ClickHouse documentation</a>.</p> 
settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br><p>Determines whether to use LowCardinality type in Native format.</p> <ul> <li><strong>true</strong> (default)-yes, use.</li> <li><strong>false</strong>-convert LowCardinality columns to regular columns when doing <strong>SELECT</strong>, and convert regular columns to LowCardinality when doing <strong>INSERT</strong>.</li> </ul> <p>LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables. If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.</p> <p>If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.</p> <p>Official ClickHouse client works with LowCardinality columns out-of-the-box.</p> <p>Default value: <strong>true</strong> (LowCardinality columns are used in Native format).</p> 
settings.<br>allowSuspiciousLowCardinalityTypes | **boolean** (boolean)<br><p>Allows specifying <strong>LowCardinality</strong> modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types">ClickHouse documentation</a>.</p> 
settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br><p>Enables returning of empty result when aggregating without keys (with <strong>GROUP BY</strong> operation absent) on empty set (e.g., <strong>SELECT count(*) FROM table WHERE 0</strong>).</p> <ul> <li><strong>true</strong>-ClickHouse will return an empty result for such queries.</li> <li><strong>false</strong> (default)-ClickHouse will return a single-line result consisting of <strong>NULL</strong> values for aggregation functions, in accordance with SQL standard.</li> </ul> 
settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1000</strong>, 1 second).</p> 
settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1800000</strong>, 1800 seconds, 30 minutes).</p> 
settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1800000</strong>, 1800 seconds, 30 minutes).</p> 
settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>Enables or disables data compression in HTTP responses.</p> <p>By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed. Use this setting to command ClickHouse to compress the result when sending it via HTTP.</p> <p>Enable this setting and add the <strong>Accept-Encoding: <compression method></strong> HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.</p> <p>ClickHouse support the following compression methods: <strong>gzip</strong>, <strong>br</strong> and <strong>deflate</strong>.</p> <p>Default value: <strong>false</strong> (compression is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/interfaces/http/">ClickHouse documentation</a>.</p> 
settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Enables progress notifications using <strong>X-ClickHouse-Progress</strong> HTTP header.</p> <p>Default value: <strong>false</strong> (notifications disabled).</p> 
settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications with <strong>X-ClickHouse-Progress</strong> HTTP header, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>100</strong>).</p> 
settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Adds CORS header in HTTP responses.</p> <p>Default value: <strong>false</strong> (header is not added).</p> 
settings.<br>cancelHttpReadonlyQueriesOnClientClose | **boolean** (boolean)<br><p>Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.</p> <p>Default value: <strong>false</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close">ClickHouse documentation</a>.</p> 
settings.<br>maxHttpGetRedirects | **integer** (int64)<br><p>Limits the maximum number of HTTP GET redirect hops for <a href="https://clickhouse.com/docs/en/engines/table-engines/special/url">URL-engine</a> tables.</p> <p>If the parameter is set to <strong>0</strong> (default), no hops is allowed.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects">ClickHouse documentation</a>.</p> 
settings.<br>joinedSubqueryRequiresAlias | **boolean** (boolean)
settings.<br>joinUseNulls | **boolean** (boolean)
settings.<br>transformNullIn | **boolean** (boolean)
settings.<br>quotaMode | **string**<br><p>Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.</p> 
settings.<br>flattenNested | **boolean** (boolean)<br><p>Sets the data format of a <a href="https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested">nested</a> columns.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested">ClickHouse documentation</a>.</p> 
settings.<br>formatRegexp | **string**<br><p>Regular expression (for Regexp format)</p> 
settings.<br>formatRegexpEscapingRule | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule">ClickHouse documentation</a>.</p> 
settings.<br>formatRegexpSkipUnmatched | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched">ClickHouse documentation</a>.</p> 
settings.<br>asyncInsert | **boolean** (boolean)<br><p>Enables asynchronous inserts.</p> <p>Disabled by default.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert">ClickHouse documentation</a>.</p> 
settings.<br>asyncInsertThreads | **integer** (int64)<br><p>The maximum number of threads for background data parsing and insertion.</p> <p>If the parameter is set to <strong>0</strong>, asynchronous insertions are disabled. Default value: <strong>16</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads">ClickHouse documentation</a>.</p> 
settings.<br>waitForAsyncInsert | **boolean** (boolean)<br><p>Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert">ClickHouse documentation</a>.</p> 
settings.<br>waitForAsyncInsertTimeout | **integer** (int64)<br><p>The timeout (in seconds) for waiting for processing of asynchronous insertion.</p> <p>Default value: <strong>120</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout">ClickHouse documentation</a>.</p> 
settings.<br>asyncInsertMaxDataSize | **integer** (int64)<br><p>The maximum size of the unparsed data in bytes collected per query before being inserted.</p> <p>If the parameter is set to <strong>0</strong>, asynchronous insertions are disabled. Default value: <strong>100000</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size">ClickHouse documentation</a>.</p> 
settings.<br>asyncInsertBusyTimeout | **integer** (int64)<br><p>The maximum timeout in milliseconds since the first INSERT query before inserting collected data.</p> <p>If the parameter is set to <strong>0</strong>, the timeout is disabled. Default value: <strong>200</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms">ClickHouse documentation</a>.</p> 
settings.<br>asyncInsertStaleTimeout | **integer** (int64)<br><p>The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the ``asyncInsertBusyTimeout`` with every INSERT query as long as ``asyncInsertMaxDataSize`` is not exceeded.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-stale-timeout-ms">ClickHouse documentation</a>.</p> 
settings.<br>memoryProfilerStep | **integer** (int64)<br><p>Memory profiler step (in bytes).</p> <p>If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.</p> <p>Default value: <strong>4194304</strong> (4 MB). Zero means disabled memory profiler.</p> 
settings.<br>memoryProfilerSampleProbability | **number** (double)<br><p>Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.</p> <p>Possible values: from <strong>0</strong> to <strong>1</strong>. Default: <strong>0</strong>.</p> 
settings.<br>maxFinalThreads | **integer** (int64)<br><p>Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>inputFormatParallelParsing | **boolean** (boolean)<br><p>Enables or disables order-preserving parallel parsing of data formats. Supported only for <a href="https://clickhouse.com/docs/en/interfaces/formats#tabseparated">TSV</a>, <a href="https://clickhouse.com/docs/en/interfaces/formats#tskv">TKSV</a>, <a href="https://clickhouse.com/docs/en/interfaces/formats#csv">CSV</a> and <a href="https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow">JSONEachRow</a> formats. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing">ClickHouse documentation</a></p> 
settings.<br>inputFormatImportNestedJson | **boolean** (boolean)<br><p>Enables or disables the insertion of JSON data with nested objects. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing">ClickHouse documentation</a></p> 
settings.<br>localFilesystemReadMethod | **string**<br><p>Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes.</p> 
settings.<br>maxReadBufferSize | **integer** (int64)<br><p>The maximum size of the buffer to read from the filesystem. See in-depth description in <a href="https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
settings.<br>insertKeeperMaxRetries | **integer** (int64)<br><p>The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries. Default: 20 from 23.2, 0(disabled) before Min_version: 22.11 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>maxTemporaryDataOnDiskSizeForUser | **integer** (int64)<br><p>The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited. Default: 0 - unlimited Min_version: 22.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>maxTemporaryDataOnDiskSizeForQuery | **integer** (int64)<br><p>The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited. Default: 0 - unlimited Min_version: 22.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>maxParserDepth | **integer** (int64)<br><p>Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. Default: 1000 Special: 0 - unlimited See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#max_parser_depth">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>remoteFilesystemReadMethod | **string**<br><p>Method of reading data from remote filesystem, one of: read, threadpool. Default: read Min_version: 21.11 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L660">ClickHouse GitHub</a></p> 
settings.<br>memoryOvercommitRatioDenominator | **integer** (int64)<br><p>It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query. Default: 1GiB Min_version: 22.5 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>memoryOvercommitRatioDenominatorForUser | **integer** (int64)<br><p>It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query. Default: 1GiB Min_version: 22.5 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>memoryUsageOvercommitMaxWaitMicroseconds | **integer** (int64)<br><p>Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown. Default: 5000000 Min_version: 22.5 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
settings.<br>compile | **boolean** (boolean)<br><p>The setting is deprecated and has no effect.</p> 
settings.<br>minCountToCompile | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
quotas[] | **object**<br><p>Set of quotas assigned to the user.</p> 
quotas[].<br>intervalDuration | **integer** (int64)<br><p>Duration of interval for quota in milliseconds. Minimal value is 1 second.</p> <p>The minimum value is 1000.</p> 
quotas[].<br>queries | **integer** (int64)<br><p>The total number of queries. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
quotas[].<br>errors | **integer** (int64)<br><p>The number of queries that threw exception. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
quotas[].<br>resultRows | **integer** (int64)<br><p>The total number of rows given as the result.. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
quotas[].<br>readRows | **integer** (int64)<br><p>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
quotas[].<br>executionTime | **integer** (int64)<br><p>The total query execution time, in milliseconds (wall time). 0 - unlimited.</p> <p>The minimum value is 0.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a ClickHouse user in the specified cluster.
[delete](delete.md) | Deletes the specified ClickHouse user.
[get](get.md) | Returns the specified ClickHouse User resource.
[grantPermission](grantPermission.md) | Grants a permission to the specified ClickHouse user.
[list](list.md) | Retrieves the list of ClickHouse User resources in the specified cluster.
[revokePermission](revokePermission.md) | Revokes a permission from the specified ClickHouse user.
[update](update.md) | Updates the specified ClickHouse user.