---
editable: false
---

# Method get
Returns the specified ClickHouse User resource.
 
To get the list of available ClickHouse User resources, make a [list](/docs/managed-clickhouse/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [list](/docs/managed-clickhouse/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Name of the ClickHouse User resource to return. To get the name of the user, use a [list](/docs/managed-clickhouse/api-ref/User/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
    "insertQuorum": "integer",
    "insertQuorumTimeout": "integer",
    "selectSequentialConsistency": true,
    "maxReplicaDelayForDistributedQueries": "integer",
    "fallbackToStaleReplicasForDistributedQueries": true,
    "maxThreads": "integer",
    "maxBlockSize": "integer",
    "maxInsertBlockSize": "integer",
    "maxMemoryUsage": "integer",
    "maxMemoryUsageForUser": "integer",
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
    "maxExpandedAstElements": "integer"
  }
}
```
A ClickHouse User resource. For more information, see 
the [Developer's guide](/docs/managed-clickhouse/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the ClickHouse user.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.yandex/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
settings.<br>readonly | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_readonly">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
settings.<br>allowDdl | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_allow_ddl">ClickHouse documentation</a>.</p> 
settings.<br>insertQuorum | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds. Default value: 60000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum_timeout">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-select_sequential_consistency">ClickHouse documentation</a>.</p> 
settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used. Default value: 300000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">ClickHouse documentation</a>.</p> 
settings.<br>maxThreads | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_threads">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxBlockSize | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#max-block-size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_insert_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxMemoryUsage | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#settings_max_memory_usage">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-memory-usage-for-user">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxRowsToRead | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesToRead | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>readOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#read-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-group-by">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>groupByOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#group-by-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxRowsToSort | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-sort">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesToSort | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-sort">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>sortOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#sort-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxResultRows | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-rows">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxResultBytes | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-bytes">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>resultOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#result-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-in-distinct">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-in-distinct">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>distinctOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#distinct-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-transfer">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-transfer">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>transferOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#transfer-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxExecutionTime | **integer** (int64)<br><p>Maximum query execution time in milliseconds. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-execution-time">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>timeoutOverflowMode | **string**<br><p>See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#timeout-overflow-mode">ClickHouse documentation</a>.</p> 
settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Maximum number of columns that can be read from a table in a single query. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-columns-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-columns">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-non-const-columns">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
settings.<br>maxQuerySize | **integer** (int64)<br><p>The maximum part of a query that can be taken to RAM for parsing with the SQL parser, in bytes. Default value: 262144. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_query_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxAstDepth | **integer** (int64)<br><p>Maximum depth of query syntax tree. Default value: 1000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-ast-depth">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxAstElements | **integer** (int64)<br><p>Maximum size of query syntax tree in number of nodes. Default value: 50000. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-ast-elements">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000.</p> <p>Value must be greater than 0.</p> 