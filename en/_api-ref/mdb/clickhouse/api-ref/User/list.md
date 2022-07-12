---
editable: false
---

# Method list
Retrieves the list of ClickHouse User resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-clickhouse/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list ClickHouse users in. To get the cluster ID, use a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.  To get the next page of results, set <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageToken</a> to the <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
        "joinedSubqueryRequiresAlias": true,
        "joinUseNulls": true,
        "transformNullIn": true,
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
users[] | **object**<br><p>List of ClickHouse User resources.</p> 
users[].<br>name | **string**<br><p>Name of the ClickHouse user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the ClickHouse cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.com/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use ``allowDdl`` instead.</p> <ul> <li><strong>0</strong> (default)-no restrictions.</li> <li><strong>1</strong>-only read data queries are allowed.</li> <li><strong>2</strong>-read data and change settings queries are allowed.</li> </ul> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
users[].<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Determines whether DDL queries are allowed (e.g., <strong>CREATE</strong>, <strong>ALTER</strong>, <strong>RENAME</strong>, etc).</p> <p>Default value: <strong>true</strong>.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>insertQuorum | **integer** (int64)<br><p>Enables or disables write quorum for ClickHouse cluster. If the value is less than <strong>2</strong>, then write quorum is disabled, otherwise it is enabled.</p> <p>When used, write quorum guarantees that ClickHouse has written data to the quorum of <strong>insert_quorum</strong> replicas with no errors until the ``insertQuorumTimeout`` expires. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous <strong>INSERT</strong> queries. Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.</p> <p>You can use ``selectSequentialConsistency`` setting to read the data written with write quorum.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>10000</strong>, 10 seconds).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds.</p> <p>If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the ``insertQuorum`` replicas, then ClickHouse will abort the execution of <strong>INSERT</strong> query and return an error. In this case, the client must send the query again to write the data block into the same or another replica.</p> <p>Minimum value: <strong>1000</strong>, 1 second (default: <strong>60000</strong>, 1 minute).</p> <p>The minimum value is 1000.</p> 
users[].<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>Determines the behavior of <strong>SELECT</strong> queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.</p> <p>Default value: <strong>false</strong> (sequential consistency is disabled).</p> 
users[].<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.</p> <p>Minimum value: <strong>1000</strong>, 1 second (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
users[].<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>Enables or disables query forcing to a stale replica in case the actual data is unavailable. If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when doing <strong>SELECT</strong> query from a distributed table that points to replicated tables.</p> <p>Default value: <strong>true</strong> (query forcing is enabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>Wait mode for asynchronous actions in <strong>ALTER</strong> queries on replicated tables:</p> <ul> <li><strong>0</strong>-do not wait for replicas.</li> <li><strong>1</strong>-only wait for own execution (default).</li> <li><strong>2</strong>-wait for all replicas.</li> </ul> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
users[].<br>settings.<br>distributedProductMode | **string**<br><p>Determine the behavior of distributed subqueries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode">ClickHouse documentation</a>.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Allows the use of these types of subqueries.</li> </ul> 
users[].<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Enables of disables memory saving mode when doing distributed aggregation.</p> <p>When ClickHouse works with a distributed query, external aggregation is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.</p> <p>Default value: <strong>false</strong> (memory saving mode is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
users[].<br>settings.<br>skipUnavailableShards | **boolean** (boolean)<br><p>Enables or disables silent skipping of unavailable shards.</p> <p>A shard is considered unavailable if all its replicas are also unavailable.</p> <p>Default value: <strong>false</strong> (silent skipping is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>compile | **boolean** (boolean)<br><p>Enables or disables query compilation. If you execute a lot of structurally identical queries, then enable this setting. As a result, such queries may be executed faster due to use of queries' compiled parts.</p> <p>Use this setting in combination with ``minCountToCompile`` setting.</p> <p>Default value: <strong>false</strong> (compilation is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#compile">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>How many structurally identical queries ClickHouse has to encounter before they are compiled.</p> <p>Minimum value: <strong>0</strong> (default: <strong>3</strong>).</p> <p>For the <strong>0</strong> value compilation is synchronous: a query waits for compilation process to complete prior to continuing execution. It is recommended to set this value only for testing purposes.</p> <p>For all other values, compilation is asynchronous: the compilation process executes in a separate thread. When a compiled part of query is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#min-count-to-compile">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Enables or disables expression compilation. If you execute a lot of queries that contain identical expressions, then enable this setting. As a result, such queries may be executed faster due to use of compiled expressions.</p> <p>Use this setting in combination with ``minCountToCompileExpression`` setting.</p> <p>Default value: <strong>false</strong> (expression compilation is disabled).</p> 
users[].<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>How many identical expressions ClickHouse has to encounter before they are compiled.</p> <p>Minimum value: <strong>0</strong> (default: <strong>3</strong>).</p> <p>For the <strong>0</strong> value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution. It is recommended to set this value only for testing purposes.</p> <p>For all other values, compilation is asynchronous: the compilation process executes in a separate thread. When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>The maximum block size for reading.</p> <p>Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts). The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.</p> <p>This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>65536</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Limits the minimum number of rows in a block to be inserted in a table by <strong>INSERT</strong> query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.</p> <p>Minimal value: <strong>0</strong>, block squashing is disabled (default: <strong>1048576</strong>).</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Limits the minimum number of bytes in a block to be inserted in a table by <strong>INSERT</strong> query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.</p> <p>Minimal value: <strong>0</strong>, block squashing is disabled (default: <strong>268435456</strong>, 256 MB).</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>Allows to form blocks of the specified size (in bytes) when inserting data in a table. This setting has effect only if server is creating such blocks by itself.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1048576</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).</p> <p>By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.</p> <p>If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.</p> <p>Minimal value and default value: <strong>0</strong>, Direct I/O is disabled.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>Determines whether to use the cache of uncompressed blocks, or not. Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed. Enable this setting for the users who instantiates small queries frequently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (uncompressed cache is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Use this setting in combination with ``useUncompressedCache`` setting.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>128x8192</strong>).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Use this setting in combination with ``useUncompressedCache`` setting.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>192x10x1024x1024</strong>).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>20x8192</strong>).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>Limits the number of bytes to be read from a file to enable concurrent read. If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>24x10x1024x1024</strong>).</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br><p>Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the <strong>GROUP BY</strong> operation, should be flushed to disk to limit the RAM comsumption.</p> <p>By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the ``maxMemoryUsage`` setting). For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.</p> <p>Minimal value and default value: <strong>0</strong>, <strong>GROUP BY</strong> in the external memory is disabled.</p> <p>When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the ``maxMemoryUsage`` setting value (by default, the maximum memory usage is limited to ten gigabytes).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory">ClickHouse documentation</a>.</p> <p>See also: the ``distributedAggregationMemoryEfficient`` setting.</p> 
users[].<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br><p>This setting is equivalent of the ``maxBytesBeforeExternalGroupBy`` setting, except for it is for sort operation (<strong>ORDER BY</strong>), not aggregation.</p> 
users[].<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br><p>Sets the threshold of the number of keys, after that the two-level aggregation should be used.</p> <p>Minimal value: <strong>0</strong>, threshold is not set (default: <strong>10000</strong>).</p> 
users[].<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br><p>Sets the threshold of the number of bytes, after that the two-level aggregation should be used.</p> <p>Minimal value: <strong>0</strong>, threshold is not set (default: <strong>100000000</strong>).</p> 
users[].<br>settings.<br>priority | **integer** (int64)<br><p>Sets the priority of a query.</p> <ul> <li><strong>0</strong>-priority is not used.</li> <li><strong>1</strong>-the highest priority.</li> <li>and so on. The higher the number, the lower a query's priority.</li> </ul> <p>This setting should be set up for each query individually.</p> <p>If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.</p> <p>Minimal value and default value: <strong>0</strong>, priority is not used.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxThreads | **integer** (int64)<br><p>Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).</p> <p>This setting applies to threads that perform the same stages of the query processing pipeline in parallel.</p> <p>Minimal value and default value: <strong>0</strong> (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. This setting does not take server's free RAM amount or total RAM amount into account.</p> <p>This limitation is enforced for any user's single query on a single server.</p> <p>Minimal value: <strong>0</strong>, no limitation is set. Value that is set in the ClickHouse default config file: <strong>10737418240</strong> (10 GB).</p> <p>If you use ``maxBytesBeforeExternalGroupBy`` or ``maxBytesBeforeExternalSort`` setting, then it is recommended to set their values twice as low as ``maxMemoryUsage`` setting value.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. This setting does not take server's free RAM amount or total RAM amount into account.</p> <p>This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> 
users[].<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> 
users[].<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>If enabled, query is not executed if the ClickHouse can't use index by date. This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (setting is disabled, query executes even if ClickHouse can't use index by date).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>If enabled, query is not executed if the ClickHouse can't use index by primary key. This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (setting is disabled, query executes even if ClickHouse can't use index by primary key).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>Limits the maximum number of rows that can be read from a table when running a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>readOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while reading the data.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
users[].<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>Limits the maximum number of unique keys received from aggregation function. This setting helps to reduce RAM consumption while doing aggregation.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>groupByOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing aggregation.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> <li><strong>any</strong>-perform approximate <strong>GROUP BY</strong> operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.</li> </ul> 
users[].<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>Limits the maximum number of rows that can be read from a table for sorting. This setting helps to reduce RAM consumption.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. This setting helps to reduce RAM consumption.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>sortOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while sorting.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
users[].<br>settings.<br>maxResultRows | **integer** (int64)<br><p>Limits the number of rows in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>Limits the number of bytes in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>resultOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while forming result.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
users[].<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>Limits the maximum number of different rows when using <strong>DISTINCT</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>Limits the maximum size of a hash table in bytes (uncompressed data) when using <strong>DISTINCT</strong>.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>distinctOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing <strong>DISCTINCT</strong>.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
users[].<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using <strong>GLOBAL IN</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using <strong>GLOBAL IN</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>transferOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing transfers.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
users[].<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>Limits the maximum query execution time in milliseconds. At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>timeoutOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> of execution time.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
users[].<br>settings.<br>maxRowsInSet | **integer** (int64)<br><p>Limit on the number of rows in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInSet | **integer** (int64)<br><p>Limit on the number of bytes in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>setOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxRowsInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in rows.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxBytesInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in bytes.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>joinOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
users[].<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Limits the maximum number of columns that can be read from a table in a single query. If the query requires to read more columns to complete, then it will be aborted.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>262144</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>Limits the maximum depth of query syntax tree.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous depth. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the <strong>SELECT ... WHERE ...</strong> query, containing constraints and conditions, in the most cases. A user can be forced to construct more optimized queries, if this setting is used.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxAstElements | **integer** (int64)<br><p>Limits the maximum size of query syntax tree in number of nodes.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>50000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>500000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>Value must be greater than 0.</p> 
users[].<br>settings.<br>minExecutionSpeed | **integer** (int64)<br><p>Minimal execution speed in rows per second.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>minExecutionSpeedBytes | **integer** (int64)<br><p>Minimal execution speed in bytes per second.</p> <p>The minimum value is 0.</p> 
users[].<br>settings.<br>countDistinctImplementation | **string**<br><p>Aggregate function to use for implementation of count(DISTINCT ...).</p> 
users[].<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>Enables or disables SQL parser if the fast stream parser cannot parse the data.</p> <p>Enable this setting, if the data that you want to insert into a table contains SQL expressions.</p> <p>For example, the stream parser is unable to parse a value that contains <strong>now()</strong> expression; therefore an <strong>INSERT</strong> query for this value will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the <strong>now()</strong> expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.</p> <p>This setting has effect only if you use <a href="https://clickhouse.com/docs/en/interfaces/formats/#data-format-values">Values</a> format when inserting data.</p> <p>Default value: <strong>true</strong> (SQL parser is enabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>Enables or disables replacing omitted input values with default values of the respective columns when performing <strong>INSERT</strong> queries.</p> <p>Default value: <strong>true</strong> (replacing is enabled).</p> 
users[].<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Enables quoting of 64-bit integers in JSON output format.</p> <p>If this setting is enabled, then 64-bit integers (<strong>UInt64</strong> and <strong>Int64</strong>) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted.</p> <p>Default value: <strong>false</strong> (quoting 64-bit integers is disabled).</p> 
users[].<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Enables special floating-point values (<strong>+nan</strong>, <strong>-nan</strong>, <strong>+inf</strong> and <strong>-inf</strong>) in JSON output format.</p> <p>Default value: <strong>false</strong> (special values do not present in output).</p> 
users[].<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br><p>Determines whether to use LowCardinality type in Native format.</p> <ul> <li><strong>true</strong> (default)-yes, use.</li> <li><strong>false</strong>-convert LowCardinality columns to regular columns when doing <strong>SELECT</strong>, and convert regular columns to LowCardinality when doing <strong>INSERT</strong>.</li> </ul> <p>LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables. If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.</p> <p>If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.</p> <p>Official ClickHouse client works with LowCardinality columns out-of-the-box.</p> <p>Default value: <strong>true</strong> (LowCardinality columns are used in Native format).</p> 
users[].<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br><p>Enables returning of empty result when aggregating without keys (with <strong>GROUP BY</strong> operation absent) on empty set (e.g., <strong>SELECT count(*) FROM table WHERE 0</strong>).</p> <ul> <li><strong>true</strong>-ClickHouse will return an empty result for such queries.</li> <li><strong>false</strong> (default)-ClickHouse will return a single-line result consisting of <strong>NULL</strong> values for aggregation functions, in accordance with SQL standard.</li> </ul> 
users[].<br>settings.<br>joinedSubqueryRequiresAlias | **boolean** (boolean)<br>
users[].<br>settings.<br>joinUseNulls | **boolean** (boolean)<br>
users[].<br>settings.<br>transformNullIn | **boolean** (boolean)<br>
users[].<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1000</strong>, 1 second).</p> 
users[].<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1800000</strong>, 1800 seconds, 30 minutes).</p> 
users[].<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1800000</strong>, 1800 seconds, 30 minutes).</p> 
users[].<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>Enables or disables data compression in HTTP responses.</p> <p>By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed. Use this setting to command ClickHouse to compress the result when sending it via HTTP.</p> <p>Enable this setting and add the <strong>Accept-Encoding: <compression method></strong> HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.</p> <p>ClickHouse support the following compression methods: <strong>gzip</strong>, <strong>br</strong> and <strong>deflate</strong>.</p> <p>Default value: <strong>false</strong> (compression is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/interfaces/http/">ClickHouse documentation</a>.</p> 
users[].<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Enables progress notifications using <strong>X-ClickHouse-Progress</strong> HTTP header.</p> <p>Default value: <strong>false</strong> (notifications disabled).</p> 
users[].<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications with <strong>X-ClickHouse-Progress</strong> HTTP header, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>100</strong>).</p> 
users[].<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Adds CORS header in HTTP responses.</p> <p>Default value: <strong>false</strong> (header is not added).</p> 
users[].<br>settings.<br>quotaMode | **string**<br><p>Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.</p> 
users[].<br>quotas[] | **object**<br><p>Set of quotas assigned to the user.</p> 
users[].<br>quotas[].<br>intervalDuration | **integer** (int64)<br><p>Duration of interval for quota in milliseconds. Minimal value is 1 second.</p> <p>The minimum value is 1000.</p> 
users[].<br>quotas[].<br>queries | **integer** (int64)<br><p>The total number of queries. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>errors | **integer** (int64)<br><p>The number of queries that threw exception. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>resultRows | **integer** (int64)<br><p>The total number of rows given as the result.. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>readRows | **integer** (int64)<br><p>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
users[].<br>quotas[].<br>executionTime | **integer** (int64)<br><p>The total query execution time, in milliseconds (wall time). 0 - unlimited.</p> <p>The minimum value is 0.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 