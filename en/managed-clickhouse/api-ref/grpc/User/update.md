---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/User/update.md
---

# Managed Service for ClickHouse API, gRPC: UserService.Update

Updates the specified ClickHouse user.

## gRPC request

**rpc Update ([UpdateUserRequest](#yandex.cloud.mdb.clickhouse.v1.UpdateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateUserRequest {#yandex.cloud.mdb.clickhouse.v1.UpdateUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string",
  "update_mask": "google.protobuf.FieldMask",
  "password": "string",
  "permissions": [
    {
      "database_name": "string"
    }
  ],
  "settings": {
    "readonly": "google.protobuf.Int64Value",
    "allow_ddl": "google.protobuf.BoolValue",
    "allow_introspection_functions": "google.protobuf.BoolValue",
    "connect_timeout": "google.protobuf.Int64Value",
    "connect_timeout_with_failover": "google.protobuf.Int64Value",
    "receive_timeout": "google.protobuf.Int64Value",
    "send_timeout": "google.protobuf.Int64Value",
    "idle_connection_timeout": "google.protobuf.Int64Value",
    "timeout_before_checking_execution_speed": "google.protobuf.Int64Value",
    "insert_quorum": "google.protobuf.Int64Value",
    "insert_quorum_timeout": "google.protobuf.Int64Value",
    "insert_quorum_parallel": "google.protobuf.BoolValue",
    "select_sequential_consistency": "google.protobuf.BoolValue",
    "replication_alter_partitions_sync": "google.protobuf.Int64Value",
    "max_replica_delay_for_distributed_queries": "google.protobuf.Int64Value",
    "fallback_to_stale_replicas_for_distributed_queries": "google.protobuf.BoolValue",
    "distributed_product_mode": "DistributedProductMode",
    "distributed_aggregation_memory_efficient": "google.protobuf.BoolValue",
    "distributed_ddl_task_timeout": "google.protobuf.Int64Value",
    "distributed_ddl_output_mode": "DistributedDdlOutputMode",
    "skip_unavailable_shards": "google.protobuf.BoolValue",
    "use_hedged_requests": "google.protobuf.BoolValue",
    "hedged_connection_timeout_ms": "google.protobuf.Int64Value",
    "load_balancing": "LoadBalancing",
    "prefer_localhost_replica": "google.protobuf.BoolValue",
    "compile_expressions": "google.protobuf.BoolValue",
    "min_count_to_compile_expression": "google.protobuf.Int64Value",
    "max_block_size": "google.protobuf.Int64Value",
    "min_insert_block_size_rows": "google.protobuf.Int64Value",
    "min_insert_block_size_bytes": "google.protobuf.Int64Value",
    "max_insert_block_size": "google.protobuf.Int64Value",
    "max_partitions_per_insert_block": "google.protobuf.Int64Value",
    "min_bytes_to_use_direct_io": "google.protobuf.Int64Value",
    "use_uncompressed_cache": "google.protobuf.BoolValue",
    "merge_tree_max_rows_to_use_cache": "google.protobuf.Int64Value",
    "merge_tree_max_bytes_to_use_cache": "google.protobuf.Int64Value",
    "merge_tree_min_rows_for_concurrent_read": "google.protobuf.Int64Value",
    "merge_tree_min_bytes_for_concurrent_read": "google.protobuf.Int64Value",
    "max_bytes_before_external_group_by": "google.protobuf.Int64Value",
    "max_bytes_before_external_sort": "google.protobuf.Int64Value",
    "group_by_two_level_threshold": "google.protobuf.Int64Value",
    "group_by_two_level_threshold_bytes": "google.protobuf.Int64Value",
    "deduplicate_blocks_in_dependent_materialized_views": "google.protobuf.BoolValue",
    "local_filesystem_read_method": "LocalFilesystemReadMethod",
    "remote_filesystem_read_method": "RemoteFilesystemReadMethod",
    "priority": "google.protobuf.Int64Value",
    "max_threads": "google.protobuf.Int64Value",
    "max_insert_threads": "google.protobuf.Int64Value",
    "max_memory_usage": "google.protobuf.Int64Value",
    "max_memory_usage_for_user": "google.protobuf.Int64Value",
    "memory_overcommit_ratio_denominator": "google.protobuf.Int64Value",
    "memory_overcommit_ratio_denominator_for_user": "google.protobuf.Int64Value",
    "memory_usage_overcommit_max_wait_microseconds": "google.protobuf.Int64Value",
    "max_network_bandwidth": "google.protobuf.Int64Value",
    "max_network_bandwidth_for_user": "google.protobuf.Int64Value",
    "max_temporary_data_on_disk_size_for_query": "google.protobuf.Int64Value",
    "max_temporary_data_on_disk_size_for_user": "google.protobuf.Int64Value",
    "max_concurrent_queries_for_user": "google.protobuf.Int64Value",
    "force_index_by_date": "google.protobuf.BoolValue",
    "force_primary_key": "google.protobuf.BoolValue",
    "max_rows_to_read": "google.protobuf.Int64Value",
    "max_bytes_to_read": "google.protobuf.Int64Value",
    "read_overflow_mode": "OverflowMode",
    "max_rows_to_group_by": "google.protobuf.Int64Value",
    "group_by_overflow_mode": "GroupByOverflowMode",
    "max_rows_to_sort": "google.protobuf.Int64Value",
    "max_bytes_to_sort": "google.protobuf.Int64Value",
    "sort_overflow_mode": "OverflowMode",
    "max_result_rows": "google.protobuf.Int64Value",
    "max_result_bytes": "google.protobuf.Int64Value",
    "result_overflow_mode": "OverflowMode",
    "max_rows_in_distinct": "google.protobuf.Int64Value",
    "max_bytes_in_distinct": "google.protobuf.Int64Value",
    "distinct_overflow_mode": "OverflowMode",
    "max_rows_to_transfer": "google.protobuf.Int64Value",
    "max_bytes_to_transfer": "google.protobuf.Int64Value",
    "transfer_overflow_mode": "OverflowMode",
    "max_execution_time": "google.protobuf.Int64Value",
    "timeout_overflow_mode": "OverflowMode",
    "max_rows_in_set": "google.protobuf.Int64Value",
    "max_bytes_in_set": "google.protobuf.Int64Value",
    "set_overflow_mode": "OverflowMode",
    "max_rows_in_join": "google.protobuf.Int64Value",
    "max_bytes_in_join": "google.protobuf.Int64Value",
    "join_overflow_mode": "OverflowMode",
    "max_columns_to_read": "google.protobuf.Int64Value",
    "max_temporary_columns": "google.protobuf.Int64Value",
    "max_temporary_non_const_columns": "google.protobuf.Int64Value",
    "max_query_size": "google.protobuf.Int64Value",
    "max_ast_depth": "google.protobuf.Int64Value",
    "max_ast_elements": "google.protobuf.Int64Value",
    "max_expanded_ast_elements": "google.protobuf.Int64Value",
    "max_parser_depth": "google.protobuf.Int64Value",
    "min_execution_speed": "google.protobuf.Int64Value",
    "min_execution_speed_bytes": "google.protobuf.Int64Value",
    "input_format_values_interpret_expressions": "google.protobuf.BoolValue",
    "input_format_defaults_for_omitted_fields": "google.protobuf.BoolValue",
    "input_format_null_as_default": "google.protobuf.BoolValue",
    "input_format_with_names_use_header": "google.protobuf.BoolValue",
    "output_format_json_quote_64bit_integers": "google.protobuf.BoolValue",
    "output_format_json_quote_denormals": "google.protobuf.BoolValue",
    "date_time_input_format": "DateTimeInputFormat",
    "date_time_output_format": "DateTimeOutputFormat",
    "low_cardinality_allow_in_native_format": "google.protobuf.BoolValue",
    "empty_result_for_aggregation_by_empty_set": "google.protobuf.BoolValue",
    "format_regexp": "string",
    "format_regexp_escaping_rule": "FormatRegexpEscapingRule",
    "format_regexp_skip_unmatched": "google.protobuf.BoolValue",
    "input_format_parallel_parsing": "google.protobuf.BoolValue",
    "input_format_import_nested_json": "google.protobuf.BoolValue",
    "format_avro_schema_registry_url": "string",
    "data_type_default_nullable": "google.protobuf.BoolValue",
    "http_connection_timeout": "google.protobuf.Int64Value",
    "http_receive_timeout": "google.protobuf.Int64Value",
    "http_send_timeout": "google.protobuf.Int64Value",
    "enable_http_compression": "google.protobuf.BoolValue",
    "send_progress_in_http_headers": "google.protobuf.BoolValue",
    "http_headers_progress_interval": "google.protobuf.Int64Value",
    "add_http_cors_header": "google.protobuf.BoolValue",
    "cancel_http_readonly_queries_on_client_close": "google.protobuf.BoolValue",
    "max_http_get_redirects": "google.protobuf.Int64Value",
    "http_max_field_name_size": "google.protobuf.Int64Value",
    "http_max_field_value_size": "google.protobuf.Int64Value",
    "quota_mode": "QuotaMode",
    "async_insert": "google.protobuf.BoolValue",
    "wait_for_async_insert": "google.protobuf.BoolValue",
    "wait_for_async_insert_timeout": "google.protobuf.Int64Value",
    "async_insert_max_data_size": "google.protobuf.Int64Value",
    "async_insert_busy_timeout": "google.protobuf.Int64Value",
    "async_insert_use_adaptive_busy_timeout": "google.protobuf.BoolValue",
    "log_query_threads": "google.protobuf.BoolValue",
    "log_query_views": "google.protobuf.BoolValue",
    "log_queries_probability": "google.protobuf.DoubleValue",
    "log_processors_profiles": "google.protobuf.BoolValue",
    "use_query_cache": "google.protobuf.BoolValue",
    "enable_reads_from_query_cache": "google.protobuf.BoolValue",
    "enable_writes_to_query_cache": "google.protobuf.BoolValue",
    "query_cache_min_query_runs": "google.protobuf.Int64Value",
    "query_cache_min_query_duration": "google.protobuf.Int64Value",
    "query_cache_ttl": "google.protobuf.Int64Value",
    "query_cache_max_entries": "google.protobuf.Int64Value",
    "query_cache_max_size_in_bytes": "google.protobuf.Int64Value",
    "query_cache_tag": "string",
    "query_cache_share_between_users": "google.protobuf.BoolValue",
    "query_cache_nondeterministic_function_handling": "QueryCacheNondeterministicFunctionHandling",
    "query_cache_system_table_handling": "QueryCacheSystemTableHandling",
    "count_distinct_implementation": "CountDistinctImplementation",
    "joined_subquery_requires_alias": "google.protobuf.BoolValue",
    "join_use_nulls": "google.protobuf.BoolValue",
    "transform_null_in": "google.protobuf.BoolValue",
    "insert_null_as_default": "google.protobuf.BoolValue",
    "join_algorithm": [
      "JoinAlgorithm"
    ],
    "any_join_distinct_right_table_keys": "google.protobuf.BoolValue",
    "allow_suspicious_low_cardinality_types": "google.protobuf.BoolValue",
    "flatten_nested": "google.protobuf.BoolValue",
    "memory_profiler_step": "google.protobuf.Int64Value",
    "memory_profiler_sample_probability": "google.protobuf.DoubleValue",
    "max_final_threads": "google.protobuf.Int64Value",
    "max_read_buffer_size": "google.protobuf.Int64Value",
    "insert_keeper_max_retries": "google.protobuf.Int64Value",
    "do_not_merge_across_partitions_select_final": "google.protobuf.BoolValue",
    "ignore_materialized_views_with_dropped_target_table": "google.protobuf.BoolValue",
    "enable_analyzer": "google.protobuf.BoolValue",
    "s3_use_adaptive_timeouts": "google.protobuf.BoolValue",
    "compile": "google.protobuf.BoolValue",
    "min_count_to_compile": "google.protobuf.Int64Value",
    "async_insert_threads": "google.protobuf.Int64Value",
    "async_insert_stale_timeout": "google.protobuf.Int64Value"
  },
  "quotas": [
    {
      "interval_duration": "google.protobuf.Int64Value",
      "queries": "google.protobuf.Int64Value",
      "errors": "google.protobuf.Int64Value",
      "result_rows": "google.protobuf.Int64Value",
      "read_rows": "google.protobuf.Int64Value",
      "execution_time": "google.protobuf.Int64Value"
    }
  ],
  "generate_password": "google.protobuf.BoolValue"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the user to be updated.
To get the name of the user, use a [UserService.List](/docs/managed-clickhouse/api-ref/grpc/User/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the ClickHouse user should be updated. ||
|| password | **string**

New password for the user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission)**

New set of permissions for the user. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings)** ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota)** ||
|| generate_password | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Generate password using Connection Manager. ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings}

