---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/User/create.md
---

# Managed Service for ClickHouse API, REST: User.Create

Creates a ClickHouse user in the specified cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.CreateUserRequest}

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
      "readonly": "string",
      "allowDdl": "boolean",
      "allowIntrospectionFunctions": "boolean",
      "connectTimeout": "string",
      "connectTimeoutWithFailover": "string",
      "receiveTimeout": "string",
      "sendTimeout": "string",
      "timeoutBeforeCheckingExecutionSpeed": "string",
      "insertQuorum": "string",
      "insertQuorumTimeout": "string",
      "insertQuorumParallel": "boolean",
      "insertNullAsDefault": "boolean",
      "selectSequentialConsistency": "boolean",
      "deduplicateBlocksInDependentMaterializedViews": "boolean",
      "replicationAlterPartitionsSync": "string",
      "maxReplicaDelayForDistributedQueries": "string",
      "fallbackToStaleReplicasForDistributedQueries": "boolean",
      "distributedProductMode": "string",
      "distributedAggregationMemoryEfficient": "boolean",
      "distributedDdlTaskTimeout": "string",
      "skipUnavailableShards": "boolean",
      "compileExpressions": "boolean",
      "minCountToCompileExpression": "string",
      "maxBlockSize": "string",
      "minInsertBlockSizeRows": "string",
      "minInsertBlockSizeBytes": "string",
      "maxInsertBlockSize": "string",
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
      "priority": "string",
      "maxThreads": "string",
      "maxMemoryUsage": "string",
      "maxMemoryUsageForUser": "string",
      "maxNetworkBandwidth": "string",
      "maxNetworkBandwidthForUser": "string",
      "maxPartitionsPerInsertBlock": "string",
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
      "joinAlgorithm": [
        "string"
      ],
      "anyJoinDistinctRightTableKeys": "boolean",
      "maxColumnsToRead": "string",
      "maxTemporaryColumns": "string",
      "maxTemporaryNonConstColumns": "string",
      "maxQuerySize": "string",
      "maxAstDepth": "string",
      "maxAstElements": "string",
      "maxExpandedAstElements": "string",
      "minExecutionSpeed": "string",
      "minExecutionSpeedBytes": "string",
      "countDistinctImplementation": "string",
      "inputFormatValuesInterpretExpressions": "boolean",
      "inputFormatDefaultsForOmittedFields": "boolean",
      "inputFormatNullAsDefault": "boolean",
      "dateTimeInputFormat": "string",
      "inputFormatWithNamesUseHeader": "boolean",
      "outputFormatJsonQuote_64bitIntegers": "boolean",
      "outputFormatJsonQuoteDenormals": "boolean",
      "dateTimeOutputFormat": "string",
      "lowCardinalityAllowInNativeFormat": "boolean",
      "allowSuspiciousLowCardinalityTypes": "boolean",
      "emptyResultForAggregationByEmptySet": "boolean",
      "httpConnectionTimeout": "string",
      "httpReceiveTimeout": "string",
      "httpSendTimeout": "string",
      "enableHttpCompression": "boolean",
      "sendProgressInHttpHeaders": "boolean",
      "httpHeadersProgressInterval": "string",
      "addHttpCorsHeader": "boolean",
      "cancelHttpReadonlyQueriesOnClientClose": "boolean",
      "maxHttpGetRedirects": "string",
      "joinedSubqueryRequiresAlias": "boolean",
      "joinUseNulls": "boolean",
      "transformNullIn": "boolean",
      "quotaMode": "string",
      "flattenNested": "boolean",
      "formatRegexp": "string",
      "formatRegexpEscapingRule": "string",
      "formatRegexpSkipUnmatched": "boolean",
      "asyncInsert": "boolean",
      "asyncInsertThreads": "string",
      "waitForAsyncInsert": "boolean",
      "waitForAsyncInsertTimeout": "string",
      "asyncInsertMaxDataSize": "string",
      "asyncInsertBusyTimeout": "string",
      "asyncInsertStaleTimeout": "string",
      "memoryProfilerStep": "string",
      "memoryProfilerSampleProbability": "number",
      "maxFinalThreads": "string",
      "inputFormatParallelParsing": "boolean",
      "inputFormatImportNestedJson": "boolean",
      "localFilesystemReadMethod": "string",
      "maxReadBufferSize": "string",
      "insertKeeperMaxRetries": "string",
      "maxTemporaryDataOnDiskSizeForUser": "string",
      "maxTemporaryDataOnDiskSizeForQuery": "string",
      "maxParserDepth": "string",
      "remoteFilesystemReadMethod": "string",
      "memoryOvercommitRatioDenominator": "string",
      "memoryOvercommitRatioDenominatorForUser": "string",
      "memoryUsageOvercommitMaxWaitMicroseconds": "string",
      "logQueryThreads": "boolean",
      "maxInsertThreads": "string",
      "useHedgedRequests": "boolean",
      "idleConnectionTimeout": "string",
      "hedgedConnectionTimeoutMs": "string",
      "loadBalancing": "string",
      "preferLocalhostReplica": "boolean",
      "compile": "boolean",
      "minCountToCompile": "string"
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
    ]
  }
}
```

#|
||Field | Description ||
|| userSpec | **[UserSpec](#yandex.cloud.mdb.clickhouse.v1.UserSpec)**

Required field. Properties of the user to be created. ||
|#

## UserSpec {#yandex.cloud.mdb.clickhouse.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the ClickHouse user. ||
|| password | **string**

Required field. Password of the ClickHouse user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission)**

Set of permissions to grant to the user. If not set, it's granted permissions to access all databases. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings)** ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota)**

Set of quotas assigned to the user. ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings}

ClickHouse user settings. Supported settings are a limited subset of all settings
described in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/).

#|
||Field | Description ||
|| readonly | **string** (int64)

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use `allowDdl` instead.
* **0** (default)-no restrictions.
* **1**-only read data queries are allowed.
* **2**-read data and change settings queries are allowed.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly). ||
|| allowDdl | **boolean**

Determines whether DDL queries are allowed (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl). ||
|| allowIntrospectionFunctions | **boolean**

Enables [introspections functions](https://clickhouse.com/docs/en/sql-reference/functions/introspection) for query profiling.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions). ||
|| connectTimeout | **string** (int64)

Connection timeout in milliseconds.

Value must be greater than **0** (default: **10000**, 10 seconds). ||
|| connectTimeoutWithFailover | **string** (int64)

The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **50**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms). ||
|| receiveTimeout | **string** (int64)

Receive timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| sendTimeout | **string** (int64)

Send timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| timeoutBeforeCheckingExecutionSpeed | **string** (int64)

Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in `minExecutionSpeed` parameter.

Default value: **10**. ||
|| insertQuorum | **string** (int64)

Enables or disables write quorum for ClickHouse cluster.
If the value is less than **2**, then write quorum is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the `insertQuorumTimeout` expires.
All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries.
Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.

You can use `selectSequentialConsistency` setting to read the data written with write quorum.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum). ||
|| insertQuorumTimeout | **string** (int64)

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the `insertQuorum` replicas, then ClickHouse will abort the execution of **INSERT** query and return an error.
In this case, the client must send the query again to write the data block into the same or another replica.

Minimum value: **1000**, 1 second (default: **60000**, 1 minute). ||
|| insertQuorumParallel | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel). ||
|| insertNullAsDefault | **boolean**

Enables the insertion of default values instead of NULL into columns with not nullable data type.

Default value: **true**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default). ||
|| selectSequentialConsistency | **boolean**

Determines the behavior of **SELECT** queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **false** (sequential consistency is disabled). ||
|| deduplicateBlocksInDependentMaterializedViews | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views). ||
|| replicationAlterPartitionsSync | **string** (int64)

Wait mode for asynchronous actions in **ALTER** queries on replicated tables:

* **0**-do not wait for replicas.
* **1**-only wait for own execution (default).
* **2**-wait for all replicas.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries). ||
|| maxReplicaDelayForDistributedQueries | **string** (int64)

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Minimum value: **1000**, 1 second (default: **300000**, 300 seconds or 5 minutes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). ||
|| fallbackToStaleReplicasForDistributedQueries | **boolean**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true** (query forcing is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). ||
|| distributedProductMode | **enum** (DistributedProductMode)

Determine the behavior of distributed subqueries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributedAggregationMemoryEfficient | **boolean**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **false** (memory saving mode is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). ||
|| distributedDdlTaskTimeout | **string** (int64)

Timeout for DDL queries, in milliseconds. ||
|| skipUnavailableShards | **boolean**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false** (silent skipping is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards). ||
|| compileExpressions | **boolean**

Enables or disables expression compilation.
If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with `minCountToCompileExpression` setting.

Default value: **false** (expression compilation is disabled). ||
|| minCountToCompileExpression | **string** (int64)

How many identical expressions ClickHouse has to encounter before they are compiled.

Minimum value: **0** (default: **3**).

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. ||
|| maxBlockSize | **string** (int64)

The maximum block size for reading.

Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts).
The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.

This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.

Value must be greater than **0** (default: **65536**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size). ||
|| minInsertBlockSizeRows | **string** (int64)

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **1048576**). ||
|| minInsertBlockSizeBytes | **string** (int64)

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **268435456**, 256 MB). ||
|| maxInsertBlockSize | **string** (int64)

Allows to form blocks of the specified size (in bytes) when inserting data in a table.
This setting has effect only if server is creating such blocks by itself.

Value must be greater than **0** (default: **1048576**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size). ||
|| minBytesToUseDirectIo | **string** (int64)

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead.
Such reading strategy is effective when the data volume is small.
If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.

If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.

Minimal value and default value: **0**, Direct I/O is disabled. ||
|| useUncompressedCache | **boolean**

Determines whether to use the cache of uncompressed blocks, or not.
Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false** (uncompressed cache is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). ||
|| mergeTreeMaxRowsToUseCache | **string** (int64)

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `useUncompressedCache` setting.

Value must be greater than **0** (default: **128x8192**). ||
|| mergeTreeMaxBytesToUseCache | **string** (int64)

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `useUncompressedCache` setting.

Value must be greater than **0** (default: **192x10x1024x1024**). ||
|| mergeTreeMinRowsForConcurrentRead | **string** (int64)

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **20x8192**). ||
|| mergeTreeMinBytesForConcurrentRead | **string** (int64)

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **24x10x1024x1024**). ||
|| maxBytesBeforeExternalGroupBy | **string** (int64)

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM comsumption.

By default, aggregation is done by employing hash table that resides in RAM.
A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the `maxMemoryUsage` setting).
For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Minimal value and default value: **0**, **GROUP BY** in the external memory is disabled.

When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the `maxMemoryUsage` setting value (by default, the maximum memory usage is limited to ten gigabytes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

See also: the `distributedAggregationMemoryEfficient` setting. ||
|| maxBytesBeforeExternalSort | **string** (int64)

This setting is equivalent of the `maxBytesBeforeExternalGroupBy` setting, except for it is for sort operation (**ORDER BY**), not aggregation. ||
|| groupByTwoLevelThreshold | **string** (int64)

Sets the threshold of the number of keys, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **10000**). ||
|| groupByTwoLevelThresholdBytes | **string** (int64)

Sets the threshold of the number of bytes, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **100000000**). ||
|| priority | **string** (int64)

Sets the priority of a query.

* **0**-priority is not used.
* **1**-the highest priority.
* and so on. The higher the number, the lower a query's priority.

This setting should be set up for each query individually.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.

Minimal value and default value: **0**, priority is not used. ||
|| maxThreads | **string** (int64)

Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).

This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

Minimal value and default value: **0** (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads). ||
|| maxMemoryUsage | **string** (int64)

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for any user's single query on a single server.

Minimal value: **0**, no limitation is set.
Value that is set in the ClickHouse default config file: **10737418240** (10 GB).

If you use `maxBytesBeforeExternalGroupBy` or `maxBytesBeforeExternalSort` setting, then it is recommended to set their values twice as low as `maxMemoryUsage` setting value.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage). ||
|| maxMemoryUsageForUser | **string** (int64)

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Minimal value and default value: **0**, no limitation is set. ||
|| maxNetworkBandwidth | **string** (int64)

The maximum speed of data exchange over the network in bytes per second for a query.

Minimal value and default value: **0**, no limitation is set. ||
|| maxNetworkBandwidthForUser | **string** (int64)

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.

Minimal value and default value: **0**, no limitation is set. ||
|| maxPartitionsPerInsertBlock | **string** (int64)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block). ||
|| maxConcurrentQueriesForUser | **string** (int64)

The maximum number of concurrent requests per user.
Default value: 0 (no limit). ||
|| forceIndexByDate | **boolean**

If enabled, query is not executed if the ClickHouse can't use index by date.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by date).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date). ||
|| forcePrimaryKey | **boolean**

If enabled, query is not executed if the ClickHouse can't use index by primary key.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by primary key).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key). ||
|| maxRowsToRead | **string** (int64)

Limits the maximum number of rows that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read). ||
|| maxBytesToRead | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set. ||
|| readOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while reading the data.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToGroupBy | **string** (int64)

Limits the maximum number of unique keys received from aggregation function.
This setting helps to reduce RAM consumption while doing aggregation.

Minimal value and default value: **0**, no limitation is set. ||
|| groupByOverflowMode | **enum** (GroupByOverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing aggregation.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.
* **any**-perform approximate **GROUP BY** operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| maxRowsToSort | **string** (int64)

Limits the maximum number of rows that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesToSort | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| sortOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while sorting.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxResultRows | **string** (int64)

Limits the number of rows in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| maxResultBytes | **string** (int64)

Limits the number of bytes in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| resultOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while forming result.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInDistinct | **string** (int64)

Limits the maximum number of different rows when using **DISTINCT**.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesInDistinct | **string** (int64)

Limits the maximum size of a hash table in bytes (uncompressed data) when using **DISTINCT**. ||
|| distinctOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing **DISCTINCT**.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToTransfer | **string** (int64)

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesToTransfer | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary
table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| transferOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing transfers.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxExecutionTime | **string** (int64)

Limits the maximum query execution time in milliseconds.
At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.

Minimal value and default value: **0**, no limitation is set. ||
|| timeoutOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) of execution time.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInSet | **string** (int64)

Limit on the number of rows in the set resulting from the execution of the IN section. ||
|| maxBytesInSet | **string** (int64)

Limit on the number of bytes in the set resulting from the execution of the IN section. ||
|| setOverflowMode | **enum** (OverflowMode)

Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInJoin | **string** (int64)

Limit on maximum size of the hash table for JOIN, in rows. ||
|| maxBytesInJoin | **string** (int64)

Limit on maximum size of the hash table for JOIN, in bytes. ||
|| joinOverflowMode | **enum** (OverflowMode)

Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| joinAlgorithm[] | **enum** (JoinAlgorithm)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| anyJoinDistinctRightTableKeys | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys). ||
|| maxColumnsToRead | **string** (int64)

Limits the maximum number of columns that can be read from a table in a single query.
If the query requires to read more columns to complete, then it will be aborted.

Minimal value and default value: **0**, no limitation is set. ||
|| maxTemporaryColumns | **string** (int64)

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| maxTemporaryNonConstColumns | **string** (int64)

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| maxQuerySize | **string** (int64)

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Value must be greater than **0** (default: **262144**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size). ||
|| maxAstDepth | **string** (int64)

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the **SELECT ... WHERE ...** query, containing constraints and conditions, in the most cases.
A user can be forced to construct more optimized queries, if this setting is used.

Value must be greater than **0** (default: **1000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth). ||
|| maxAstElements | **string** (int64)

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **50000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements). ||
|| maxExpandedAstElements | **string** (int64)

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **500000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries. ||
|| minExecutionSpeed | **string** (int64)

Minimal execution speed in rows per second. ||
|| minExecutionSpeedBytes | **string** (int64)

Minimal execution speed in bytes per second. ||
|| countDistinctImplementation | **enum** (CountDistinctImplementation)

Aggregate function to use for implementation of count(DISTINCT ...).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| inputFormatValuesInterpretExpressions | **boolean**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table.
With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true** (SQL parser is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). ||
|| inputFormatDefaultsForOmittedFields | **boolean**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true** (replacing is enabled). ||
|| inputFormatNullAsDefault | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default). ||
|| dateTimeInputFormat | **enum** (DateTimeInputFormat)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| inputFormatWithNamesUseHeader | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header). ||
|| outputFormatJsonQuote_64bitIntegers | **boolean**

Enables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines.
Otherwise, such integers will not be quoted.

Default value: **false** (quoting 64-bit integers is disabled). ||
|| outputFormatJsonQuoteDenormals | **boolean**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false** (special values do not present in output). ||
|| dateTimeOutputFormat | **enum** (DateTimeOutputFormat)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| lowCardinalityAllowInNativeFormat | **boolean**

Determines whether to use LowCardinality type in Native format.

* **true** (default)-yes, use.
* **false**-convert LowCardinality columns to regular columns when doing **SELECT**, and convert regular columns to LowCardinality when doing **INSERT**.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column.
Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true** (LowCardinality columns are used in Native format). ||
|| allowSuspiciousLowCardinalityTypes | **boolean**

Allows specifying **LowCardinality** modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types). ||
|| emptyResultForAggregationByEmptySet | **boolean**

Enables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).

* **true**-ClickHouse will return an empty result for such queries.
* **false** (default)-ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. ||
|| httpConnectionTimeout | **string** (int64)

HTTP connection timeout, in milliseconds.

Value must be greater than **0** (default: **1000**, 1 second). ||
|| httpReceiveTimeout | **string** (int64)

HTTP receive timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| httpSendTimeout | **string** (int64)

HTTP send timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| enableHttpCompression | **boolean**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false** (compression is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/interfaces/http/). ||
|| sendProgressInHttpHeaders | **boolean**

Enables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false** (notifications disabled). ||
|| httpHeadersProgressInterval | **string** (int64)

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Value must be greater than **0** (default: **100**). ||
|| addHttpCorsHeader | **boolean**

Adds CORS header in HTTP responses.

Default value: **false** (header is not added). ||
|| cancelHttpReadonlyQueriesOnClientClose | **boolean**

Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.

Default value: **false**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close). ||
|| maxHttpGetRedirects | **string** (int64)

Limits the maximum number of HTTP GET redirect hops for [URL-engine](https://clickhouse.com/docs/en/engines/table-engines/special/url) tables.

If the parameter is set to **0** (default), no hops is allowed.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects). ||
|| joinedSubqueryRequiresAlias | **boolean** ||
|| joinUseNulls | **boolean** ||
|| transformNullIn | **boolean** ||
|| quotaMode | **enum** (QuotaMode)

Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| flattenNested | **boolean**

Sets the data format of a [nested](https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested) columns.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested). ||
|| formatRegexp | **string**

Regular expression (for Regexp format) ||
|| formatRegexpEscapingRule | **enum** (FormatRegexpEscapingRule)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| formatRegexpSkipUnmatched | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched). ||
|| asyncInsert | **boolean**

Enables asynchronous inserts.

Disabled by default.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert). ||
|| asyncInsertThreads | **string** (int64)

The maximum number of threads for background data parsing and insertion.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **16**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads). ||
|| waitForAsyncInsert | **boolean**

Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert). ||
|| waitForAsyncInsertTimeout | **string** (int64)

The timeout (in seconds) for waiting for processing of asynchronous insertion.

Default value: **120**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout). ||
|| asyncInsertMaxDataSize | **string** (int64)

The maximum size of the unparsed data in bytes collected per query before being inserted.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **100000**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size). ||
|| asyncInsertBusyTimeout | **string** (int64)

The maximum timeout in milliseconds since the first INSERT query before inserting collected data.

If the parameter is set to **0**, the timeout is disabled. Default value: **200**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms). ||
|| asyncInsertStaleTimeout | **string** (int64)

The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the `asyncInsertBusyTimeout` with every INSERT query as long as `asyncInsertMaxDataSize` is not exceeded.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-stale-timeout-ms). ||
|| memoryProfilerStep | **string** (int64)

Memory profiler step (in bytes).

If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.

Default value: **4194304** (4 MB). Zero means disabled memory profiler. ||
|| memoryProfilerSampleProbability | **number** (double)

Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.

Possible values: from **0** to **1**. Default: **0**. ||
|| maxFinalThreads | **string** (int64)

Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads). ||
|| inputFormatParallelParsing | **boolean**

Enables or disables order-preserving parallel parsing of data formats. Supported only for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv) and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| inputFormatImportNestedJson | **boolean**

Enables or disables the insertion of JSON data with nested objects.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| localFilesystemReadMethod | **enum** (LocalFilesystemReadMethod)

Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes.

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP` ||
|| maxReadBufferSize | **string** (int64)

