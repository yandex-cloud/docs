---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/create.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.Create

Creates a ClickHouse cluster in the specified folder.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.mdb.clickhouse.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.mdb.clickhouse.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "environment": "Environment",
  "config_spec": {
    "version": "string",
    "clickhouse": {
      "config": {
        "log_level": "LogLevel",
        "merge_tree": {
          "replicated_deduplication_window": "google.protobuf.Int64Value",
          "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
          "parts_to_delay_insert": "google.protobuf.Int64Value",
          "parts_to_throw_insert": "google.protobuf.Int64Value",
          "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
          "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
          "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
          "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
          "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
          "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
          "min_bytes_for_wide_part": "google.protobuf.Int64Value",
          "min_rows_for_wide_part": "google.protobuf.Int64Value",
          "ttl_only_drop_parts": "google.protobuf.BoolValue",
          "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue",
          "merge_with_ttl_timeout": "google.protobuf.Int64Value",
          "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
          "max_parts_in_total": "google.protobuf.Int64Value",
          "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
          "cleanup_delay_period": "google.protobuf.Int64Value",
          "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
          "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
          "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
          "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
          "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
          "merge_max_block_size": "google.protobuf.Int64Value",
          "check_sample_column_is_correct": "google.protobuf.BoolValue",
          "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
          "max_cleanup_delay_period": "google.protobuf.Int64Value",
          "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
          "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
          "materialize_ttl_recalculate_only": "google.protobuf.BoolValue"
        },
        "compression": [
          {
            "method": "Method",
            "min_part_size": "int64",
            "min_part_size_ratio": "double",
            "level": "google.protobuf.Int64Value"
          }
        ],
        "dictionaries": [
          {
            "name": "string",
            "structure": {
              "id": {
                "name": "string"
              },
              "key": {
                "attributes": [
                  {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  }
                ]
              },
              "range_min": {
                "name": "string",
                "type": "string",
                "null_value": "string",
                "expression": "string",
                "hierarchical": "bool",
                "injective": "bool"
              },
              "range_max": {
                "name": "string",
                "type": "string",
                "null_value": "string",
                "expression": "string",
                "hierarchical": "bool",
                "injective": "bool"
              },
              "attributes": [
                {
                  "name": "string",
                  "type": "string",
                  "null_value": "string",
                  "expression": "string",
                  "hierarchical": "bool",
                  "injective": "bool"
                }
              ]
            },
            "layout": {
              "type": "Type",
              "size_in_cells": "int64",
              "allow_read_expired_keys": "google.protobuf.BoolValue",
              "max_update_queue_size": "int64",
              "update_queue_push_timeout_milliseconds": "int64",
              "query_wait_timeout_milliseconds": "int64",
              "max_threads_for_updates": "int64",
              "initial_array_size": "int64",
              "max_array_size": "int64",
              "access_to_key_from_attributes": "google.protobuf.BoolValue"
            },
            // Includes only one of the fields `fixed_lifetime`, `lifetime_range`
            "fixed_lifetime": "int64",
            "lifetime_range": {
              "min": "int64",
              "max": "int64"
            },
            // end of the list of possible fields
            // Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`
            "http_source": {
              "url": "string",
              "format": "string",
              "headers": [
                {
                  "name": "string",
                  "value": "string"
                }
              ]
            },
            "mysql_source": {
              "db": "string",
              "table": "string",
              "port": "int64",
              "user": "string",
              "password": "string",
              "replicas": [
                {
                  "host": "string",
                  "priority": "int64",
                  "port": "int64",
                  "user": "string",
                  "password": "string"
                }
              ],
              "where": "string",
              "invalidate_query": "string",
              "close_connection": "google.protobuf.BoolValue",
              "share_connection": "google.protobuf.BoolValue"
            },
            "clickhouse_source": {
              "db": "string",
              "table": "string",
              "host": "string",
              "port": "int64",
              "user": "string",
              "password": "string",
              "where": "string",
              "secure": "google.protobuf.BoolValue"
            },
            "mongodb_source": {
              "db": "string",
              "collection": "string",
              "host": "string",
              "port": "int64",
              "user": "string",
              "password": "string",
              "options": "string"
            },
            "postgresql_source": {
              "db": "string",
              "table": "string",
              "hosts": [
                "string"
              ],
              "port": "int64",
              "user": "string",
              "password": "string",
              "invalidate_query": "string",
              "ssl_mode": "SslMode"
            }
            // end of the list of possible fields
          }
        ],
        "graphite_rollup": [
          {
            "name": "string",
            "patterns": [
              {
                "regexp": "string",
                "function": "string",
                "retention": [
                  {
                    "age": "int64",
                    "precision": "int64"
                  }
                ]
              }
            ],
            "path_column_name": "string",
            "time_column_name": "string",
            "value_column_name": "string",
            "version_column_name": "string"
          }
        ],
        "kafka": {
          "security_protocol": "SecurityProtocol",
          "sasl_mechanism": "SaslMechanism",
          "sasl_username": "string",
          "sasl_password": "string",
          "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
          "max_poll_interval_ms": "google.protobuf.Int64Value",
          "session_timeout_ms": "google.protobuf.Int64Value",
          "debug": "Debug",
          "auto_offset_reset": "AutoOffsetReset"
        },
        "kafka_topics": [
          {
            "name": "string",
            "settings": {
              "security_protocol": "SecurityProtocol",
              "sasl_mechanism": "SaslMechanism",
              "sasl_username": "string",
              "sasl_password": "string",
              "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
              "max_poll_interval_ms": "google.protobuf.Int64Value",
              "session_timeout_ms": "google.protobuf.Int64Value",
              "debug": "Debug",
              "auto_offset_reset": "AutoOffsetReset"
            }
          }
        ],
        "rabbitmq": {
          "username": "string",
          "password": "string",
          "vhost": "string"
        },
        "max_connections": "google.protobuf.Int64Value",
        "max_concurrent_queries": "google.protobuf.Int64Value",
        "keep_alive_timeout": "google.protobuf.Int64Value",
        "uncompressed_cache_size": "google.protobuf.Int64Value",
        "mark_cache_size": "google.protobuf.Int64Value",
        "max_table_size_to_drop": "google.protobuf.Int64Value",
        "max_partition_size_to_drop": "google.protobuf.Int64Value",
        "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value",
        "timezone": "string",
        "geobase_enabled": "google.protobuf.BoolValue",
        "geobase_uri": "string",
        "query_log_retention_size": "google.protobuf.Int64Value",
        "query_log_retention_time": "google.protobuf.Int64Value",
        "query_thread_log_enabled": "google.protobuf.BoolValue",
        "query_thread_log_retention_size": "google.protobuf.Int64Value",
        "query_thread_log_retention_time": "google.protobuf.Int64Value",
        "part_log_retention_size": "google.protobuf.Int64Value",
        "part_log_retention_time": "google.protobuf.Int64Value",
        "metric_log_enabled": "google.protobuf.BoolValue",
        "metric_log_retention_size": "google.protobuf.Int64Value",
        "metric_log_retention_time": "google.protobuf.Int64Value",
        "trace_log_enabled": "google.protobuf.BoolValue",
        "trace_log_retention_size": "google.protobuf.Int64Value",
        "trace_log_retention_time": "google.protobuf.Int64Value",
        "text_log_enabled": "google.protobuf.BoolValue",
        "text_log_retention_size": "google.protobuf.Int64Value",
        "text_log_retention_time": "google.protobuf.Int64Value",
        "text_log_level": "LogLevel",
        "opentelemetry_span_log_enabled": "google.protobuf.BoolValue",
        "opentelemetry_span_log_retention_size": "google.protobuf.Int64Value",
        "opentelemetry_span_log_retention_time": "google.protobuf.Int64Value",
        "query_views_log_enabled": "google.protobuf.BoolValue",
        "query_views_log_retention_size": "google.protobuf.Int64Value",
        "query_views_log_retention_time": "google.protobuf.Int64Value",
        "asynchronous_metric_log_enabled": "google.protobuf.BoolValue",
        "asynchronous_metric_log_retention_size": "google.protobuf.Int64Value",
        "asynchronous_metric_log_retention_time": "google.protobuf.Int64Value",
        "session_log_enabled": "google.protobuf.BoolValue",
        "session_log_retention_size": "google.protobuf.Int64Value",
        "session_log_retention_time": "google.protobuf.Int64Value",
        "zookeeper_log_enabled": "google.protobuf.BoolValue",
        "zookeeper_log_retention_size": "google.protobuf.Int64Value",
        "zookeeper_log_retention_time": "google.protobuf.Int64Value",
        "asynchronous_insert_log_enabled": "google.protobuf.BoolValue",
        "asynchronous_insert_log_retention_size": "google.protobuf.Int64Value",
        "asynchronous_insert_log_retention_time": "google.protobuf.Int64Value",
        "processors_profile_log_enabled": "google.protobuf.BoolValue",
        "processors_profile_log_retention_size": "google.protobuf.Int64Value",
        "processors_profile_log_retention_time": "google.protobuf.Int64Value",
        "background_pool_size": "google.protobuf.Int64Value",
        "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
        "background_schedule_pool_size": "google.protobuf.Int64Value",
        "background_fetches_pool_size": "google.protobuf.Int64Value",
        "background_move_pool_size": "google.protobuf.Int64Value",
        "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
        "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
        "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
        "background_common_pool_size": "google.protobuf.Int64Value",
        "default_database": "google.protobuf.StringValue",
        "total_memory_profiler_step": "google.protobuf.Int64Value",
        "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
        "query_masking_rules": [
          {
            "name": "string",
            "regexp": "string",
            "replace": "string"
          }
        ],
        "dictionaries_lazy_load": "google.protobuf.BoolValue",
        "query_cache": {
          "max_size_in_bytes": "google.protobuf.Int64Value",
          "max_entries": "google.protobuf.Int64Value",
          "max_entry_size_in_bytes": "google.protobuf.Int64Value",
          "max_entry_size_in_rows": "google.protobuf.Int64Value"
        },
        "jdbc_bridge": {
          "host": "string",
          "port": "google.protobuf.Int64Value"
        }
      },
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      }
    },
    "zookeeper": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      }
    },
    "backup_window_start": "google.type.TimeOfDay",
    "access": {
      "data_lens": "bool",
      "web_sql": "bool",
      "metrika": "bool",
      "serverless": "bool",
      "data_transfer": "bool",
      "yandex_query": "bool"
    },
    "cloud_storage": {
      "enabled": "bool",
      "move_factor": "google.protobuf.DoubleValue",
      "data_cache_enabled": "google.protobuf.BoolValue",
      "data_cache_max_size": "google.protobuf.Int64Value",
      "prefer_not_to_merge": "google.protobuf.BoolValue"
    },
    "sql_database_management": "google.protobuf.BoolValue",
    "sql_user_management": "google.protobuf.BoolValue",
    "admin_password": "string",
    "embedded_keeper": "google.protobuf.BoolValue",
    "backup_retain_period_days": "google.protobuf.Int64Value"
  },
  "database_specs": [
    {
      "name": "string"
    }
  ],
  "user_specs": [
    {
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
  ],
  "host_specs": [
    {
      "zone_id": "string",
      "type": "Type",
      "subnet_id": "string",
      "assign_public_ip": "bool",
      "shard_name": "string"
    }
  ],
  "network_id": "string",
  "shard_name": "string",
  "service_account_id": "string",
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "shard_specs": [
    {
      "name": "string",
      "config_spec": {
        "clickhouse": {
          "config": {
            "log_level": "LogLevel",
            "merge_tree": {
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue"
            },
            "compression": [
              {
                "method": "Method",
                "min_part_size": "int64",
                "min_part_size_ratio": "double",
                "level": "google.protobuf.Int64Value"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "null_value": "string",
                        "expression": "string",
                        "hierarchical": "bool",
                        "injective": "bool"
                      }
                    ]
                  },
                  "range_min": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "range_max": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "null_value": "string",
                      "expression": "string",
                      "hierarchical": "bool",
                      "injective": "bool"
                    }
                  ]
                },
                "layout": {
                  "type": "Type",
                  "size_in_cells": "int64",
                  "allow_read_expired_keys": "google.protobuf.BoolValue",
                  "max_update_queue_size": "int64",
                  "update_queue_push_timeout_milliseconds": "int64",
                  "query_wait_timeout_milliseconds": "int64",
                  "max_threads_for_updates": "int64",
                  "initial_array_size": "int64",
                  "max_array_size": "int64",
                  "access_to_key_from_attributes": "google.protobuf.BoolValue"
                },
                // Includes only one of the fields `fixed_lifetime`, `lifetime_range`
                "fixed_lifetime": "int64",
                "lifetime_range": {
                  "min": "int64",
                  "max": "int64"
                },
                // end of the list of possible fields
                // Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`
                "http_source": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysql_source": {
                  "db": "string",
                  "table": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "int64",
                      "port": "int64",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidate_query": "string",
                  "close_connection": "google.protobuf.BoolValue",
                  "share_connection": "google.protobuf.BoolValue"
                },
                "clickhouse_source": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "google.protobuf.BoolValue"
                },
                "mongodb_source": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresql_source": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "invalidate_query": "string",
                  "ssl_mode": "SslMode"
                }
                // end of the list of possible fields
              }
            ],
            "graphite_rollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "int64",
                        "precision": "int64"
                      }
                    ]
                  }
                ],
                "path_column_name": "string",
                "time_column_name": "string",
                "value_column_name": "string",
                "version_column_name": "string"
              }
            ],
            "kafka": {
              "security_protocol": "SecurityProtocol",
              "sasl_mechanism": "SaslMechanism",
              "sasl_username": "string",
              "sasl_password": "string",
              "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
              "max_poll_interval_ms": "google.protobuf.Int64Value",
              "session_timeout_ms": "google.protobuf.Int64Value",
              "debug": "Debug",
              "auto_offset_reset": "AutoOffsetReset"
            },
            "kafka_topics": [
              {
                "name": "string",
                "settings": {
                  "security_protocol": "SecurityProtocol",
                  "sasl_mechanism": "SaslMechanism",
                  "sasl_username": "string",
                  "sasl_password": "string",
                  "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
                  "max_poll_interval_ms": "google.protobuf.Int64Value",
                  "session_timeout_ms": "google.protobuf.Int64Value",
                  "debug": "Debug",
                  "auto_offset_reset": "AutoOffsetReset"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "query_log_retention_size": "google.protobuf.Int64Value",
            "query_log_retention_time": "google.protobuf.Int64Value",
            "query_thread_log_enabled": "google.protobuf.BoolValue",
            "query_thread_log_retention_size": "google.protobuf.Int64Value",
            "query_thread_log_retention_time": "google.protobuf.Int64Value",
            "part_log_retention_size": "google.protobuf.Int64Value",
            "part_log_retention_time": "google.protobuf.Int64Value",
            "metric_log_enabled": "google.protobuf.BoolValue",
            "metric_log_retention_size": "google.protobuf.Int64Value",
            "metric_log_retention_time": "google.protobuf.Int64Value",
            "trace_log_enabled": "google.protobuf.BoolValue",
            "trace_log_retention_size": "google.protobuf.Int64Value",
            "trace_log_retention_time": "google.protobuf.Int64Value",
            "text_log_enabled": "google.protobuf.BoolValue",
            "text_log_retention_size": "google.protobuf.Int64Value",
            "text_log_retention_time": "google.protobuf.Int64Value",
            "text_log_level": "LogLevel",
            "opentelemetry_span_log_enabled": "google.protobuf.BoolValue",
            "opentelemetry_span_log_retention_size": "google.protobuf.Int64Value",
            "opentelemetry_span_log_retention_time": "google.protobuf.Int64Value",
            "query_views_log_enabled": "google.protobuf.BoolValue",
            "query_views_log_retention_size": "google.protobuf.Int64Value",
            "query_views_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_metric_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_metric_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_metric_log_retention_time": "google.protobuf.Int64Value",
            "session_log_enabled": "google.protobuf.BoolValue",
            "session_log_retention_size": "google.protobuf.Int64Value",
            "session_log_retention_time": "google.protobuf.Int64Value",
            "zookeeper_log_enabled": "google.protobuf.BoolValue",
            "zookeeper_log_retention_size": "google.protobuf.Int64Value",
            "zookeeper_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_insert_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_insert_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_insert_log_retention_time": "google.protobuf.Int64Value",
            "processors_profile_log_enabled": "google.protobuf.BoolValue",
            "processors_profile_log_retention_size": "google.protobuf.Int64Value",
            "processors_profile_log_retention_time": "google.protobuf.Int64Value",
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "weight": "google.protobuf.Int64Value"
        }
      },
      "shard_group_names": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create the ClickHouse cluster in. ||
|| name | **string**

Required field. Name of the ClickHouse cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the ClickHouse cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | enum **Environment**

Required field. Deployment environment of the ClickHouse cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec)**