ClickHouse user settings. Supported settings are a subset of settings described
in [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/).

#|
||Field | Description ||
|| readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use **allow_ddl** instead.
* **0** - no restrictions.
* **1** - only read data queries are allowed.
* **2** - read data and change settings queries are allowed.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/permissions-for-queries#readonly). ||
|| allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows or denies DDL queries (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/permissions-for-queries#allow_ddl). ||
|| allow_introspection_functions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables introspection functions for query profiling.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#allow_introspection_functions). ||
|| connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout in milliseconds.

Default value: **10000** (10 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout). ||
|| connect_timeout_with_failover | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The timeout in milliseconds for connecting to a remote server for a Distributed table engine.

Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **1000** (1 second).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout_with_failover_ms). ||
|| receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Receive timeout in milliseconds.

Default value: **300000** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#receive_timeout). ||
|| send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Send timeout in milliseconds.

Default value: **300000** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#send_timeout). ||
|| idle_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout to close idle TCP connections after specified time has elapsed, in milliseconds.

Default value: **3600000** (1 hour).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#idle_connection_timeout). ||
|| timeout_before_checking_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Checks that the speed is not too low after the specified time has elapsed, in milliseconds. It is checked that execution speed
is not less that specified in **min_execution_speed** parameter.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#timeout_before_checking_execution_speed). ||
|| insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Enables or disables the quorum writes. If the value is less than **2**, then the quorum writes is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors
until the **insert_quorum_timeout** expires. All replicas in the quorum are in the consistent state, meaning that they contain
linearized data from the previous **INSERT** queries. Employ write quorum, if you need the guarantees that the written data
would not be lost in case of one or more replicas failure.

You can use **select_sequential_consistency** setting to read the data written with write quorum.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum). ||
|| insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the **insert_quorum** replicas,
then ClickHouse will abort the execution of **INSERT** query and return an error. In this case, the client must send the query again
to write the data block into the same or another replica.

Default value: **600000** (10 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum_timeout). ||
|| insert_quorum_parallel | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables parallelism for quorum **INSERT** queries.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum_parallel). ||
|| select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines the behavior of **SELECT** queries from replicated tables. If enabled, ClickHouse will terminate a query with error message in case
the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#select_sequential_consistency). ||
|| replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Wait mode for asynchronous actions in **ALTER** queries on replicated tables.
* **0** - do not wait for replicas.
* **1** - only wait for own execution.
* **2** - wait for all replicas.

Default value: **1**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#alter_sync). ||
|| max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Default value: **300000** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_replica_delay_for_distributed_queries). ||
|| fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#fallback_to_stale_replicas_for_distributed_queries). ||
|| distributed_product_mode | enum **DistributedProductMode**

Determines the behavior of distributed subqueries.

Default value: **DISTRIBUTED_PRODUCT_MODE_DENY**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_product_mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_aggregation_memory_efficient). ||
|| distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for DDL queries, in milliseconds.

Default value: **180000** (3 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_ddl_task_timeout). ||
|| distributed_ddl_output_mode | enum **DistributedDdlOutputMode**

Determines the format of distributed DDL query result.

Default value: **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_ddl_output_mode).

- `DISTRIBUTED_DDL_OUTPUT_MODE_UNSPECIFIED`
- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW`: Returns result set with query execution status for all hosts where query is finished. If query has failed on some hosts, then it will rethrow the first exception.
If query is not finished yet on some hosts and **distributed_ddl_task_timeout** exceeded, then it throws **TIMEOUT_EXCEEDED** exception.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**, but distributed DDL query returns no result set.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT`: Returns **NULL** as execution status in some rows of result set instead of throwing **TIMEOUT_EXCEEDED** if query is not finished on the corresponding hosts.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW`: Do not throw **TIMEOUT_EXCEEDED** and do not rethrow exceptions if query has failed on some hosts.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_NONE**, but doesn't wait for inactive replicas of the **Replicated** database.
With this mode it's impossible to figure out that the query was not executed on some replica and will be executed in background.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT**, but doesn't wait for inactive replicas of the **Replicated** database.
- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**, but doesn't wait for inactive replicas of the **Replicated** database. ||
|| skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#skip_unavailable_shards). ||
|| use_hedged_requests | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables hedged requests logic for remote queries.

It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s)
were not established within **hedged_connection_timeout** or no data was received within **receive_data_timeout**. Query uses the first connection
which send non empty progress packet, other connections are cancelled.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_hedged_requests). ||
|| hedged_connection_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout for establishing connection with replica for Hedged requests.

Default value: **50**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#hedged_connection_timeout_ms). ||
|| load_balancing | enum **LoadBalancing**

Algorithm of replicas selection that is used for distributed query processing.

Default value: **LOAD_BALANCING_RANDOM**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#load_balancing).

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| prefer_localhost_replica | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable preferable using the localhost replica when processing distributed queries.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#prefer_localhost_replica). ||
|| compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable expression compilation to native code.

If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with **min_count_to_compile_expression** setting.

Default value: **true** for versions 25.5 and higher, **false** for versions 25.4 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#compile_expressions). ||
|| min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many identical expressions ClickHouse has to encounter before they are compiled.

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.

Default value: **3**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_count_to_compile_expression). ||
|| max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the recommended maximum number of rows to include in a single block when loading data from tables.

Blocks the size of **max_block_size** are not always loaded from the table: if ClickHouse determines that less data needs to be retrieved,
a smaller block is processed.

The block size should not be too small to avoid noticeable costs when processing each block. It should also not be too large to ensure that
queries with a **LIMIT** clause execute quickly after processing the first block. When setting **max_block_size**, the goal should be to avoid
consuming too much memory when extracting a large number of columns in multiple threads and to preserve at least some cache locality.

Default value: **65409**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_block_size). ||
|| min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value,
will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled.

Default value: **1048449**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_insert_block_size_rows). ||
|| min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value,
will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled.

Default value: **268402944**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_insert_block_size_bytes). ||
|| max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size of blocks (in a count of rows) to form for insertion into a table.

This setting only applies in cases when the server forms the blocks. For example, for an **INSERT** via the HTTP interface, the server parses
the data format and forms blocks of the specified size. But when using clickhouse-client, the client parses the data itself, and
the **max_insert_block_size** setting on the server does not affect the size of the inserted blocks. The setting also does not have a purpose
when using **INSERT SELECT**, since data is inserted using the same blocks that are formed after **SELECT**.

Default value: **1048449**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_insert_block_size). ||
|| max_partitions_per_insert_block | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When inserting data, ClickHouse calculates the number of partitions in the inserted block.
If the number of partitions is more than **max_partitions_per_insert_block**, ClickHouse throws an exception.

Default value: **100**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings-max_partitions_per_insert_block). ||
|| min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). If set to **0**, Direct I/O is disabled.

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy
is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk,
bypassing the filesystem cache.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_bytes_to_use_direct_io). ||
|| use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use the cache of uncompressed blocks, or not.

Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_uncompressed_cache). ||
|| merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.

Use this setting in combination with **use_uncompressed_cache** setting.

Default value: **1048576**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_max_rows_to_use_cache). ||
|| merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.

Use this setting in combination with **use_uncompressed_cache** setting.

Default value: **2013265920** (1920 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_max_bytes_to_use_cache). ||
|| merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Default value: **163840**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_min_rows_for_concurrent_read). ||
|| merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Default value: **251658240** (240 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_min_bytes_for_concurrent_read). ||
|| max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation,
should be flushed to disk to limit the RAM consumption. If set to **0**, **GROUP BY** in the external memory is disabled.

By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data
volumes that can lead to memory exhaustion and abortion of the query (see the **max_memory_usage** setting). For such queries,
you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_before_external_group_by). ||
|| max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **ORDER BY** operation,
should be flushed to disk to limit the RAM consumption. If set to **0**, **ORDER BY** in the external memory is disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_before_external_sort). ||
|| group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of keys, after that the two-level aggregation should be used. **0** means threshold is not set.

Default value: **100000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_two_level_threshold). ||
|| group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of bytes, after that the two-level aggregation should be used. **0** means threshold is not set.

Default value: **50000000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_two_level_threshold_bytes). ||
|| deduplicate_blocks_in_dependent_materialized_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the deduplication check for materialized views that receive data from replicated tables.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#deduplicate_blocks_in_dependent_materialized_views). ||
|| local_filesystem_read_method | enum **LocalFilesystemReadMethod**

Method of reading data from local filesystem.

The LOCAL_FILESYSTEM_READ_METHOD_IO_URING is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and
other tables with append-able files in presence of concurrent reads and writes.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#local_filesystem_read_method).

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP`
- `LOCAL_FILESYSTEM_READ_METHOD_IO_URING` ||
|| remote_filesystem_read_method | enum **RemoteFilesystemReadMethod**

