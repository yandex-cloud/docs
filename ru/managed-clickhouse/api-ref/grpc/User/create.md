---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/User/create.md
---

# Managed Service for ClickHouse API, gRPC: UserService.Create

Creates a ClickHouse user in the specified cluster.

## gRPC request

**rpc Create ([CreateUserRequest](#yandex.cloud.mdb.clickhouse.v1.CreateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateUserRequest {#yandex.cloud.mdb.clickhouse.v1.CreateUserRequest}

```json
{
  "cluster_id": "string",
  "user_spec": {
    "name": "string",
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
      "timeout_before_checking_execution_speed": "google.protobuf.Int64Value",
      "insert_quorum": "google.protobuf.Int64Value",
      "insert_quorum_timeout": "google.protobuf.Int64Value",
      "insert_quorum_parallel": "google.protobuf.BoolValue",
      "insert_null_as_default": "google.protobuf.BoolValue",
      "select_sequential_consistency": "google.protobuf.BoolValue",
      "deduplicate_blocks_in_dependent_materialized_views": "google.protobuf.BoolValue",
      "replication_alter_partitions_sync": "google.protobuf.Int64Value",
      "max_replica_delay_for_distributed_queries": "google.protobuf.Int64Value",
      "fallback_to_stale_replicas_for_distributed_queries": "google.protobuf.BoolValue",
      "distributed_product_mode": "DistributedProductMode",
      "distributed_aggregation_memory_efficient": "google.protobuf.BoolValue",
      "distributed_ddl_task_timeout": "google.protobuf.Int64Value",
      "skip_unavailable_shards": "google.protobuf.BoolValue",
      "compile_expressions": "google.protobuf.BoolValue",
      "min_count_to_compile_expression": "google.protobuf.Int64Value",
      "max_block_size": "google.protobuf.Int64Value",
      "min_insert_block_size_rows": "google.protobuf.Int64Value",
      "min_insert_block_size_bytes": "google.protobuf.Int64Value",
      "max_insert_block_size": "google.protobuf.Int64Value",
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
      "priority": "google.protobuf.Int64Value",
      "max_threads": "google.protobuf.Int64Value",
      "max_memory_usage": "google.protobuf.Int64Value",
      "max_memory_usage_for_user": "google.protobuf.Int64Value",
      "max_network_bandwidth": "google.protobuf.Int64Value",
      "max_network_bandwidth_for_user": "google.protobuf.Int64Value",
      "max_partitions_per_insert_block": "google.protobuf.Int64Value",
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
      "join_algorithm": [
        "JoinAlgorithm"
      ],
      "any_join_distinct_right_table_keys": "google.protobuf.BoolValue",
      "max_columns_to_read": "google.protobuf.Int64Value",
      "max_temporary_columns": "google.protobuf.Int64Value",
      "max_temporary_non_const_columns": "google.protobuf.Int64Value",
      "max_query_size": "google.protobuf.Int64Value",
      "max_ast_depth": "google.protobuf.Int64Value",
      "max_ast_elements": "google.protobuf.Int64Value",
      "max_expanded_ast_elements": "google.protobuf.Int64Value",
      "min_execution_speed": "google.protobuf.Int64Value",
      "min_execution_speed_bytes": "google.protobuf.Int64Value",
      "count_distinct_implementation": "CountDistinctImplementation",
      "input_format_values_interpret_expressions": "google.protobuf.BoolValue",
      "input_format_defaults_for_omitted_fields": "google.protobuf.BoolValue",
      "input_format_null_as_default": "google.protobuf.BoolValue",
      "date_time_input_format": "DateTimeInputFormat",
      "input_format_with_names_use_header": "google.protobuf.BoolValue",
      "output_format_json_quote_64bit_integers": "google.protobuf.BoolValue",
      "output_format_json_quote_denormals": "google.protobuf.BoolValue",
      "date_time_output_format": "DateTimeOutputFormat",
      "low_cardinality_allow_in_native_format": "google.protobuf.BoolValue",
      "allow_suspicious_low_cardinality_types": "google.protobuf.BoolValue",
      "empty_result_for_aggregation_by_empty_set": "google.protobuf.BoolValue",
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
      "joined_subquery_requires_alias": "google.protobuf.BoolValue",
      "join_use_nulls": "google.protobuf.BoolValue",
      "transform_null_in": "google.protobuf.BoolValue",
      "quota_mode": "QuotaMode",
      "flatten_nested": "google.protobuf.BoolValue",
      "format_regexp": "string",
      "format_regexp_escaping_rule": "FormatRegexpEscapingRule",
      "format_regexp_skip_unmatched": "google.protobuf.BoolValue",
      "async_insert": "google.protobuf.BoolValue",
      "async_insert_threads": "google.protobuf.Int64Value",
      "wait_for_async_insert": "google.protobuf.BoolValue",
      "wait_for_async_insert_timeout": "google.protobuf.Int64Value",
      "async_insert_max_data_size": "google.protobuf.Int64Value",
      "async_insert_busy_timeout": "google.protobuf.Int64Value",
      "async_insert_use_adaptive_busy_timeout": "google.protobuf.BoolValue",
      "memory_profiler_step": "google.protobuf.Int64Value",
      "memory_profiler_sample_probability": "google.protobuf.DoubleValue",
      "max_final_threads": "google.protobuf.Int64Value",
      "input_format_parallel_parsing": "google.protobuf.BoolValue",
      "input_format_import_nested_json": "google.protobuf.BoolValue",
      "format_avro_schema_registry_url": "string",
      "data_type_default_nullable": "google.protobuf.BoolValue",
      "local_filesystem_read_method": "LocalFilesystemReadMethod",
      "max_read_buffer_size": "google.protobuf.Int64Value",
      "insert_keeper_max_retries": "google.protobuf.Int64Value",
      "max_temporary_data_on_disk_size_for_user": "google.protobuf.Int64Value",
      "max_temporary_data_on_disk_size_for_query": "google.protobuf.Int64Value",
      "max_parser_depth": "google.protobuf.Int64Value",
      "remote_filesystem_read_method": "RemoteFilesystemReadMethod",
      "memory_overcommit_ratio_denominator": "google.protobuf.Int64Value",
      "memory_overcommit_ratio_denominator_for_user": "google.protobuf.Int64Value",
      "memory_usage_overcommit_max_wait_microseconds": "google.protobuf.Int64Value",
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
      "max_insert_threads": "google.protobuf.Int64Value",
      "use_hedged_requests": "google.protobuf.BoolValue",
      "idle_connection_timeout": "google.protobuf.Int64Value",
      "hedged_connection_timeout_ms": "google.protobuf.Int64Value",
      "load_balancing": "LoadBalancing",
      "prefer_localhost_replica": "google.protobuf.BoolValue",
      "do_not_merge_across_partitions_select_final": "google.protobuf.BoolValue",
      "ignore_materialized_views_with_dropped_target_table": "google.protobuf.BoolValue",
      "compile": "google.protobuf.BoolValue",
      "min_count_to_compile": "google.protobuf.Int64Value",
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
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| user_spec | **[UserSpec](#yandex.cloud.mdb.clickhouse.v1.UserSpec)**

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

ClickHouse user settings. Supported settings are a limited subset of all settings
described in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/).

#|
||Field | Description ||
|| readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use `allow_ddl` instead.
* **0** (default)-no restrictions.
* **1**-only read data queries are allowed.
* **2**-read data and change settings queries are allowed.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly). ||
|| allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether DDL queries are allowed (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl). ||
|| allow_introspection_functions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables [introspections functions](https://clickhouse.com/docs/en/sql-reference/functions/introspection) for query profiling.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions). ||
|| connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout in milliseconds.

Value must be greater than **0** (default: **10000**, 10 seconds). ||
|| connect_timeout_with_failover | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **50**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms). ||
|| receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Receive timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Send timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| timeout_before_checking_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in `min_execution_speed` parameter.

Default value: **10**. ||
|| insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Enables or disables write quorum for ClickHouse cluster.
If the value is less than **2**, then write quorum is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the `insert_quorum_timeout` expires.
All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries.
Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.

You can use `select_sequential_consistency` setting to read the data written with write quorum.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum). ||
|| insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the `insert_quorum` replicas, then ClickHouse will abort the execution of **INSERT** query and return an error.
In this case, the client must send the query again to write the data block into the same or another replica.

Minimum value: **1000**, 1 second (default: **60000**, 1 minute). ||
|| insert_quorum_parallel | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel). ||
|| insert_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the insertion of default values instead of NULL into columns with not nullable data type.

Default value: **true**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default). ||
|| select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines the behavior of **SELECT** queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **false** (sequential consistency is disabled). ||
|| deduplicate_blocks_in_dependent_materialized_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views). ||
|| replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Wait mode for asynchronous actions in **ALTER** queries on replicated tables:

* **0**-do not wait for replicas.
* **1**-only wait for own execution (default).
* **2**-wait for all replicas.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries). ||
|| max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Minimum value: **1000**, 1 second (default: **300000**, 300 seconds or 5 minutes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). ||
|| fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true** (query forcing is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). ||
|| distributed_product_mode | enum **DistributedProductMode**

Determine the behavior of distributed subqueries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **false** (memory saving mode is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). ||
|| distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for DDL queries, in milliseconds. ||
|| skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false** (silent skipping is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards). ||
|| compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables expression compilation.
If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with `min_count_to_compile_expression` setting.

Default value: **false** (expression compilation is disabled). ||
|| min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many identical expressions ClickHouse has to encounter before they are compiled.

Minimum value: **0** (default: **3**).

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. ||
|| max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum block size for reading.

Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts).
The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.

This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.

Value must be greater than **0** (default: **65536**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size). ||
|| min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **1048576**). ||
|| min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **268435456**, 256 MB). ||
|| max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Allows to form blocks of the specified size (in bytes) when inserting data in a table.
This setting has effect only if server is creating such blocks by itself.

Value must be greater than **0** (default: **1048576**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size). ||
|| min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead.
Such reading strategy is effective when the data volume is small.
If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.

If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.

Minimal value and default value: **0**, Direct I/O is disabled. ||
|| use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use the cache of uncompressed blocks, or not.
Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false** (uncompressed cache is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). ||
|| merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `use_uncompressed_cache` setting.

Value must be greater than **0** (default: **128x8192**). ||
|| merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `use_uncompressed_cache` setting.

Value must be greater than **0** (default: **192x10x1024x1024**). ||
|| merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **20x8192**). ||
|| merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **24x10x1024x1024**). ||
|| max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM comsumption.

By default, aggregation is done by employing hash table that resides in RAM.
A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the `max_memory_usage` setting).
For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Minimal value and default value: **0**, **GROUP BY** in the external memory is disabled.

When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the `max_memory_usage` setting value (by default, the maximum memory usage is limited to ten gigabytes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

See also: the `distributed_aggregation_memory_efficient` setting. ||
|| max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This setting is equivalent of the `max_bytes_before_external_group_by` setting, except for it is for sort operation (**ORDER BY**), not aggregation. ||
|| group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of keys, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **10000**). ||
|| group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of bytes, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **100000000**). ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the priority of a query.

* **0**-priority is not used.
* **1**-the highest priority.
* and so on. The higher the number, the lower a query's priority.

This setting should be set up for each query individually.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.

Minimal value and default value: **0**, priority is not used. ||
|| max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).

This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

Minimal value and default value: **0** (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads). ||
|| max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for any user's single query on a single server.

Minimal value: **0**, no limitation is set.
Value that is set in the ClickHouse default config file: **10737418240** (10 GB).

If you use `max_bytes_before_external_group_by` or `max_bytes_before_external_sort` setting, then it is recommended to set their values twice as low as `max_memory_usage` setting value.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage). ||
|| max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Minimal value and default value: **0**, no limitation is set. ||
|| max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for a query.

Minimal value and default value: **0**, no limitation is set. ||
|| max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.

Minimal value and default value: **0**, no limitation is set. ||
|| max_partitions_per_insert_block | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block). ||
|| max_concurrent_queries_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of concurrent requests per user.
Default value: 0 (no limit). ||
|| force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If enabled, query is not executed if the ClickHouse can't use index by date.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by date).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date). ||
|| force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If enabled, query is not executed if the ClickHouse can't use index by primary key.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by primary key).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key). ||
|| max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read). ||
|| max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set. ||
|| read_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while reading the data.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of unique keys received from aggregation function.
This setting helps to reduce RAM consumption while doing aggregation.

Minimal value and default value: **0**, no limitation is set. ||
|| group_by_overflow_mode | enum **GroupByOverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing aggregation.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.
* **any**-perform approximate **GROUP BY** operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| sort_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while sorting.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of rows in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of bytes in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| result_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while forming result.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of different rows when using **DISTINCT**.

Minimal value and default value: **0**, no limitation is set. ||
|| max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of a hash table in bytes (uncompressed data) when using **DISTINCT**. ||
|| distinct_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing **DISCTINCT**.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary
table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| transfer_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing transfers.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum query execution time in milliseconds.
At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.

Minimal value and default value: **0**, no limitation is set. ||
|| timeout_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) of execution time.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on the number of rows in the set resulting from the execution of the IN section. ||
|| max_bytes_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on the number of bytes in the set resulting from the execution of the IN section. ||
|| set_overflow_mode | enum **OverflowMode**

Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on maximum size of the hash table for JOIN, in rows. ||
|| max_bytes_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on maximum size of the hash table for JOIN, in bytes. ||
|| join_overflow_mode | enum **OverflowMode**

Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| join_algorithm[] | enum **JoinAlgorithm**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| any_join_distinct_right_table_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys). ||
|| max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of columns that can be read from a table in a single query.
If the query requires to read more columns to complete, then it will be aborted.

Minimal value and default value: **0**, no limitation is set. ||
|| max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Value must be greater than **0** (default: **262144**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size). ||
|| max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the **SELECT ... WHERE ...** query, containing constraints and conditions, in the most cases.
A user can be forced to construct more optimized queries, if this setting is used.

Value must be greater than **0** (default: **1000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth). ||
|| max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **50000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements). ||
|| max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **500000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries. ||
|| min_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in rows per second. ||
|| min_execution_speed_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in bytes per second. ||
|| count_distinct_implementation | enum **CountDistinctImplementation**

Aggregate function to use for implementation of count(DISTINCT ...).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table.
With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true** (SQL parser is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). ||
|| input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true** (replacing is enabled). ||
|| input_format_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default). ||
|| date_time_input_format | enum **DateTimeInputFormat**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| input_format_with_names_use_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header). ||
|| output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines.
Otherwise, such integers will not be quoted.

Default value: **false** (quoting 64-bit integers is disabled). ||
|| output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false** (special values do not present in output). ||
|| date_time_output_format | enum **DateTimeOutputFormat**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use LowCardinality type in Native format.

* **true** (default)-yes, use.
* **false**-convert LowCardinality columns to regular columns when doing **SELECT**, and convert regular columns to LowCardinality when doing **INSERT**.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column.
Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true** (LowCardinality columns are used in Native format). ||
|| allow_suspicious_low_cardinality_types | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows specifying **LowCardinality** modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types). ||
|| empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).

* **true**-ClickHouse will return an empty result for such queries.
* **false** (default)-ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. ||
|| http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP connection timeout, in milliseconds.

Value must be greater than **0** (default: **1000**, 1 second). ||
|| http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP receive timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP send timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false** (compression is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/interfaces/http/). ||
|| send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false** (notifications disabled). ||
|| http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Value must be greater than **0** (default: **100**). ||
|| add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Adds CORS header in HTTP responses.

Default value: **false** (header is not added). ||
|| cancel_http_readonly_queries_on_client_close | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.

Default value: **false**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close). ||
|| max_http_get_redirects | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of HTTP GET redirect hops for [URL-engine](https://clickhouse.com/docs/en/engines/table-engines/special/url) tables.

If the parameter is set to **0** (default), no hops is allowed.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects). ||
|| http_max_field_name_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field name in HTTP header.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#http_max_field_name_size). ||
|| http_max_field_value_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field value in HTTP header.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#http_max_field_value_size). ||
|| joined_subquery_requires_alias | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| join_use_nulls | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| transform_null_in | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| quota_mode | enum **QuotaMode**

Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| flatten_nested | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets the data format of a [nested](https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested) columns.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested). ||
|| format_regexp | **string**

Regular expression (for Regexp format) ||
|| format_regexp_escaping_rule | enum **FormatRegexpEscapingRule**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| format_regexp_skip_unmatched | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched). ||
|| async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables asynchronous inserts.

Disabled by default.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert). ||
|| async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads for background data parsing and insertion.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **16**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads). ||
|| wait_for_async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert). ||
|| wait_for_async_insert_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The timeout (in seconds) for waiting for processing of asynchronous insertion.

Default value: **120**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout). ||
|| async_insert_max_data_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the unparsed data in bytes collected per query before being inserted.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **100000**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size). ||
|| async_insert_busy_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum timeout in milliseconds since the first INSERT query before inserting collected data.

If the parameter is set to **0**, the timeout is disabled. Default value: **200**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms). ||
|| async_insert_use_adaptive_busy_timeout | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If it is set to true, use adaptive busy timeout for asynchronous inserts.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#async_insert_use_adaptive_busy_timeout). ||
|| memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Memory profiler step (in bytes).

If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.

Default value: **4194304** (4 MB). Zero means disabled memory profiler. ||
|| memory_profiler_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.

Possible values: from **0** to **1**. Default: **0**. ||
|| max_final_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads). ||
|| input_format_parallel_parsing | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables order-preserving parallel parsing of data formats. Supported only for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv) and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| input_format_import_nested_json | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the insertion of JSON data with nested objects.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| format_avro_schema_registry_url | **string**

Avro schema registry URL.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/formats#format_avro_schema_registry_url). ||
|| data_type_default_nullable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows data types without explicit modifiers NULL or NOT NULL in column definition will be Nullable.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#data_type_default_nullable). ||
|| local_filesystem_read_method | enum **LocalFilesystemReadMethod**

Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes.

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP` ||
|| max_read_buffer_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the buffer to read from the filesystem.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size) ||
|| insert_keeper_max_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries.
Default: 20 from 23.2, 0(disabled) before
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries) ||
|| max_temporary_data_on_disk_size_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user) ||
|| max_temporary_data_on_disk_size_for_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query) ||
|| max_parser_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size.
Default: 1000
Special: 0 - unlimited
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_parser_depth) ||
|| remote_filesystem_read_method | enum **RemoteFilesystemReadMethod**

