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
        "background_pool_size": "google.protobuf.Int64Value",
        "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
        "background_schedule_pool_size": "google.protobuf.Int64Value",
        "background_fetches_pool_size": "google.protobuf.Int64Value",
        "background_move_pool_size": "google.protobuf.Int64Value",
        "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
        "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
        "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
        "background_common_pool_size": "google.protobuf.Int64Value",
        "dictionaries_lazy_load": "google.protobuf.BoolValue",
        "log_level": "LogLevel",
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
        "error_log_enabled": "google.protobuf.BoolValue",
        "error_log_retention_size": "google.protobuf.Int64Value",
        "error_log_retention_time": "google.protobuf.Int64Value",
        "access_control_improvements": {
          "select_from_system_db_requires_grant": "google.protobuf.BoolValue",
          "select_from_information_schema_requires_grant": "google.protobuf.BoolValue"
        },
        "max_connections": "google.protobuf.Int64Value",
        "max_concurrent_queries": "google.protobuf.Int64Value",
        "max_table_size_to_drop": "google.protobuf.Int64Value",
        "max_partition_size_to_drop": "google.protobuf.Int64Value",
        "keep_alive_timeout": "google.protobuf.Int64Value",
        "uncompressed_cache_size": "google.protobuf.Int64Value",
        "mark_cache_size": "google.protobuf.Int64Value",
        "timezone": "string",
        "geobase_enabled": "google.protobuf.BoolValue",
        "geobase_uri": "string",
        "default_database": "google.protobuf.StringValue",
        "total_memory_profiler_step": "google.protobuf.Int64Value",
        "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
        "async_insert_threads": "google.protobuf.Int64Value",
        "backup_threads": "google.protobuf.Int64Value",
        "restore_threads": "google.protobuf.Int64Value",
        "merge_tree": {
          "parts_to_delay_insert": "google.protobuf.Int64Value",
          "parts_to_throw_insert": "google.protobuf.Int64Value",
          "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
          "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
          "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
          "max_parts_in_total": "google.protobuf.Int64Value",
          "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
          "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
          "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
          "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
          "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
          "min_bytes_for_wide_part": "google.protobuf.Int64Value",
          "min_rows_for_wide_part": "google.protobuf.Int64Value",
          "cleanup_delay_period": "google.protobuf.Int64Value",
          "max_cleanup_delay_period": "google.protobuf.Int64Value",
          "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
          "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
          "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
          "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
          "merge_max_block_size": "google.protobuf.Int64Value",
          "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
          "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
          "replicated_deduplication_window": "google.protobuf.Int64Value",
          "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
          "fsync_after_insert": "google.protobuf.BoolValue",
          "fsync_part_directory": "google.protobuf.BoolValue",
          "min_compressed_bytes_to_fsync_after_fetch": "google.protobuf.Int64Value",
          "min_compressed_bytes_to_fsync_after_merge": "google.protobuf.Int64Value",
          "min_rows_to_fsync_after_merge": "google.protobuf.Int64Value",
          "ttl_only_drop_parts": "google.protobuf.BoolValue",
          "merge_with_ttl_timeout": "google.protobuf.Int64Value",
          "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
          "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
          "materialize_ttl_recalculate_only": "google.protobuf.BoolValue",
          "check_sample_column_is_correct": "google.protobuf.BoolValue",
          "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue"
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
        "query_masking_rules": [
          {
            "name": "string",
            "regexp": "string",
            "replace": "string"
          }
        ],
        "query_cache": {
          "max_size_in_bytes": "google.protobuf.Int64Value",
          "max_entries": "google.protobuf.Int64Value",
          "max_entry_size_in_bytes": "google.protobuf.Int64Value",
          "max_entry_size_in_rows": "google.protobuf.Int64Value"
        },
        "jdbc_bridge": {
          "host": "string",
          "port": "google.protobuf.Int64Value"
        },
        "mysql_protocol": "google.protobuf.BoolValue",
        "custom_macros": [
          {
            "name": "string",
            "value": "string"
          }
        ],
        "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value"
      },
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      "disk_size_autoscaling": {
        "planned_usage_threshold": "google.protobuf.Int64Value",
        "emergency_usage_threshold": "google.protobuf.Int64Value",
        "disk_size_limit": "google.protobuf.Int64Value"
      }
    },
    "zookeeper": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      "disk_size_autoscaling": {
        "planned_usage_threshold": "google.protobuf.Int64Value",
        "emergency_usage_threshold": "google.protobuf.Int64Value",
        "disk_size_limit": "google.protobuf.Int64Value"
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
      "name": "string",
      "engine": "DatabaseEngine"
    }
  ],
  "user_specs": [
    {
      "name": "string",
      "password": "string",
      "generate_password": "google.protobuf.BoolValue",
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
      ]
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
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "log_level": "LogLevel",
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
            "error_log_enabled": "google.protobuf.BoolValue",
            "error_log_retention_size": "google.protobuf.Int64Value",
            "error_log_retention_time": "google.protobuf.Int64Value",
            "access_control_improvements": {
              "select_from_system_db_requires_grant": "google.protobuf.BoolValue",
              "select_from_information_schema_requires_grant": "google.protobuf.BoolValue"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "async_insert_threads": "google.protobuf.Int64Value",
            "backup_threads": "google.protobuf.Int64Value",
            "restore_threads": "google.protobuf.Int64Value",
            "merge_tree": {
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "fsync_after_insert": "google.protobuf.BoolValue",
              "fsync_part_directory": "google.protobuf.BoolValue",
              "min_compressed_bytes_to_fsync_after_fetch": "google.protobuf.Int64Value",
              "min_compressed_bytes_to_fsync_after_merge": "google.protobuf.Int64Value",
              "min_rows_to_fsync_after_merge": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue"
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
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            },
            "mysql_protocol": "google.protobuf.BoolValue",
            "custom_macros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value"
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "weight": "google.protobuf.Int64Value",
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "shard_group_names": [
        "string"
      ]
    }
  ],
  "disk_encryption_key_id": "google.protobuf.StringValue"
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
|| disk_encryption_key_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the key to encrypt cluster disks. ||
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
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig}

ClickHouse configuration settings. Supported settings are a subset of settings described
in [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings).

#|
||Field | Description ||
|| background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the number of threads performing background merges and mutations for MergeTree-engine tables.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_pool_size). ||
|| background_merges_mutations_concurrency_ratio | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.

For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently.
This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority.

Default value: **2**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio). ||
|| background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for constantly executing some lightweight periodic operations
for replicated tables, Kafka streaming, and DNS cache updates.

Default value: **512**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_schedule_pool_size). ||
|| background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.

Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_fetches_pool_size). ||
|| background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.