The maximum size of the buffer to read from the filesystem.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size) ||
|| insertKeeperMaxRetries | **string** (int64)

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries.
Default: 20 from 23.2, 0(disabled) before
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries) ||
|| maxTemporaryDataOnDiskSizeForUser | **string** (int64)

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user) ||
|| maxTemporaryDataOnDiskSizeForQuery | **string** (int64)

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query) ||
|| maxParserDepth | **string** (int64)

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size.
Default: 1000
Special: 0 - unlimited
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_parser_depth) ||
|| remoteFilesystemReadMethod | **enum** (RemoteFilesystemReadMethod)

Method of reading data from remote filesystem, one of: read, threadpool.
Default: read
Min_version: 21.11
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L660)

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| memoryOvercommitRatioDenominator | **string** (int64)

It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator) ||
|| memoryOvercommitRatioDenominatorForUser | **string** (int64)

It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user) ||
|| memoryUsageOvercommitMaxWaitMicroseconds | **string** (int64)

Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown.
Default: 5000000
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds) ||
|| logQueryThreads | **boolean**

Setting up query threads logging. Query threads log into the [system.query_thread_log](https://clickhouse.com/docs/en/operations/system-tables/query_thread_log) table. This setting has effect only when [log_queries](https://clickhouse.com/docs/en/operations/settings/settings#log-queries) is true. Queries threads run by ClickHouse with this setup are logged according to the rules in the [query_thread_log](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters-query_thread_log) server configuration parameter.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_threads) ||
|| maxInsertThreads | **string** (int64)

The maximum number of threads to execute the INSERT SELECT query.
Default: 0
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_insert_threads) ||
|| useHedgedRequests | **boolean**

