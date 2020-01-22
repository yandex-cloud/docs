---
editable: false
---

# UserService

A set of methods for managing ClickHouse User resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified ClickHouse User resource. |
| [List](#List) | Retrieves the list of ClickHouse User resources in the specified cluster. |
| [Create](#Create) | Creates a ClickHouse user in the specified cluster. |
| [Update](#Update) | Updates the specified ClickHouse user. |
| [Delete](#Delete) | Deletes the specified ClickHouse user. |
| [GrantPermission](#GrantPermission) | Grants a permission to the specified ClickHouse user. |
| [RevokePermission](#RevokePermission) | Revokes a permission from the specified ClickHouse user. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified ClickHouse User resource. <br>To get the list of available ClickHouse User resources, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the ClickHouse User resource to return. To get the name of the user, use a [UserService.List](#List) request.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse user. 
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user. 
settings | **[UserSettings](#UserSettings)**<br> 
quotas[] | **[UserQuota](#UserQuota)**<br>Set of quotas assigned to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
data_filters[] | **[DataFilter](#DataFilter)**<br> 


### DataFilter {#DataFilter}

Field | Description
--- | ---
table_name | **string**<br> 
filter | **string**<br> 


### UserSettings {#UserSettings}

Field | Description
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li>0 (default) —  no restrictions. </li><li>1 — only read data queries are allowed. </li><li>2 — read data and change settings queries are allowed. </li></ul> Acceptable values are 0 to 2, inclusive.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether DDL queries are allowed. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum). The minimum value is 0.
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Connection timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Receive timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Send timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/alter/#synchronicity-of-alter-queries). Acceptable values are 0 to 2, inclusive.
distributed_product_mode | enum **DistributedProductMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#distributed-product-mode). <ul><ul/>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the memory-saving mode of distributed aggregation is enabled. 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout for DDL queries, in milliseconds. 
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query compilation is enabled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#compile). 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of structurally identical queries before they are compiled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#min-count-to-compile). The minimum value is 0.
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether expression compilation is enabled. 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of identical expressions before they are compiled. The minimum value is 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#max-block-size). Value must be greater than 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to `0`, blocks will never be squashed. The minimum value is 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough.  If set to `0`, blocks will never be squashed. The minimum value is 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_insert_block_size). Value must be greater than 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-min_bytes_to_use_direct_io). The minimum value is 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_max_rows_to_use_cache). Value must be greater than 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Value must be greater than 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of rows to be read from a file to enable concurrent read. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_min_rows_for_concurrent_read). Value must be greater than 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of bytes to be read from a file to enable concurrent read. Value must be greater than 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the query. The minimum value is 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_threads). Value must be greater than 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#settings_max_memory_usage). The minimum value is 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-memory-usage-for-user). The minimum value is 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth). 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth_for_user). 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-force_index_by_date). 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#force-primary-key). 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-read). The minimum value is 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-read). The minimum value is 0.
read_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-group-by). The minimum value is 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-sort). The minimum value is 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-sort). The minimum value is 0.
sort_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-rows). The minimum value is 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-bytes). The minimum value is 0.
result_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-in-distinct). The minimum value is 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-in-distinct). The minimum value is 0.
distinct_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-transfer). The minimum value is 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-transfer). The minimum value is 0.
transfer_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum query execution time in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-execution-time). The minimum value is 0.
timeout_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of columns that can be read from a table in a single query. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-columns-to-read). The minimum value is 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-columns). The minimum value is 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-non-const-columns). The minimum value is 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000. Value must be greater than 0.
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields). 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether quoting of 64-bit integers is enabled in JSON output format. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-output_format_json_quote_64bit_integers). 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether output of special floating-point values (`+nan`, `-nan`, `+inf` and `-inf`) is enabled in JSON output format. 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP connection timeout, in milliseconds. 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP receive timeout, in milliseconds. 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP send timeout, in milliseconds. 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-enable_http_compression). 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-send_progress_in_http_headers). 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum interval between progress notifications, in milliseconds. Default value: 100. 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether CORS header in HTTP responses is enabled. Default value: `false`. 


### UserQuota {#UserQuota}

Field | Description
--- | ---
interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Duration of interval for quota in milliseconds. Minimal value is 1 minute. The minimum value is 60000.
queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of queries. 0 - unlimited. The minimum value is 0.
errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of queries that threw exception. 0 - unlimited. The minimum value is 0.
result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of rows given as the result.. 0 - unlimited. The minimum value is 0.
read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited. The minimum value is 0.
execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total query execution time, in milliseconds (wall time). 0 - unlimited. The minimum value is 0.