Default value: **8**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_move_pool_size). ||
|| background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for executing distributed sends.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_distributed_schedule_pool_size). ||
|| background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_buffer_flush_schedule_pool_size). ||
|| background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for executing background operations for message streaming.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_message_broker_schedule_pool_size). ||
|| background_common_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.

Default value: **8**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_common_pool_size). ||
|| dictionaries_lazy_load | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup.

Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#dictionaries_lazy_load). ||
|| log_level | enum **LogLevel**

Logging level.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_log data based on size is disabled.

Default value: **1073741824** (1 GiB). ||
|| query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query_thread_log system table.

Default value: **true**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_thread_log). ||
|| query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_thread_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_thread_log records will be retained before removal. If set to **0**,
automatic removal of query_thread_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that part_log can grow to before old data will be removed. If set to **0**,
automatic removal of part_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that part_log records will be retained before removal. If set to **0**,
automatic removal of part_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables metric_log system table.

Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/metric_log). ||
|| metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of metric_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that metric_log records will be retained before removal. If set to **0**,
automatic removal of metric_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables trace_log system table.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/trace_log). ||
|| trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that trace_log can grow to before old data will be removed. If set to **0**,
automatic removal of trace_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that trace_log records will be retained before removal. If set to **0**,
automatic removal of trace_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables text_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/text_log). ||
|| text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that text_log can grow to before old data will be removed. If set to **0**,
automatic removal of text_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that text_log records will be retained before removal. If set to **0**,
automatic removal of text_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| text_log_level | enum **LogLevel**

Logging level for text_log system table.

Default value: **TRACE**.

Change of the setting is applied with restart.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables opentelemetry_span_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/opentelemetry_span_log). ||
|| opentelemetry_span_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**,
automatic removal of opentelemetry_span_log data based on size is disabled.

Default value: **0**. ||
|| opentelemetry_span_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**,
automatic removal of opentelemetry_span_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| query_views_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query_views_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_views_log). ||
|| query_views_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_views_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_views_log data based on size is disabled.

Default value: **0**. ||
|| query_views_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_views_log records will be retained before removal. If set to **0**,
automatic removal of query_views_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| asynchronous_metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables asynchronous_metric_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_metric_log). ||
|| asynchronous_metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_metric_log data based on size is disabled.

Default value: **0**. ||
|| asynchronous_metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_metric_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| session_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables session_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log). ||
|| session_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that session_log can grow to before old data will be removed. If set to **0**,
automatic removal of session_log data based on size is disabled.

Default value: **0**. ||
|| session_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that session_log records will be retained before removal. If set to **0**,
automatic removal of session_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| zookeeper_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables zookeeper_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/zookeeper_log). ||
|| zookeeper_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**,
automatic removal of zookeeper_log data based on size is disabled.

Default value: **0**. ||
|| zookeeper_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that zookeeper_log records will be retained before removal. If set to **0**,
automatic removal of zookeeper_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| asynchronous_insert_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables asynchronous_insert_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_insert_log). ||
|| asynchronous_insert_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_insert_log data based on size is disabled.

Default value: **0**. ||
|| asynchronous_insert_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_insert_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| processors_profile_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables processors_profile_log system table.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/processors_profile_log). ||
|| processors_profile_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**,
automatic removal of processors_profile_log data based on size is disabled.

Default value: **0**. ||
|| processors_profile_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that processors_profile_log records will be retained before removal. If set to **0**,
automatic removal of processors_profile_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| error_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables error_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/error_log). ||
|| error_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that error_log can grow to before old data will be removed. If set to **0**,
automatic removal of error_log data based on size is disabled.

Default value: **0**. ||
|| error_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that error_log records will be retained before removal. If set to **0**,
automatic removal of error_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| access_control_improvements | **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements)**

Access control settings. ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections.

Default value: **4096**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_connections). ||
|| max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of concurrently executed queries.

Default value: **500**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_concurrent_queries). ||
|| max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query.

Default value: **50000000000** (48828125 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_table_size_to_drop). ||
|| max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query.

Default value: **50000000000** (48828125 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_partition_size_to_drop). ||
|| keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.

Default value: **30**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#keep_alive_timeout). ||
|| uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#uncompressed_cache_size). ||
|| mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size (in bytes) of the cache of "marks" used by MergeTree tables.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#mark_cache_size). ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.

Default value: **Europe/Moscow**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#timezone). ||
|| geobase_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables geobase.

Change of the setting is applied with restart. ||
|| geobase_uri | **string**

Address of the archive with the user geobase in Object Storage.

Change of the setting is applied with restart. ||
|| default_database | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

The default database.

Default value: **default**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#default_database). ||
|| total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect
the allocating stack trace. **0** means disabled memory profiler.

Default value: **0**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_profiler_step). ||
|| total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table
with trace_type equal to a MemorySample with the specified probability.

Default value: **0**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_tracker_sample_probability). ||
|| async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#async_insert_threads). ||
|| backup_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute **BACKUP** requests.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#backup_threads). ||
|| restore_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute **RESTORE** requests.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#restore_threads). ||
|| merge_tree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree)**

Settings for the MergeTree table engine family.

Change of the settings of **merge_tree** is applied with restart. ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression)**

Data compression settings for MergeTree engine tables.

Change of the settings of **compression** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**

Configuration of external dictionaries.

Change of the settings of **dictionaries** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries). ||
|| graphite_rollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup)**

Rollup settings for the GraphiteMergeTree engine tables.

Change of the settings of **graphite_rollup** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**

Kafka integration settings.

Change of the settings of **kafka** is applied with restart. ||
|| kafka_topics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic)**

Per-topic Kafka integration settings.

Change of the settings of **kafka_topics** is applied with restart. ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq)**

RabbitMQ integration settings.

Change of the settings of **rabbitmq** is applied with restart. ||
|| query_masking_rules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs,
system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing
sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.

Change of the settings of **query_masking_rules** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#query_masking_rules). ||
|| query_cache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache)**

[Query cache](https://clickhouse.com/docs/operations/query-cache) configuration.

Change of the settings of **query_cache** is applied with restart. ||
|| jdbc_bridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge)**

JDBC bridge configuration for queries to external databases.

Change of the settings of **jdbc_bridge** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse). ||
|| mysql_protocol | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables MySQL interface on ClickHouse server

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/interfaces/mysql). ||
|| custom_macros[] | **[Macro](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro)**

Custom ClickHouse macros. ||
|| builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The interval in seconds before reloading built-in dictionaries.

Default value: **3600**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval). ||
|#

## AccessControlImprovements {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements}

Access control settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#access_control_improvements).