Method of reading data from remote filesystem, one of: read, threadpool.
Default: read
Min_version: 21.11
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L660)

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| memory_overcommit_ratio_denominator | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator) ||
|| memory_overcommit_ratio_denominator_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user) ||
|| memory_usage_overcommit_max_wait_microseconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown.
Default: 5000000
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds) ||
|| log_query_threads | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting up query threads logging. Query threads log into the [system.query_thread_log](https://clickhouse.com/docs/en/operations/system-tables/query_thread_log) table. This setting has effect only when [log_queries](https://clickhouse.com/docs/en/operations/settings/settings#log-queries) is true. Queries threads run by ClickHouse with this setup are logged according to the rules in the [query_thread_log](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters-query_thread_log) server configuration parameter.
Default: false
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_threads) ||
|| log_query_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query views logging to the the system.query_view_log table.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_views) ||
|| log_queries_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Log queries with the specified probability.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_queries_probability). ||
|| log_processors_profiles | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enabled or disable logging of processors level profiling data to the the system.log_processors_profiles table.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_processors_profiles). ||
|| use_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, SELECT queries may utilize the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_query_cache). ||
|| enable_reads_from_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of SELECT queries are retrieved from the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#enable_reads_from_query_cache). ||
|| enable_writes_to_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of SELECT queries are stored in the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#enable_writes_to_query_cache). ||
|| query_cache_min_query_runs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of times a SELECT query must run before its result is stored in the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_min_query_runs). ||
|| query_cache_min_query_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_min_query_duration). ||
|| query_cache_ttl | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