## List {#List}

Retrieves the list of ClickHouse User resources in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list ClickHouse users in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](#User1)**<br>List of ClickHouse User resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest1), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse user. 
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to the user. 
settings | **[UserSettings](#UserSettings1)**<br> 
quotas[] | **[UserQuota](#UserQuota1)**<br>Set of quotas assigned to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
data_filters[] | **[DataFilter](#DataFilter1)**<br> 


### DataFilter {#DataFilter}

Field | Description
--- | ---
table_name | **string**<br> 
filter | **string**<br> 


### UserSettings {#UserSettings}

Field | Description
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li>0 (default) —  no restrictions. </li><li>1 — only read data queries are allowed. </li><li>2 — read data and change settings queries are allowed. </li></ul> Acceptable values are 0 to 2, inclusive.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether DDL queries are allowed. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum). The minimum value is 0.
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Connection timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Receive timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Send timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/alter/#synchronicity-of-alter-queries). Acceptable values are 0 to 2, inclusive.
distributed_product_mode | enum **DistributedProductMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#distributed-product-mode). <ul><ul/>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the memory-saving mode of distributed aggregation is enabled. 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout for DDL queries, in milliseconds. 
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query compilation is enabled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#compile). 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of structurally identical queries before they are compiled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#min-count-to-compile). The minimum value is 0.
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether expression compilation is enabled. 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of identical expressions before they are compiled. The minimum value is 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#max-block-size). Value must be greater than 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to `0`, blocks will never be squashed. The minimum value is 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough.  If set to `0`, blocks will never be squashed. The minimum value is 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_insert_block_size). Value must be greater than 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-min_bytes_to_use_direct_io). The minimum value is 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_max_rows_to_use_cache). Value must be greater than 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Value must be greater than 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of rows to be read from a file to enable concurrent read. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_min_rows_for_concurrent_read). Value must be greater than 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of bytes to be read from a file to enable concurrent read. Value must be greater than 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the query. The minimum value is 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_threads). Value must be greater than 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#settings_max_memory_usage). The minimum value is 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-memory-usage-for-user). The minimum value is 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth). 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth_for_user). 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-force_index_by_date). 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#force-primary-key). 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-read). The minimum value is 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-read). The minimum value is 0.
read_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-group-by). The minimum value is 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-sort). The minimum value is 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-sort). The minimum value is 0.
sort_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-rows). The minimum value is 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-bytes). The minimum value is 0.
result_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-in-distinct). The minimum value is 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-in-distinct). The minimum value is 0.
distinct_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-transfer). The minimum value is 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-transfer). The minimum value is 0.
transfer_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum query execution time in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-execution-time). The minimum value is 0.
timeout_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of columns that can be read from a table in a single query. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-columns-to-read). The minimum value is 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-columns). The minimum value is 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-non-const-columns). The minimum value is 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000. Value must be greater than 0.
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields). 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether quoting of 64-bit integers is enabled in JSON output format. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-output_format_json_quote_64bit_integers). 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether output of special floating-point values (`+nan`, `-nan`, `+inf` and `-inf`) is enabled in JSON output format. 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP connection timeout, in milliseconds. 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP receive timeout, in milliseconds. 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP send timeout, in milliseconds. 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-enable_http_compression). 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-send_progress_in_http_headers). 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum interval between progress notifications, in milliseconds. Default value: 100. 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether CORS header in HTTP responses is enabled. Default value: `false`. 


### UserQuota {#UserQuota}

Field | Description
--- | ---
interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Duration of interval for quota in milliseconds. Minimal value is 1 minute. The minimum value is 60000.
queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of queries. 0 - unlimited. The minimum value is 0.
errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of queries that threw exception. 0 - unlimited. The minimum value is 0.
result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of rows given as the result.. 0 - unlimited. The minimum value is 0.
read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited. The minimum value is 0.
execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total query execution time, in milliseconds (wall time). 0 - unlimited. The minimum value is 0.


## Create {#Create}