#|
||Field | Description ||
|| select_from_system_db_requires_grant | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets whether **SELECT * FROM system.<table>** requires any grants and can be executed by any user.
If set to true then this query requires **GRANT SELECT ON system.<table>** just as for non-system tables.

Default value: **false**. ||
|| select_from_information_schema_requires_grant | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets whether **SELECT * FROM information_schema.<table>** requires any grants and can be executed by any user.
If set to true, then this query requires **GRANT SELECT ON information_schema.<table>**, just as for ordinary tables.

Default value: **false**. ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree}

Settings for the MergeTree table engine family.

#|
||Field | Description ||
|| parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down.

Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_delay_insert). ||
|| parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT**
is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts".

Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_throw_insert). ||
|| inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value,
an **INSERT** is artificially slowed down.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_delay_insert). ||
|| inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value,
**INSERT** is interrupted with an error.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_throw_insert). ||
|| max_avg_part_size_for_too_many_parts | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average
part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold,
**INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server
if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_avg_part_size_for_too_many_parts). ||
|| max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value,
an **INSERT** is interrupted with the error "Too many parts (N)".

Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_parts_in_total). ||
|| max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.

Default value: **16**. ||
|| number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of
merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges.

Default value: **8**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_lower_max_size_of_merge). ||
|| number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When there is less than specified number of free entries in pool, do not execute part mutations.
This is to leave free threads for regular merges and to avoid "Too many parts" errors.

Default value: **20**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_mutation). ||
|| max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool.

Default value: **1048576** (1 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_min_space_in_pool). ||
|| max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available.
Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled.

Default value: **161061273600** (150 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_max_space_in_pool). ||
|| min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of bytes in a data part that can be stored in Wide format.

Default value: **10485760** (10 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_bytes_for_wide_part). ||
|| min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of rows in a data part that can be stored in Wide format.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_for_wide_part). ||
|| cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum period to clean old queue logs, blocks hashes and parts.

Default value: **30**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#cleanup_delay_period). ||
|| max_cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum period to clean old queue logs, blocks hashes and parts.

Default value: **300** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_cleanup_delay_period). ||
|| merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

Default value: **5000** (5 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_selecting_sleep_ms). ||
|| max_merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_merge_selecting_sleep_ms). ||
|| min_age_to_force_merge_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Merge parts if every part in the range is older than the specified value. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds). ||
|| min_age_to_force_merge_on_partition_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only). ||
|| merge_max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of rows that are read from the merged parts into memory.

Default value: **8192**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_max_block_size). ||
|| deduplicate_merge_projection_mode | enum **DeduplicateMergeProjectionMode**

Determines the behavior of background merges for MergeTree tables with projections.

Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).

- `DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD` ||
|| lightweight_mutation_projection_mode | enum **LightweightMutationProjectionMode**

