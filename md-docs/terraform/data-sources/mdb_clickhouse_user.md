[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for ClickHouse > Data Sources > mdb_clickhouse_user

# yandex_mdb_clickhouse_user (DataSource)

Manages a ClickHouse user within the Yandex.Cloud. For more information, see [the official documentation](https://cloud.yandex.com/docs/managed-clickhouse/concepts).

## Example usage

```terraform
data "yandex_mdb_clickhouse_user" "foo" {
  cluster_id = "some_cluster_id"
  name       = "username"
  password   = "your_password"
}

output "permissions" {
  value = data.yandex_mdb_clickhouse_user.permission
}
```

## Arguments & Attributes Reference

- `auth_method` (*Read-Only*) (String). Authentication method for the user. Possible values are `password`, `iam`. Default is `password`.
- `cluster_id` (**Required**)(String). ID of the ClickHouse cluster. Provided by the client when the user is created.
- `connection_manager` [Block]. **Deprecated**. Please use `user_connection_manager` instead. Connection Manager connection configuration. Filled in by the server automatically.
  - `connection_id` (*Read-Only*) (String). ID of Connection Manager connection. Filled in by the server automatically. String.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). Name of the ClickHouse user. Provided by the client when the user is created.
- `password` (*Read-Only*) (String). Password of the ClickHouse user. Provided by the client when the user is created.
- `user_connection_manager` [Block]. Connection Manager settings for the user.
  - `connection_folder_id` (*Read-Only*) (String). ID of the folder where the connection is created.
  - `connection_id` (*Read-Only*) (String). ID of the Connection Manager connection for this user.
  - `secret_folder_id` (*Read-Only*) (String). ID of the folder where the secret is created.
- `permission` [Block]. 
  - `database_name` (*Read-Only*) (String). 
- `quota` [Block]. 
  - `errors` (Number). 
  - `execution_time` (Number). 
  - `interval_duration` (*Read-Only*) (Number). 
  - `queries` (Number). 
  - `read_rows` (Number). 
  - `result_rows` (Number). 
- `settings` [Block]. 
  - `add_http_cors_header` (Bool). 
  - `allow_ddl` (Bool). 
  - `allow_introspection_functions` (Bool). 
  - `allow_suspicious_low_cardinality_types` (Bool). 
  - `any_join_distinct_right_table_keys` (Bool). 
  - `async_insert` (Bool). 
  - `async_insert_busy_timeout` (Number). 
  - `async_insert_max_data_size` (Number). 
  - `async_insert_stale_timeout` (Number). 
  - `async_insert_threads` (Number). 
  - `async_insert_use_adaptive_busy_timeout` (Bool). If it is set to true, use adaptive busy timeout for asynchronous inserts.
  - `cancel_http_readonly_queries_on_client_close` (Bool). 
  - `compile_expressions` (Bool). 
  - `connect_timeout` (Number). 
  - `connect_timeout_with_failover` (Number). 
  - `count_distinct_implementation` (String). 
  - `data_type_default_nullable` (Bool). Allows data types without explicit modifiers NULL or NOT NULL in column definition will be Nullable.
  - `date_time_input_format` (String). 
  - `date_time_output_format` (String). 
  - `deduplicate_blocks_in_dependent_materialized_views` (Bool). 
  - `distinct_overflow_mode` (String). 
  - `distributed_aggregation_memory_efficient` (Bool). 
  - `distributed_ddl_output_mode` (String). Determines the format of distributed DDL query result.
  - `distributed_ddl_task_timeout` (Number). 
  - `distributed_product_mode` (String). 
  - `do_not_merge_across_partitions_select_final` (Bool). Enable or disable independent processing of partitions for **SELECT** queries with **FINAL**.
  - `empty_result_for_aggregation_by_empty_set` (Bool). 
  - `enable_analyzer` (Bool). Enable new query analyzer.
  - `enable_http_compression` (Bool). 
  - `enable_reads_from_query_cache` (Bool). If turned on, results of SELECT queries are retrieved from the query cache.
  - `enable_writes_to_query_cache` (Bool). If turned on, results of SELECT queries are stored in the query cache.
  - `fallback_to_stale_replicas_for_distributed_queries` (Bool). 
  - `flatten_nested` (Bool). 
  - `force_index_by_date` (Bool). 
  - `force_primary_key` (Bool). 
  - `format_avro_schema_registry_url` (String). Avro schema registry URL.
  - `format_regexp` (String). 
  - `format_regexp_skip_unmatched` (Bool). 
  - `group_by_overflow_mode` (String). 
  - `group_by_two_level_threshold` (Number). 
  - `group_by_two_level_threshold_bytes` (Number). 
  - `hedged_connection_timeout_ms` (Number). 
  - `http_connection_timeout` (Number). 
  - `http_headers_progress_interval` (Number). 
  - `http_max_field_name_size` (Number). Maximum length of field name in HTTP header.
  - `http_max_field_value_size` (Number). Maximum length of field value in HTTP header.
  - `http_receive_timeout` (Number). 
  - `http_send_timeout` (Number). 
  - `idle_connection_timeout` (Number). 
  - `ignore_materialized_views_with_dropped_target_table` (Bool). Ignore materialized views with dropped target table during pushing to views.
  - `input_format_defaults_for_omitted_fields` (Bool). 
  - `input_format_import_nested_json` (Bool). 
  - `input_format_null_as_default` (Bool). 
  - `input_format_parallel_parsing` (Bool). 
  - `input_format_values_interpret_expressions` (Bool). 
  - `input_format_with_names_use_header` (Bool). 
  - `insert_keeper_max_retries` (Number). 
  - `insert_null_as_default` (Bool). 
  - `insert_quorum` (Number). 
  - `insert_quorum_parallel` (Bool). 
  - `insert_quorum_timeout` (Number). 
  - `join_algorithm` (Set Of String). 
  - `join_overflow_mode` (String). 
  - `join_use_nulls` (Bool). 
  - `joined_subquery_requires_alias` (Bool). 
  - `load_balancing` (String). 
  - `local_filesystem_read_method` (String). 
  - `log_processors_profiles` (Bool). Enabled or disable logging of processors level profiling data to the the system.processors_profile_log table.
  - `log_queries_probability` (Number). Log queries with the specified probability.
  - `log_query_threads` (Bool). 
  - `log_query_views` (Bool). Enables or disables query views logging to the the system.query_views_log table.
  - `low_cardinality_allow_in_native_format` (Bool). 
  - `max_ast_depth` (Number). 
  - `max_ast_elements` (Number). 
  - `max_block_size` (Number). 
  - `max_bytes_before_external_group_by` (Number). 
  - `max_bytes_before_external_sort` (Number). 
  - `max_bytes_in_distinct` (Number). 
  - `max_bytes_in_join` (Number). 
  - `max_bytes_in_set` (Number). 
  - `max_bytes_to_read` (Number). 
  - `max_bytes_to_sort` (Number). 
  - `max_bytes_to_transfer` (Number). 
  - `max_columns_to_read` (Number). 
  - `max_concurrent_queries_for_user` (Number). 
  - `max_execution_time` (Number). 
  - `max_expanded_ast_elements` (Number). 
  - `max_final_threads` (Number). 
  - `max_http_get_redirects` (Number). 
  - `max_insert_block_size` (Number). 
  - `max_insert_threads` (Number). 
  - `max_memory_usage` (Number). 
  - `max_memory_usage_for_user` (Number). 
  - `max_network_bandwidth` (Number). 
  - `max_network_bandwidth_for_user` (Number). 
  - `max_parser_depth` (Number). 
  - `max_partitions_per_insert_block` (Number). 
  - `max_query_size` (Number). 
  - `max_read_buffer_size` (Number). 
  - `max_replica_delay_for_distributed_queries` (Number). 
  - `max_result_bytes` (Number). 
  - `max_result_rows` (Number). 
  - `max_rows_in_distinct` (Number). 
  - `max_rows_in_join` (Number). 
  - `max_rows_in_set` (Number). 
  - `max_rows_to_group_by` (Number). 
  - `max_rows_to_read` (Number). 
  - `max_rows_to_sort` (Number). 
  - `max_rows_to_transfer` (Number). 
  - `max_temporary_columns` (Number). 
  - `max_temporary_data_on_disk_size_for_query` (Number). 
  - `max_temporary_data_on_disk_size_for_user` (Number). 
  - `max_temporary_non_const_columns` (Number). 
  - `max_threads` (Number). 
  - `memory_overcommit_ratio_denominator` (Number). 
  - `memory_overcommit_ratio_denominator_for_user` (Number). 
  - `memory_profiler_sample_probability` (Number). 
  - `memory_profiler_step` (Number). 
  - `memory_usage_overcommit_max_wait_microseconds` (Number). 
  - `merge_tree_max_bytes_to_use_cache` (Number). 
  - `merge_tree_max_rows_to_use_cache` (Number). 
  - `merge_tree_min_bytes_for_concurrent_read` (Number). 
  - `merge_tree_min_rows_for_concurrent_read` (Number). 
  - `min_bytes_to_use_direct_io` (Number). 
  - `min_count_to_compile_expression` (Number). 
  - `min_execution_speed` (Number). 
  - `min_execution_speed_bytes` (Number). 
  - `min_insert_block_size_bytes` (Number). 
  - `min_insert_block_size_rows` (Number). 
  - `output_format_json_quote_64bit_integers` (Bool). 
  - `output_format_json_quote_denormals` (Bool). 
  - `prefer_localhost_replica` (Bool). 
  - `priority` (Number). 
  - `query_cache_max_entries` (Number). The maximum number of query results the current user may store in the query cache. 0 means unlimited.
  - `query_cache_max_size_in_bytes` (Number). The maximum amount of memory (in bytes) the current user may allocate in the query cache. 0 means unlimited.
  - `query_cache_min_query_duration` (Number). Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.
  - `query_cache_min_query_runs` (Number). Minimum number of times a SELECT query must run before its result is stored in the query cache.
  - `query_cache_nondeterministic_function_handling` (String). Controls how the query cache handles **SELECT** queries with non-deterministic functions like rand() or now().
  - `query_cache_share_between_users` (Bool). If turned on, the result of SELECT queries cached in the query cache can be read by other users. It is not recommended to enable this setting due to security reasons.
  - `query_cache_system_table_handling` (String). Controls how the query cache handles **SELECT** queries against system tables.
  - `query_cache_tag` (String). A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.
  - `query_cache_ttl` (Number). After this time in seconds entries in the query cache become stale.
  - `quota_mode` (String). 
  - `read_overflow_mode` (String). 
  - `readonly` (Number). 
  - `receive_timeout` (Number). 
  - `remote_filesystem_read_method` (String). 
  - `replication_alter_partitions_sync` (Number). 
  - `result_overflow_mode` (String). 
  - `s3_use_adaptive_timeouts` (Bool). Enables or disables adaptive timeouts for S3 requests.
  - `select_sequential_consistency` (Bool). 
  - `send_progress_in_http_headers` (Bool). 
  - `send_timeout` (Number). 
  - `set_overflow_mode` (String). 
  - `skip_unavailable_shards` (Bool). 
  - `sort_overflow_mode` (String). 
  - `timeout_before_checking_execution_speed` (Number). 
  - `timeout_overflow_mode` (String). 
  - `transfer_overflow_mode` (String). 
  - `transform_null_in` (Bool). 
  - `use_hedged_requests` (Bool). 
  - `use_query_cache` (Bool). If turned on, SELECT queries may utilize the query cache.
  - `use_uncompressed_cache` (Bool). 
  - `wait_for_async_insert` (Bool). 
  - `wait_for_async_insert_timeout` (Number).