After this time in seconds entries in the query cache become stale.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_ttl). ||
|| query_cache_max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of query results the current user may store in the query cache. 0 means unlimited.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_max_entries). ||
|| query_cache_max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of memory (in bytes) the current user may allocate in the query cache. 0 means unlimited.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_max_size_in_bytes). ||
|| query_cache_tag | **string**

A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_tag). ||
|| query_cache_share_between_users | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, the result of SELECT queries cached in the query cache can be read by other users. It is not recommended to enable this setting due to security reasons.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_share_between_users). ||
|| query_cache_nondeterministic_function_handling | enum **QueryCacheNondeterministicFunctionHandling**

Controls how the query cache handles SELECT queries with non-deterministic functions like rand() or now().
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_nondeterministic_function_handling).

- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_UNSPECIFIED`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`: Throw an exception and don't cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`: Cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception. ||
|| max_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute the INSERT SELECT query.
Default: 0
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_insert_threads) ||
|| use_hedged_requests | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within hedged_connection_timeout or no data was received within receive_data_timeout. Query uses the first connection which send non empty progress packet (or data packet, if allow_changing_replica_until_first_data_packet); other connections are cancelled. Queries with max_parallel_replicas > 1 are supported.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_hedged_requests) ||
|| idle_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout to close idle TCP connections after specified number of milliseconds.
Default: 360000 (3600 seconds)
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) ||
|| hedged_connection_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout for establishing connection with replica for Hedged requests.
Default: 50
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L64) ||
|| load_balancing | enum **LoadBalancing**