Determines the behavior of lightweight deletes for MergeTree tables with projections.

Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD` ||
|| replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.

Default value: **1000** for versions 23.11 and higher, **100** for versions 23.10 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window). ||
|| replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.

Default value: **604800** (7 days).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds). ||
|| fsync_after_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_after_insert). ||
|| fsync_part_directory | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Do fsync for part directory after all part operations (writes, renames, etc.).

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_part_directory). ||
|| min_compressed_bytes_to_fsync_after_fetch | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_fetch). ||
|| min_compressed_bytes_to_fsync_after_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_merge). ||
|| min_rows_to_fsync_after_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal number of rows to do fsync for part after merge. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_to_fsync_after_merge). ||
|| ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings.
* **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings.
* **false** - only the rows that have expired based on their **TTL** settings are removed.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#ttl_only_drop_parts). ||
|| merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum delay in seconds before repeating a merge with delete TTL.

Default value: **14400** (4 hours).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_ttl_timeout). ||
|| merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum delay in seconds before repeating a merge with recompression TTL.

Default value: **14400** (4 hours).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout). ||
|| max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
This is to leave free threads for regular merges and avoid "Too many parts" errors.

Default value: **2**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_number_of_merges_with_ttl_in_pool). ||
|| materialize_ttl_recalculate_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Only recalculate ttl info when **MATERIALIZE TTL**.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only). ||
|| check_sample_column_is_correct | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct.
The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#check_sample_column_is_correct). ||
|| allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting is automatically enabled if cloud storage is enabled, disabled otherwise.

Default value: **true**. ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression}

Compression settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression).

#|
||Field | Description ||
|| method | enum **Method**

Required field. Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4).
- `ZSTD`: [ZSTD compression algorithm](https://facebook.github.io/zstd).
- `LZ4HC`: [LZ4 HC (high compression) algorithm](https://clickhouse.com/docs/sql-reference/statements/create/table#lz4hc). ||
|| min_part_size | **int64**

The minimum size of a data part. ||
|| min_part_size_ratio | **double**

The ratio of the data part size to the table size. ||
|| level | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Compression level. ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

External dictionary configuration.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**

Required field. Structure of the external dictionary. ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**

Required field. Layout determining how to store the dictionary in memory.

For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory. ||
|| fixed_lifetime | **int64**

Fixed interval between dictionary updates.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`. ||
|| lifetime_range | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`. ||
|| http_source | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

HTTP source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| mysql_source | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

MySQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| clickhouse_source | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

ClickHouse source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| mongodb_source | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

MongoDB source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| postgresql_source | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

PostgreSQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

Configuration of external dictionary structure.

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**

Composite key for the dictionary, containing of one or more key columns.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| range_min | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| range_max | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.

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

Default value: **false**. ||
|| injective | **bool**

Indication of injective mapping "id -> attribute".

Default value: **false**. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

#|
||Field | Description ||
|| type | enum **Type**

Required field. Layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory).

- `TYPE_UNSPECIFIED`
- `FLAT`: The dictionary is completely stored in memory in the form of flat arrays.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable for dictionaries with composite keys of arbitrary type.
- `RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable for dictionaries with composite keys of arbitrary type.
- `SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to HASHED layout type but uses less memory in favor of more CPU usage.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to COMPLEX_KEY_HASHED layout type but uses less memory in favor of more CPU usage.
Applicable for dictionaries with composite keys of arbitrary type.
- `COMPLEX_KEY_RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable for dictionaries with composite keys of arbitrary type.
- `DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable for dictionaries with composite keys of arbitrary type.
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN. ||
|| size_in_cells | **int64**

Number of cells in the cache. Rounded up to a power of two.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **1000000000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| allow_read_expired_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to read expired keys.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| max_update_queue_size | **int64**

Max size of update queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **100000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| update_queue_push_timeout_milliseconds | **int64**

Max timeout in milliseconds for push update task into queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **10**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| query_wait_timeout_milliseconds | **int64**

Max wait timeout in milliseconds for update task to complete.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| max_threads_for_updates | **int64**

Max threads for cache dictionary update.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **4**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| initial_array_size | **int64**

Initial dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **1024**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| max_array_size | **int64**

Maximum dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **500000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| access_to_key_from_attributes | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to retrieve key attribute using **dictGetString** function.
Enabling this option increases memory usage.
Applicable only for **IP_TRIE** layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ip_trie). ||
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

Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/). ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string**

Required field. Header name. ||
|| value | **string**

Required field. Header value. ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| port | **int64**

Port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Required field. Name of the user for replicas of the dictionary source. ||
|| password | **string**

Password of the user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| close_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be closed after each request. ||
|| share_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **int64**

The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **int64**

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user.
If a user is not specified for a replica, ClickHouse uses the user specified for the source. ||
|| password | **string**

Password of the MySQL database user.
If a password is not specified for a replica, ClickHouse uses the password specified for the source. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| host | **string**

ClickHouse host. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use TLS for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| collection | **string**

Required field. Collection name. ||
|| host | **string**

Required field. MongoDB host. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string**

Dictionary source options. ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| hosts[] | **string**

PostgreSQL hosts. ||
|| port | **int64**

Port to use when connecting to the PostgreSQL hosts. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| ssl_mode | enum **SslMode**

Mode of SSL TCP/IP connection to the PostgreSQL host.

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup}

Rollup settings for the GraphiteMergeTree table engine.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite-rollup).

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern)**

Pattern to use for the rollup. ||
|| path_column_name | **string**

The name of the column storing the metric name (Graphite sensor).

Default value: **Path**. ||
|| time_column_name | **string**

The name of the column storing the time of measuring the metric.

Default value: **Time**. ||
|| value_column_name | **string**

The name of the column storing the value of the metric at the time set in **time_column_name**.

Default value: **Value**. ||
|| version_column_name | **string**

The name of the column storing the version of the metric.

Default value: **Timestamp**. ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern}

#|
||Field | Description ||
|| regexp | **string**

A pattern for the metric name (a regular or DSL). ||
|| function | **string**

The name of the aggregating function to apply to data whose age falls within the range [age, age + precision].
Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention)**

Retention rules. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention}

#|
||Field | Description ||
|| age | **int64**

The minimum age of the data in seconds. ||
|| precision | **int64**

Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day). ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka}

Kafka configuration settings.
For details, see [librdkafka documentation](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).

#|
||Field | Description ||
|| security_protocol | enum **SecurityProtocol**

Protocol used to communicate with brokers.

Default value: **SECURITY_PROTOCOL_PLAINTEXT**.

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| sasl_mechanism | enum **SaslMechanism**

SASL mechanism to use for authentication.

Default value: **SASL_MECHANISM_GSSAPI**.

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| sasl_username | **string**

SASL username for use with the PLAIN and SASL-SCRAM mechanisms. ||
|| sasl_password | **string**

SASL password for use with the PLAIN and SASL-SCRAM mechanisms. ||
|| enable_ssl_certificate_verification | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable OpenSSL's builtin broker (server) certificate verification.

Default value: **true**. ||
|| max_poll_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum allowed time between calls to consume messages for high-level consumers.
If this interval is exceeded the consumer is considered failed and the group will
rebalance in order to reassign the partitions to another consumer group member.

Default value: **300000** (5 minutes). ||
|| session_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
the session timeout, the broker will remove the consumer from the group and trigger a rebalance.

Default value: **45000** (45 seconds). ||
|| debug | enum **Debug**

Debug context to enable.

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

Action to take when there is no initial offset in offset store or the desired offset is out of range.

Default value: **AUTO_OFFSET_RESET_LARGEST**.

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

Required field. Kafka topic name. ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**

Required field. Kafka topic settings. ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq}

RabbitMQ integration settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/table-engines/integrations/rabbitmq).

#|
||Field | Description ||
|| username | **string**

RabbitMQ username. ||
|| password | **string**

RabbitMQ password. ||
|| vhost | **string**

RabbitMQ virtual host. ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression. ||
|| replace | **string**

Substitution string for sensitive data.

Default value: six asterisks. ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache}

Query cache configuration.

#|
||Field | Description ||
|| max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum cache size in bytes.

Default value: **1073741824** (1 GiB). ||
|| max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of **SELECT** query results stored in the cache.

Default value: **1024**. ||
|| max_entry_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size in bytes **SELECT** query results may have to be saved in the cache.

Default value: **1048576** (1 MiB). ||
|| max_entry_size_in_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of rows **SELECT** query results may have to be saved in the cache.

Default value: **30000000**. ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge}

JDBC bridge configuration for queries to external databases.

#|
||Field | Description ||
|| host | **string**

Required field. Host of jdbc bridge. ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Port of jdbc bridge.

Default value: **9019**. ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro}

ClickHouse macro.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the macro. ||
|| value | **string**

Required field. Value of the macro. ||
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

## DiskSizeAutoscaling {#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used.
All available resource presets can be retrieved with a [ResourcePresetService.List](/docs/managed-clickhouse/api-ref/grpc/ResourcePreset/list#List) request. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings. ||
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
|| engine | enum **DatabaseEngine**

Database engine. For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/database-engines).

- `DATABASE_ENGINE_UNSPECIFIED`
- `DATABASE_ENGINE_ATOMIC`
- `DATABASE_ENGINE_REPLICATED` ||
|#

## UserSpec {#yandex.cloud.mdb.clickhouse.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. User name. ||
|| password | **string**

User password. ||
|| generate_password | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable or disable password generation using Connection Manager.

Default value: **false**. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission)**

Set of permissions to grant to the user. If not set, it's granted permissions to access all databases. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings)**

User settings ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota)**

Quotas assigned to the user. ||
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
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings. ||
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
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "log_level": "LogLevel",
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
            "error_log_enabled": "google.protobuf.BoolValue",
            "error_log_retention_size": "google.protobuf.Int64Value",
            "error_log_retention_time": "google.protobuf.Int64Value",
            "access_control_improvements": {
              "select_from_system_db_requires_grant": "google.protobuf.BoolValue",
              "select_from_information_schema_requires_grant": "google.protobuf.BoolValue"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "async_insert_threads": "google.protobuf.Int64Value",
            "backup_threads": "google.protobuf.Int64Value",
            "restore_threads": "google.protobuf.Int64Value",
            "merge_tree": {
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "fsync_after_insert": "google.protobuf.BoolValue",
              "fsync_part_directory": "google.protobuf.BoolValue",
              "min_compressed_bytes_to_fsync_after_fetch": "google.protobuf.Int64Value",
              "min_compressed_bytes_to_fsync_after_merge": "google.protobuf.Int64Value",
              "min_rows_to_fsync_after_merge": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue"
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
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            },
            "mysql_protocol": "google.protobuf.BoolValue",
            "custom_macros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value"
          },
          "user_config": {
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "log_level": "LogLevel",
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
            "error_log_enabled": "google.protobuf.BoolValue",
            "error_log_retention_size": "google.protobuf.Int64Value",
            "error_log_retention_time": "google.protobuf.Int64Value",
            "access_control_improvements": {
              "select_from_system_db_requires_grant": "google.protobuf.BoolValue",
              "select_from_information_schema_requires_grant": "google.protobuf.BoolValue"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "async_insert_threads": "google.protobuf.Int64Value",
            "backup_threads": "google.protobuf.Int64Value",
            "restore_threads": "google.protobuf.Int64Value",
            "merge_tree": {
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "fsync_after_insert": "google.protobuf.BoolValue",
              "fsync_part_directory": "google.protobuf.BoolValue",
              "min_compressed_bytes_to_fsync_after_fetch": "google.protobuf.Int64Value",
              "min_compressed_bytes_to_fsync_after_merge": "google.protobuf.Int64Value",
              "min_rows_to_fsync_after_merge": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue"
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
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            },
            "mysql_protocol": "google.protobuf.BoolValue",
            "custom_macros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value"
          },
          "default_config": {
            "background_pool_size": "google.protobuf.Int64Value",
            "background_merges_mutations_concurrency_ratio": "google.protobuf.Int64Value",
            "background_schedule_pool_size": "google.protobuf.Int64Value",
            "background_fetches_pool_size": "google.protobuf.Int64Value",
            "background_move_pool_size": "google.protobuf.Int64Value",
            "background_distributed_schedule_pool_size": "google.protobuf.Int64Value",
            "background_buffer_flush_schedule_pool_size": "google.protobuf.Int64Value",
            "background_message_broker_schedule_pool_size": "google.protobuf.Int64Value",
            "background_common_pool_size": "google.protobuf.Int64Value",
            "dictionaries_lazy_load": "google.protobuf.BoolValue",
            "log_level": "LogLevel",
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
            "error_log_enabled": "google.protobuf.BoolValue",
            "error_log_retention_size": "google.protobuf.Int64Value",
            "error_log_retention_time": "google.protobuf.Int64Value",
            "access_control_improvements": {
              "select_from_system_db_requires_grant": "google.protobuf.BoolValue",
              "select_from_information_schema_requires_grant": "google.protobuf.BoolValue"
            },
            "max_connections": "google.protobuf.Int64Value",
            "max_concurrent_queries": "google.protobuf.Int64Value",
            "max_table_size_to_drop": "google.protobuf.Int64Value",
            "max_partition_size_to_drop": "google.protobuf.Int64Value",
            "keep_alive_timeout": "google.protobuf.Int64Value",
            "uncompressed_cache_size": "google.protobuf.Int64Value",
            "mark_cache_size": "google.protobuf.Int64Value",
            "timezone": "string",
            "geobase_enabled": "google.protobuf.BoolValue",
            "geobase_uri": "string",
            "default_database": "google.protobuf.StringValue",
            "total_memory_profiler_step": "google.protobuf.Int64Value",
            "total_memory_tracker_sample_probability": "google.protobuf.DoubleValue",
            "async_insert_threads": "google.protobuf.Int64Value",
            "backup_threads": "google.protobuf.Int64Value",
            "restore_threads": "google.protobuf.Int64Value",
            "merge_tree": {
              "parts_to_delay_insert": "google.protobuf.Int64Value",
              "parts_to_throw_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_delay_insert": "google.protobuf.Int64Value",
              "inactive_parts_to_throw_insert": "google.protobuf.Int64Value",
              "max_avg_part_size_for_too_many_parts": "google.protobuf.Int64Value",
              "max_parts_in_total": "google.protobuf.Int64Value",
              "max_replicated_merges_in_queue": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_lower_max_size_of_merge": "google.protobuf.Int64Value",
              "number_of_free_entries_in_pool_to_execute_mutation": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_min_space_in_pool": "google.protobuf.Int64Value",
              "max_bytes_to_merge_at_max_space_in_pool": "google.protobuf.Int64Value",
              "min_bytes_for_wide_part": "google.protobuf.Int64Value",
              "min_rows_for_wide_part": "google.protobuf.Int64Value",
              "cleanup_delay_period": "google.protobuf.Int64Value",
              "max_cleanup_delay_period": "google.protobuf.Int64Value",
              "merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "max_merge_selecting_sleep_ms": "google.protobuf.Int64Value",
              "min_age_to_force_merge_seconds": "google.protobuf.Int64Value",
              "min_age_to_force_merge_on_partition_only": "google.protobuf.BoolValue",
              "merge_max_block_size": "google.protobuf.Int64Value",
              "deduplicate_merge_projection_mode": "DeduplicateMergeProjectionMode",
              "lightweight_mutation_projection_mode": "LightweightMutationProjectionMode",
              "replicated_deduplication_window": "google.protobuf.Int64Value",
              "replicated_deduplication_window_seconds": "google.protobuf.Int64Value",
              "fsync_after_insert": "google.protobuf.BoolValue",
              "fsync_part_directory": "google.protobuf.BoolValue",
              "min_compressed_bytes_to_fsync_after_fetch": "google.protobuf.Int64Value",
              "min_compressed_bytes_to_fsync_after_merge": "google.protobuf.Int64Value",
              "min_rows_to_fsync_after_merge": "google.protobuf.Int64Value",
              "ttl_only_drop_parts": "google.protobuf.BoolValue",
              "merge_with_ttl_timeout": "google.protobuf.Int64Value",
              "merge_with_recompression_ttl_timeout": "google.protobuf.Int64Value",
              "max_number_of_merges_with_ttl_in_pool": "google.protobuf.Int64Value",
              "materialize_ttl_recalculate_only": "google.protobuf.BoolValue",
              "check_sample_column_is_correct": "google.protobuf.BoolValue",
              "allow_remote_fs_zero_copy_replication": "google.protobuf.BoolValue"
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
            "query_masking_rules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "query_cache": {
              "max_size_in_bytes": "google.protobuf.Int64Value",
              "max_entries": "google.protobuf.Int64Value",
              "max_entry_size_in_bytes": "google.protobuf.Int64Value",
              "max_entry_size_in_rows": "google.protobuf.Int64Value"
            },
            "jdbc_bridge": {
              "host": "string",
              "port": "google.protobuf.Int64Value"
            },
            "mysql_protocol": "google.protobuf.BoolValue",
            "custom_macros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtin_dictionaries_reload_interval": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "zookeeper": {
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
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
    "deletion_protection": "bool",
    "disk_encryption_key_id": "google.protobuf.StringValue"
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
|| disk_encryption_key_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the key to encrypt cluster disks. ||
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
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings. ||
|#

## ClickhouseConfigSet {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet}

#|
||Field | Description ||
|| effective_config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. Effective configuration (a combination of user-defined configuration and default configuration). ||
|| user_config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. User-defined configuration. ||
|| default_config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. Default configuration. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2}

ClickHouse configuration settings. Supported settings are a subset of settings described
in [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings).

#|
||Field | Description ||
|| background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the number of threads performing background merges and mutations for MergeTree-engine tables.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_pool_size). ||
|| background_merges_mutations_concurrency_ratio | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.

For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently.
This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority.

Default value: **2**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio). ||
|| background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for constantly executing some lightweight periodic operations
for replicated tables, Kafka streaming, and DNS cache updates.

Default value: **512**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_schedule_pool_size). ||
|| background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.

Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_fetches_pool_size). ||
|| background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.

Default value: **8**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_move_pool_size). ||
|| background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for executing distributed sends.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_distributed_schedule_pool_size). ||
|| background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_buffer_flush_schedule_pool_size). ||
|| background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for executing background operations for message streaming.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_message_broker_schedule_pool_size). ||
|| background_common_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.

Default value: **8**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_common_pool_size). ||
|| dictionaries_lazy_load | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup.

Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#dictionaries_lazy_load). ||
|| log_level | enum **LogLevel**

Logging level.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_log data based on size is disabled.

Default value: **1073741824** (1 GiB). ||
|| query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query_thread_log system table.

Default value: **true**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_thread_log). ||
|| query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_thread_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_thread_log records will be retained before removal. If set to **0**,
automatic removal of query_thread_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that part_log can grow to before old data will be removed. If set to **0**,
automatic removal of part_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that part_log records will be retained before removal. If set to **0**,
automatic removal of part_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables metric_log system table.

Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/metric_log). ||
|| metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of metric_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that metric_log records will be retained before removal. If set to **0**,
automatic removal of metric_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables trace_log system table.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/trace_log). ||
|| trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that trace_log can grow to before old data will be removed. If set to **0**,
automatic removal of trace_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that trace_log records will be retained before removal. If set to **0**,
automatic removal of trace_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables text_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/text_log). ||
|| text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that text_log can grow to before old data will be removed. If set to **0**,
automatic removal of text_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that text_log records will be retained before removal. If set to **0**,
automatic removal of text_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| text_log_level | enum **LogLevel**

Logging level for text_log system table.

Default value: **TRACE**.

Change of the setting is applied with restart.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables opentelemetry_span_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/opentelemetry_span_log). ||
|| opentelemetry_span_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**,
automatic removal of opentelemetry_span_log data based on size is disabled.

Default value: **0**. ||
|| opentelemetry_span_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**,
automatic removal of opentelemetry_span_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| query_views_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables query_views_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_views_log). ||
|| query_views_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that query_views_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_views_log data based on size is disabled.

Default value: **0**. ||
|| query_views_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that query_views_log records will be retained before removal. If set to **0**,
automatic removal of query_views_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| asynchronous_metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables asynchronous_metric_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_metric_log). ||
|| asynchronous_metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_metric_log data based on size is disabled.

Default value: **0**. ||
|| asynchronous_metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_metric_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| session_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables session_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log). ||
|| session_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that session_log can grow to before old data will be removed. If set to **0**,
automatic removal of session_log data based on size is disabled.

Default value: **0**. ||
|| session_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that session_log records will be retained before removal. If set to **0**,
automatic removal of session_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| zookeeper_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables zookeeper_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/zookeeper_log). ||
|| zookeeper_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**,
automatic removal of zookeeper_log data based on size is disabled.

Default value: **0**. ||
|| zookeeper_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that zookeeper_log records will be retained before removal. If set to **0**,
automatic removal of zookeeper_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| asynchronous_insert_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables asynchronous_insert_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_insert_log). ||
|| asynchronous_insert_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_insert_log data based on size is disabled.

Default value: **0**. ||
|| asynchronous_insert_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_insert_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| processors_profile_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables processors_profile_log system table.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/processors_profile_log). ||
|| processors_profile_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**,
automatic removal of processors_profile_log data based on size is disabled.

Default value: **0**. ||
|| processors_profile_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that processors_profile_log records will be retained before removal. If set to **0**,
automatic removal of processors_profile_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| error_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables error_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/error_log). ||
|| error_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size that error_log can grow to before old data will be removed. If set to **0**,
automatic removal of error_log data based on size is disabled.

Default value: **0**. ||
|| error_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time that error_log records will be retained before removal. If set to **0**,
automatic removal of error_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| access_control_improvements | **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements2)**

Access control settings. ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections.

Default value: **4096**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_connections). ||
|| max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of concurrently executed queries.

Default value: **500**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_concurrent_queries). ||
|| max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query.

Default value: **50000000000** (48828125 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_table_size_to_drop). ||
|| max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query.

Default value: **50000000000** (48828125 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_partition_size_to_drop). ||
|| keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.

Default value: **30**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#keep_alive_timeout). ||
|| uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#uncompressed_cache_size). ||
|| mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size (in bytes) of the cache of "marks" used by MergeTree tables.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#mark_cache_size). ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.

Default value: **Europe/Moscow**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#timezone). ||
|| geobase_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables geobase.

Change of the setting is applied with restart. ||
|| geobase_uri | **string**

Address of the archive with the user geobase in Object Storage.

Change of the setting is applied with restart. ||
|| default_database | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

The default database.

Default value: **default**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#default_database). ||
|| total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect
the allocating stack trace. **0** means disabled memory profiler.

Default value: **0**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_profiler_step). ||
|| total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table
with trace_type equal to a MemorySample with the specified probability.

Default value: **0**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_tracker_sample_probability). ||
|| async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#async_insert_threads). ||
|| backup_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute **BACKUP** requests.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#backup_threads). ||
|| restore_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of threads to execute **RESTORE** requests.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#restore_threads). ||
|| merge_tree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2)**

Settings for the MergeTree table engine family.

Change of the settings of **merge_tree** is applied with restart. ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2)**

Data compression settings for MergeTree engine tables.

Change of the settings of **compression** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2)**

Configuration of external dictionaries.

Change of the settings of **dictionaries** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries). ||
|| graphite_rollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2)**

Rollup settings for the GraphiteMergeTree engine tables.

Change of the settings of **graphite_rollup** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)**

Kafka integration settings.

Change of the settings of **kafka** is applied with restart. ||
|| kafka_topics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2)**

Per-topic Kafka integration settings.

Change of the settings of **kafka_topics** is applied with restart. ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2)**

RabbitMQ integration settings.

Change of the settings of **rabbitmq** is applied with restart. ||
|| query_masking_rules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs,
system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing
sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.

Change of the settings of **query_masking_rules** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#query_masking_rules). ||
|| query_cache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2)**

[Query cache](https://clickhouse.com/docs/operations/query-cache) configuration.

Change of the settings of **query_cache** is applied with restart. ||
|| jdbc_bridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge2)**

JDBC bridge configuration for queries to external databases.

Change of the settings of **jdbc_bridge** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse). ||
|| mysql_protocol | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables MySQL interface on ClickHouse server

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/interfaces/mysql). ||
|| custom_macros[] | **[Macro](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro2)**

Custom ClickHouse macros. ||
|| builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The interval in seconds before reloading built-in dictionaries.

Default value: **3600**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval). ||
|#

## AccessControlImprovements {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements2}

Access control settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#access_control_improvements).

#|
||Field | Description ||
|| select_from_system_db_requires_grant | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets whether **SELECT * FROM system.<table>** requires any grants and can be executed by any user.
If set to true then this query requires **GRANT SELECT ON system.<table>** just as for non-system tables.

Default value: **false**. ||
|| select_from_information_schema_requires_grant | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Sets whether **SELECT * FROM information_schema.<table>** requires any grants and can be executed by any user.
If set to true, then this query requires **GRANT SELECT ON information_schema.<table>**, just as for ordinary tables.

Default value: **false**. ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2}

Settings for the MergeTree table engine family.

#|
||Field | Description ||
|| parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down.

Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_delay_insert). ||
|| parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT**
is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts".

Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_throw_insert). ||
|| inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value,
an **INSERT** is artificially slowed down.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_delay_insert). ||
|| inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value,
**INSERT** is interrupted with an error.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_throw_insert). ||
|| max_avg_part_size_for_too_many_parts | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average
part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold,
**INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server
if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_avg_part_size_for_too_many_parts). ||
|| max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value,
an **INSERT** is interrupted with the error "Too many parts (N)".

Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_parts_in_total). ||
|| max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.

Default value: **16**. ||
|| number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of
merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges.

Default value: **8**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_lower_max_size_of_merge). ||
|| number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When there is less than specified number of free entries in pool, do not execute part mutations.
This is to leave free threads for regular merges and to avoid "Too many parts" errors.

Default value: **20**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_mutation). ||
|| max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool.

Default value: **1048576** (1 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_min_space_in_pool). ||
|| max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available.
Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled.

Default value: **161061273600** (150 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_max_space_in_pool). ||
|| min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of bytes in a data part that can be stored in Wide format.

Default value: **10485760** (10 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_bytes_for_wide_part). ||
|| min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of rows in a data part that can be stored in Wide format.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_for_wide_part). ||
|| cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum period to clean old queue logs, blocks hashes and parts.

Default value: **30**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#cleanup_delay_period). ||
|| max_cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum period to clean old queue logs, blocks hashes and parts.

Default value: **300** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_cleanup_delay_period). ||
|| merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

Default value: **5000** (5 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_selecting_sleep_ms). ||
|| max_merge_selecting_sleep_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_merge_selecting_sleep_ms). ||
|| min_age_to_force_merge_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Merge parts if every part in the range is older than the specified value. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds). ||
|| min_age_to_force_merge_on_partition_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only). ||
|| merge_max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of rows that are read from the merged parts into memory.

Default value: **8192**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_max_block_size). ||
|| deduplicate_merge_projection_mode | enum **DeduplicateMergeProjectionMode**

Determines the behavior of background merges for MergeTree tables with projections.

Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).

- `DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD` ||
|| lightweight_mutation_projection_mode | enum **LightweightMutationProjectionMode**

Determines the behavior of lightweight deletes for MergeTree tables with projections.

Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD` ||
|| replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.