Creates a ClickHouse user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to create a user in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
user_spec | **[UserSpec](#UserSpec)**<br>Required. Properties of the user to be created. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the ClickHouse user.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the ClickHouse user.  The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions to grant to the user. 
settings | **[UserSettings](#UserSettings2)**<br> 
quotas[] | **[UserQuota](#UserQuota2)**<br>Set of quotas assigned to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
data_filters[] | **[DataFilter](#DataFilter2)**<br> 


### DataFilter {#DataFilter}

Field | Description
--- | ---
table_name | **string**<br> 
filter | **string**<br> 


### UserSettings {#UserSettings}

Field | Description
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li>0 (default) —  no restrictions. </li><li>1 — only read data queries are allowed. </li><li>2 — read data and change settings queries are allowed. </li></ul> Acceptable values are 0 to 2, inclusive.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether DDL queries are allowed. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum). The minimum value is 0.
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Connection timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Receive timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Send timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/alter/#synchronicity-of-alter-queries). Acceptable values are 0 to 2, inclusive.
distributed_product_mode | enum **DistributedProductMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#distributed-product-mode). <ul><ul/>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the memory-saving mode of distributed aggregation is enabled. 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout for DDL queries, in milliseconds. 
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query compilation is enabled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#compile). 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of structurally identical queries before they are compiled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#min-count-to-compile). The minimum value is 0.
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether expression compilation is enabled. 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of identical expressions before they are compiled. The minimum value is 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#max-block-size). Value must be greater than 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to `0`, blocks will never be squashed. The minimum value is 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough.  If set to `0`, blocks will never be squashed. The minimum value is 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_insert_block_size). Value must be greater than 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-min_bytes_to_use_direct_io). The minimum value is 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_max_rows_to_use_cache). Value must be greater than 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Value must be greater than 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of rows to be read from a file to enable concurrent read. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_min_rows_for_concurrent_read). Value must be greater than 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of bytes to be read from a file to enable concurrent read. Value must be greater than 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the query. The minimum value is 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_threads). Value must be greater than 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#settings_max_memory_usage). The minimum value is 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-memory-usage-for-user). The minimum value is 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth). 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth_for_user). 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-force_index_by_date). 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#force-primary-key). 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-read). The minimum value is 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-read). The minimum value is 0.
read_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-group-by). The minimum value is 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-sort). The minimum value is 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-sort). The minimum value is 0.
sort_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-rows). The minimum value is 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-bytes). The minimum value is 0.
result_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-in-distinct). The minimum value is 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-in-distinct). The minimum value is 0.
distinct_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-transfer). The minimum value is 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-transfer). The minimum value is 0.
transfer_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum query execution time in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-execution-time). The minimum value is 0.
timeout_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of columns that can be read from a table in a single query. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-columns-to-read). The minimum value is 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-columns). The minimum value is 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-non-const-columns). The minimum value is 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000. Value must be greater than 0.
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields). 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether quoting of 64-bit integers is enabled in JSON output format. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-output_format_json_quote_64bit_integers). 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether output of special floating-point values (`+nan`, `-nan`, `+inf` and `-inf`) is enabled in JSON output format. 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP connection timeout, in milliseconds. 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP receive timeout, in milliseconds. 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP send timeout, in milliseconds. 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-enable_http_compression). 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-send_progress_in_http_headers). 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum interval between progress notifications, in milliseconds. Default value: 100. 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether CORS header in HTTP responses is enabled. Default value: `false`. 


### UserQuota {#UserQuota}