Specifies the algorithm of replicas selection that is used for distributed query processing, one of: random, nearest_hostname, in_order, first_or_random, round_robin.
Default: random
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#load_balancing)

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| prefer_localhost_replica | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables preferable using the localhost replica when processing distributed queries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#prefer_localhost_replica) ||
|| do_not_merge_across_partitions_select_final | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disable independent processing of partitions for SELECT queries with FINAL.
Default: false
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree) ||
|| ignore_materialized_views_with_dropped_target_table | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Ignore materialized views with dropped target table during pushing to views.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#ignore_materialized_views_with_dropped_target_table). ||
|| compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

The setting is deprecated and has no effect. ||
|| min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| async_insert_stale_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
See in-depth description [ClickHouse documentation](https://clickhouse.com/docs/en/operations/quotas/).

#|
||Field | Description ||
|| interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Duration of interval for quota in milliseconds.
Minimal value is 1 second. ||
|| queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of queries.
0 - unlimited. ||
|| errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of queries that threw exception.
0 - unlimited. ||
|| result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of rows given as the result..
0 - unlimited. ||
|| read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of source rows read from tables for running the query, on all remote servers.
0 - unlimited. ||
|| execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total query execution time, in milliseconds (wall time).
0 - unlimited. ||
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
      "timeout_before_checking_execution_speed": "google.protobuf.Int64Value",
      "insert_quorum": "google.protobuf.Int64Value",
      "insert_quorum_timeout": "google.protobuf.Int64Value",
      "insert_quorum_parallel": "google.protobuf.BoolValue",
      "insert_null_as_default": "google.protobuf.BoolValue",
      "select_sequential_consistency": "google.protobuf.BoolValue",
      "deduplicate_blocks_in_dependent_materialized_views": "google.protobuf.BoolValue",
      "replication_alter_partitions_sync": "google.protobuf.Int64Value",
      "max_replica_delay_for_distributed_queries": "google.protobuf.Int64Value",
      "fallback_to_stale_replicas_for_distributed_queries": "google.protobuf.BoolValue",
      "distributed_product_mode": "DistributedProductMode",
      "distributed_aggregation_memory_efficient": "google.protobuf.BoolValue",
      "distributed_ddl_task_timeout": "google.protobuf.Int64Value",
      "skip_unavailable_shards": "google.protobuf.BoolValue",
      "compile_expressions": "google.protobuf.BoolValue",
      "min_count_to_compile_expression": "google.protobuf.Int64Value",
      "max_block_size": "google.protobuf.Int64Value",
      "min_insert_block_size_rows": "google.protobuf.Int64Value",
      "min_insert_block_size_bytes": "google.protobuf.Int64Value",
      "max_insert_block_size": "google.protobuf.Int64Value",
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
      "priority": "google.protobuf.Int64Value",
      "max_threads": "google.protobuf.Int64Value",
      "max_memory_usage": "google.protobuf.Int64Value",
      "max_memory_usage_for_user": "google.protobuf.Int64Value",
      "max_network_bandwidth": "google.protobuf.Int64Value",
      "max_network_bandwidth_for_user": "google.protobuf.Int64Value",
      "max_partitions_per_insert_block": "google.protobuf.Int64Value",
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
      "join_algorithm": [
        "JoinAlgorithm"
      ],
      "any_join_distinct_right_table_keys": "google.protobuf.BoolValue",
      "max_columns_to_read": "google.protobuf.Int64Value",
      "max_temporary_columns": "google.protobuf.Int64Value",
      "max_temporary_non_const_columns": "google.protobuf.Int64Value",
      "max_query_size": "google.protobuf.Int64Value",
      "max_ast_depth": "google.protobuf.Int64Value",
      "max_ast_elements": "google.protobuf.Int64Value",
      "max_expanded_ast_elements": "google.protobuf.Int64Value",
      "min_execution_speed": "google.protobuf.Int64Value",
      "min_execution_speed_bytes": "google.protobuf.Int64Value",
      "count_distinct_implementation": "CountDistinctImplementation",
      "input_format_values_interpret_expressions": "google.protobuf.BoolValue",
      "input_format_defaults_for_omitted_fields": "google.protobuf.BoolValue",
      "input_format_null_as_default": "google.protobuf.BoolValue",
      "date_time_input_format": "DateTimeInputFormat",
      "input_format_with_names_use_header": "google.protobuf.BoolValue",
      "output_format_json_quote_64bit_integers": "google.protobuf.BoolValue",
      "output_format_json_quote_denormals": "google.protobuf.BoolValue",
      "date_time_output_format": "DateTimeOutputFormat",
      "low_cardinality_allow_in_native_format": "google.protobuf.BoolValue",
      "allow_suspicious_low_cardinality_types": "google.protobuf.BoolValue",
      "empty_result_for_aggregation_by_empty_set": "google.protobuf.BoolValue",
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
      "joined_subquery_requires_alias": "google.protobuf.BoolValue",
      "join_use_nulls": "google.protobuf.BoolValue",
      "transform_null_in": "google.protobuf.BoolValue",
      "quota_mode": "QuotaMode",
      "flatten_nested": "google.protobuf.BoolValue",
      "format_regexp": "string",
      "format_regexp_escaping_rule": "FormatRegexpEscapingRule",
      "format_regexp_skip_unmatched": "google.protobuf.BoolValue",
      "async_insert": "google.protobuf.BoolValue",
      "async_insert_threads": "google.protobuf.Int64Value",
      "wait_for_async_insert": "google.protobuf.BoolValue",
      "wait_for_async_insert_timeout": "google.protobuf.Int64Value",
      "async_insert_max_data_size": "google.protobuf.Int64Value",
      "async_insert_busy_timeout": "google.protobuf.Int64Value",
      "async_insert_use_adaptive_busy_timeout": "google.protobuf.BoolValue",
      "memory_profiler_step": "google.protobuf.Int64Value",
      "memory_profiler_sample_probability": "google.protobuf.DoubleValue",
      "max_final_threads": "google.protobuf.Int64Value",
      "input_format_parallel_parsing": "google.protobuf.BoolValue",
      "input_format_import_nested_json": "google.protobuf.BoolValue",
      "format_avro_schema_registry_url": "string",
      "data_type_default_nullable": "google.protobuf.BoolValue",
      "local_filesystem_read_method": "LocalFilesystemReadMethod",
      "max_read_buffer_size": "google.protobuf.Int64Value",
      "insert_keeper_max_retries": "google.protobuf.Int64Value",
      "max_temporary_data_on_disk_size_for_user": "google.protobuf.Int64Value",
      "max_temporary_data_on_disk_size_for_query": "google.protobuf.Int64Value",
      "max_parser_depth": "google.protobuf.Int64Value",
      "remote_filesystem_read_method": "RemoteFilesystemReadMethod",
      "memory_overcommit_ratio_denominator": "google.protobuf.Int64Value",
      "memory_overcommit_ratio_denominator_for_user": "google.protobuf.Int64Value",
      "memory_usage_overcommit_max_wait_microseconds": "google.protobuf.Int64Value",
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
      "max_insert_threads": "google.protobuf.Int64Value",
      "use_hedged_requests": "google.protobuf.BoolValue",
      "idle_connection_timeout": "google.protobuf.Int64Value",
      "hedged_connection_timeout_ms": "google.protobuf.Int64Value",
      "load_balancing": "LoadBalancing",
      "prefer_localhost_replica": "google.protobuf.BoolValue",
      "do_not_merge_across_partitions_select_final": "google.protobuf.BoolValue",
      "ignore_materialized_views_with_dropped_target_table": "google.protobuf.BoolValue",
      "compile": "google.protobuf.BoolValue",
      "min_count_to_compile": "google.protobuf.Int64Value",
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
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.clickhouse.v1.CreateUserMetadata)**

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