Enables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within hedged_connection_timeout or no data was received within receive_data_timeout. Query uses the first connection which send non empty progress packet (or data packet, if allow_changing_replica_until_first_data_packet); other connections are cancelled. Queries with max_parallel_replicas > 1 are supported.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_hedged_requests) ||
|| idleConnectionTimeout | **string** (int64)

Timeout to close idle TCP connections after specified number of milliseconds.
Default: 360000 (3600 seconds)
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) ||
|| hedgedConnectionTimeoutMs | **string** (int64)

Connection timeout for establishing connection with replica for Hedged requests.
Default: 50
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L64) ||
|| loadBalancing | **enum** (LoadBalancing)

Specifies the algorithm of replicas selection that is used for distributed query processing, one of: random, nearest_hostname, in_order, first_or_random, round_robin.
Default: random
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#load_balancing)

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| preferLocalhostReplica | **boolean**

Enables/disables preferable using the localhost replica when processing distributed queries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#prefer_localhost_replica) ||
|| compile | **boolean**

The setting is deprecated and has no effect. ||
|| minCountToCompile | **string** (int64)

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
See in-depth description [ClickHouse documentation](https://clickhouse.com/docs/en/operations/quotas/).

#|
||Field | Description ||
|| intervalDuration | **string** (int64)

Duration of interval for quota in milliseconds.
Minimal value is 1 second. ||
|| queries | **string** (int64)

The total number of queries.
0 - unlimited. ||
|| errors | **string** (int64)

The number of queries that threw exception.
0 - unlimited. ||
|| resultRows | **string** (int64)

The total number of rows given as the result..
0 - unlimited. ||
|| readRows | **string** (int64)

The total number of source rows read from tables for running the query, on all remote servers.
0 - unlimited. ||
|| executionTime | **string** (int64)

The total query execution time, in milliseconds (wall time).
0 - unlimited. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "userName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
      "timeoutBeforeCheckingExecutionSpeed": "string",
      "insertQuorum": "string",
      "insertQuorumTimeout": "string",
      "insertQuorumParallel": "boolean",
      "insertNullAsDefault": "boolean",
      "selectSequentialConsistency": "boolean",
      "deduplicateBlocksInDependentMaterializedViews": "boolean",
      "replicationAlterPartitionsSync": "string",
      "maxReplicaDelayForDistributedQueries": "string",
      "fallbackToStaleReplicasForDistributedQueries": "boolean",
      "distributedProductMode": "string",
      "distributedAggregationMemoryEfficient": "boolean",
      "distributedDdlTaskTimeout": "string",
      "skipUnavailableShards": "boolean",
      "compileExpressions": "boolean",
      "minCountToCompileExpression": "string",
      "maxBlockSize": "string",
      "minInsertBlockSizeRows": "string",
      "minInsertBlockSizeBytes": "string",
      "maxInsertBlockSize": "string",
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
      "priority": "string",
      "maxThreads": "string",
      "maxMemoryUsage": "string",
      "maxMemoryUsageForUser": "string",
      "maxNetworkBandwidth": "string",
      "maxNetworkBandwidthForUser": "string",
      "maxPartitionsPerInsertBlock": "string",
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
      "joinAlgorithm": [
        "string"
      ],
      "anyJoinDistinctRightTableKeys": "boolean",
      "maxColumnsToRead": "string",
      "maxTemporaryColumns": "string",
      "maxTemporaryNonConstColumns": "string",
      "maxQuerySize": "string",
      "maxAstDepth": "string",
      "maxAstElements": "string",
      "maxExpandedAstElements": "string",
      "minExecutionSpeed": "string",
      "minExecutionSpeedBytes": "string",
      "countDistinctImplementation": "string",
      "inputFormatValuesInterpretExpressions": "boolean",
      "inputFormatDefaultsForOmittedFields": "boolean",
      "inputFormatNullAsDefault": "boolean",
      "dateTimeInputFormat": "string",
      "inputFormatWithNamesUseHeader": "boolean",
      "outputFormatJsonQuote_64bitIntegers": "boolean",
      "outputFormatJsonQuoteDenormals": "boolean",
      "dateTimeOutputFormat": "string",
      "lowCardinalityAllowInNativeFormat": "boolean",
      "allowSuspiciousLowCardinalityTypes": "boolean",
      "emptyResultForAggregationByEmptySet": "boolean",
      "httpConnectionTimeout": "string",
      "httpReceiveTimeout": "string",
      "httpSendTimeout": "string",
      "enableHttpCompression": "boolean",
      "sendProgressInHttpHeaders": "boolean",
      "httpHeadersProgressInterval": "string",
      "addHttpCorsHeader": "boolean",
      "cancelHttpReadonlyQueriesOnClientClose": "boolean",
      "maxHttpGetRedirects": "string",
      "joinedSubqueryRequiresAlias": "boolean",
      "joinUseNulls": "boolean",
      "transformNullIn": "boolean",
      "quotaMode": "string",
      "flattenNested": "boolean",
      "formatRegexp": "string",
      "formatRegexpEscapingRule": "string",
      "formatRegexpSkipUnmatched": "boolean",
      "asyncInsert": "boolean",
      "asyncInsertThreads": "string",
      "waitForAsyncInsert": "boolean",
      "waitForAsyncInsertTimeout": "string",
      "asyncInsertMaxDataSize": "string",
      "asyncInsertBusyTimeout": "string",
      "asyncInsertStaleTimeout": "string",
      "memoryProfilerStep": "string",
      "memoryProfilerSampleProbability": "number",
      "maxFinalThreads": "string",
      "inputFormatParallelParsing": "boolean",
      "inputFormatImportNestedJson": "boolean",
      "localFilesystemReadMethod": "string",
      "maxReadBufferSize": "string",
      "insertKeeperMaxRetries": "string",
      "maxTemporaryDataOnDiskSizeForUser": "string",
      "maxTemporaryDataOnDiskSizeForQuery": "string",
      "maxParserDepth": "string",
      "remoteFilesystemReadMethod": "string",
      "memoryOvercommitRatioDenominator": "string",
      "memoryOvercommitRatioDenominatorForUser": "string",
      "memoryUsageOvercommitMaxWaitMicroseconds": "string",
      "logQueryThreads": "boolean",
      "maxInsertThreads": "string",
      "useHedgedRequests": "boolean",
      "idleConnectionTimeout": "string",
      "hedgedConnectionTimeoutMs": "string",
      "loadBalancing": "string",
      "preferLocalhostReplica": "boolean",
      "compile": "boolean",
      "minCountToCompile": "string"
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
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.clickhouse.v1.CreateUserMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[User](#yandex.cloud.mdb.clickhouse.v1.User)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateUserMetadata {#yandex.cloud.mdb.clickhouse.v1.CreateUserMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the ClickHouse cluster the user is being created in. ||
|| userName | **string**

Name of the user that is being created. ||
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

## User {#yandex.cloud.mdb.clickhouse.v1.User}

A ClickHouse User resource. For more information, see
the [Developer's guide](/docs/managed-clickhouse/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the ClickHouse user. ||
|| clusterId | **string**

ID of the ClickHouse cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission2)**

Set of permissions granted to the user. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings2)** ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota2)**