Method of reading data from remote filesystem.

Default value: **REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#remote_filesystem_read_method).

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the priority of a query.
* **0** - priorities are not used.
* **1** - the highest priority.
* and so on. The higher the number, the lower a query's priority.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query
is paused until higher-priority queries are completed.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#priority). ||
|| max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of threads to process the request. If set to **0**, the number of threads is calculated automatically based on the number of available CPU cores.

The setting applies to threads that perform the same stages of the query processing pipeline in parallel. It does not take threads that read data from remote servers into account.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_threads). ||
|| max_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute the **INSERT SELECT** query.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_insert_threads). ||
|| max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. **0** means unlimited.

This limitation is enforced for any user's single query on a single server.

If you use **max_bytes_before_external_group_by** or **max_bytes_before_external_sort** setting, then it is recommended to set
their values twice as low as **max_memory_usage** setting value.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_memory_usage). ||
|| max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. **0** means unlimited.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_memory_usage_for_user). ||
|| memory_overcommit_ratio_denominator | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents the soft memory limit when the hard limit is reached on the global level.
This value is used to compute the overcommit ratio for the query. **0** means skip the query.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_overcommit_ratio_denominator). ||
|| memory_overcommit_ratio_denominator_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents the soft memory limit when the hard limit is reached on the user level.
This value is used to compute the overcommit ratio for the user. **0** means skip the query.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_overcommit_ratio_denominator_for_user). ||
|| memory_usage_overcommit_max_wait_microseconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time thread will wait for memory to be freed in the case of memory overcommit. If the timeout is reached and memory is not freed, an exception is thrown.

Default value: **5000000** (5 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds). ||
|| max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for a query. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max-network-bandwidth). ||
|| max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max-network-bandwidth-for-user). ||
|| max_temporary_data_on_disk_size_for_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query). ||
|| max_temporary_data_on_disk_size_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user). ||
|| max_concurrent_queries_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneously processed queries per user. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_concurrent_queries_for_user). ||
|| force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Disables query execution if the index cannot be used by date.

This setting has effect only for tables of the MergeTree family.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#force_index_by_date). ||
|| force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Disables query execution if indexing by the primary key cannot be used.

This setting has effect only for tables of the MergeTree family.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#force_primary_key). ||
|| max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table when running a query.  **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#max-rows-to-read). ||
|| max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.  **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#max-bytes-to-read). ||
|| read_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while reading the data.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#read_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of unique keys received from aggregation. **0** means unlimited.
This setting lets you limit RAM consumption when aggregating.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_group_by). ||
|| group_by_overflow_mode | enum **GroupByOverflowMode**

Determines the behavior on exceeding limits while doing aggregation.

Default value: **GROUP_BY_OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_overflow_mode).

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `GROUP_BY_OVERFLOW_MODE_BREAK`: Return a partial result.
- `GROUP_BY_OVERFLOW_MODE_ANY`: Continuing aggregation for the keys that got into the set, but do not add new keys to the set. ||
|| max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table for sorting. **0** means unlimited.
This setting lets you to limit RAM consumption when sorting

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_sort). ||
|| max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. **0** means unlimited.
This setting lets you to limit RAM consumption when sorting

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_to_sort). ||
|| sort_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while sorting.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#sort_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of rows in the result. **0** means unlimited.

This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_result_rows). ||
|| max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the result size in bytes (uncompressed data). **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_result_bytes). ||
|| result_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while forming result.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#result_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of different rows in the state, which is used for performing **DISTINCT**. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_distinct). ||
|| max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) in the state, which is used for performing **DISTINCT**. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_distinct). ||
|| distinct_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while performing **DISTINCT**.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distinct_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN\|JOIN**. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_transfer). ||
|| max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN\|JOIN**.
**0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_to_transfer). ||
|| transfer_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while transfering data.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#transfer_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum query execution time in milliseconds. **0** means unlimited.

The timeout is checked and the query can stop only in designated places during data processing.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_execution_time). ||
|| timeout_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits of execution time.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#timeout_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits on the maximum number of rows in the set resulting from the execution of the **IN** section. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_set). ||
|| max_bytes_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits on the maximum number of bytes (uncompressed data) in the set resulting from the execution of the **IN** section. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_set). ||
|| set_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#set_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows in the hash table that is used when joining tables. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_join). ||
|| max_bytes_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes in the hash table that is used when joining tables. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_join). ||
|| join_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of columns that can be read from a table in a single query. **0** means unlimited.
If the query requires to read more columns to complete, then it will be aborted.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_columns_to_read). ||
|| max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, including constant columns. **0** means unlimited.
If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_temporary_columns). ||
|| max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, not including constant columns. **0** means unlimited.
If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_temporary_non_const_columns). ||
|| max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Data in the **VALUES** clause of **INSERT** queries is processed by a separate stream parser (that consumes O(1) RAM) and not affected by this restriction.

Default value: **262144** (256 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_query_size). ||
|| max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Default value: **1000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_ast_depth). ||
|| max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Default value: **50000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_ast_elements). ||
|| max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Default value: **500000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_expanded_ast_elements). ||
|| max_parser_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. If set to **0**, recursion depth is unlimited.

Default value: **1000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_parser_depth). ||
|| min_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in rows per second. Checked on every data block when timeout_before_checking_execution_speed expires.
If the execution speed is lower, an exception is thrown. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_execution_speed). ||
|| min_execution_speed_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in bytes per second. Checked on every data block when timeout_before_checking_execution_speed expires.
If the execution speed is lower, an exception is thrown. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_execution_speed_bytes). ||
|| input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value
will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the **now()** expression
will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_values_interpret_expressions). ||
|| input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_defaults_for_omitted_fields). ||
|| input_format_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the initialization of **NULL** fields with default values, if data type of these fields is not nullable.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_null_as_default). ||
|| input_format_with_names_use_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables checking the column order when inserting data.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_with_names_use_header). ||
|| output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output
in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#output_format_json_quote_64bit_integers). ||
|| output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#output_format_json_quote_denormals). ||
|| date_time_input_format | enum **DateTimeInputFormat**

Specifies which of date time parsers to use.

Default value: **DATE_TIME_INPUT_FORMAT_BASIC**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| date_time_output_format | enum **DateTimeOutputFormat**

Specifies which of date time output formats to use.

Default value: **DATE_TIME_OUTPUT_FORMAT_SIMPLE**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows or restricts using the LowCardinality data type with the Native format.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret
the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column
when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#low_cardinality_allow_in_native_format). ||
|| empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).
* **true** - ClickHouse will return an empty result for such queries.
* **false** - ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#empty_result_for_aggregation_by_empty_set). ||
|| format_regexp | **string**