## CreateUserMetadata {#yandex.cloud.mdb.clickhouse.v1.CreateUserMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the ClickHouse cluster the user is being created in. ||
|| user_name | **string**

Name of the user that is being created. ||
|#

## User {#yandex.cloud.mdb.clickhouse.v1.User}

A ClickHouse User resource. For more information, see
the [Developer's guide](/docs/managed-clickhouse/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the ClickHouse user. ||
|| cluster_id | **string**

ID of the ClickHouse cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission2)**

Set of permissions granted to the user. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings2)** ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota2)**

Set of quotas assigned to the user. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.clickhouse.v1.ConnectionManager)**

Connection Manager connection configuration. Read only field. ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission2}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings2}

ClickHouse user settings. Supported settings are a limited subset of all settings
described in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/).

#|
||Field | Description ||
|| readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use `allow_ddl` instead.
* **0** (default)-no restrictions.
* **1**-only read data queries are allowed.
* **2**-read data and change settings queries are allowed.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly). ||
|| allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether DDL queries are allowed (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl). ||
|| allow_introspection_functions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables [introspections functions](https://clickhouse.com/docs/en/sql-reference/functions/introspection) for query profiling.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions). ||
|| connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout in milliseconds.

Value must be greater than **0** (default: **10000**, 10 seconds). ||
|| connect_timeout_with_failover | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **50**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms). ||
|| receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Receive timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Send timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| timeout_before_checking_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in `min_execution_speed` parameter.