Set of quotas assigned to the user. ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission2}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings2}

ClickHouse user settings. Supported settings are a limited subset of all settings
described in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/).

#|
||Field | Description ||
|| readonly | **string** (int64)

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use `allowDdl` instead.
* **0** (default)-no restrictions.
* **1**-only read data queries are allowed.
* **2**-read data and change settings queries are allowed.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly). ||
|| allowDdl | **boolean**

Determines whether DDL queries are allowed (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl). ||
|| allowIntrospectionFunctions | **boolean**

Enables [introspections functions](https://clickhouse.com/docs/en/sql-reference/functions/introspection) for query profiling.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions). ||
|| connectTimeout | **string** (int64)

Connection timeout in milliseconds.

Value must be greater than **0** (default: **10000**, 10 seconds). ||
|| connectTimeoutWithFailover | **string** (int64)

The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **50**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms). ||
|| receiveTimeout | **string** (int64)

Receive timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| sendTimeout | **string** (int64)

Send timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| timeoutBeforeCheckingExecutionSpeed | **string** (int64)

Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in `minExecutionSpeed` parameter.

Default value: **10**. ||
|| insertQuorum | **string** (int64)

Enables or disables write quorum for ClickHouse cluster.
If the value is less than **2**, then write quorum is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the `insertQuorumTimeout` expires.
All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries.
Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.