Required field. Configuration and resources for hosts that should be created for the ClickHouse cluster. ||
|| database_specs[] | **[DatabaseSpec](#yandex.cloud.mdb.clickhouse.v1.DatabaseSpec)**

Descriptions of databases to be created in the ClickHouse cluster. ||
|| user_specs[] | **[UserSpec](#yandex.cloud.mdb.clickhouse.v1.UserSpec)**

Descriptions of database users to be created in the ClickHouse cluster. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.clickhouse.v1.HostSpec)**

Individual configurations for hosts that should be created for the ClickHouse cluster. ||
|| network_id | **string**

Required field. ID of the network to create the cluster in. ||
|| shard_name | **string**

Name of the first shard in cluster. If not set, defaults to the value 'shard1'. ||
|| service_account_id | **string**

ID of the service account used for access to Object Storage. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| shard_specs[] | **[ShardSpec](#yandex.cloud.mdb.clickhouse.v1.ShardSpec)**

Configuration(s) of the shard(s) to be created. ||
|#

## ConfigSpec {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of the ClickHouse server software. ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Clickhouse)**

Configuration and resources for a ClickHouse server. ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Zookeeper)**

Configuration and resources for a ZooKeeper server. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.clickhouse.v1.Access)**

Access policy for external services.

If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy. ||
|| cloud_storage | **[CloudStorage](#yandex.cloud.mdb.clickhouse.v1.CloudStorage)** ||
|| sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether database management through SQL commands is enabled. ||
|| sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether user management through SQL commands is enabled. ||
|| admin_password | **string**

Password for user 'admin' that has SQL user management access. ||
|| embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether cluster should use embedded Keeper instead of Zookeeper ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

Configuration for a ClickHouse server. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ClickHouse hosts. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig}