Regular expression (for Regexp format).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp). ||
|| format_regexp_escaping_rule | enum **FormatRegexpEscapingRule**

Field escaping rule (for Regexp format).

Default value: **FORMAT_REGEXP_ESCAPING_RULE_RAW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| format_regexp_skip_unmatched | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Skip lines unmatched by regular expression (for Regexp format)

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp_skip_unmatched). ||
|| input_format_parallel_parsing | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables order-preserving parallel parsing of data formats. Supported only for TSV, TSKV, CSV and JSONEachRow formats.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#input_format_parallel_parsing). ||
|| input_format_import_nested_json | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the insertion of JSON data with nested objects.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_import_nested_json). ||
|| format_avro_schema_registry_url | **string**

Avro schema registry URL.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_avro_schema_registry_url). ||
|| data_type_default_nullable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows data types without explicit modifiers **NULL** or **NOT NULL** in column definition will be Nullable.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#data_type_default_nullable). ||
|| http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP connection timeout, in milliseconds.

Default value: **1000** (1 second).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_connection_timeout). ||
|| http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP receive timeout, in milliseconds.

Default value: **30000** (30 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_receive_timeout). ||
|| http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP send timeout, in milliseconds.

Default value: **30000** (30 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_send_timeout). ||
|| enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_http_compression). ||
|| send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#send_progress_in_http_headers). ||
|| http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Default value: **100**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_headers_progress_interval_ms). ||
|| add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Adds CORS header in HTTP responses.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#add_http_cors_header). ||
|| cancel_http_readonly_queries_on_client_close | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Cancels HTTP read-only queries (e.g. **SELECT**) when a client closes the connection without waiting for the response.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#cancel_http_readonly_queries_on_client_close). ||
|| max_http_get_redirects | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of HTTP GET redirect hops. If set to **0**, no hops is allowed.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_http_get_redirects). ||
|| http_max_field_name_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field name in HTTP header.

Default value: **131072**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_max_field_name_size). ||
|| http_max_field_value_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field value in HTTP header.

Default value: **131072**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_max_field_value_size). ||
|| quota_mode | enum **QuotaMode**

Quota accounting mode.

Default value: **QUOTA_MODE_DEFAULT**.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If enabled, data from **INSERT** query is stored in queue and later flushed to table in background.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert). ||
|| wait_for_async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#wait_for_async_insert). ||
|| wait_for_async_insert_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for waiting for processing asynchronous inserts, in seconds.

Default value: **120** (2 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#wait_for_async_insert_timeout). ||
|| async_insert_max_data_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the unparsed data in bytes collected per query before being inserted.

Default value: **10485760** (10 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_max_data_size). ||
|| async_insert_busy_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time to wait before dumping collected data per query since the first data appeared.

Default value: **200**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_busy_timeout_max_ms). ||
|| async_insert_use_adaptive_busy_timeout | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables of disables adaptive busy timeout for asynchronous inserts.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_use_adaptive_busy_timeout). ||
|| log_query_threads | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query threads logging to the the system.query_thread_log table.
This setting has effect only when **log_queries** setting is enabled.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_query_threads). ||
|| log_query_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query views logging to the the system.query_views_log table.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_query_views). ||
|| log_queries_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Log queries with the specified probability.

Default value: **1**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_queries_probability). ||
|| log_processors_profiles | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables logging of processors level profiling data to the the system.processors_profile_log table.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_processors_profiles). ||
|| use_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, **SELECT** queries may utilize the query cache.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_query_cache). ||
|| enable_reads_from_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of **SELECT** queries are retrieved from the query cache.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_reads_from_query_cache). ||
|| enable_writes_to_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of **SELECT** queries are stored in the query cache.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_writes_to_query_cache). ||
|| query_cache_min_query_runs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of times a **SELECT** query must run before its result is stored in the query cache.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_min_query_runs). ||
|| query_cache_min_query_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_min_query_duration). ||
|| query_cache_ttl | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

After this time in seconds entries in the query cache become stale.

Default value: **60** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_ttl). ||
|| query_cache_max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of query results the current user may store in the query cache. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_max_entries). ||
|| query_cache_max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of memory (in bytes) the current user may allocate in the query cache. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_max_size_in_bytes). ||
|| query_cache_tag | **string**

A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_tag). ||
|| query_cache_share_between_users | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, the result of **SELECT** queries cached in the query cache can be read by other users.

It is not recommended to enable this setting due to security reasons.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_share_between_users). ||
|| query_cache_nondeterministic_function_handling | enum **QueryCacheNondeterministicFunctionHandling**

Controls how the query cache handles **SELECT** queries with non-deterministic functions like rand() or now().

Default value: **QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_nondeterministic_function_handling).

- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_UNSPECIFIED`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`: Throw an exception and don't cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`: Cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception. ||
|| query_cache_system_table_handling | enum **QueryCacheSystemTableHandling**

Controls how the query cache handles **SELECT** queries against system tables.

Default value: **QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_system_table_handling).

- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_UNSPECIFIED`
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW`: Throw an exception and don't cache the query result.
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE`: Cache the query result.
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception. ||
|| count_distinct_implementation | enum **CountDistinctImplementation**

Specifies which of the uniq* functions should be used to perform the **COUNT(DISTINCT ...)** construction.

Default value: **COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#count_distinct_implementation).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| joined_subquery_requires_alias | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Force joined subqueries and table functions to have aliases for correct name qualification.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#joined_subquery_requires_alias). ||
|| join_use_nulls | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines **JOIN** behavior on filling empty cells when merging tables. If enabled, the empty cells are filled with **NULL**.
Otherwise, the empty cells are filled with the default value of the corresponding field type.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_use_nulls). ||
|| transform_null_in | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables equality of **NULL** values for **IN** operator.

By default, **NULL** values can't be compared because **NULL** means undefined value. Thus, comparison **expr = NULL** must always return false.
With this setting enabled **NULL = NULL** returns true for **IN** operator.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#transform_null_in). ||
|| insert_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the insertion of default values instead of **NULL** into columns with not nullable data type.

If column type is not nullable and this setting is disabled, then inserting NULL causes an exception.
If column type is nullable, then NULL values are inserted as is, regardless of this setting.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_null_as_default). ||
|| join_algorithm[] | enum **JoinAlgorithm**

Specifies which JOIN algorithm to use.

Default value: **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_PARALLEL_HASH,JOIN_ALGORITHM_HASH** for versions 24.12 and higher, **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_AUTO** for versions from 23.8 to 24.11, **JOIN_ALGORITHM_AUTO** for versions 23.7 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| any_join_distinct_right_table_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables legacy ClickHouse server behaviour in **ANY INNER\|LEFT JOIN** operations.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#any_join_distinct_right_table_keys). ||
|| allow_suspicious_low_cardinality_types | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows or restricts using LowCardinality with data types with fixed size of 8 bytes or less.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#allow_suspicious_low_cardinality_types). ||
|| flatten_nested | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets the data format of nested columns.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#flatten_nested). ||
|| memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the step of memory profiler. Whenever query memory usage becomes larger than every next step in number of bytes the memory profiler
will collect the allocating stacktrace and will write it into trace_log. If set to **0**, memory profiler is disabled.

Default value: **4194304**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_profiler_step). ||
|| memory_profiler_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Collect random allocations and deallocations and write them into system.trace_log with MemorySample trace_type.
The probability is for every alloc/free regardless to the size of the allocation.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_profiler_sample_probability). ||
|| max_final_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of parallel threads for the **SELECT** query data read phase with the **FINAL** modifier.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_final_threads). ||
|| max_read_buffer_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the buffer to read from the filesystem.

Default value: **1048576** (1 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_read_buffer_size). ||
|| insert_keeper_max_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree tables.
Only Keeper requests which failed due to network error, Keeper session timeout or request timeout are considered for retries.

Default value: **20**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_keeper_max_retries). ||
|| do_not_merge_across_partitions_select_final | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable independent processing of partitions for **SELECT** queries with **FINAL**.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree). ||
|| ignore_materialized_views_with_dropped_target_table | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Ignore materialized views with dropped target table during pushing to views.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#ignore_materialized_views_with_dropped_target_table). ||
|| enable_analyzer | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables new query analyzer.

Default value: **true** for versions 25.5 and higher, **false** for versions 25.4 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/guides/developer/understanding-query-execution-with-the-analyzer#analyzer). ||
|| s3_use_adaptive_timeouts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables adaptive timeouts for S3 requests.
* **true** - for all S3 requests first two attempts are made with low send and receive timeouts.
* **false** - all attempts are made with identical timeouts.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#s3_use_adaptive_timeouts). ||
|| compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

The setting is deprecated and has no effect. ||
|| min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| async_insert_stale_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/quotas/).

#|
||Field | Description ||
|| interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Duration of interval for quota in milliseconds. ||
|| queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of queries. **0** means unlimited. ||
|| errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of queries that threw exception. **0** means unlimited. ||
|| result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of rows given as the result. **0** means unlimited. ||
|| read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of source rows read from tables for running the query, on all remote servers. **0** means unlimited. ||
|| execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total query execution time, in milliseconds (wall time). **0** means unlimited. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "user_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
    "permissions": [
      {
        "database_name": "string"
      }
    ],
    "settings": {
      "readonly": "google.protobuf.Int64Value",
      "allow_ddl": "google.protobuf.BoolValue",
      "allow_introspection_functions": "google.protobuf.BoolValue",
      "connect_timeout": "google.protobuf.Int64Value",
      "connect_timeout_with_failover": "google.protobuf.Int64Value",
      "receive_timeout": "google.protobuf.Int64Value",
      "send_timeout": "google.protobuf.Int64Value",
      "idle_connection_timeout": "google.protobuf.Int64Value",
      "timeout_before_checking_execution_speed": "google.protobuf.Int64Value",
      "insert_quorum": "google.protobuf.Int64Value",
      "insert_quorum_timeout": "google.protobuf.Int64Value",
      "insert_quorum_parallel": "google.protobuf.BoolValue",
      "select_sequential_consistency": "google.protobuf.BoolValue",
      "replication_alter_partitions_sync": "google.protobuf.Int64Value",
      "max_replica_delay_for_distributed_queries": "google.protobuf.Int64Value",
      "fallback_to_stale_replicas_for_distributed_queries": "google.protobuf.BoolValue",
      "distributed_product_mode": "DistributedProductMode",
      "distributed_aggregation_memory_efficient": "google.protobuf.BoolValue",
      "distributed_ddl_task_timeout": "google.protobuf.Int64Value",
      "distributed_ddl_output_mode": "DistributedDdlOutputMode",
      "skip_unavailable_shards": "google.protobuf.BoolValue",
      "use_hedged_requests": "google.protobuf.BoolValue",
      "hedged_connection_timeout_ms": "google.protobuf.Int64Value",
      "load_balancing": "LoadBalancing",
      "prefer_localhost_replica": "google.protobuf.BoolValue",
      "compile_expressions": "google.protobuf.BoolValue",
      "min_count_to_compile_expression": "google.protobuf.Int64Value",
      "max_block_size": "google.protobuf.Int64Value",
      "min_insert_block_size_rows": "google.protobuf.Int64Value",
      "min_insert_block_size_bytes": "google.protobuf.Int64Value",
      "max_insert_block_size": "google.protobuf.Int64Value",
      "max_partitions_per_insert_block": "google.protobuf.Int64Value",
      "min_bytes_to_use_direct_io": "google.protobuf.Int64Value",
      "use_uncompressed_cache": "google.protobuf.BoolValue",
      "merge_tree_max_rows_to_use_cache": "google.protobuf.Int64Value",
      "merge_tree_max_bytes_to_use_cache": "google.protobuf.Int64Value",
      "merge_tree_min_rows_for_concurrent_read": "google.protobuf.Int64Value",
      "merge_tree_min_bytes_for_concurrent_read": "google.protobuf.Int64Value",
      "max_bytes_before_external_group_by": "google.protobuf.Int64Value",
      "max_bytes_before_external_sort": "google.protobuf.Int64Value",
      "group_by_two_level_threshold": "google.protobuf.Int64Value",
      "group_by_two_level_threshold_bytes": "google.protobuf.Int64Value",
      "deduplicate_blocks_in_dependent_materialized_views": "google.protobuf.BoolValue",
      "local_filesystem_read_method": "LocalFilesystemReadMethod",
      "remote_filesystem_read_method": "RemoteFilesystemReadMethod",
      "priority": "google.protobuf.Int64Value",
      "max_threads": "google.protobuf.Int64Value",
      "max_insert_threads": "google.protobuf.Int64Value",
      "max_memory_usage": "google.protobuf.Int64Value",
      "max_memory_usage_for_user": "google.protobuf.Int64Value",
      "memory_overcommit_ratio_denominator": "google.protobuf.Int64Value",
      "memory_overcommit_ratio_denominator_for_user": "google.protobuf.Int64Value",
      "memory_usage_overcommit_max_wait_microseconds": "google.protobuf.Int64Value",
      "max_network_bandwidth": "google.protobuf.Int64Value",
      "max_network_bandwidth_for_user": "google.protobuf.Int64Value",
      "max_temporary_data_on_disk_size_for_query": "google.protobuf.Int64Value",
      "max_temporary_data_on_disk_size_for_user": "google.protobuf.Int64Value",
      "max_concurrent_queries_for_user": "google.protobuf.Int64Value",
      "force_index_by_date": "google.protobuf.BoolValue",
      "force_primary_key": "google.protobuf.BoolValue",
      "max_rows_to_read": "google.protobuf.Int64Value",
      "max_bytes_to_read": "google.protobuf.Int64Value",
      "read_overflow_mode": "OverflowMode",
      "max_rows_to_group_by": "google.protobuf.Int64Value",
      "group_by_overflow_mode": "GroupByOverflowMode",
      "max_rows_to_sort": "google.protobuf.Int64Value",
      "max_bytes_to_sort": "google.protobuf.Int64Value",
      "sort_overflow_mode": "OverflowMode",
      "max_result_rows": "google.protobuf.Int64Value",
      "max_result_bytes": "google.protobuf.Int64Value",
      "result_overflow_mode": "OverflowMode",
      "max_rows_in_distinct": "google.protobuf.Int64Value",
      "max_bytes_in_distinct": "google.protobuf.Int64Value",
      "distinct_overflow_mode": "OverflowMode",
      "max_rows_to_transfer": "google.protobuf.Int64Value",
      "max_bytes_to_transfer": "google.protobuf.Int64Value",
      "transfer_overflow_mode": "OverflowMode",
      "max_execution_time": "google.protobuf.Int64Value",
      "timeout_overflow_mode": "OverflowMode",
      "max_rows_in_set": "google.protobuf.Int64Value",
      "max_bytes_in_set": "google.protobuf.Int64Value",
      "set_overflow_mode": "OverflowMode",
      "max_rows_in_join": "google.protobuf.Int64Value",
      "max_bytes_in_join": "google.protobuf.Int64Value",
      "join_overflow_mode": "OverflowMode",
      "max_columns_to_read": "google.protobuf.Int64Value",
      "max_temporary_columns": "google.protobuf.Int64Value",
      "max_temporary_non_const_columns": "google.protobuf.Int64Value",
      "max_query_size": "google.protobuf.Int64Value",
      "max_ast_depth": "google.protobuf.Int64Value",
      "max_ast_elements": "google.protobuf.Int64Value",
      "max_expanded_ast_elements": "google.protobuf.Int64Value",
      "max_parser_depth": "google.protobuf.Int64Value",
      "min_execution_speed": "google.protobuf.Int64Value",
      "min_execution_speed_bytes": "google.protobuf.Int64Value",
      "input_format_values_interpret_expressions": "google.protobuf.BoolValue",
      "input_format_defaults_for_omitted_fields": "google.protobuf.BoolValue",
      "input_format_null_as_default": "google.protobuf.BoolValue",
      "input_format_with_names_use_header": "google.protobuf.BoolValue",
      "output_format_json_quote_64bit_integers": "google.protobuf.BoolValue",
      "output_format_json_quote_denormals": "google.protobuf.BoolValue",
      "date_time_input_format": "DateTimeInputFormat",
      "date_time_output_format": "DateTimeOutputFormat",
      "low_cardinality_allow_in_native_format": "google.protobuf.BoolValue",
      "empty_result_for_aggregation_by_empty_set": "google.protobuf.BoolValue",
      "format_regexp": "string",
      "format_regexp_escaping_rule": "FormatRegexpEscapingRule",
      "format_regexp_skip_unmatched": "google.protobuf.BoolValue",
      "input_format_parallel_parsing": "google.protobuf.BoolValue",
      "input_format_import_nested_json": "google.protobuf.BoolValue",
      "format_avro_schema_registry_url": "string",
      "data_type_default_nullable": "google.protobuf.BoolValue",
      "http_connection_timeout": "google.protobuf.Int64Value",
      "http_receive_timeout": "google.protobuf.Int64Value",
      "http_send_timeout": "google.protobuf.Int64Value",
      "enable_http_compression": "google.protobuf.BoolValue",
      "send_progress_in_http_headers": "google.protobuf.BoolValue",
      "http_headers_progress_interval": "google.protobuf.Int64Value",
      "add_http_cors_header": "google.protobuf.BoolValue",
      "cancel_http_readonly_queries_on_client_close": "google.protobuf.BoolValue",
      "max_http_get_redirects": "google.protobuf.Int64Value",
      "http_max_field_name_size": "google.protobuf.Int64Value",
      "http_max_field_value_size": "google.protobuf.Int64Value",
      "quota_mode": "QuotaMode",
      "async_insert": "google.protobuf.BoolValue",
      "wait_for_async_insert": "google.protobuf.BoolValue",
      "wait_for_async_insert_timeout": "google.protobuf.Int64Value",
      "async_insert_max_data_size": "google.protobuf.Int64Value",
      "async_insert_busy_timeout": "google.protobuf.Int64Value",
      "async_insert_use_adaptive_busy_timeout": "google.protobuf.BoolValue",
      "log_query_threads": "google.protobuf.BoolValue",
      "log_query_views": "google.protobuf.BoolValue",
      "log_queries_probability": "google.protobuf.DoubleValue",
      "log_processors_profiles": "google.protobuf.BoolValue",
      "use_query_cache": "google.protobuf.BoolValue",
      "enable_reads_from_query_cache": "google.protobuf.BoolValue",
      "enable_writes_to_query_cache": "google.protobuf.BoolValue",
      "query_cache_min_query_runs": "google.protobuf.Int64Value",
      "query_cache_min_query_duration": "google.protobuf.Int64Value",
      "query_cache_ttl": "google.protobuf.Int64Value",
      "query_cache_max_entries": "google.protobuf.Int64Value",
      "query_cache_max_size_in_bytes": "google.protobuf.Int64Value",
      "query_cache_tag": "string",
      "query_cache_share_between_users": "google.protobuf.BoolValue",
      "query_cache_nondeterministic_function_handling": "QueryCacheNondeterministicFunctionHandling",
      "query_cache_system_table_handling": "QueryCacheSystemTableHandling",
      "count_distinct_implementation": "CountDistinctImplementation",
      "joined_subquery_requires_alias": "google.protobuf.BoolValue",
      "join_use_nulls": "google.protobuf.BoolValue",
      "transform_null_in": "google.protobuf.BoolValue",
      "insert_null_as_default": "google.protobuf.BoolValue",
      "join_algorithm": [
        "JoinAlgorithm"
      ],
      "any_join_distinct_right_table_keys": "google.protobuf.BoolValue",
      "allow_suspicious_low_cardinality_types": "google.protobuf.BoolValue",
      "flatten_nested": "google.protobuf.BoolValue",
      "memory_profiler_step": "google.protobuf.Int64Value",
      "memory_profiler_sample_probability": "google.protobuf.DoubleValue",
      "max_final_threads": "google.protobuf.Int64Value",
      "max_read_buffer_size": "google.protobuf.Int64Value",
      "insert_keeper_max_retries": "google.protobuf.Int64Value",
      "do_not_merge_across_partitions_select_final": "google.protobuf.BoolValue",
      "ignore_materialized_views_with_dropped_target_table": "google.protobuf.BoolValue",
      "enable_analyzer": "google.protobuf.BoolValue",
      "s3_use_adaptive_timeouts": "google.protobuf.BoolValue",
      "compile": "google.protobuf.BoolValue",
      "min_count_to_compile": "google.protobuf.Int64Value",
      "async_insert_threads": "google.protobuf.Int64Value",
      "async_insert_stale_timeout": "google.protobuf.Int64Value"
    },
    "quotas": [
      {
        "interval_duration": "google.protobuf.Int64Value",
        "queries": "google.protobuf.Int64Value",
        "errors": "google.protobuf.Int64Value",
        "result_rows": "google.protobuf.Int64Value",
        "read_rows": "google.protobuf.Int64Value",
        "execution_time": "google.protobuf.Int64Value"
      }
    ],
    "connection_manager": {
      "connection_id": "string"
    }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateUserMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateUserMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## UpdateUserMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateUserMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the ClickHouse cluster the user belongs to. ||
|| user_name | **string**

Name of the user that is being updated. ||
|#

## User {#yandex.cloud.mdb.clickhouse.v1.User}

A ClickHouse User resource. For more information, see the [Developer's guide](/docs/managed-clickhouse/concepts).

#|
||Field | Description ||
|| name | **string**

Required field. User name. ||
|| cluster_id | **string**

Required field. Cluster ID. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission2)**

User permissions. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings2)**

User settings. ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota2)**

Quotas assigned to the user. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.clickhouse.v1.ConnectionManager)**

Connection Manager connection configuration. ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission2}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings2}

ClickHouse user settings. Supported settings are a subset of settings described
in [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/).

#|
||Field | Description ||
|| readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use **allow_ddl** instead.
* **0** - no restrictions.
* **1** - only read data queries are allowed.
* **2** - read data and change settings queries are allowed.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/permissions-for-queries#readonly). ||
|| allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows or denies DDL queries (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/permissions-for-queries#allow_ddl). ||
|| allow_introspection_functions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables introspection functions for query profiling.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#allow_introspection_functions). ||
|| connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout in milliseconds.

Default value: **10000** (10 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout). ||
|| connect_timeout_with_failover | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The timeout in milliseconds for connecting to a remote server for a Distributed table engine.

Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **1000** (1 second).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout_with_failover_ms). ||
|| receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Receive timeout in milliseconds.

Default value: **300000** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#receive_timeout). ||
|| send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Send timeout in milliseconds.

Default value: **300000** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#send_timeout). ||
|| idle_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout to close idle TCP connections after specified time has elapsed, in milliseconds.

Default value: **3600000** (1 hour).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#idle_connection_timeout). ||
|| timeout_before_checking_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Checks that the speed is not too low after the specified time has elapsed, in milliseconds. It is checked that execution speed
is not less that specified in **min_execution_speed** parameter.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#timeout_before_checking_execution_speed). ||
|| insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Enables or disables the quorum writes. If the value is less than **2**, then the quorum writes is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors
until the **insert_quorum_timeout** expires. All replicas in the quorum are in the consistent state, meaning that they contain
linearized data from the previous **INSERT** queries. Employ write quorum, if you need the guarantees that the written data
would not be lost in case of one or more replicas failure.

You can use **select_sequential_consistency** setting to read the data written with write quorum.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum). ||
|| insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the **insert_quorum** replicas,
then ClickHouse will abort the execution of **INSERT** query and return an error. In this case, the client must send the query again
to write the data block into the same or another replica.

Default value: **600000** (10 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum_timeout). ||
|| insert_quorum_parallel | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables parallelism for quorum **INSERT** queries.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum_parallel). ||
|| select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines the behavior of **SELECT** queries from replicated tables. If enabled, ClickHouse will terminate a query with error message in case
the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#select_sequential_consistency). ||
|| replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Wait mode for asynchronous actions in **ALTER** queries on replicated tables.
* **0** - do not wait for replicas.
* **1** - only wait for own execution.
* **2** - wait for all replicas.

Default value: **1**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#alter_sync). ||
|| max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Default value: **300000** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_replica_delay_for_distributed_queries). ||
|| fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#fallback_to_stale_replicas_for_distributed_queries). ||
|| distributed_product_mode | enum **DistributedProductMode**

Determines the behavior of distributed subqueries.

Default value: **DISTRIBUTED_PRODUCT_MODE_DENY**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_product_mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_aggregation_memory_efficient). ||
|| distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for DDL queries, in milliseconds.

Default value: **180000** (3 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_ddl_task_timeout). ||
|| distributed_ddl_output_mode | enum **DistributedDdlOutputMode**

Determines the format of distributed DDL query result.

Default value: **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_ddl_output_mode).

- `DISTRIBUTED_DDL_OUTPUT_MODE_UNSPECIFIED`
- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW`: Returns result set with query execution status for all hosts where query is finished. If query has failed on some hosts, then it will rethrow the first exception.
If query is not finished yet on some hosts and **distributed_ddl_task_timeout** exceeded, then it throws **TIMEOUT_EXCEEDED** exception.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**, but distributed DDL query returns no result set.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT`: Returns **NULL** as execution status in some rows of result set instead of throwing **TIMEOUT_EXCEEDED** if query is not finished on the corresponding hosts.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW`: Do not throw **TIMEOUT_EXCEEDED** and do not rethrow exceptions if query has failed on some hosts.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_NONE**, but doesn't wait for inactive replicas of the **Replicated** database.
With this mode it's impossible to figure out that the query was not executed on some replica and will be executed in background.
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT**, but doesn't wait for inactive replicas of the **Replicated** database.
- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**, but doesn't wait for inactive replicas of the **Replicated** database. ||
|| skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#skip_unavailable_shards). ||
|| use_hedged_requests | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables hedged requests logic for remote queries.