Default value: **1000** for versions 23.11 and higher, **100** for versions 23.10 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window). ||
|| replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.

Default value: **604800** (7 days).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds). ||
|| fsync_after_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_after_insert). ||
|| fsync_part_directory | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Do fsync for part directory after all part operations (writes, renames, etc.).

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_part_directory). ||
|| min_compressed_bytes_to_fsync_after_fetch | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_fetch). ||
|| min_compressed_bytes_to_fsync_after_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_merge). ||
|| min_rows_to_fsync_after_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal number of rows to do fsync for part after merge. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_to_fsync_after_merge). ||
|| ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings.
* **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings.
* **false** - only the rows that have expired based on their **TTL** settings are removed.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#ttl_only_drop_parts). ||
|| merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum delay in seconds before repeating a merge with delete TTL.

Default value: **14400** (4 hours).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_ttl_timeout). ||
|| merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum delay in seconds before repeating a merge with recompression TTL.

Default value: **14400** (4 hours).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout). ||
|| max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
This is to leave free threads for regular merges and avoid "Too many parts" errors.

Default value: **2**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_number_of_merges_with_ttl_in_pool). ||
|| materialize_ttl_recalculate_only | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Only recalculate ttl info when **MATERIALIZE TTL**.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only). ||
|| check_sample_column_is_correct | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct.
The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#check_sample_column_is_correct). ||
|| allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting is automatically enabled if cloud storage is enabled, disabled otherwise.