Default value: **10**. ||
|| insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Enables or disables write quorum for ClickHouse cluster.
If the value is less than **2**, then write quorum is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the `insert_quorum_timeout` expires.
All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries.
Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.

You can use `select_sequential_consistency` setting to read the data written with write quorum.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum). ||
|| insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the `insert_quorum` replicas, then ClickHouse will abort the execution of **INSERT** query and return an error.
In this case, the client must send the query again to write the data block into the same or another replica.

Minimum value: **1000**, 1 second (default: **60000**, 1 minute). ||
|| insert_quorum_parallel | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel). ||
|| insert_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the insertion of default values instead of NULL into columns with not nullable data type.

Default value: **true**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default). ||
|| select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines the behavior of **SELECT** queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **false** (sequential consistency is disabled). ||
|| deduplicate_blocks_in_dependent_materialized_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views). ||
|| replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Wait mode for asynchronous actions in **ALTER** queries on replicated tables:

* **0**-do not wait for replicas.
* **1**-only wait for own execution (default).
* **2**-wait for all replicas.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries). ||
|| max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Minimum value: **1000**, 1 second (default: **300000**, 300 seconds or 5 minutes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). ||
|| fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true** (query forcing is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). ||
|| distributed_product_mode | enum **DistributedProductMode**

Determine the behavior of distributed subqueries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **false** (memory saving mode is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). ||
|| distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for DDL queries, in milliseconds. ||
|| skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false** (silent skipping is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards). ||
|| compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables expression compilation.
If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with `min_count_to_compile_expression` setting.

Default value: **false** (expression compilation is disabled). ||
|| min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many identical expressions ClickHouse has to encounter before they are compiled.

Minimum value: **0** (default: **3**).

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. ||
|| max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum block size for reading.

Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts).
The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.

This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.

Value must be greater than **0** (default: **65536**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size). ||
|| min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **1048576**). ||
|| min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **268435456**, 256 MB). ||
|| max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Allows to form blocks of the specified size (in bytes) when inserting data in a table.
This setting has effect only if server is creating such blocks by itself.

Value must be greater than **0** (default: **1048576**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size). ||
|| min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead.
Such reading strategy is effective when the data volume is small.
If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.

If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.

Minimal value and default value: **0**, Direct I/O is disabled. ||
|| use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use the cache of uncompressed blocks, or not.
Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false** (uncompressed cache is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). ||
|| merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `use_uncompressed_cache` setting.

Value must be greater than **0** (default: **128x8192**). ||
|| merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `use_uncompressed_cache` setting.

Value must be greater than **0** (default: **192x10x1024x1024**). ||
|| merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **20x8192**). ||
|| merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **24x10x1024x1024**). ||
|| max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM comsumption.

By default, aggregation is done by employing hash table that resides in RAM.
A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the `max_memory_usage` setting).
For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Minimal value and default value: **0**, **GROUP BY** in the external memory is disabled.

When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the `max_memory_usage` setting value (by default, the maximum memory usage is limited to ten gigabytes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

See also: the `distributed_aggregation_memory_efficient` setting. ||
|| max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This setting is equivalent of the `max_bytes_before_external_group_by` setting, except for it is for sort operation (**ORDER BY**), not aggregation. ||
|| group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of keys, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **10000**). ||
|| group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the threshold of the number of bytes, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **100000000**). ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the priority of a query.

* **0**-priority is not used.
* **1**-the highest priority.
* and so on. The higher the number, the lower a query's priority.

This setting should be set up for each query individually.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.

Minimal value and default value: **0**, priority is not used. ||
|| max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).

This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

Minimal value and default value: **0** (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads). ||
|| max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for any user's single query on a single server.

Minimal value: **0**, no limitation is set.
Value that is set in the ClickHouse default config file: **10737418240** (10 GB).

If you use `max_bytes_before_external_group_by` or `max_bytes_before_external_sort` setting, then it is recommended to set their values twice as low as `max_memory_usage` setting value.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage). ||
|| max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Minimal value and default value: **0**, no limitation is set. ||
|| max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for a query.