ClickHouse configuration options. Detailed description for each set of options
is available in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/).

Any options not listed here are not supported.

#|
||Field | Description ||
|| log_level | enum **LogLevel**

Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| merge_tree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree)**

Settings for the MergeTree engine.
See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression)**

Compression settings for the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**

Configuration of external dictionaries to be used by the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). ||
|| graphite_rollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup)**

Settings for thinning Graphite data.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)** ||
|| kafka_topics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic)** ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq)** ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections. ||
|| max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of simultaneously processed requests. ||
|| keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. ||
|| uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Cache size (in bytes) for uncompressed data used by MergeTree tables. ||
|| mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. ||
|| max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the table that can be deleted using a DROP query. ||
|| max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the partition that can be deleted using a DROP query. ||
|| builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. ||
|| geobase_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable geobase. ||
|| geobase_uri | **string**

Address of the archive with the user geobase in Object Storage. ||
|| query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of
query_log data based on size is disabled. ||
|| query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of
query_log data based on time is disabled. ||
|| query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether query_thread_log system table is enabled. ||
|| query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of
query_thread_log data based on size is disabled. ||
|| query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of
query_thread_log data based on time is disabled. ||
|| part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of
part_log data based on size is disabled. ||
|| part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of
part_log data based on time is disabled. ||
|| metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether metric_log system table is enabled. ||
|| metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of
metric_log data based on size is disabled. ||
|| metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of
metric_log data based on time is disabled. ||
|| trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether trace_log system table is enabled. ||
|| trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of
trace_log data based on size is disabled. ||
|| trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of
trace_log data based on time is disabled. ||
|| text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether text_log system table is enabled. ||
|| text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of
text_log data based on size is disabled. ||
|| text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of
text_log data based on time is disabled. ||
|| text_log_level | enum **LogLevel**

Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable opentelemetry_span_log system table. Default value: false. ||
|| opentelemetry_span_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of opentelemetry_span_log data based on size is disabled. ||
|| opentelemetry_span_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0,
automatic removal of opentelemetry_span_log data based on time is disabled. ||
|| query_views_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable query_views_log system table. Default value: false. ||
|| query_views_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of query_views_log data based on size is disabled. ||
|| query_views_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_views_log records will be retained before removal. If set to 0,
automatic removal of query_views_log data based on time is disabled. ||
|| asynchronous_metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable asynchronous_metric_log system table. Default value: false. ||
|| asynchronous_metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_metric_log data based on size is disabled. ||
|| asynchronous_metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_metric_log data based on time is disabled. ||
|| session_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable session_log system table. Default value: false. ||
|| session_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that session_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of session_log data based on size is disabled. ||
|| session_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that session_log records will be retained before removal. If set to 0,
automatic removal of session_log data based on time is disabled. ||
|| zookeeper_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable zookeeper_log system table. Default value: false. ||
|| zookeeper_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of zookeeper_log data based on size is disabled. ||
|| zookeeper_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that zookeeper_log records will be retained before removal. If set to 0,
automatic removal of zookeeper_log data based on time is disabled. ||
|| asynchronous_insert_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable asynchronous_insert_log system table. Default value: false.
Minimal required ClickHouse version: 22.10. ||
|| asynchronous_insert_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_insert_log data based on size is disabled. ||
|| asynchronous_insert_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_insert_log data based on time is disabled. ||
|| processors_profile_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable processors_profile_log system table. ||
|| processors_profile_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that processors_profile_log can grow to before old data will be removed.
If set to 0 (default), automatic removal of processors_profile_log data based on size is disabled. ||
|| processors_profile_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that processors_profile_log records will be retained before removal.
If set to 0, automatic removal of processors_profile_log data based on time is disabled. ||
|| background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_merges_mutations_concurrency_ratio | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility.
Default: 2
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio) ||
|| background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). ||
|| background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_common_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background.
Default: 8
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size) ||
|| default_database | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

The default database.

To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](/docs/managed-clickhouse/operations/databases#list-db). ||
|| total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). ||
|| total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| query_masking_rules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.
Change of these settings is applied with ClickHouse restart
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules) ||
|| dictionaries_lazy_load | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Lazy loading of dictionaries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load) ||
|| query_cache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache)**

[Query cache](https://clickhouse.com/docs/en/operations/query-cache) configuration.
Min version: 23.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache) ||
|| jdbc_bridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge)**

JDBC bridge for queries to external databases.
https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree}

Options specific to the MergeTree table engine.

#|
||Field | Description ||
|| replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of blocks of hashes to keep in ZooKeeper. ||
|| replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Period of time to keep blocks of hashes for. ||
|| parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If table contains at least that many active parts in single partition, artificially slow down insert into table. ||
|| parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If more than this number active parts in single partition, throw 'Too many parts ...' exception. ||
|| inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. ||
|| number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If there is less than specified number of free entries in background pool (or replicated queue), start to lower
maximum size of merge to process. ||
|| max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries
in replication queue). ||
|| max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of bytes in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of rows in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). ||
|| allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_avg_part_size_for_too_many_parts | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.
Default: 1 GiB
Min version: 22.10
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80) ||
|| min_age_to_force_merge_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds.
Default: 0 - disabled
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| min_age_to_force_merge_on_partition_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset.
Default: false
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters.
Default: 5000
Min_version: 21.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms) ||
|| merge_max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of rows that are read from the merged parts into memory.
Default: 8192
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size) ||
|| check_sample_column_is_correct | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned [integer types](https://clickhouse.com/docs/en/sql-reference/data-types/int-uint): UInt8, UInt16, UInt32, UInt64.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct) ||
|| max_merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters.
Default: 60000
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71) ||
|| max_cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum period to clean old queue logs, blocks hashes and parts.
Default: 300
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142) ||
|| deduplicate_merge_projection_mode | enum **DeduplicateMergeProjectionMode**

Determines the behavior of background merges for MergeTree tables with projections.
https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode

- `DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD` ||
|| lightweight_mutation_projection_mode | enum **LightweightMutationProjectionMode**

Determines the behavior of lightweight deletes for MergeTree tables with projections.

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD` ||
|| materialize_ttl_recalculate_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Only recalculate ttl info when MATERIALIZE TTL. ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression}

#|
||Field | Description ||
|| method | enum **Method**

Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).
- `ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/). ||
|| min_part_size | **int64**

Minimum size of a part of a table. ||
|| min_part_size_ratio | **double**

Minimum ratio of a part relative to the size of all the data in the table. ||
|| level | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**

Required field. Set of attributes for the external dictionary.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**

Required field. Layout for storing the dictionary in memory.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). ||
|| fixed_lifetime | **int64**

Fixed interval between dictionary updates.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| lifetime_range | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| http_source | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

HTTP source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| mysql_source | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

MySQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| clickhouse_source | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

ClickHouse source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| mongodb_source | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

MongoDB source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| postgresql_source | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

PostgreSQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**

Composite key for the dictionary, containing of one or more key columns.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| range_min | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| range_max | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the end of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Description of the fields available for database queries.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id}

Numeric key.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the numeric key. ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key}

Complex key.

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Attributes of a complex key. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the column. ||
|| type | **string**

Required field. Type of the column. ||
|| null_value | **string**

Default value for an element without data (for example, an empty string). ||
|| expression | **string**

Expression, describing the attribute, if applicable. ||
|| hierarchical | **bool**

Indication of hierarchy support.
Default value: `false`. ||
|| injective | **bool**

Indication of injective mapping "id -> attribute".
Default value: `false`. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

Layout determining how to store the dictionary in memory.