You can use `selectSequentialConsistency` setting to read the data written with write quorum.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum). ||
|| insertQuorumTimeout | **string** (int64)

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the `insertQuorum` replicas, then ClickHouse will abort the execution of **INSERT** query and return an error.
In this case, the client must send the query again to write the data block into the same or another replica.

Minimum value: **1000**, 1 second (default: **60000**, 1 minute). ||
|| insertQuorumParallel | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel). ||
|| insertNullAsDefault | **boolean**

Enables the insertion of default values instead of NULL into columns with not nullable data type.

Default value: **true**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default). ||
|| selectSequentialConsistency | **boolean**

Determines the behavior of **SELECT** queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **false** (sequential consistency is disabled). ||
|| deduplicateBlocksInDependentMaterializedViews | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views). ||
|| replicationAlterPartitionsSync | **string** (int64)

Wait mode for asynchronous actions in **ALTER** queries on replicated tables:

* **0**-do not wait for replicas.
* **1**-only wait for own execution (default).
* **2**-wait for all replicas.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries). ||
|| maxReplicaDelayForDistributedQueries | **string** (int64)

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Minimum value: **1000**, 1 second (default: **300000**, 300 seconds or 5 minutes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). ||
|| fallbackToStaleReplicasForDistributedQueries | **boolean**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true** (query forcing is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). ||
|| distributedProductMode | **enum** (DistributedProductMode)