Minimal value and default value: **0**, no limitation is set. ||
|| max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.

Minimal value and default value: **0**, no limitation is set. ||
|| max_partitions_per_insert_block | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block). ||
|| max_concurrent_queries_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of concurrent requests per user.
Default value: 0 (no limit). ||
|| force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If enabled, query is not executed if the ClickHouse can't use index by date.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by date).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date). ||
|| force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If enabled, query is not executed if the ClickHouse can't use index by primary key.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by primary key).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key). ||
|| max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read). ||
|| max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set. ||
|| read_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while reading the data.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of unique keys received from aggregation function.
This setting helps to reduce RAM consumption while doing aggregation.

Minimal value and default value: **0**, no limitation is set. ||
|| group_by_overflow_mode | enum **GroupByOverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing aggregation.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.
* **any**-perform approximate **GROUP BY** operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| sort_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while sorting.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of rows in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the number of bytes in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| result_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while forming result.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of different rows when using **DISTINCT**.

Minimal value and default value: **0**, no limitation is set. ||
|| max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of a hash table in bytes (uncompressed data) when using **DISTINCT**. ||
|| distinct_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing **DISCTINCT**.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary
table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| transfer_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing transfers.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum query execution time in milliseconds.
At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.

Minimal value and default value: **0**, no limitation is set. ||
|| timeout_overflow_mode | enum **OverflowMode**

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) of execution time.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on the number of rows in the set resulting from the execution of the IN section. ||
|| max_bytes_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on the number of bytes in the set resulting from the execution of the IN section. ||
|| set_overflow_mode | enum **OverflowMode**

Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| max_rows_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on maximum size of the hash table for JOIN, in rows. ||
|| max_bytes_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on maximum size of the hash table for JOIN, in bytes. ||
|| join_overflow_mode | enum **OverflowMode**

Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| join_algorithm[] | enum **JoinAlgorithm**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| any_join_distinct_right_table_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys). ||
|| max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of columns that can be read from a table in a single query.
If the query requires to read more columns to complete, then it will be aborted.

Minimal value and default value: **0**, no limitation is set. ||
|| max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Value must be greater than **0** (default: **262144**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size). ||
|| max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the **SELECT ... WHERE ...** query, containing constraints and conditions, in the most cases.
A user can be forced to construct more optimized queries, if this setting is used.

Value must be greater than **0** (default: **1000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth). ||
|| max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **50000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements). ||
|| max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **500000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries. ||
|| min_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in rows per second. ||
|| min_execution_speed_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal execution speed in bytes per second. ||
|| count_distinct_implementation | enum **CountDistinctImplementation**

Aggregate function to use for implementation of count(DISTINCT ...).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table.
With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true** (SQL parser is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). ||
|| input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true** (replacing is enabled). ||
|| input_format_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default). ||
|| date_time_input_format | enum **DateTimeInputFormat**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| input_format_with_names_use_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header). ||
|| output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines.
Otherwise, such integers will not be quoted.

Default value: **false** (quoting 64-bit integers is disabled). ||
|| output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false** (special values do not present in output). ||
|| date_time_output_format | enum **DateTimeOutputFormat**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use LowCardinality type in Native format.

* **true** (default)-yes, use.
* **false**-convert LowCardinality columns to regular columns when doing **SELECT**, and convert regular columns to LowCardinality when doing **INSERT**.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column.
Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true** (LowCardinality columns are used in Native format). ||
|| allow_suspicious_low_cardinality_types | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows specifying **LowCardinality** modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types). ||
|| empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).

* **true**-ClickHouse will return an empty result for such queries.
* **false** (default)-ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. ||
|| http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP connection timeout, in milliseconds.

Value must be greater than **0** (default: **1000**, 1 second). ||
|| http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP receive timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

HTTP send timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false** (compression is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/interfaces/http/). ||
|| send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false** (notifications disabled). ||
|| http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Value must be greater than **0** (default: **100**). ||
|| add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Adds CORS header in HTTP responses.

Default value: **false** (header is not added). ||
|| cancel_http_readonly_queries_on_client_close | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.

Default value: **false**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close). ||
|| max_http_get_redirects | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits the maximum number of HTTP GET redirect hops for [URL-engine](https://clickhouse.com/docs/en/engines/table-engines/special/url) tables.

If the parameter is set to **0** (default), no hops is allowed.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects). ||
|| http_max_field_name_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field name in HTTP header.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#http_max_field_name_size). ||
|| http_max_field_value_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum length of field value in HTTP header.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#http_max_field_value_size). ||
|| joined_subquery_requires_alias | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| join_use_nulls | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| transform_null_in | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| quota_mode | enum **QuotaMode**

Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| flatten_nested | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets the data format of a [nested](https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested) columns.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested). ||
|| format_regexp | **string**

Regular expression (for Regexp format) ||
|| format_regexp_escaping_rule | enum **FormatRegexpEscapingRule**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| format_regexp_skip_unmatched | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched). ||
|| async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables asynchronous inserts.

Disabled by default.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert). ||
|| async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads for background data parsing and insertion.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **16**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads). ||
|| wait_for_async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert). ||
|| wait_for_async_insert_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The timeout (in seconds) for waiting for processing of asynchronous insertion.

Default value: **120**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout). ||
|| async_insert_max_data_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the unparsed data in bytes collected per query before being inserted.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **100000**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size). ||
|| async_insert_busy_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum timeout in milliseconds since the first INSERT query before inserting collected data.

If the parameter is set to **0**, the timeout is disabled. Default value: **200**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms). ||
|| async_insert_use_adaptive_busy_timeout | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If it is set to true, use adaptive busy timeout for asynchronous inserts.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#async_insert_use_adaptive_busy_timeout). ||
|| memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Memory profiler step (in bytes).

If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.