Default value: **true**. ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2}

Compression settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression).

#|
||Field | Description ||
|| method | enum **Method**

Required field. Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4).
- `ZSTD`: [ZSTD compression algorithm](https://facebook.github.io/zstd).
- `LZ4HC`: [LZ4 HC (high compression) algorithm](https://clickhouse.com/docs/sql-reference/statements/create/table#lz4hc). ||
|| min_part_size | **int64**

The minimum size of a data part. ||
|| min_part_size_ratio | **double**

The ratio of the data part size to the table size. ||
|| level | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Compression level. ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2}

External dictionary configuration.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2)**

Required field. Structure of the external dictionary. ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2)**

Required field. Layout determining how to store the dictionary in memory.

For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory. ||
|| fixed_lifetime | **int64**

Fixed interval between dictionary updates.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`. ||
|| lifetime_range | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range2)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixed_lifetime`, `lifetime_range`. ||
|| http_source | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource2)**

HTTP source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| mysql_source | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2)**

MySQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| clickhouse_source | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2)**

ClickHouse source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| mongodb_source | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2)**

MongoDB source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|| postgresql_source | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2)**

PostgreSQL source for the dictionary.

Includes only one of the fields `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source`, `postgresql_source`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2}

Configuration of external dictionary structure.

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id2)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key2)**