Determine the behavior of distributed subqueries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributedAggregationMemoryEfficient | **boolean**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **false** (memory saving mode is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). ||
|| distributedDdlTaskTimeout | **string** (int64)

Timeout for DDL queries, in milliseconds. ||
|| skipUnavailableShards | **boolean**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false** (silent skipping is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards). ||
|| compileExpressions | **boolean**

Enables or disables expression compilation.
If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with `minCountToCompileExpression` setting.

Default value: **false** (expression compilation is disabled). ||
|| minCountToCompileExpression | **string** (int64)

How many identical expressions ClickHouse has to encounter before they are compiled.

Minimum value: **0** (default: **3**).

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. ||
|| maxBlockSize | **string** (int64)

The maximum block size for reading.

Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts).
The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.

This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.

Value must be greater than **0** (default: **65536**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size). ||
|| minInsertBlockSizeRows | **string** (int64)

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **1048576**). ||
|| minInsertBlockSizeBytes | **string** (int64)

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **268435456**, 256 MB). ||
|| maxInsertBlockSize | **string** (int64)

Allows to form blocks of the specified size (in bytes) when inserting data in a table.
This setting has effect only if server is creating such blocks by itself.

Value must be greater than **0** (default: **1048576**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size). ||
|| minBytesToUseDirectIo | **string** (int64)

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead.
Such reading strategy is effective when the data volume is small.
If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.

If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.

Minimal value and default value: **0**, Direct I/O is disabled. ||
|| useUncompressedCache | **boolean**

Determines whether to use the cache of uncompressed blocks, or not.
Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false** (uncompressed cache is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). ||
|| mergeTreeMaxRowsToUseCache | **string** (int64)

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `useUncompressedCache` setting.

Value must be greater than **0** (default: **128x8192**). ||
|| mergeTreeMaxBytesToUseCache | **string** (int64)

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `useUncompressedCache` setting.

Value must be greater than **0** (default: **192x10x1024x1024**). ||
|| mergeTreeMinRowsForConcurrentRead | **string** (int64)

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **20x8192**). ||
|| mergeTreeMinBytesForConcurrentRead | **string** (int64)

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **24x10x1024x1024**). ||
|| maxBytesBeforeExternalGroupBy | **string** (int64)

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM comsumption.

By default, aggregation is done by employing hash table that resides in RAM.
A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the `maxMemoryUsage` setting).
For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Minimal value and default value: **0**, **GROUP BY** in the external memory is disabled.

When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the `maxMemoryUsage` setting value (by default, the maximum memory usage is limited to ten gigabytes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

See also: the `distributedAggregationMemoryEfficient` setting. ||
|| maxBytesBeforeExternalSort | **string** (int64)

This setting is equivalent of the `maxBytesBeforeExternalGroupBy` setting, except for it is for sort operation (**ORDER BY**), not aggregation. ||
|| groupByTwoLevelThreshold | **string** (int64)

Sets the threshold of the number of keys, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **10000**). ||
|| groupByTwoLevelThresholdBytes | **string** (int64)

Sets the threshold of the number of bytes, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **100000000**). ||
|| priority | **string** (int64)

Sets the priority of a query.

* **0**-priority is not used.
* **1**-the highest priority.
* and so on. The higher the number, the lower a query's priority.

This setting should be set up for each query individually.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.

Minimal value and default value: **0**, priority is not used. ||
|| maxThreads | **string** (int64)

Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).

This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

Minimal value and default value: **0** (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads). ||
|| maxMemoryUsage | **string** (int64)

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for any user's single query on a single server.

Minimal value: **0**, no limitation is set.
Value that is set in the ClickHouse default config file: **10737418240** (10 GB).

If you use `maxBytesBeforeExternalGroupBy` or `maxBytesBeforeExternalSort` setting, then it is recommended to set their values twice as low as `maxMemoryUsage` setting value.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage). ||
|| maxMemoryUsageForUser | **string** (int64)

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Minimal value and default value: **0**, no limitation is set. ||
|| maxNetworkBandwidth | **string** (int64)

The maximum speed of data exchange over the network in bytes per second for a query.