#|
||Field | Description ||
|| type | enum **Type**

Required field. Layout type for an external dictionary.

- `TYPE_UNSPECIFIED`
- `FLAT`: The entire dictionary is stored in memory in the form of flat arrays.
Available for all dictionary sources.
- `HASHED`: The entire dictionary is stored in memory in the form of a hash table.
Available for all dictionary sources.
- `COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys.
Available for all dictionary sources.
- `RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table,
with an ordered array of ranges and their corresponding values.
Available for all dictionary sources.
- `CACHE`: The dictionary is stored in a cache with a set number of cells.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `SPARSE_HASHED`: Similar to HASHED, but uses less memory in favor of more CPU usage.
- `COMPLEX_KEY_SPARSE_HASHED`: Similar to SPARSE_HASHED, to be used with composite keys.
- `COMPLEX_KEY_RANGE_HASHED`: Similar to RANGE_HASHED, to be used with composite keys.
- `DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
- `COMPLEX_KEY_DIRECT`: Similar to DIRECT, to be used with composite keys.
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN. ||
|| size_in_cells | **int64**

Number of cells in the cache. Rounded up to a power of two.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| allow_read_expired_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to read expired keys.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| max_update_queue_size | **int64**

Max size of update queue.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| update_queue_push_timeout_milliseconds | **int64**

Max timeout in milliseconds for push update task into queue.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| query_wait_timeout_milliseconds | **int64**

Max wait timeout in milliseconds for update task to complete.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| max_threads_for_updates | **int64**

Max threads for cache dictionary update.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| initial_array_size | **int64**

Initial dictionary key size.
Applicable only for FLAT layout type. ||
|| max_array_size | **int64**

Maximum dictionary key size.
Applicable only for FLAT layout type. ||
|| access_to_key_from_attributes | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to retrieve key attribute using dictGetString function.
Enabling this option increases memory usage.
Applicable only for IP_TRIE layout type. ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range}

#|
||Field | Description ||
|| min | **int64**

Minimum dictionary lifetime. ||
|| max | **int64**

Maximum dictionary lifetime. ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource}

#|
||Field | Description ||
|| url | **string**

Required field. URL of the source dictionary available over HTTP. ||
|| format | **string**

Required field. The data format. Valid values are all formats supported by ClickHouse SQL dialect. ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| value | **string**

Required field.  ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MySQL database to connect to. ||
|| table | **string**

Required field. Name of the database table to use as a ClickHouse dictionary. ||
|| port | **int64**

Default port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Name of the default user for replicas of the dictionary source. ||
|| password | **string**

Password of the default user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| close_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should the connection be closed after each request. ||
|| share_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **int64**

Required field. The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **int64**

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user. ||
|| password | **string**

Password of the MySQL database user. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the ClickHouse database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| host | **string**

ClickHouse host of the specified database. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Use ssl for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MongoDB database. ||
|| collection | **string**

Required field. Name of the collection in the specified database to be used as the dictionary source. ||
|| host | **string**

MongoDB host of the specified database. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the PostrgreSQL database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| hosts[] | **string**

Name of the PostrgreSQL host ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| ssl_mode | enum **SslMode**

Mode of SSL TCP/IP connection to the PostgreSQL host.
For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html).

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup}

Rollup settings for the GraphiteMergeTree table engine.

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern)**

Pattern to use for the rollup. ||
|| path_column_name | **string**

The name of the column storing the metric name (Graphite sensor).
Default: Path
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| time_column_name | **string**

The name of the column storing the time of measuring the metric.
Default: Time
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| value_column_name | **string**

The name of the column storing the value of the metric at the time set in time_column_name.
Default: Value
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| version_column_name | **string**

The name of the column storing the version of the metric.
Default: Timestamp
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern}

#|
||Field | Description ||
|| regexp | **string**

Pattern for metric names. ||
|| function | **string**

Required field. Name of the aggregating function to apply to data of the age specified in `retention`. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention)**

Age of data to use for thinning. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention}

#|
||Field | Description ||
|| age | **int64**

Minimum age of the data in seconds. ||
|| precision | **int64**

Precision of determining the age of the data, in seconds. ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka}

#|
||Field | Description ||
|| security_protocol | enum **SecurityProtocol**

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| sasl_mechanism | enum **SaslMechanism**

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| sasl_username | **string** ||
|| sasl_password | **string** ||
|| enable_ssl_certificate_verification | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| max_poll_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| session_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| debug | enum **Debug**

- `DEBUG_UNSPECIFIED`
- `DEBUG_GENERIC`
- `DEBUG_BROKER`
- `DEBUG_TOPIC`
- `DEBUG_METADATA`
- `DEBUG_FEATURE`
- `DEBUG_QUEUE`
- `DEBUG_MSG`
- `DEBUG_PROTOCOL`
- `DEBUG_CGRP`
- `DEBUG_SECURITY`
- `DEBUG_FETCH`
- `DEBUG_INTERCEPTOR`
- `DEBUG_PLUGIN`
- `DEBUG_CONSUMER`
- `DEBUG_ADMIN`
- `DEBUG_EOS`
- `DEBUG_MOCK`
- `DEBUG_ASSIGNOR`
- `DEBUG_CONF`
- `DEBUG_TELEMETRY`
- `DEBUG_ALL` ||
|| auto_offset_reset | enum **AutoOffsetReset**

- `AUTO_OFFSET_RESET_UNSPECIFIED`
- `AUTO_OFFSET_RESET_SMALLEST`
- `AUTO_OFFSET_RESET_EARLIEST`
- `AUTO_OFFSET_RESET_BEGINNING`
- `AUTO_OFFSET_RESET_LARGEST`
- `AUTO_OFFSET_RESET_LATEST`
- `AUTO_OFFSET_RESET_END`
- `AUTO_OFFSET_RESET_ERROR` ||
|#

## KafkaTopic {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**

Required field.  ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq}

#|
||Field | Description ||
|| username | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username ||
|| password | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password ||
|| vhost | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression.
Required. ||
|| replace | **string**

Substitution string for sensitive data.
Default: six asterisks ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache}

#|
||Field | Description ||
|| max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum cache size in bytes.
Default: 1073741824 (1 GiB) ||
|| max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of SELECT query results stored in the cache.
Default: 1024 ||
|| max_entry_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size in bytes SELECT query results may have to be saved in the cache.
Dafault: 1048576 (1 MiB) ||
|| max_entry_size_in_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of rows SELECT query results may have to be saved in the cache.
Default: 30000000 (30 mil) ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge}

JDBC bridge for queries to external databases.

#|
||Field | Description ||
|| host | **string**

Required field. Host of jdbc bridge. ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Port of jdbc bridge. ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used.
All available resource presets can be retrieved with a [ResourcePresetService.List](/docs/managed-clickhouse/api-ref/grpc/ResourcePreset/list#List) request. ||
|#

## Access {#yandex.cloud.mdb.clickhouse.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow to export data from the cluster to DataLens. ||
|| web_sql | **bool**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. ||
|| metrika | **bool**

Allow to import data from Yandex Metrica and AppMetrica to the cluster.

See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. ||
|| serverless | **bool**

Allow access to cluster for Serverless. ||
|| data_transfer | **bool**

Allow access for DataTransfer ||
|| yandex_query | **bool**

Allow access for Query ||
|#

## CloudStorage {#yandex.cloud.mdb.clickhouse.v1.CloudStorage}

#|
||Field | Description ||
|| enabled | **bool**

Whether to use Object Storage for storing ClickHouse data. ||
|| move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| prefer_not_to_merge | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## DatabaseSpec {#yandex.cloud.mdb.clickhouse.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the ClickHouse database. 1-63 characters long. ||
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

## HostSpec {#yandex.cloud.mdb.clickhouse.v1.HostSpec}

#|
||Field | Description ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| type | enum **Type**

Required field. Type of the host to be deployed.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `CLICKHOUSE`: ClickHouse host.
- `ZOOKEEPER`: ZooKeeper host. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the [Cluster.network_id](#yandex.cloud.mdb.clickhouse.v1.Cluster) field. ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| shard_name | **string**

Name of the shard that the host is assigned to. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## ShardSpec {#yandex.cloud.mdb.clickhouse.v1.ShardSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the shard to be created. ||
|| config_spec | **[ShardConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec)**

Configuration of the shard to be created. ||
|| shard_group_names[] | **string**

Shard groups that contain the shard. ||
|#

## ShardConfigSpec {#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec}

#|
||Field | Description ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec.Clickhouse)**

ClickHouse configuration for a shard. ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

ClickHouse settings for the shard. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Computational resources for the shard. ||
|| weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Relative weight of the shard considered when writing data to the cluster.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). ||
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
    "cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "environment": "Environment",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      "clickhouse": {
        "config": {
          "effective_config": {
            "log_level": "LogLevel",
            "merge_tree": {
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue"
            },
            "compression": [
              {
                "method": "Method",
                "min_part_size": "int64",
                "min_part_size_ratio": "double",
                "level": "google.protobuf.Int64Value"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "null_value": "string",
                        "expression": "string",
                        "hierarchical": "bool",
                        "injective": "bool"
                      }
                    ]
                  },
                  "range_min": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "range_max": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "null_value": "string",
                      "expression": "string",
                      "hierarchical": "bool",
                      "injective": "bool"
                    }
                  ]
                },
                "layout": {
                  "type": "Type",
                  "size_in_cells": "int64",
                  "allow_read_expired_keys": "google.protobuf.BoolValue",
                  "max_update_queue_size": "int64",
                  "update_queue_push_timeout_milliseconds": "int64",
                  "query_wait_timeout_milliseconds": "int64",
                  "max_threads_for_updates": "int64",
                  "initial_array_size": "int64",
                  "max_array_size": "int64",
                  "access_to_key_from_attributes": "google.protobuf.BoolValue"
                },
                // Includes only one of the fields `fixed_lifetime`, `lifetime_range`
                "fixed_lifetime": "int64",
                "lifetime_range": {
                  "min": "int64",
                  "max": "int64"
                },
                // end of the list of possible fields
                // Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`
                "http_source": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysql_source": {
                  "db": "string",
                  "table": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "int64",
                      "port": "int64",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidate_query": "string",
                  "close_connection": "google.protobuf.BoolValue",
                  "share_connection": "google.protobuf.BoolValue"
                },
                "clickhouse_source": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "google.protobuf.BoolValue"
                },
                "mongodb_source": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresql_source": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "invalidate_query": "string",
                  "ssl_mode": "SslMode"
                }
                // end of the list of possible fields
              }
            ],
            "graphite_rollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "int64",
                        "precision": "int64"
                      }
                    ]
                  }
                ],
                "path_column_name": "string",
                "time_column_name": "string",
                "value_column_name": "string",
                "version_column_name": "string"
              }
            ],
            "kafka": {
              "security_protocol": "SecurityProtocol",
              "sasl_mechanism": "SaslMechanism",
              "sasl_username": "string",
              "sasl_password": "string",
              "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
              "max_poll_interval_ms": "google.protobuf.Int64Value",
              "session_timeout_ms": "google.protobuf.Int64Value",
              "debug": "Debug",
              "auto_offset_reset": "AutoOffsetReset"
            },
            "kafka_topics": [
              {
                "name": "string",
                "settings": {
                  "security_protocol": "SecurityProtocol",
                  "sasl_mechanism": "SaslMechanism",
                  "sasl_username": "string",
                  "sasl_password": "string",
                  "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
                  "max_poll_interval_ms": "google.protobuf.Int64Value",
                  "session_timeout_ms": "google.protobuf.Int64Value",
                  "debug": "Debug",
                  "auto_offset_reset": "AutoOffsetReset"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "query_log_retention_size": "google.protobuf.Int64Value",
            "query_log_retention_time": "google.protobuf.Int64Value",
            "query_thread_log_enabled": "google.protobuf.BoolValue",
            "query_thread_log_retention_size": "google.protobuf.Int64Value",
            "query_thread_log_retention_time": "google.protobuf.Int64Value",
            "part_log_retention_size": "google.protobuf.Int64Value",
            "part_log_retention_time": "google.protobuf.Int64Value",
            "metric_log_enabled": "google.protobuf.BoolValue",
            "metric_log_retention_size": "google.protobuf.Int64Value",
            "metric_log_retention_time": "google.protobuf.Int64Value",
            "trace_log_enabled": "google.protobuf.BoolValue",
            "trace_log_retention_size": "google.protobuf.Int64Value",
            "trace_log_retention_time": "google.protobuf.Int64Value",
            "text_log_enabled": "google.protobuf.BoolValue",
            "text_log_retention_size": "google.protobuf.Int64Value",
            "text_log_retention_time": "google.protobuf.Int64Value",
            "text_log_level": "LogLevel",
            "opentelemetry_span_log_enabled": "google.protobuf.BoolValue",
            "opentelemetry_span_log_retention_size": "google.protobuf.Int64Value",
            "opentelemetry_span_log_retention_time": "google.protobuf.Int64Value",
            "query_views_log_enabled": "google.protobuf.BoolValue",
            "query_views_log_retention_size": "google.protobuf.Int64Value",
            "query_views_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_metric_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_metric_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_metric_log_retention_time": "google.protobuf.Int64Value",
            "session_log_enabled": "google.protobuf.BoolValue",
            "session_log_retention_size": "google.protobuf.Int64Value",
            "session_log_retention_time": "google.protobuf.Int64Value",
            "zookeeper_log_enabled": "google.protobuf.BoolValue",
            "zookeeper_log_retention_size": "google.protobuf.Int64Value",
            "zookeeper_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_insert_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_insert_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_insert_log_retention_time": "google.protobuf.Int64Value",
            "processors_profile_log_enabled": "google.protobuf.BoolValue",
            "processors_profile_log_retention_size": "google.protobuf.Int64Value",
            "processors_profile_log_retention_time": "google.protobuf.Int64Value",
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            }
          },
          "user_config": {
            "log_level": "LogLevel",
            "merge_tree": {
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue"
            },
            "compression": [
              {
                "method": "Method",
                "min_part_size": "int64",
                "min_part_size_ratio": "double",
                "level": "google.protobuf.Int64Value"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "null_value": "string",
                        "expression": "string",
                        "hierarchical": "bool",
                        "injective": "bool"
                      }
                    ]
                  },
                  "range_min": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "range_max": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "null_value": "string",
                      "expression": "string",
                      "hierarchical": "bool",
                      "injective": "bool"
                    }
                  ]
                },
                "layout": {
                  "type": "Type",
                  "size_in_cells": "int64",
                  "allow_read_expired_keys": "google.protobuf.BoolValue",
                  "max_update_queue_size": "int64",
                  "update_queue_push_timeout_milliseconds": "int64",
                  "query_wait_timeout_milliseconds": "int64",
                  "max_threads_for_updates": "int64",
                  "initial_array_size": "int64",
                  "max_array_size": "int64",
                  "access_to_key_from_attributes": "google.protobuf.BoolValue"
                },
                // Includes only one of the fields `fixed_lifetime`, `lifetime_range`
                "fixed_lifetime": "int64",
                "lifetime_range": {
                  "min": "int64",
                  "max": "int64"
                },
                // end of the list of possible fields
                // Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`
                "http_source": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysql_source": {
                  "db": "string",
                  "table": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "int64",
                      "port": "int64",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidate_query": "string",
                  "close_connection": "google.protobuf.BoolValue",
                  "share_connection": "google.protobuf.BoolValue"
                },
                "clickhouse_source": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "google.protobuf.BoolValue"
                },
                "mongodb_source": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresql_source": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "invalidate_query": "string",
                  "ssl_mode": "SslMode"
                }
                // end of the list of possible fields
              }
            ],
            "graphite_rollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "int64",
                        "precision": "int64"
                      }
                    ]
                  }
                ],
                "path_column_name": "string",
                "time_column_name": "string",
                "value_column_name": "string",
                "version_column_name": "string"
              }
            ],
            "kafka": {
              "security_protocol": "SecurityProtocol",
              "sasl_mechanism": "SaslMechanism",
              "sasl_username": "string",
              "sasl_password": "string",
              "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
              "max_poll_interval_ms": "google.protobuf.Int64Value",
              "session_timeout_ms": "google.protobuf.Int64Value",
              "debug": "Debug",
              "auto_offset_reset": "AutoOffsetReset"
            },
            "kafka_topics": [
              {
                "name": "string",
                "settings": {
                  "security_protocol": "SecurityProtocol",
                  "sasl_mechanism": "SaslMechanism",
                  "sasl_username": "string",
                  "sasl_password": "string",
                  "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
                  "max_poll_interval_ms": "google.protobuf.Int64Value",
                  "session_timeout_ms": "google.protobuf.Int64Value",
                  "debug": "Debug",
                  "auto_offset_reset": "AutoOffsetReset"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "query_log_retention_size": "google.protobuf.Int64Value",
            "query_log_retention_time": "google.protobuf.Int64Value",
            "query_thread_log_enabled": "google.protobuf.BoolValue",
            "query_thread_log_retention_size": "google.protobuf.Int64Value",
            "query_thread_log_retention_time": "google.protobuf.Int64Value",
            "part_log_retention_size": "google.protobuf.Int64Value",
            "part_log_retention_time": "google.protobuf.Int64Value",
            "metric_log_enabled": "google.protobuf.BoolValue",
            "metric_log_retention_size": "google.protobuf.Int64Value",
            "metric_log_retention_time": "google.protobuf.Int64Value",
            "trace_log_enabled": "google.protobuf.BoolValue",
            "trace_log_retention_size": "google.protobuf.Int64Value",
            "trace_log_retention_time": "google.protobuf.Int64Value",
            "text_log_enabled": "google.protobuf.BoolValue",
            "text_log_retention_size": "google.protobuf.Int64Value",
            "text_log_retention_time": "google.protobuf.Int64Value",
            "text_log_level": "LogLevel",
            "opentelemetry_span_log_enabled": "google.protobuf.BoolValue",
            "opentelemetry_span_log_retention_size": "google.protobuf.Int64Value",
            "opentelemetry_span_log_retention_time": "google.protobuf.Int64Value",
            "query_views_log_enabled": "google.protobuf.BoolValue",
            "query_views_log_retention_size": "google.protobuf.Int64Value",
            "query_views_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_metric_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_metric_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_metric_log_retention_time": "google.protobuf.Int64Value",
            "session_log_enabled": "google.protobuf.BoolValue",
            "session_log_retention_size": "google.protobuf.Int64Value",
            "session_log_retention_time": "google.protobuf.Int64Value",
            "zookeeper_log_enabled": "google.protobuf.BoolValue",
            "zookeeper_log_retention_size": "google.protobuf.Int64Value",
            "zookeeper_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_insert_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_insert_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_insert_log_retention_time": "google.protobuf.Int64Value",
            "processors_profile_log_enabled": "google.protobuf.BoolValue",
            "processors_profile_log_retention_size": "google.protobuf.Int64Value",
            "processors_profile_log_retention_time": "google.protobuf.Int64Value",
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            }
          },
          "default_config": {
            "log_level": "LogLevel",
            "merge_tree": {
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue"
            },
            "compression": [
              {
                "method": "Method",
                "min_part_size": "int64",
                "min_part_size_ratio": "double",
                "level": "google.protobuf.Int64Value"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "null_value": "string",
                        "expression": "string",
                        "hierarchical": "bool",
                        "injective": "bool"
                      }
                    ]
                  },
                  "range_min": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "range_max": {
                    "name": "string",
                    "type": "string",
                    "null_value": "string",
                    "expression": "string",
                    "hierarchical": "bool",
                    "injective": "bool"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "null_value": "string",
                      "expression": "string",
                      "hierarchical": "bool",
                      "injective": "bool"
                    }
                  ]
                },
                "layout": {
                  "type": "Type",
                  "size_in_cells": "int64",
                  "allow_read_expired_keys": "google.protobuf.BoolValue",
                  "max_update_queue_size": "int64",
                  "update_queue_push_timeout_milliseconds": "int64",
                  "query_wait_timeout_milliseconds": "int64",
                  "max_threads_for_updates": "int64",
                  "initial_array_size": "int64",
                  "max_array_size": "int64",
                  "access_to_key_from_attributes": "google.protobuf.BoolValue"
                },
                // Includes only one of the fields `fixed_lifetime`, `lifetime_range`
                "fixed_lifetime": "int64",
                "lifetime_range": {
                  "min": "int64",
                  "max": "int64"
                },
                // end of the list of possible fields
                // Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`
                "http_source": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysql_source": {
                  "db": "string",
                  "table": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "int64",
                      "port": "int64",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidate_query": "string",
                  "close_connection": "google.protobuf.BoolValue",
                  "share_connection": "google.protobuf.BoolValue"
                },
                "clickhouse_source": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "google.protobuf.BoolValue"
                },
                "mongodb_source": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresql_source": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "int64",
                  "user": "string",
                  "password": "string",
                  "invalidate_query": "string",
                  "ssl_mode": "SslMode"
                }
                // end of the list of possible fields
              }
            ],
            "graphite_rollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "int64",
                        "precision": "int64"
                      }
                    ]
                  }
                ],
                "path_column_name": "string",
                "time_column_name": "string",
                "value_column_name": "string",
                "version_column_name": "string"
              }
            ],
            "kafka": {
              "security_protocol": "SecurityProtocol",
              "sasl_mechanism": "SaslMechanism",
              "sasl_username": "string",
              "sasl_password": "string",
              "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
              "max_poll_interval_ms": "google.protobuf.Int64Value",
              "session_timeout_ms": "google.protobuf.Int64Value",
              "debug": "Debug",
              "auto_offset_reset": "AutoOffsetReset"
            },
            "kafka_topics": [
              {
                "name": "string",
                "settings": {
                  "security_protocol": "SecurityProtocol",
                  "sasl_mechanism": "SaslMechanism",
                  "sasl_username": "string",
                  "sasl_password": "string",
                  "enable_ssl_certificate_verification": "google.protobuf.BoolValue",
                  "max_poll_interval_ms": "google.protobuf.Int64Value",
                  "session_timeout_ms": "google.protobuf.Int64Value",
                  "debug": "Debug",
                  "auto_offset_reset": "AutoOffsetReset"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "query_log_retention_size": "google.protobuf.Int64Value",
            "query_log_retention_time": "google.protobuf.Int64Value",
            "query_thread_log_enabled": "google.protobuf.BoolValue",
            "query_thread_log_retention_size": "google.protobuf.Int64Value",
            "query_thread_log_retention_time": "google.protobuf.Int64Value",
            "part_log_retention_size": "google.protobuf.Int64Value",
            "part_log_retention_time": "google.protobuf.Int64Value",
            "metric_log_enabled": "google.protobuf.BoolValue",
            "metric_log_retention_size": "google.protobuf.Int64Value",
            "metric_log_retention_time": "google.protobuf.Int64Value",
            "trace_log_enabled": "google.protobuf.BoolValue",
            "trace_log_retention_size": "google.protobuf.Int64Value",
            "trace_log_retention_time": "google.protobuf.Int64Value",
            "text_log_enabled": "google.protobuf.BoolValue",
            "text_log_retention_size": "google.protobuf.Int64Value",
            "text_log_retention_time": "google.protobuf.Int64Value",
            "text_log_level": "LogLevel",
            "opentelemetry_span_log_enabled": "google.protobuf.BoolValue",
            "opentelemetry_span_log_retention_size": "google.protobuf.Int64Value",
            "opentelemetry_span_log_retention_time": "google.protobuf.Int64Value",
            "query_views_log_enabled": "google.protobuf.BoolValue",
            "query_views_log_retention_size": "google.protobuf.Int64Value",
            "query_views_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_metric_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_metric_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_metric_log_retention_time": "google.protobuf.Int64Value",
            "session_log_enabled": "google.protobuf.BoolValue",
            "session_log_retention_size": "google.protobuf.Int64Value",
            "session_log_retention_time": "google.protobuf.Int64Value",
            "zookeeper_log_enabled": "google.protobuf.BoolValue",
            "zookeeper_log_retention_size": "google.protobuf.Int64Value",
            "zookeeper_log_retention_time": "google.protobuf.Int64Value",
            "asynchronous_insert_log_enabled": "google.protobuf.BoolValue",
            "asynchronous_insert_log_retention_size": "google.protobuf.Int64Value",
            "asynchronous_insert_log_retention_time": "google.protobuf.Int64Value",
            "processors_profile_log_enabled": "google.protobuf.BoolValue",
            "processors_profile_log_retention_size": "google.protobuf.Int64Value",
            "processors_profile_log_retention_time": "google.protobuf.Int64Value",
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "zookeeper": {
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "backup_window_start": "google.type.TimeOfDay",
      "access": {
        "data_lens": "bool",
        "web_sql": "bool",
        "metrika": "bool",
        "serverless": "bool",
        "data_transfer": "bool",
        "yandex_query": "bool"
      },
      "cloud_storage": {
        "enabled": "bool",
        "move_factor": "google.protobuf.DoubleValue",
        "data_cache_enabled": "google.protobuf.BoolValue",
        "data_cache_max_size": "google.protobuf.Int64Value",
        "prefer_not_to_merge": "google.protobuf.BoolValue"
      },
      "sql_database_management": "google.protobuf.BoolValue",
      "sql_user_management": "google.protobuf.BoolValue",
      "embedded_keeper": "google.protobuf.BoolValue",
      "backup_retain_period_days": "google.protobuf.Int64Value"
    },
    "network_id": "string",
    "health": "Health",
    "status": "Status",
    "service_account_id": "string",
    "maintenance_window": {
      // Includes only one of the fields `anytime`, `weekly_maintenance_window`
      "anytime": "AnytimeMaintenanceWindow",
      "weekly_maintenance_window": {
        "day": "WeekDay",
        "hour": "int64"
      }
      // end of the list of possible fields
    },
    "planned_operation": {
      "info": "string",
      "delayed_until": "google.protobuf.Timestamp"
    },
    "security_group_ids": [
      "string"
    ],
    "deletion_protection": "bool"
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
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.clickhouse.v1.CreateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.clickhouse.v1.Cluster)**

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

## CreateClusterMetadata {#yandex.cloud.mdb.clickhouse.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the ClickHouse cluster that is being created. ||
|#

## Cluster {#yandex.cloud.mdb.clickhouse.v1.Cluster}

A ClickHouse Cluster resource. For more information, see the
[Cluster](/docs/managed-clickhouse/concepts) section in the Developer's Guide.

#|
||Field | Description ||
|| id | **string**

ID of the ClickHouse cluster.
This ID is assigned by MDB at creation time. ||
|| folder_id | **string**

ID of the folder that the ClickHouse cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the ClickHouse cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the ClickHouse cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. ||
|| environment | enum **Environment**

Deployment environment of the ClickHouse cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.clickhouse.v1.Monitoring)**

Description of monitoring systems relevant to the ClickHouse cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig)**