Composite key for the dictionary, containing of one or more key columns.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| range_min | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| range_max | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.

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

Default value: **false**. ||
|| injective | **bool**

Indication of injective mapping "id -> attribute".

Default value: **false**. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2}

#|
||Field | Description ||
|| type | enum **Type**

Required field. Layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory).

- `TYPE_UNSPECIFIED`
- `FLAT`: The dictionary is completely stored in memory in the form of flat arrays.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable for dictionaries with composite keys of arbitrary type.
- `RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable for dictionaries with composite keys of arbitrary type.
- `SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to HASHED layout type but uses less memory in favor of more CPU usage.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to COMPLEX_KEY_HASHED layout type but uses less memory in favor of more CPU usage.
Applicable for dictionaries with composite keys of arbitrary type.
- `COMPLEX_KEY_RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable for dictionaries with composite keys of arbitrary type.
- `DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable for dictionaries with composite keys of arbitrary type.
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN. ||
|| size_in_cells | **int64**

Number of cells in the cache. Rounded up to a power of two.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **1000000000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| allow_read_expired_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to read expired keys.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| max_update_queue_size | **int64**

Max size of update queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **100000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| update_queue_push_timeout_milliseconds | **int64**

Max timeout in milliseconds for push update task into queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **10**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| query_wait_timeout_milliseconds | **int64**