Minimal value and default value: **0**, no limitation is set. ||
|| maxNetworkBandwidthForUser | **string** (int64)

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.

Minimal value and default value: **0**, no limitation is set. ||
|| maxPartitionsPerInsertBlock | **string** (int64)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block). ||
|| maxConcurrentQueriesForUser | **string** (int64)

The maximum number of concurrent requests per user.
Default value: 0 (no limit). ||
|| forceIndexByDate | **boolean**

If enabled, query is not executed if the ClickHouse can't use index by date.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by date).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date). ||
|| forcePrimaryKey | **boolean**

If enabled, query is not executed if the ClickHouse can't use index by primary key.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by primary key).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key). ||
|| maxRowsToRead | **string** (int64)

Limits the maximum number of rows that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read). ||
|| maxBytesToRead | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set. ||
|| readOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while reading the data.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToGroupBy | **string** (int64)

Limits the maximum number of unique keys received from aggregation function.
This setting helps to reduce RAM consumption while doing aggregation.

Minimal value and default value: **0**, no limitation is set. ||
|| groupByOverflowMode | **enum** (GroupByOverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing aggregation.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.
* **any**-perform approximate **GROUP BY** operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| maxRowsToSort | **string** (int64)

Limits the maximum number of rows that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesToSort | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| sortOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while sorting.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxResultRows | **string** (int64)

Limits the number of rows in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| maxResultBytes | **string** (int64)

Limits the number of bytes in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| resultOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while forming result.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInDistinct | **string** (int64)

Limits the maximum number of different rows when using **DISTINCT**.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesInDistinct | **string** (int64)

Limits the maximum size of a hash table in bytes (uncompressed data) when using **DISTINCT**. ||
|| distinctOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing **DISCTINCT**.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToTransfer | **string** (int64)

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesToTransfer | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary
table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| transferOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing transfers.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxExecutionTime | **string** (int64)

Limits the maximum query execution time in milliseconds.
At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.

Minimal value and default value: **0**, no limitation is set. ||
|| timeoutOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) of execution time.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInSet | **string** (int64)

Limit on the number of rows in the set resulting from the execution of the IN section. ||
|| maxBytesInSet | **string** (int64)

Limit on the number of bytes in the set resulting from the execution of the IN section. ||
|| setOverflowMode | **enum** (OverflowMode)

Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInJoin | **string** (int64)

Limit on maximum size of the hash table for JOIN, in rows. ||
|| maxBytesInJoin | **string** (int64)

Limit on maximum size of the hash table for JOIN, in bytes. ||
|| joinOverflowMode | **enum** (OverflowMode)

Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| joinAlgorithm[] | **enum** (JoinAlgorithm)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| anyJoinDistinctRightTableKeys | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys). ||
|| maxColumnsToRead | **string** (int64)

Limits the maximum number of columns that can be read from a table in a single query.
If the query requires to read more columns to complete, then it will be aborted.

Minimal value and default value: **0**, no limitation is set. ||
|| maxTemporaryColumns | **string** (int64)

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| maxTemporaryNonConstColumns | **string** (int64)

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| maxQuerySize | **string** (int64)

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Value must be greater than **0** (default: **262144**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size). ||
|| maxAstDepth | **string** (int64)

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the **SELECT ... WHERE ...** query, containing constraints and conditions, in the most cases.
A user can be forced to construct more optimized queries, if this setting is used.

Value must be greater than **0** (default: **1000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth). ||
|| maxAstElements | **string** (int64)

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **50000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements). ||
|| maxExpandedAstElements | **string** (int64)

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **500000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries. ||
|| minExecutionSpeed | **string** (int64)

Minimal execution speed in rows per second. ||
|| minExecutionSpeedBytes | **string** (int64)

Minimal execution speed in bytes per second. ||
|| countDistinctImplementation | **enum** (CountDistinctImplementation)

Aggregate function to use for implementation of count(DISTINCT ...).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| inputFormatValuesInterpretExpressions | **boolean**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table.
With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true** (SQL parser is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). ||
|| inputFormatDefaultsForOmittedFields | **boolean**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true** (replacing is enabled). ||
|| inputFormatNullAsDefault | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default). ||
|| dateTimeInputFormat | **enum** (DateTimeInputFormat)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| inputFormatWithNamesUseHeader | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header). ||
|| outputFormatJsonQuote_64bitIntegers | **boolean**

Enables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines.
Otherwise, such integers will not be quoted.

Default value: **false** (quoting 64-bit integers is disabled). ||
|| outputFormatJsonQuoteDenormals | **boolean**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false** (special values do not present in output). ||
|| dateTimeOutputFormat | **enum** (DateTimeOutputFormat)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| lowCardinalityAllowInNativeFormat | **boolean**

Determines whether to use LowCardinality type in Native format.

* **true** (default)-yes, use.
* **false**-convert LowCardinality columns to regular columns when doing **SELECT**, and convert regular columns to LowCardinality when doing **INSERT**.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column.
Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true** (LowCardinality columns are used in Native format). ||
|| allowSuspiciousLowCardinalityTypes | **boolean**

Allows specifying **LowCardinality** modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types). ||
|| emptyResultForAggregationByEmptySet | **boolean**

Enables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).

* **true**-ClickHouse will return an empty result for such queries.
* **false** (default)-ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. ||
|| httpConnectionTimeout | **string** (int64)

HTTP connection timeout, in milliseconds.

Value must be greater than **0** (default: **1000**, 1 second). ||
|| httpReceiveTimeout | **string** (int64)

HTTP receive timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| httpSendTimeout | **string** (int64)

HTTP send timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| enableHttpCompression | **boolean**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false** (compression is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/interfaces/http/). ||
|| sendProgressInHttpHeaders | **boolean**

Enables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false** (notifications disabled). ||
|| httpHeadersProgressInterval | **string** (int64)

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Value must be greater than **0** (default: **100**). ||
|| addHttpCorsHeader | **boolean**

Adds CORS header in HTTP responses.

Default value: **false** (header is not added). ||
|| cancelHttpReadonlyQueriesOnClientClose | **boolean**

Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.

Default value: **false**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close). ||
|| maxHttpGetRedirects | **string** (int64)