Configuration of the ClickHouse cluster. ||
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-clickhouse/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-clickhouse/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-clickhouse/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-clickhouse/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| service_account_id | **string**

ID of the service account used for access to Object Storage. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow2)**

Maintenance window for the cluster. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|#

## Monitoring {#yandex.cloud.mdb.clickhouse.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the ClickHouse cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of the ClickHouse server software. ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Clickhouse)**

Configuration and resource allocation for ClickHouse hosts. ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper)**

Configuration and resource allocation for ZooKeeper hosts. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.clickhouse.v1.Access2)**

Access policy for external services. ||
|| cloud_storage | **[CloudStorage](#yandex.cloud.mdb.clickhouse.v1.CloudStorage2)** ||
|| sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether database management through SQL commands is enabled. ||
|| sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether user management through SQL commands is enabled. ||
|| embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether cluster should use embedded Keeper instead of Zookeeper. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfigSet](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet)**

Configuration settings of a ClickHouse server. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources2)**

Resources allocated to ClickHouse hosts. ||
|#

## ClickhouseConfigSet {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet}

#|
||Field | Description ||
|| effective_config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. Effective settings for a ClickHouse cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

User-defined settings for a ClickHouse cluster. ||
|| default_config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Default configuration for a ClickHouse cluster. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2}