It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s)
were not established within **hedged_connection_timeout** or no data was received within **receive_data_timeout**. Query uses the first connection
which send non empty progress packet, other connections are cancelled.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_hedged_requests). ||
|| hedged_connection_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout for establishing connection with replica for Hedged requests.

Default value: **50**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#hedged_connection_timeout_ms). ||
|| load_balancing | enum **LoadBalancing**

Algorithm of replicas selection that is used for distributed query processing.

Default value: **LOAD_BALANCING_RANDOM**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#load_balancing).

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| prefer_localhost_replica | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable preferable using the localhost replica when processing distributed queries.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#prefer_localhost_replica). ||
|| compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable expression compilation to native code.

If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with **min_count_to_compile_expression** setting.

Default value: **true** for versions 25.5 and higher, **false** for versions 25.4 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#compile_expressions). ||
|| min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many identical expressions ClickHouse has to encounter before they are compiled.

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.

Default value: **3**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_count_to_compile_expression). ||
|| max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the recommended maximum number of rows to include in a single block when loading data from tables.

Blocks the size of **max_block_size** are not always loaded from the table: if ClickHouse determines that less data needs to be retrieved,
a smaller block is processed.

The block size should not be too small to avoid noticeable costs when processing each block. It should also not be too large to ensure that
queries with a **LIMIT** clause execute quickly after processing the first block. When setting **max_block_size**, the goal should be to avoid
consuming too much memory when extracting a large number of columns in multiple threads and to preserve at least some cache locality.

Default value: **65409**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_block_size). ||
|| min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value,
will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled.

Default value: **1048449**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_insert_block_size_rows). ||
|| min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value,
will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled.

Default value: **268402944**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_insert_block_size_bytes). ||
|| max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The size of blocks (in a count of rows) to form for insertion into a table.

This setting only applies in cases when the server forms the blocks. For example, for an **INSERT** via the HTTP interface, the server parses
the data format and forms blocks of the specified size. But when using clickhouse-client, the client parses the data itself, and
the **max_insert_block_size** setting on the server does not affect the size of the inserted blocks. The setting also does not have a purpose
when using **INSERT SELECT**, since data is inserted using the same blocks that are formed after **SELECT**.