Field | Description
--- | ---
interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Duration of interval for quota in milliseconds. Minimal value is 1 minute. The minimum value is 60000.
queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of queries. 0 - unlimited. The minimum value is 0.
errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of queries that threw exception. 0 - unlimited. The minimum value is 0.
result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of rows given as the result.. 0 - unlimited. The minimum value is 0.
read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited. The minimum value is 0.
execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total query execution time, in milliseconds (wall time). 0 - unlimited. The minimum value is 0.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateUserMetadata](#CreateUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User2)>**<br>if operation finished successfully. 


### CreateUserMetadata {#CreateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster the user is being created in. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse user. 
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to the user. 
settings | **[UserSettings](#UserSettings3)**<br> 
quotas[] | **[UserQuota](#UserQuota3)**<br>Set of quotas assigned to the user. 


## Update {#Update}

Updates the specified ClickHouse user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to be updated. To get the name of the user, use a [UserService.List](#List) request.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the ClickHouse user should be updated. 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission3)**<br>New set of permissions for the user. 
settings | **[UserSettings](#UserSettings3)**<br> 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
data_filters[] | **[DataFilter](#DataFilter3)**<br> 


### DataFilter {#DataFilter}

Field | Description
--- | ---
table_name | **string**<br> 
filter | **string**<br> 


### UserSettings {#UserSettings}

Field | Description
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li>0 (default) —  no restrictions. </li><li>1 — only read data queries are allowed. </li><li>2 — read data and change settings queries are allowed. </li></ul> Acceptable values are 0 to 2, inclusive.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether DDL queries are allowed. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-insert_quorum). The minimum value is 0.
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Connection timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Receive timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Send timeout in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout). Value must be greater than 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> The minimum value is 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/alter/#synchronicity-of-alter-queries). Acceptable values are 0 to 2, inclusive.
distributed_product_mode | enum **DistributedProductMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#distributed-product-mode). <ul><ul/>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the memory-saving mode of distributed aggregation is enabled. 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout for DDL queries, in milliseconds. 
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query compilation is enabled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#compile). 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of structurally identical queries before they are compiled. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#min-count-to-compile). The minimum value is 0.
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether expression compilation is enabled. 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of identical expressions before they are compiled. The minimum value is 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#max-block-size). Value must be greater than 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to `0`, blocks will never be squashed. The minimum value is 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough.  If set to `0`, blocks will never be squashed. The minimum value is 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_insert_block_size). Value must be greater than 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-min_bytes_to_use_direct_io). The minimum value is 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_max_rows_to_use_cache). Value must be greater than 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Value must be greater than 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of rows to be read from a file to enable concurrent read. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#setting-merge_tree_min_rows_for_concurrent_read). Value must be greater than 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of bytes to be read from a file to enable concurrent read. Value must be greater than 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the query. The minimum value is 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_threads). Value must be greater than 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#settings_max_memory_usage). The minimum value is 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-memory-usage-for-user). The minimum value is 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth). 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-max_network_bandwidth_for_user). 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-force_index_by_date). 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#force-primary-key). 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-read). The minimum value is 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-read). The minimum value is 0.
read_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-group-by). The minimum value is 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-sort). The minimum value is 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-sort). The minimum value is 0.
sort_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-rows). The minimum value is 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-result-bytes). The minimum value is 0.
result_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-in-distinct). The minimum value is 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-in-distinct). The minimum value is 0.
distinct_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-rows-to-transfer). The minimum value is 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-bytes-to-transfer). The minimum value is 0.
transfer_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum query execution time in milliseconds. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-execution-time). The minimum value is 0.
timeout_overflow_mode | enum **OverflowMode**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of columns that can be read from a table in a single query. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-columns-to-read). The minimum value is 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-columns). The minimum value is 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/query_complexity/#max-temporary-non-const-columns). The minimum value is 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li></li></ol> Value must be greater than 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000. Value must be greater than 0.
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields). 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether quoting of 64-bit integers is enabled in JSON output format. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#session_settings-output_format_json_quote_64bit_integers). 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether output of special floating-point values (`+nan`, `-nan`, `+inf` and `-inf`) is enabled in JSON output format. 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP connection timeout, in milliseconds. 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP receive timeout, in milliseconds. 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP send timeout, in milliseconds. 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-enable_http_compression). 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: `false`. See in-depth description in [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/settings/settings/#settings-send_progress_in_http_headers). 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum interval between progress notifications, in milliseconds. Default value: 100. 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether CORS header in HTTP responses is enabled. Default value: `false`. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateUserMetadata](#UpdateUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User3)>**<br>if operation finished successfully. 


### UpdateUserMetadata {#UpdateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse user. 
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
permissions[] | **[Permission](#Permission4)**<br>Set of permissions granted to the user. 
settings | **[UserSettings](#UserSettings4)**<br> 
quotas[] | **[UserQuota](#UserQuota3)**<br>Set of quotas assigned to the user. 


## Delete {#Delete}

Deletes the specified ClickHouse user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to delete. To get the name of the user, use a [UserService.List](#List) request.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteUserMetadata](#DeleteUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteUserMetadata {#DeleteUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants a permission to the specified ClickHouse user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to grant the permission to. To get the name of the user, use a [UserService.List](#List) request.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Permission that should be granted to the specified user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
data_filters[] | **[DataFilter](#DataFilter4)**<br> 


### DataFilter {#DataFilter}

Field | Description
--- | ---
table_name | **string**<br> 
filter | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User4)>**<br>if operation finished successfully. 


### GrantUserPermissionMetadata {#GrantUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse user. 
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user. 
settings | **[UserSettings](#UserSettings4)**<br> 
quotas[] | **[UserQuota](#UserQuota3)**<br>Set of quotas assigned to the user. 


## RevokePermission {#RevokePermission}

Revokes a permission from the specified ClickHouse user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request.  The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to revoke a permission from. To get the name of the user, use a [UserService.List](#List) request.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
database_name | **string**<br>Name of the database that the user should lose access to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User5)>**<br>if operation finished successfully. 


### RevokeUserPermissionMetadata {#RevokeUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse user. 
cluster_id | **string**<br>ID of the ClickHouse cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user. 
settings | **[UserSettings](#UserSettings4)**<br> 
quotas[] | **[UserQuota](#UserQuota3)**<br>Set of quotas assigned to the user. 