ClickHouse configuration options. Detailed description for each set of options
is available in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/).

Any options not listed here are not supported.

#|
||Field | Description ||
|| log_level | enum **LogLevel**

Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| merge_tree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2)**

Settings for the MergeTree engine.
See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2)**

Compression settings for the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2)**

Configuration of external dictionaries to be used by the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). ||
|| graphite_rollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2)**

Settings for thinning Graphite data.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)** ||
|| kafka_topics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2)** ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2)** ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections. ||
|| max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of simultaneously processed requests. ||
|| keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. ||
|| uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Cache size (in bytes) for uncompressed data used by MergeTree tables. ||
|| mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. ||
|| max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the table that can be deleted using a DROP query. ||
|| max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the partition that can be deleted using a DROP query. ||
|| builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The setting is deprecated and has no effect. ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. ||
|| geobase_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable geobase. ||
|| geobase_uri | **string**

Address of the archive with the user geobase in Object Storage. ||
|| query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of
query_log data based on size is disabled. ||
|| query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of
query_log data based on time is disabled. ||
|| query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether query_thread_log system table is enabled. ||
|| query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of
query_thread_log data based on size is disabled. ||
|| query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of
query_thread_log data based on time is disabled. ||
|| part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of
part_log data based on size is disabled. ||
|| part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of
part_log data based on time is disabled. ||
|| metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether metric_log system table is enabled. ||
|| metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of
metric_log data based on size is disabled. ||
|| metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of
metric_log data based on time is disabled. ||
|| trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether trace_log system table is enabled. ||
|| trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of
trace_log data based on size is disabled. ||
|| trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of
trace_log data based on time is disabled. ||
|| text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether text_log system table is enabled. ||
|| text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of
text_log data based on size is disabled. ||
|| text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of
text_log data based on time is disabled. ||
|| text_log_level | enum **LogLevel**

Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable opentelemetry_span_log system table. Default value: false. ||
|| opentelemetry_span_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of opentelemetry_span_log data based on size is disabled. ||
|| opentelemetry_span_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0,
automatic removal of opentelemetry_span_log data based on time is disabled. ||
|| query_views_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable query_views_log system table. Default value: false. ||
|| query_views_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of query_views_log data based on size is disabled. ||
|| query_views_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_views_log records will be retained before removal. If set to 0,
automatic removal of query_views_log data based on time is disabled. ||
|| asynchronous_metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable asynchronous_metric_log system table. Default value: false. ||
|| asynchronous_metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_metric_log data based on size is disabled. ||
|| asynchronous_metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_metric_log data based on time is disabled. ||
|| session_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable session_log system table. Default value: false. ||
|| session_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that session_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of session_log data based on size is disabled. ||
|| session_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that session_log records will be retained before removal. If set to 0,
automatic removal of session_log data based on time is disabled. ||
|| zookeeper_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable zookeeper_log system table. Default value: false. ||
|| zookeeper_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of zookeeper_log data based on size is disabled. ||
|| zookeeper_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that zookeeper_log records will be retained before removal. If set to 0,
automatic removal of zookeeper_log data based on time is disabled. ||
|| asynchronous_insert_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable asynchronous_insert_log system table. Default value: false.
Minimal required ClickHouse version: 22.10. ||
|| asynchronous_insert_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_insert_log data based on size is disabled. ||
|| asynchronous_insert_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_insert_log data based on time is disabled. ||
|| processors_profile_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable processors_profile_log system table. ||
|| processors_profile_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that processors_profile_log can grow to before old data will be removed.
If set to 0 (default), automatic removal of processors_profile_log data based on size is disabled. ||
|| processors_profile_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that processors_profile_log records will be retained before removal.
If set to 0, automatic removal of processors_profile_log data based on time is disabled. ||
|| background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_merges_mutations_concurrency_ratio | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility.
Default: 2
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio) ||
|| background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). ||
|| background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| background_common_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background.
Default: 8
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size) ||
|| default_database | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