Default value: **1048449**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_insert_block_size). ||
|| max_partitions_per_insert_block | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When inserting data, ClickHouse calculates the number of partitions in the inserted block.
If the number of partitions is more than **max_partitions_per_insert_block**, ClickHouse throws an exception.

Default value: **100**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings-max_partitions_per_insert_block). ||
|| min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). If set to **0**, Direct I/O is disabled.

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy
is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk,
bypassing the filesystem cache.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_bytes_to_use_direct_io). ||
|| use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use the cache of uncompressed blocks, or not.

Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_uncompressed_cache). ||
|| merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.

Use this setting in combination with **use_uncompressed_cache** setting.

Default value: **1048576**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_max_rows_to_use_cache). ||
|| merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.

Use this setting in combination with **use_uncompressed_cache** setting.

Default value: **2013265920** (1920 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_max_bytes_to_use_cache). ||
|| merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Default value: **163840**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_min_rows_for_concurrent_read). ||
|| merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Default value: **251658240** (240 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_min_bytes_for_concurrent_read). ||
|| max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation,
should be flushed to disk to limit the RAM consumption. If set to **0**, **GROUP BY** in the external memory is disabled.

By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data
volumes that can lead to memory exhaustion and abortion of the query (see the **max_memory_usage** setting). For such queries,
you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_before_external_group_by). ||
|| max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **ORDER BY** operation,
should be flushed to disk to limit the RAM consumption. If set to **0**, **ORDER BY** in the external memory is disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_before_external_sort). ||
|| group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of keys, after that the two-level aggregation should be used. **0** means threshold is not set.

Default value: **100000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_two_level_threshold). ||
|| group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of bytes, after that the two-level aggregation should be used. **0** means threshold is not set.

Default value: **50000000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_two_level_threshold_bytes). ||
|| deduplicate_blocks_in_dependent_materialized_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the deduplication check for materialized views that receive data from replicated tables.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#deduplicate_blocks_in_dependent_materialized_views). ||
|| local_filesystem_read_method | enum **LocalFilesystemReadMethod**

Method of reading data from local filesystem.

The LOCAL_FILESYSTEM_READ_METHOD_IO_URING is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and
other tables with append-able files in presence of concurrent reads and writes.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#local_filesystem_read_method).

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP`
- `LOCAL_FILESYSTEM_READ_METHOD_IO_URING` ||
|| remote_filesystem_read_method | enum **RemoteFilesystemReadMethod**

Method of reading data from remote filesystem.

Default value: **REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#remote_filesystem_read_method).

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the priority of a query.
* **0** - priorities are not used.
* **1** - the highest priority.
* and so on. The higher the number, the lower a query's priority.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query
is paused until higher-priority queries are completed.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#priority). ||
|| max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of threads to process the request. If set to **0**, the number of threads is calculated automatically based on the number of available CPU cores.

The setting applies to threads that perform the same stages of the query processing pipeline in parallel. It does not take threads that read data from remote servers into account.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_threads). ||
|| max_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute the **INSERT SELECT** query.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_insert_threads). ||
|| max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. **0** means unlimited.

This limitation is enforced for any user's single query on a single server.

If you use **max_bytes_before_external_group_by** or **max_bytes_before_external_sort** setting, then it is recommended to set
their values twice as low as **max_memory_usage** setting value.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_memory_usage). ||
|| max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. **0** means unlimited.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_memory_usage_for_user). ||
|| memory_overcommit_ratio_denominator | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents the soft memory limit when the hard limit is reached on the global level.
This value is used to compute the overcommit ratio for the query. **0** means skip the query.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_overcommit_ratio_denominator). ||
|| memory_overcommit_ratio_denominator_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents the soft memory limit when the hard limit is reached on the user level.
This value is used to compute the overcommit ratio for the user. **0** means skip the query.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_overcommit_ratio_denominator_for_user). ||
|| memory_usage_overcommit_max_wait_microseconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time thread will wait for memory to be freed in the case of memory overcommit. If the timeout is reached and memory is not freed, an exception is thrown.

Default value: **5000000** (5 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds). ||
|| max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for a query. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max-network-bandwidth). ||
|| max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max-network-bandwidth-for-user). ||
|| max_temporary_data_on_disk_size_for_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query). ||
|| max_temporary_data_on_disk_size_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user). ||
|| max_concurrent_queries_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneously processed queries per user. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_concurrent_queries_for_user). ||
|| force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Disables query execution if the index cannot be used by date.

This setting has effect only for tables of the MergeTree family.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#force_index_by_date). ||
|| force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Disables query execution if indexing by the primary key cannot be used.

This setting has effect only for tables of the MergeTree family.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#force_primary_key). ||
|| max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table when running a query.  **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#max-rows-to-read). ||
|| max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.  **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#max-bytes-to-read). ||
|| read_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while reading the data.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#read_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of unique keys received from aggregation. **0** means unlimited.
This setting lets you limit RAM consumption when aggregating.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_group_by). ||
|| group_by_overflow_mode | enum **GroupByOverflowMode**

Determines the behavior on exceeding limits while doing aggregation.

Default value: **GROUP_BY_OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_overflow_mode).

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `GROUP_BY_OVERFLOW_MODE_BREAK`: Return a partial result.
- `GROUP_BY_OVERFLOW_MODE_ANY`: Continuing aggregation for the keys that got into the set, but do not add new keys to the set. ||
|| max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table for sorting. **0** means unlimited.
This setting lets you to limit RAM consumption when sorting

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_sort). ||
|| max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. **0** means unlimited.
This setting lets you to limit RAM consumption when sorting

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_to_sort). ||
|| sort_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while sorting.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#sort_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of rows in the result. **0** means unlimited.

This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_result_rows). ||
|| max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the result size in bytes (uncompressed data). **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_result_bytes). ||
|| result_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while forming result.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#result_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of different rows in the state, which is used for performing **DISTINCT**. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_distinct). ||
|| max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) in the state, which is used for performing **DISTINCT**. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_distinct). ||
|| distinct_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while performing **DISTINCT**.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distinct_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN\|JOIN**. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_transfer). ||
|| max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN\|JOIN**.
**0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_to_transfer). ||
|| transfer_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits while transfering data.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#transfer_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum query execution time in milliseconds. **0** means unlimited.

The timeout is checked and the query can stop only in designated places during data processing.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_execution_time). ||
|| timeout_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding limits of execution time.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#timeout_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits on the maximum number of rows in the set resulting from the execution of the **IN** section. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_set). ||
|| max_bytes_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits on the maximum number of bytes (uncompressed data) in the set resulting from the execution of the **IN** section. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_set). ||
|| set_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#set_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_rows_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows in the hash table that is used when joining tables. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_join). ||
|| max_bytes_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes in the hash table that is used when joining tables. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_join). ||
|| join_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.

Default value: **OVERFLOW_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_overflow_mode).

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
- `OVERFLOW_MODE_BREAK`: Return a partial result. ||
|| max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of columns that can be read from a table in a single query. **0** means unlimited.
If the query requires to read more columns to complete, then it will be aborted.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_columns_to_read). ||
|| max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, including constant columns. **0** means unlimited.
If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_temporary_columns). ||
|| max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, not including constant columns. **0** means unlimited.
If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_temporary_non_const_columns). ||
|| max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Data in the **VALUES** clause of **INSERT** queries is processed by a separate stream parser (that consumes O(1) RAM) and not affected by this restriction.

Default value: **262144** (256 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_query_size). ||
|| max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Default value: **1000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_ast_depth). ||
|| max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Default value: **50000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_ast_elements). ||
|| max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Default value: **500000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_expanded_ast_elements). ||
|| max_parser_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. If set to **0**, recursion depth is unlimited.

Default value: **1000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_parser_depth). ||
|| min_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in rows per second. Checked on every data block when timeout_before_checking_execution_speed expires.
If the execution speed is lower, an exception is thrown. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_execution_speed). ||
|| min_execution_speed_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in bytes per second. Checked on every data block when timeout_before_checking_execution_speed expires.
If the execution speed is lower, an exception is thrown. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_execution_speed_bytes). ||
|| input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value
will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the **now()** expression
will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_values_interpret_expressions). ||
|| input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_defaults_for_omitted_fields). ||
|| input_format_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the initialization of **NULL** fields with default values, if data type of these fields is not nullable.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_null_as_default). ||
|| input_format_with_names_use_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables checking the column order when inserting data.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_with_names_use_header). ||
|| output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output
in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#output_format_json_quote_64bit_integers). ||
|| output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#output_format_json_quote_denormals). ||
|| date_time_input_format | enum **DateTimeInputFormat**

Specifies which of date time parsers to use.

Default value: **DATE_TIME_INPUT_FORMAT_BASIC**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| date_time_output_format | enum **DateTimeOutputFormat**

Specifies which of date time output formats to use.

Default value: **DATE_TIME_OUTPUT_FORMAT_SIMPLE**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows or restricts using the LowCardinality data type with the Native format.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret
the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column
when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#low_cardinality_allow_in_native_format). ||
|| empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).
* **true** - ClickHouse will return an empty result for such queries.
* **false** - ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#empty_result_for_aggregation_by_empty_set). ||
|| format_regexp | **string**

Regular expression (for Regexp format).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp). ||
|| format_regexp_escaping_rule | enum **FormatRegexpEscapingRule**

Field escaping rule (for Regexp format).

Default value: **FORMAT_REGEXP_ESCAPING_RULE_RAW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| format_regexp_skip_unmatched | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Skip lines unmatched by regular expression (for Regexp format)

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp_skip_unmatched). ||
|| input_format_parallel_parsing | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables order-preserving parallel parsing of data formats. Supported only for TSV, TSKV, CSV and JSONEachRow formats.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#input_format_parallel_parsing). ||
|| input_format_import_nested_json | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the insertion of JSON data with nested objects.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_import_nested_json). ||
|| format_avro_schema_registry_url | **string**

Avro schema registry URL.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_avro_schema_registry_url). ||
|| data_type_default_nullable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows data types without explicit modifiers **NULL** or **NOT NULL** in column definition will be Nullable.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#data_type_default_nullable). ||
|| http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP connection timeout, in milliseconds.

Default value: **1000** (1 second).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_connection_timeout). ||
|| http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP receive timeout, in milliseconds.

Default value: **30000** (30 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_receive_timeout). ||
|| http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP send timeout, in milliseconds.

Default value: **30000** (30 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_send_timeout). ||
|| enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_http_compression). ||
|| send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#send_progress_in_http_headers). ||
|| http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Default value: **100**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_headers_progress_interval_ms). ||
|| add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Adds CORS header in HTTP responses.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#add_http_cors_header). ||
|| cancel_http_readonly_queries_on_client_close | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Cancels HTTP read-only queries (e.g. **SELECT**) when a client closes the connection without waiting for the response.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#cancel_http_readonly_queries_on_client_close). ||
|| max_http_get_redirects | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of HTTP GET redirect hops. If set to **0**, no hops is allowed.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_http_get_redirects). ||
|| http_max_field_name_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field name in HTTP header.

Default value: **131072**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_max_field_name_size). ||
|| http_max_field_value_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field value in HTTP header.

Default value: **131072**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_max_field_value_size). ||
|| quota_mode | enum **QuotaMode**

Quota accounting mode.

Default value: **QUOTA_MODE_DEFAULT**.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If enabled, data from **INSERT** query is stored in queue and later flushed to table in background.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert). ||
|| wait_for_async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#wait_for_async_insert). ||
|| wait_for_async_insert_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for waiting for processing asynchronous inserts, in seconds.

Default value: **120** (2 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#wait_for_async_insert_timeout). ||
|| async_insert_max_data_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the unparsed data in bytes collected per query before being inserted.

Default value: **10485760** (10 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_max_data_size). ||
|| async_insert_busy_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time to wait before dumping collected data per query since the first data appeared.

Default value: **200**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_busy_timeout_max_ms). ||
|| async_insert_use_adaptive_busy_timeout | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables of disables adaptive busy timeout for asynchronous inserts.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_use_adaptive_busy_timeout). ||
|| log_query_threads | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query threads logging to the the system.query_thread_log table.
This setting has effect only when **log_queries** setting is enabled.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_query_threads). ||
|| log_query_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query views logging to the the system.query_views_log table.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_query_views). ||
|| log_queries_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Log queries with the specified probability.

Default value: **1**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_queries_probability). ||
|| log_processors_profiles | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables logging of processors level profiling data to the the system.processors_profile_log table.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_processors_profiles). ||
|| use_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, **SELECT** queries may utilize the query cache.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_query_cache). ||
|| enable_reads_from_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of **SELECT** queries are retrieved from the query cache.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_reads_from_query_cache). ||
|| enable_writes_to_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of **SELECT** queries are stored in the query cache.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_writes_to_query_cache). ||
|| query_cache_min_query_runs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of times a **SELECT** query must run before its result is stored in the query cache.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_min_query_runs). ||
|| query_cache_min_query_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_min_query_duration). ||
|| query_cache_ttl | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

After this time in seconds entries in the query cache become stale.

Default value: **60** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_ttl). ||
|| query_cache_max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of query results the current user may store in the query cache. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_max_entries). ||
|| query_cache_max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of memory (in bytes) the current user may allocate in the query cache. **0** means unlimited.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_max_size_in_bytes). ||
|| query_cache_tag | **string**

A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_tag). ||
|| query_cache_share_between_users | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, the result of **SELECT** queries cached in the query cache can be read by other users.

It is not recommended to enable this setting due to security reasons.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_share_between_users). ||
|| query_cache_nondeterministic_function_handling | enum **QueryCacheNondeterministicFunctionHandling**

Controls how the query cache handles **SELECT** queries with non-deterministic functions like rand() or now().

Default value: **QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_nondeterministic_function_handling).

- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_UNSPECIFIED`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`: Throw an exception and don't cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`: Cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception. ||
|| query_cache_system_table_handling | enum **QueryCacheSystemTableHandling**