Max wait timeout in milliseconds for update task to complete.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| max_threads_for_updates | **int64**

Max threads for cache dictionary update.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **4**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| initial_array_size | **int64**

Initial dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **1024**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| max_array_size | **int64**

Maximum dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **500000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| access_to_key_from_attributes | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to retrieve key attribute using **dictGetString** function.
Enabling this option increases memory usage.
Applicable only for **IP_TRIE** layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ip_trie). ||
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

Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/). ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2}

#|
||Field | Description ||
|| name | **string**

Required field. Header name. ||
|| value | **string**

Required field. Header value. ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| port | **int64**

Port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Required field. Name of the user for replicas of the dictionary source. ||
|| password | **string**

Password of the user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| close_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be closed after each request. ||
|| share_connection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **int64**

The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **int64**

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user.
If a user is not specified for a replica, ClickHouse uses the user specified for the source. ||
|| password | **string**

Password of the MySQL database user.
If a password is not specified for a replica, ClickHouse uses the password specified for the source. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| host | **string**

ClickHouse host. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether to use TLS for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| collection | **string**

Required field. Collection name. ||
|| host | **string**

Required field. MongoDB host. ||
|| port | **int64**

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string**

Dictionary source options. ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| hosts[] | **string**

PostgreSQL hosts. ||
|| port | **int64**

Port to use when connecting to the PostgreSQL hosts. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidate_query | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| ssl_mode | enum **SslMode**

Mode of SSL TCP/IP connection to the PostgreSQL host.

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2}

Rollup settings for the GraphiteMergeTree table engine.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite-rollup).

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2)**

Pattern to use for the rollup. ||
|| path_column_name | **string**

The name of the column storing the metric name (Graphite sensor).

Default value: **Path**. ||
|| time_column_name | **string**

The name of the column storing the time of measuring the metric.

Default value: **Time**. ||
|| value_column_name | **string**

The name of the column storing the value of the metric at the time set in **time_column_name**.

Default value: **Value**. ||
|| version_column_name | **string**

The name of the column storing the version of the metric.

Default value: **Timestamp**. ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2}

#|
||Field | Description ||
|| regexp | **string**

A pattern for the metric name (a regular or DSL). ||
|| function | **string**

The name of the aggregating function to apply to data whose age falls within the range [age, age + precision].
Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2)**

Retention rules. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2}

#|
||Field | Description ||
|| age | **int64**

The minimum age of the data in seconds. ||
|| precision | **int64**

Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day). ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2}

Kafka configuration settings.
For details, see [librdkafka documentation](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).

#|
||Field | Description ||
|| security_protocol | enum **SecurityProtocol**

Protocol used to communicate with brokers.

Default value: **SECURITY_PROTOCOL_PLAINTEXT**.

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| sasl_mechanism | enum **SaslMechanism**

SASL mechanism to use for authentication.

Default value: **SASL_MECHANISM_GSSAPI**.

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| sasl_username | **string**

SASL username for use with the PLAIN and SASL-SCRAM mechanisms. ||
|| sasl_password | **string**

SASL password for use with the PLAIN and SASL-SCRAM mechanisms. ||
|| enable_ssl_certificate_verification | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable OpenSSL's builtin broker (server) certificate verification.

Default value: **true**. ||
|| max_poll_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum allowed time between calls to consume messages for high-level consumers.
If this interval is exceeded the consumer is considered failed and the group will
rebalance in order to reassign the partitions to another consumer group member.

Default value: **300000** (5 minutes). ||
|| session_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
the session timeout, the broker will remove the consumer from the group and trigger a rebalance.

Default value: **45000** (45 seconds). ||
|| debug | enum **Debug**

Debug context to enable.

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

Action to take when there is no initial offset in offset store or the desired offset is out of range.

Default value: **AUTO_OFFSET_RESET_LARGEST**.

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

Required field. Kafka topic name. ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)**

Required field. Kafka topic settings. ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2}

RabbitMQ integration settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/table-engines/integrations/rabbitmq).

#|
||Field | Description ||
|| username | **string**

RabbitMQ username. ||
|| password | **string**

RabbitMQ password. ||
|| vhost | **string**

RabbitMQ virtual host. ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression. ||
|| replace | **string**

Substitution string for sensitive data.

Default value: six asterisks. ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2}

Query cache configuration.

#|
||Field | Description ||
|| max_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum cache size in bytes.

Default value: **1073741824** (1 GiB). ||
|| max_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of **SELECT** query results stored in the cache.

Default value: **1024**. ||
|| max_entry_size_in_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size in bytes **SELECT** query results may have to be saved in the cache.

Default value: **1048576** (1 MiB). ||
|| max_entry_size_in_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of rows **SELECT** query results may have to be saved in the cache.

Default value: **30000000**. ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge2}

JDBC bridge configuration for queries to external databases.

#|
||Field | Description ||
|| host | **string**

Required field. Host of jdbc bridge. ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Port of jdbc bridge.

Default value: **9019**. ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro2}

ClickHouse macro.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the macro. ||
|| value | **string**

Required field. Value of the macro. ||
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

## DiskSizeAutoscaling {#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| planned_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources2)**

Resources allocated to ZooKeeper hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings. ||
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