The default database.

To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](/docs/managed-clickhouse/operations/databases#list-db). ||
|| total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). ||
|| total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| query_masking_rules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.
Change of these settings is applied with ClickHouse restart
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules) ||
|| dictionaries_lazy_load | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Lazy loading of dictionaries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load) ||
|| query_cache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2)**

[Query cache](https://clickhouse.com/docs/en/operations/query-cache) configuration.
Min version: 23.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache) ||
|| jdbc_bridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge2)**

JDBC bridge for queries to external databases.
https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2}

Options specific to the MergeTree table engine.

#|
||Field | Description ||
|| replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of blocks of hashes to keep in ZooKeeper. ||
|| replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Period of time to keep blocks of hashes for. ||
|| parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If table contains at least that many active parts in single partition, artificially slow down insert into table. ||
|| parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If more than this number active parts in single partition, throw 'Too many parts ...' exception. ||
|| inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. ||
|| number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If there is less than specified number of free entries in background pool (or replicated queue), start to lower
maximum size of merge to process. ||
|| max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries
in replication queue). ||
|| max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of bytes in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of rows in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). ||
|| allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_avg_part_size_for_too_many_parts | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.
Default: 1 GiB
Min version: 22.10
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80) ||
|| min_age_to_force_merge_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds.
Default: 0 - disabled
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| min_age_to_force_merge_on_partition_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset.
Default: false
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters.
Default: 5000
Min_version: 21.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms) ||
|| merge_max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of rows that are read from the merged parts into memory.
Default: 8192
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size) ||
|| check_sample_column_is_correct | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned [integer types](https://clickhouse.com/docs/en/sql-reference/data-types/int-uint): UInt8, UInt16, UInt32, UInt64.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct) ||
|| max_merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters.
Default: 60000
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71) ||
|| max_cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum period to clean old queue logs, blocks hashes and parts.
Default: 300
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142) ||
|| deduplicate_merge_projection_mode | enum **DeduplicateMergeProjectionMode**

Determines the behavior of background merges for MergeTree tables with projections.
https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode

- `DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD` ||
|| lightweight_mutation_projection_mode | enum **LightweightMutationProjectionMode**

Determines the behavior of lightweight deletes for MergeTree tables with projections.

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD` ||
|| materialize_ttl_recalculate_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Only recalculate ttl info when MATERIALIZE TTL. ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2}

#|
||Field | Description ||
|| method | enum **Method**

Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).
- `ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/). ||
|| min_part_size | **int64**

Minimum size of a part of a table. ||
|| min_part_size_ratio | **double**

Minimum ratio of a part relative to the size of all the data in the table. ||
|| level | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2)**

Required field. Set of attributes for the external dictionary.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2)**