Controls how the query cache handles **SELECT** queries against system tables.

Default value: **QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_system_table_handling).

- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_UNSPECIFIED`
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW`: Throw an exception and don't cache the query result.
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE`: Cache the query result.
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception. ||
|| count_distinct_implementation | enum **CountDistinctImplementation**

Specifies which of the uniq* functions should be used to perform the **COUNT(DISTINCT ...)** construction.

Default value: **COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#count_distinct_implementation).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| joined_subquery_requires_alias | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Force joined subqueries and table functions to have aliases for correct name qualification.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#joined_subquery_requires_alias). ||
|| join_use_nulls | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines **JOIN** behavior on filling empty cells when merging tables. If enabled, the empty cells are filled with **NULL**.
Otherwise, the empty cells are filled with the default value of the corresponding field type.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_use_nulls). ||
|| transform_null_in | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables equality of **NULL** values for **IN** operator.

By default, **NULL** values can't be compared because **NULL** means undefined value. Thus, comparison **expr = NULL** must always return false.
With this setting enabled **NULL = NULL** returns true for **IN** operator.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#transform_null_in). ||
|| insert_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the insertion of default values instead of **NULL** into columns with not nullable data type.

If column type is not nullable and this setting is disabled, then inserting NULL causes an exception.
If column type is nullable, then NULL values are inserted as is, regardless of this setting.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_null_as_default). ||
|| join_algorithm[] | enum **JoinAlgorithm**

Specifies which JOIN algorithm to use.

Default value: **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_PARALLEL_HASH,JOIN_ALGORITHM_HASH** for versions 24.12 and higher, **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_AUTO** for versions from 23.8 to 24.11, **JOIN_ALGORITHM_AUTO** for versions 23.7 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| any_join_distinct_right_table_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables legacy ClickHouse server behaviour in **ANY INNER\|LEFT JOIN** operations.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#any_join_distinct_right_table_keys). ||
|| allow_suspicious_low_cardinality_types | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows or restricts using LowCardinality with data types with fixed size of 8 bytes or less.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#allow_suspicious_low_cardinality_types). ||
|| flatten_nested | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets the data format of nested columns.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#flatten_nested). ||
|| memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the step of memory profiler. Whenever query memory usage becomes larger than every next step in number of bytes the memory profiler
will collect the allocating stacktrace and will write it into trace_log. If set to **0**, memory profiler is disabled.

Default value: **4194304**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_profiler_step). ||
|| memory_profiler_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Collect random allocations and deallocations and write them into system.trace_log with MemorySample trace_type.
The probability is for every alloc/free regardless to the size of the allocation.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_profiler_sample_probability). ||
|| max_final_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of parallel threads for the **SELECT** query data read phase with the **FINAL** modifier.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_final_threads). ||
|| max_read_buffer_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the buffer to read from the filesystem.

Default value: **1048576** (1 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_read_buffer_size). ||
|| insert_keeper_max_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree tables.
Only Keeper requests which failed due to network error, Keeper session timeout or request timeout are considered for retries.

Default value: **20**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_keeper_max_retries). ||
|| do_not_merge_across_partitions_select_final | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable independent processing of partitions for **SELECT** queries with **FINAL**.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree). ||
|| ignore_materialized_views_with_dropped_target_table | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Ignore materialized views with dropped target table during pushing to views.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#ignore_materialized_views_with_dropped_target_table). ||
|| enable_analyzer | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables new query analyzer.

Default value: **true** for versions 25.5 and higher, **false** for versions 25.4 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/guides/developer/understanding-query-execution-with-the-analyzer#analyzer). ||
|| s3_use_adaptive_timeouts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables adaptive timeouts for S3 requests.
* **true** - for all S3 requests first two attempts are made with low send and receive timeouts.
* **false** - all attempts are made with identical timeouts.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#s3_use_adaptive_timeouts). ||
|| compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

The setting is deprecated and has no effect. ||
|| min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| async_insert_stale_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota2}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/quotas/).

#|
||Field | Description ||
|| interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Duration of interval for quota in milliseconds. ||
|| queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of queries. **0** means unlimited. ||
|| errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of queries that threw exception. **0** means unlimited. ||
|| result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of rows given as the result. **0** means unlimited. ||
|| read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of source rows read from tables for running the query, on all remote servers. **0** means unlimited. ||
|| execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total query execution time, in milliseconds (wall time). **0** means unlimited. ||
|#

## ConnectionManager {#yandex.cloud.mdb.clickhouse.v1.ConnectionManager}

Connection Manager connection configuration.

#|
||Field | Description ||
|| connection_id | **string**

ID of Connection Manager connection. ||
|#