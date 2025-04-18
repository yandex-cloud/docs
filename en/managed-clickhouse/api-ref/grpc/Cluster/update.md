---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/update.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.Update

Updates the specified ClickHouse cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "description": "string",
  "labels": "map<string, string>",
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
  "name": "string",
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
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "network_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse Cluster resource to update.
To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the ClickHouse Cluster resource should be updated. ||
|| description | **string**

New description of the ClickHouse cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".

The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-clickhouse/api-ref/grpc/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec)**

New configuration and resources for hosts in the cluster. ||
|| name | **string**

New name for the cluster. ||
|| service_account_id | **string**

ID of the service account used for access to Object Storage. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| network_id | **string**

ID of the network to move the cluster to. ||
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
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterMetadata)**

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

## UpdateClusterMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the ClickHouse Cluster resource that is being updated. ||
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