Required field. Layout for storing the dictionary in memory.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). ||
|| fixed_lifetime | **int64**

Fixed interval between dictionary updates.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| lifetime_range | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range2)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| http_source | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource2)**

HTTP source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| mysql_source | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2)**

MySQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| clickhouse_source | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2)**

ClickHouse source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| mongodb_source | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2)**

MongoDB source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|| postgresql_source | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2)**

PostgreSQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`.

Description of the source for the external dictionary. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id2)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key2)**

Composite key for the dictionary, containing of one or more key columns.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| range_min | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| range_max | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the end of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Description of the fields available for database queries.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id2}

Numeric key.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the numeric key. ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key2}

Complex key.

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Attributes of a complex key. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the column. ||
|| type | **string**

Required field. Type of the column. ||
|| null_value | **string**

Default value for an element without data (for example, an empty string). ||
|| expression | **string**

Expression, describing the attribute, if applicable. ||
|| hierarchical | **bool**

Indication of hierarchy support.
Default value: `false`. ||
|| injective | **bool**

Indication of injective mapping "id -> attribute".
Default value: `false`. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2}

Layout determining how to store the dictionary in memory.

#|
||Field | Description ||
|| type | enum **Type**

Required field. Layout type for an external dictionary.

- `TYPE_UNSPECIFIED`
- `FLAT`: The entire dictionary is stored in memory in the form of flat arrays.
Available for all dictionary sources.
- `HASHED`: The entire dictionary is stored in memory in the form of a hash table.
Available for all dictionary sources.
- `COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys.
Available for all dictionary sources.
- `RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table,
with an ordered array of ranges and their corresponding values.
Available for all dictionary sources.
- `CACHE`: The dictionary is stored in a cache with a set number of cells.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `SPARSE_HASHED`: Similar to HASHED, but uses less memory in favor of more CPU usage.
- `COMPLEX_KEY_SPARSE_HASHED`: Similar to SPARSE_HASHED, to be used with composite keys.
- `COMPLEX_KEY_RANGE_HASHED`: Similar to RANGE_HASHED, to be used with composite keys.
- `DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
- `COMPLEX_KEY_DIRECT`: Similar to DIRECT, to be used with composite keys.
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN. ||
|| size_in_cells | **int64**

Number of cells in the cache. Rounded up to a power of two.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| allow_read_expired_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to read expired keys.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| max_update_queue_size | **int64**

Max size of update queue.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| update_queue_push_timeout_milliseconds | **int64**

Max timeout in milliseconds for push update task into queue.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| query_wait_timeout_milliseconds | **int64**

Max wait timeout in milliseconds for update task to complete.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| max_threads_for_updates | **int64**

Max threads for cache dictionary update.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| initial_array_size | **int64**

Initial dictionary key size.
Applicable only for FLAT layout type. ||
|| max_array_size | **int64**

Maximum dictionary key size.
Applicable only for FLAT layout type. ||
|| access_to_key_from_attributes | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to retrieve key attribute using dictGetString function.
Enabling this option increases memory usage.
Applicable only for IP_TRIE layout type. ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range2}

#|
||Field | Description ||
|| min | **int64**

Minimum dictionary lifetime. ||
|| max | **int64**

Maximum dictionary lifetime. ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource2}

#|
||Field | Description ||
|| url | **string**

Required field. URL of the source dictionary available over HTTP. ||
|| format | **string**

Required field. The data format. Valid values are all formats supported by ClickHouse SQL dialect. ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| value | **string**

Required field.  ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MySQL database to connect to. ||
|| table | **string**

Required field. Name of the database table to use as a ClickHouse dictionary. ||
|| port | **int64**

Default port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Name of the default user for replicas of the dictionary source. ||
|| password | **string**

Password of the default user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| close_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should the connection be closed after each request. ||
|| share_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **int64**

Required field. The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **int64**

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user. ||
|| password | **string**

Password of the MySQL database user. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the ClickHouse database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| host | **string**

ClickHouse host of the specified database. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Use ssl for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MongoDB database. ||
|| collection | **string**

Required field. Name of the collection in the specified database to be used as the dictionary source. ||
|| host | **string**

MongoDB host of the specified database. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the PostrgreSQL database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| hosts[] | **string**

Name of the PostrgreSQL host ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| ssl_mode | enum **SslMode**

Mode of SSL TCP/IP connection to the PostgreSQL host.
For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html).

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2}

Rollup settings for the GraphiteMergeTree table engine.

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2)**

Pattern to use for the rollup. ||
|| path_column_name | **string**

The name of the column storing the metric name (Graphite sensor).
Default: Path
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| time_column_name | **string**

The name of the column storing the time of measuring the metric.
Default: Time
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| value_column_name | **string**

The name of the column storing the value of the metric at the time set in time_column_name.
Default: Value
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| version_column_name | **string**

The name of the column storing the version of the metric.
Default: Timestamp
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2}

#|
||Field | Description ||
|| regexp | **string**

Pattern for metric names. ||
|| function | **string**

Required field. Name of the aggregating function to apply to data of the age specified in `retention`. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2)**

Age of data to use for thinning. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2}

#|
||Field | Description ||
|| age | **int64**

Minimum age of the data in seconds. ||
|| precision | **int64**

Precision of determining the age of the data, in seconds. ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2}

#|
||Field | Description ||
|| security_protocol | enum **SecurityProtocol**

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| sasl_mechanism | enum **SaslMechanism**

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| sasl_username | **string** ||
|| sasl_password | **string** ||
|| enable_ssl_certificate_verification | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| max_poll_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| session_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| debug | enum **Debug**

- `DEBUG_UNSPECIFIED`
- `DEBUG_GENERIC`
- `DEBUG_BROKER`
- `DEBUG_TOPIC`
- `DEBUG_METADATA`
- `DEBUG_FEATURE`
- `DEBUG_QUEUE`
- `DEBUG_MSG`
- `DEBUG_PROTOCOL`
- `DEBUG_CGRP`
- `DEBUG_SECURITY`
- `DEBUG_FETCH`
- `DEBUG_INTERCEPTOR`
- `DEBUG_PLUGIN`
- `DEBUG_CONSUMER`
- `DEBUG_ADMIN`
- `DEBUG_EOS`
- `DEBUG_MOCK`
- `DEBUG_ASSIGNOR`
- `DEBUG_CONF`
- `DEBUG_TELEMETRY`
- `DEBUG_ALL` ||
|| auto_offset_reset | enum **AutoOffsetReset**

- `AUTO_OFFSET_RESET_UNSPECIFIED`
- `AUTO_OFFSET_RESET_SMALLEST`
- `AUTO_OFFSET_RESET_EARLIEST`
- `AUTO_OFFSET_RESET_BEGINNING`
- `AUTO_OFFSET_RESET_LARGEST`
- `AUTO_OFFSET_RESET_LATEST`
- `AUTO_OFFSET_RESET_END`
- `AUTO_OFFSET_RESET_ERROR` ||
|#

## KafkaTopic {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)**

Required field.  ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2}

#|
||Field | Description ||
|| username | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username ||
|| password | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password ||
|| vhost | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression.
Required. ||
|| replace | **string**

Substitution string for sensitive data.
Default: six asterisks ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2}

#|
||Field | Description ||
|| max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum cache size in bytes.
Default: 1073741824 (1 GiB) ||
|| max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of SELECT query results stored in the cache.
Default: 1024 ||
|| max_entry_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size in bytes SELECT query results may have to be saved in the cache.
Dafault: 1048576 (1 MiB) ||
|| max_entry_size_in_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of rows SELECT query results may have to be saved in the cache.
Default: 30000000 (30 mil) ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge2}

JDBC bridge for queries to external databases.

#|
||Field | Description ||
|| host | **string**

Required field. Host of jdbc bridge. ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Port of jdbc bridge. ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources2}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources2)**

Resources allocated to ZooKeeper hosts. ||
|#

## Access {#yandex.cloud.mdb.clickhouse.v1.Access2}

#|
||Field | Description ||
|| data_lens | **bool**

Allow to export data from the cluster to DataLens. ||
|| web_sql | **bool**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. ||
|| metrika | **bool**

Allow to import data from Yandex Metrica and AppMetrica to the cluster.

See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. ||
|| serverless | **bool**

Allow access to cluster for Serverless. ||
|| data_transfer | **bool**

Allow access for DataTransfer ||
|| yandex_query | **bool**

Allow access for Query ||
|#

## CloudStorage {#yandex.cloud.mdb.clickhouse.v1.CloudStorage2}

#|
||Field | Description ||
|| enabled | **bool**

Whether to use Object Storage for storing ClickHouse data. ||
|| move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| prefer_not_to_merge | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow2}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.AnytimeMaintenanceWindow2)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow2)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.AnytimeMaintenanceWindow2}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow2}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#