Limits the maximum number of HTTP GET redirect hops for [URL-engine](https://clickhouse.com/docs/en/engines/table-engines/special/url) tables.

If the parameter is set to **0** (default), no hops is allowed.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects). ||
|| joinedSubqueryRequiresAlias | **boolean** ||
|| joinUseNulls | **boolean** ||
|| transformNullIn | **boolean** ||
|| quotaMode | **enum** (QuotaMode)

Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| flattenNested | **boolean**

Sets the data format of a [nested](https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested) columns.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested). ||
|| formatRegexp | **string**

Regular expression (for Regexp format) ||
|| formatRegexpEscapingRule | **enum** (FormatRegexpEscapingRule)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| formatRegexpSkipUnmatched | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched). ||
|| asyncInsert | **boolean**

Enables asynchronous inserts.

Disabled by default.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert). ||
|| asyncInsertThreads | **string** (int64)

The maximum number of threads for background data parsing and insertion.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **16**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads). ||
|| waitForAsyncInsert | **boolean**

Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert). ||
|| waitForAsyncInsertTimeout | **string** (int64)

The timeout (in seconds) for waiting for processing of asynchronous insertion.

Default value: **120**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout). ||
|| asyncInsertMaxDataSize | **string** (int64)

The maximum size of the unparsed data in bytes collected per query before being inserted.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **100000**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size). ||
|| asyncInsertBusyTimeout | **string** (int64)

The maximum timeout in milliseconds since the first INSERT query before inserting collected data.

If the parameter is set to **0**, the timeout is disabled. Default value: **200**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms). ||
|| asyncInsertStaleTimeout | **string** (int64)

The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the `asyncInsertBusyTimeout` with every INSERT query as long as `asyncInsertMaxDataSize` is not exceeded.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-stale-timeout-ms). ||
|| memoryProfilerStep | **string** (int64)

Memory profiler step (in bytes).

If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.

Default value: **4194304** (4 MB). Zero means disabled memory profiler. ||
|| memoryProfilerSampleProbability | **number** (double)

Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.

Possible values: from **0** to **1**. Default: **0**. ||
|| maxFinalThreads | **string** (int64)

Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads). ||
|| inputFormatParallelParsing | **boolean**

Enables or disables order-preserving parallel parsing of data formats. Supported only for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv) and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| inputFormatImportNestedJson | **boolean**

Enables or disables the insertion of JSON data with nested objects.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| localFilesystemReadMethod | **enum** (LocalFilesystemReadMethod)

Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes.

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP` ||
|| maxReadBufferSize | **string** (int64)

The maximum size of the buffer to read from the filesystem.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size) ||
|| insertKeeperMaxRetries | **string** (int64)

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries.
Default: 20 from 23.2, 0(disabled) before
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries) ||
|| maxTemporaryDataOnDiskSizeForUser | **string** (int64)

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user) ||
|| maxTemporaryDataOnDiskSizeForQuery | **string** (int64)

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query) ||
|| maxParserDepth | **string** (int64)

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size.
Default: 1000
Special: 0 - unlimited
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_parser_depth) ||
|| remoteFilesystemReadMethod | **enum** (RemoteFilesystemReadMethod)

Method of reading data from remote filesystem, one of: read, threadpool.
Default: read
Min_version: 21.11
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L660)

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| memoryOvercommitRatioDenominator | **string** (int64)

It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator) ||
|| memoryOvercommitRatioDenominatorForUser | **string** (int64)

It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user) ||
|| memoryUsageOvercommitMaxWaitMicroseconds | **string** (int64)

Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown.
Default: 5000000
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds) ||
|| logQueryThreads | **boolean**

Setting up query threads logging. Query threads log into the [system.query_thread_log](https://clickhouse.com/docs/en/operations/system-tables/query_thread_log) table. This setting has effect only when [log_queries](https://clickhouse.com/docs/en/operations/settings/settings#log-queries) is true. Queries threads run by ClickHouse with this setup are logged according to the rules in the [query_thread_log](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters-query_thread_log) server configuration parameter.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_threads) ||
|| maxInsertThreads | **string** (int64)

The maximum number of threads to execute the INSERT SELECT query.
Default: 0
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_insert_threads) ||
|| useHedgedRequests | **boolean**

Enables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within hedged_connection_timeout or no data was received within receive_data_timeout. Query uses the first connection which send non empty progress packet (or data packet, if allow_changing_replica_until_first_data_packet); other connections are cancelled. Queries with max_parallel_replicas > 1 are supported.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_hedged_requests) ||
|| idleConnectionTimeout | **string** (int64)

Timeout to close idle TCP connections after specified number of milliseconds.
Default: 360000 (3600 seconds)
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) ||
|| hedgedConnectionTimeoutMs | **string** (int64)

Connection timeout for establishing connection with replica for Hedged requests.
Default: 50
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L64) ||
|| loadBalancing | **enum** (LoadBalancing)

Specifies the algorithm of replicas selection that is used for distributed query processing, one of: random, nearest_hostname, in_order, first_or_random, round_robin.
Default: random
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#load_balancing)

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| preferLocalhostReplica | **boolean**

Enables/disables preferable using the localhost replica when processing distributed queries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#prefer_localhost_replica) ||
|| compile | **boolean**

The setting is deprecated and has no effect. ||
|| minCountToCompile | **string** (int64)

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota2}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
See in-depth description [ClickHouse documentation](https://clickhouse.com/docs/en/operations/quotas/).

#|
||Field | Description ||
|| intervalDuration | **string** (int64)

Duration of interval for quota in milliseconds.
Minimal value is 1 second. ||
|| queries | **string** (int64)

The total number of queries.
0 - unlimited. ||
|| errors | **string** (int64)

The number of queries that threw exception.
0 - unlimited. ||
|| resultRows | **string** (int64)

The total number of rows given as the result..
0 - unlimited. ||
|| readRows | **string** (int64)

The total number of source rows read from tables for running the query, on all remote servers.
0 - unlimited. ||
|| executionTime | **string** (int64)

The total query execution time, in milliseconds (wall time).
0 - unlimited. ||
|#