Default value: **4194304** (4 MB). Zero means disabled memory profiler. ||
|| memory_profiler_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.

Possible values: from **0** to **1**. Default: **0**. ||
|| max_final_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads). ||
|| input_format_parallel_parsing | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables order-preserving parallel parsing of data formats. Supported only for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv) and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| input_format_import_nested_json | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the insertion of JSON data with nested objects.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| format_avro_schema_registry_url | **string**

Avro schema registry URL.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/formats#format_avro_schema_registry_url). ||
|| data_type_default_nullable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows data types without explicit modifiers NULL or NOT NULL in column definition will be Nullable.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#data_type_default_nullable). ||
|| local_filesystem_read_method | enum **LocalFilesystemReadMethod**

Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes.

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP` ||
|| max_read_buffer_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of the buffer to read from the filesystem.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size) ||
|| insert_keeper_max_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries.
Default: 20 from 23.2, 0(disabled) before
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries) ||
|| max_temporary_data_on_disk_size_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user) ||
|| max_temporary_data_on_disk_size_for_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query) ||
|| max_parser_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size.
Default: 1000
Special: 0 - unlimited
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_parser_depth) ||
|| remote_filesystem_read_method | enum **RemoteFilesystemReadMethod**

Method of reading data from remote filesystem, one of: read, threadpool.
Default: read
Min_version: 21.11
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L660)

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| memory_overcommit_ratio_denominator | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator) ||
|| memory_overcommit_ratio_denominator_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user) ||
|| memory_usage_overcommit_max_wait_microseconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown.
Default: 5000000
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds) ||
|| log_query_threads | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting up query threads logging. Query threads log into the [system.query_thread_log](https://clickhouse.com/docs/en/operations/system-tables/query_thread_log) table. This setting has effect only when [log_queries](https://clickhouse.com/docs/en/operations/settings/settings#log-queries) is true. Queries threads run by ClickHouse with this setup are logged according to the rules in the [query_thread_log](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters-query_thread_log) server configuration parameter.
Default: false
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_threads) ||
|| log_query_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query views logging to the the system.query_view_log table.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_views) ||
|| log_queries_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Log queries with the specified probability.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_queries_probability). ||
|| log_processors_profiles | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enabled or disable logging of processors level profiling data to the the system.log_processors_profiles table.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_processors_profiles). ||
|| use_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, SELECT queries may utilize the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_query_cache). ||
|| enable_reads_from_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of SELECT queries are retrieved from the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#enable_reads_from_query_cache). ||
|| enable_writes_to_query_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, results of SELECT queries are stored in the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#enable_writes_to_query_cache). ||
|| query_cache_min_query_runs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of times a SELECT query must run before its result is stored in the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_min_query_runs). ||
|| query_cache_min_query_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_min_query_duration). ||
|| query_cache_ttl | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

After this time in seconds entries in the query cache become stale.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_ttl). ||
|| query_cache_max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of query results the current user may store in the query cache. 0 means unlimited.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_max_entries). ||
|| query_cache_max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum amount of memory (in bytes) the current user may allocate in the query cache. 0 means unlimited.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_max_size_in_bytes). ||
|| query_cache_tag | **string**

A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_tag). ||
|| query_cache_share_between_users | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If turned on, the result of SELECT queries cached in the query cache can be read by other users. It is not recommended to enable this setting due to security reasons.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_share_between_users). ||
|| query_cache_nondeterministic_function_handling | enum **QueryCacheNondeterministicFunctionHandling**

Controls how the query cache handles SELECT queries with non-deterministic functions like rand() or now().
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#query_cache_nondeterministic_function_handling).

- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_UNSPECIFIED`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`: Throw an exception and don't cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`: Cache the query result.
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception. ||
|| max_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute the INSERT SELECT query.
Default: 0
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_insert_threads) ||
|| use_hedged_requests | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within hedged_connection_timeout or no data was received within receive_data_timeout. Query uses the first connection which send non empty progress packet (or data packet, if allow_changing_replica_until_first_data_packet); other connections are cancelled. Queries with max_parallel_replicas > 1 are supported.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_hedged_requests) ||
|| idle_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout to close idle TCP connections after specified number of milliseconds.
Default: 360000 (3600 seconds)
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) ||
|| hedged_connection_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Connection timeout for establishing connection with replica for Hedged requests.
Default: 50
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L64) ||
|| load_balancing | enum **LoadBalancing**

Specifies the algorithm of replicas selection that is used for distributed query processing, one of: random, nearest_hostname, in_order, first_or_random, round_robin.
Default: random
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#load_balancing)

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| prefer_localhost_replica | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables preferable using the localhost replica when processing distributed queries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#prefer_localhost_replica) ||
|| do_not_merge_across_partitions_select_final | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disable independent processing of partitions for SELECT queries with FINAL.
Default: false
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree) ||
|| ignore_materialized_views_with_dropped_target_table | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Ignore materialized views with dropped target table during pushing to views.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#ignore_materialized_views_with_dropped_target_table). ||
|| compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

The setting is deprecated and has no effect. ||
|| min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| async_insert_stale_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota2}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
See in-depth description [ClickHouse documentation](https://clickhouse.com/docs/en/operations/quotas/).

#|
||Field | Description ||
|| interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Duration of interval for quota in milliseconds.
Minimal value is 1 second. ||
|| queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of queries.
0 - unlimited. ||
|| errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of queries that threw exception.
0 - unlimited. ||
|| result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of rows given as the result..
0 - unlimited. ||
|| read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total number of source rows read from tables for running the query, on all remote servers.
0 - unlimited. ||
|| execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The total query execution time, in milliseconds (wall time).
0 - unlimited. ||
|#

## ConnectionManager {#yandex.cloud.mdb.clickhouse.v1.ConnectionManager}

Connection Manager connection configuration.

#|
||Field | Description ||
|| connection_id | **string**

ID of Connection Manager connection. ||
|#