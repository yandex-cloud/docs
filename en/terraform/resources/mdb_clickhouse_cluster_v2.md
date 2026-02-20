---
subcategory: Managed Service for ClickHouse
---

# yandex_mdb_clickhouse_cluster_v2 (Resource)

Manages a ClickHouse cluster within the Yandex Cloud. For more information, see [the official documentation](https://cloud.yandex.com/docs/managed-clickhouse/). [How to connect to the DB](https://yandex.cloud/en/docs/managed-clickhouse/quickstart#connect). To connect, use port 9440. The port number is not configurable.

## Example usage

```terraform
//
// Create a new MDB Clickhouse Cluster.
//
resource "yandex_mdb_clickhouse_cluster_v2" "my_cluster" {
    name        = "test"
    environment = "PRESTABLE"
    network_id  = yandex_vpc_network.foo.id

    clickhouse = {
        resources = {
            resource_preset_id = "s2.micro"
            disk_type_id       = "network-ssd"
            disk_size          = 32
        }

        config = {
            log_level                       = "TRACE"
            max_connections                 = 100
            max_concurrent_queries          = 50
            keep_alive_timeout              = 3000
            uncompressed_cache_size         = 8589934592
            max_table_size_to_drop          = 53687091200
            max_partition_size_to_drop      = 53687091200
            timezone                        = "UTC"
            geobase_uri                     = ""
            query_log_retention_size        = 1073741824
            query_log_retention_time        = 2592000
            query_thread_log_enabled        = true
            query_thread_log_retention_size = 536870912
            query_thread_log_retention_time = 2592000
            part_log_retention_size         = 536870912
            part_log_retention_time         = 2592000
            metric_log_enabled              = true
            metric_log_retention_size       = 536870912
            metric_log_retention_time       = 2592000
            trace_log_enabled               = true
            trace_log_retention_size        = 536870912
            trace_log_retention_time        = 2592000
            text_log_enabled                = true
            text_log_retention_size         = 536870912
            text_log_retention_time         = 2592000
            text_log_level                  = "TRACE"
            background_pool_size            = 16
            background_schedule_pool_size   = 16

            merge_tree = {
                replicated_deduplication_window                           = 100
                replicated_deduplication_window_seconds                   = 604800
                parts_to_delay_insert                                     = 150
                parts_to_throw_insert                                     = 300
                max_replicated_merges_in_queue                            = 16
                number_of_free_entries_in_pool_to_lower_max_size_of_merge = 8
                max_bytes_to_merge_at_min_space_in_pool                   = 1048576
                max_bytes_to_merge_at_max_space_in_pool                   = 161061273600
            }

            kafka = {
                security_protocol = "SECURITY_PROTOCOL_PLAINTEXT"
                sasl_mechanism    = "SASL_MECHANISM_GSSAPI"
                sasl_username     = "user1"
                sasl_password     = "pass1"
            }

            rabbitmq = {
                username = "rabbit_user"
                password = "rabbit_pass"
            }

            compression = [
                {
                    method              = "LZ4"
                    min_part_size       = 1024
                    min_part_size_ratio = 0.5
                },
                {
                    method              = "ZSTD"
                    min_part_size       = 2048
                    min_part_size_ratio = 0.7
                },
            ]

            graphite_rollup = [
                {
                    name = "rollup1"
                    patterns = [{
                        regexp   = "abc"
                        function = "func1"
                        retention = [{
                            age       = 1000
                            precision = 3
                        }]
                    }]
                },
                {
                    name = "rollup2"
                    patterns = [{
                        function = "func2"
                        retention = [{
                            age       = 2000
                            precision = 5
                        }]
                    }]
                }
            ]
        }
    }

    hosts = {
        "h1" = {
            type      = "CLICKHOUSE"
            zone      = "ru-central1-a"
            subnet_id = yandex_vpc_subnet.foo.id
        }
    }

    format_schema {
        name = "test_schema"
        type = "FORMAT_SCHEMA_TYPE_CAPNPROTO"
        uri  = "https://storage.yandexcloud.net/ch-data/schema.proto"
    }

    service_account_id = "your_service_account_id"

    cloud_storage = {
        enabled = false
    }

    maintenance_window {
        type = "ANYTIME"
    }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```
```terraform
//
// Create a new MDB High Availability Clickhouse Cluster.
//
resource "yandex_mdb_clickhouse_cluster_v2" "my_cluster" {
  name        = "ha"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  clickhouse = {
    resources = {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  zookeeper = {
    resources = {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  hosts = {
    "ka" = {
      type      = "KEEPER"
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
    }
    "kb" = {
      type      = "KEEPER"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.bar.id
    }
    "kd" = {
      type      = "KEEPER"
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.baz.id
    }
    "ca" = {
      type      = "CLICKHOUSE"
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
    }
    "cb" = {
      type      = "CLICKHOUSE"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.bar.id
    }
  }

  cloud_storage = {
    enabled = false
  }

  maintenance_window {
    type = "ANYTIME"
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "bar" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}

resource "yandex_vpc_subnet" "baz" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.3.0.0/24"]
}
```
```terraform
//
// Create a new MDB Sharded Clickhouse Cluster.
//
resource "yandex_mdb_clickhouse_cluster_v2" "my_cluster" {
  name        = "sharded"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.foo.id

  clickhouse = {
    resources = {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  zookeeper = {
    resources = {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  shards = {
    "shard1" = {
      weight = 110
    }
    "shard2" = {
      weight = 300
    }
  }

  hosts = {
    "c1a" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-a"
      subnet_id  = yandex_vpc_subnet.foo.id
      shard_name = "shard1"
    }
    "c1b" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-b"
      subnet_id  = yandex_vpc_subnet.bar.id
      shard_name = "shard1"
    }
    "c2a" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-b"
      subnet_id  = yandex_vpc_subnet.bar.id
      shard_name = "shard2"
    }
    "c2d" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-d"
      subnet_id  = yandex_vpc_subnet.baz.id
      shard_name = "shard2"
    }
  }

  shard_group {
    name        = "single_shard_group"
    description = "Cluster configuration that contain only shard1"
    shard_names = [
      "shard1",
    ]
  }

  cloud_storage = {
    enabled = false
  }

  maintenance_window {
    type = "ANYTIME"
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "bar" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}

resource "yandex_vpc_subnet" "baz" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.3.0.0/24"]
}
```

## Arguments & Attributes Reference

- `access` [Block]. Access policy to the ClickHouse cluster.
  - `data_lens` (Bool). Allow access for DataLens.
  - `data_transfer` (Bool). Allow access for DataTransfer.
  - `metrika` (Bool). Allow access for Yandex.Metrika.
  - `serverless` (Bool). Allow access for Serverless.
  - `web_sql` (Bool). Allow access for Web SQL.
  - `yandex_query` (Bool). Allow access for YandexQuery.
- `admin_password` (String). A password used to authorize as user `admin` when `sql_user_management` enabled.
- `backup_retain_period_days` (Number). The period in days during which backups are stored.
- `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
  - `hours` (Number). The hour at which backup will be started (UTC).
  - `minutes` (Number). The minute at which backup will be started (UTC).
- `clickhouse` [Block]. Configuration of the ClickHouse subcluster.
  - `config` [Block]. Configuration of the ClickHouse subcluster.
    - `access_control_improvements` [Block]. Access control settings.
      - `select_from_information_schema_requires_grant` (Bool). Sets whether `SELECT * FROM information_schema.<table>` requires any grants and can be executed by any user. If set to true, then this query requires `GRANT SELECT ON information_schema.<table>`, just as for ordinary tables.
      - `select_from_system_db_requires_grant` (Bool). Sets whether `SELECT * FROM system.<table>` requires any grants and can be executed by any user. If set to true then this query requires `GRANT SELECT ON system.<table>` just as for non-system tables.
    - `async_insert_threads` (Number). Maximum number of threads to parse and insert data in background.
    - `asynchronous_insert_log_enabled` (Bool). Enable or disable asynchronous_insert_log system table.
    - `asynchronous_insert_log_retention_size` (Number). The maximum size that asynchronous_insert_log can grow to before old data will be removed.
    - `asynchronous_insert_log_retention_time` (Number). The maximum time that asynchronous_insert_log records will be retained before removal.
    - `asynchronous_metric_log_enabled` (Bool). Enable or disable asynchronous_metric_log system table.
    - `asynchronous_metric_log_retention_size` (Number). The maximum size that asynchronous_metric_log can grow to before old data will be removed.
    - `asynchronous_metric_log_retention_time` (Number). The maximum time that asynchronous_metric_log records will be retained before removal.
    - `background_buffer_flush_schedule_pool_size` (Number). The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.
    - `background_common_pool_size` (Number). The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.
    - `background_distributed_schedule_pool_size` (Number). The maximum number of threads that will be used for executing distributed sends.
    - `background_fetches_pool_size` (Number). The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.
    - `background_merges_mutations_concurrency_ratio` (Number). Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.
    - `background_message_broker_schedule_pool_size` (Number). The maximum number of threads that will be used for executing background operations for message streaming.
    - `background_move_pool_size` (Number). The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.
    - `background_pool_size` (Number). Sets the number of threads performing background merges and mutations for MergeTree-engine tables.
    - `background_schedule_pool_size` (Number). The maximum number of threads that will be used for constantly executing some lightweight periodic operations for replicated tables, Kafka streaming, and DNS cache updates.
    - `backup_threads` (Number). The maximum number of threads to execute **BACKUP** requests.
    - `compression` [Block]. Data compression configuration.
      - `level` (Number). Compression level for `ZSTD` method.
      - `method` (**Required**)(String). Compression method. Two methods are available: `LZ4` and `zstd`.
      - `min_part_size` (**Required**)(Number). Min part size: Minimum size (in bytes) of a data part in a table. ClickHouse only applies the rule to tables with data parts greater than or equal to the Min part size value.
      - `min_part_size_ratio` (**Required**)(Number). Min part size ratio: Minimum table part size to total table size ratio. ClickHouse only applies the rule to tables in which this ratio is greater than or equal to the Min part size ratio value.
    - `custom_macros` [Block]. Custom ClickHouse macros.
      - `name` (**Required**)(String). Name of the macro.
      - `value` (**Required**)(String). Value of the macro.
    - `default_database` (String). Default database name.
    - `dictionaries_lazy_load` (Bool). Lazy loading of dictionaries. If true, then each dictionary is loaded on the first use.
    - `error_log_enabled` (Bool). Enables or disables error_log system table.
    - `error_log_retention_size` (Number). The maximum size that error_log can grow to before old data will be removed. If set to **0**, automatic removal of error_log data based on size is disabled.
    - `error_log_retention_time` (Number). The maximum time that error_log records will be retained before removal. If set to **0**, automatic removal of error_log data based on time is disabled.
    - `geobase_enabled` (Bool). Enable or disable geobase.
    - `geobase_uri` (String). Address of the archive with the user geobase in Object Storage.
    - `graphite_rollup` [Block]. Graphite rollup configuration.
      - `name` (**Required**)(String). Graphite rollup configuration name.
      - `path_column_name` (String). The name of the column storing the metric name (Graphite sensor). Default value: Path.
      - `patterns` [Block]. Set of thinning rules.
        - `function` (**Required**)(String). Aggregation function name.
        - `regexp` (String). Regular expression that the metric name must match.
        - `retention` [Block]. Retain parameters.
          - `age` (**Required**)(Number). Minimum data age in seconds.
          - `precision` (**Required**)(Number). Accuracy of determining the age of the data in seconds.
      - `time_column_name` (String). The name of the column storing the time of measuring the metric. Default value: Time.
      - `value_column_name` (String). The name of the column storing the value of the metric at the time set in `time_column_name`. Default value: Value.
      - `version_column_name` (String). The name of the column storing the version of the metric. Default value: Timestamp.
    - `jdbc_bridge` [Block]. JDBC bridge configuration.
      - `host` (**Required**)(String). Host of jdbc bridge.
      - `port` (Number). Port of jdbc bridge. Default value: 9019.
    - `kafka` [Block]. Kafka connection configuration.
      - `auto_offset_reset` (String). Action when no initial offset: 'smallest','earliest','largest','latest','error'.
      - `debug` (String). A comma-separated list of debug contexts to enable.
      - `enable_ssl_certificate_verification` (Bool). Enable verification of SSL certificates.
      - `max_poll_interval_ms` (Number). Maximum allowed time between calls to consume messages. If exceeded, consumer is considered failed.
      - `sasl_mechanism` (String). SASL mechanism used in kafka authentication.
      - `sasl_password` (String). User password on kafka server.
      - `sasl_username` (String). Username on kafka server.
      - `security_protocol` (String). Security protocol used to connect to kafka server.
      - `session_timeout_ms` (Number). Client group session and failure detection timeout.
    - `keep_alive_timeout` (Number). The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.
    - `log_level` (String). Logging level.
    - `max_concurrent_queries` (Number). Limit on total number of concurrently executed queries.
    - `max_connections` (Number). Max server connections.
    - `max_partition_size_to_drop` (Number). Restriction on dropping partitions.
    - `max_table_size_to_drop` (Number). Restriction on deleting tables.
    - `merge_tree` [Block]. MergeTree engine configuration.
      - `check_sample_column_is_correct` (Bool). Enables the check at table creation that the sampling column type is correct. Default value: true.
      - `cleanup_delay_period` (Number). Minimum period to clean old queue logs, blocks hashes and parts.
      - `deduplicate_merge_projection_mode` (String). Determines the behavior of background merges for MergeTree tables with projections.
      - `fsync_after_insert` (Bool). Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts.
      - `fsync_part_directory` (Bool). Do fsync for part directory after all part operations (writes, renames, etc.).
      - `inactive_parts_to_delay_insert` (Number). If the number of inactive parts in a single partition in the table at least that many the inactive_parts_to_delay_insert value, an INSERT artificially slows down. It is useful when a server fails to clean up parts quickly enough.
      - `inactive_parts_to_throw_insert` (Number). If the number of inactive parts in a single partition more than the inactive_parts_to_throw_insert value, INSERT is interrupted with the `Too many inactive parts (N). Parts cleaning are processing significantly slower than inserts` exception.
      - `lightweight_mutation_projection_mode` (String). Determines the behavior of lightweight deletes for MergeTree tables with projections.
      - `materialize_ttl_recalculate_only` (Bool). Only recalculate ttl info when **MATERIALIZE TTL**.
      - `max_avg_part_size_for_too_many_parts` (Number). The `too many parts` check will be active only if the average part size is not larger than the specified threshold. This allows large tables if parts are successfully merged.
      - `max_bytes_to_merge_at_max_space_in_pool` (Number). The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available. Roughly corresponds to the maximum possible part size created by an automatic background merge.
      - `max_bytes_to_merge_at_min_space_in_pool` (Number). Max bytes to merge at min space in pool: Maximum total size of a data part to merge when the number of free threads in the background pool is minimum.
      - `max_cleanup_delay_period` (Number). Maximum period to clean old queue logs, blocks hashes and parts. Default value: 300 seconds.
      - `max_merge_selecting_sleep_ms` (Number). Maximum sleep time for merge selecting. Default value: 60000 milliseconds (60 seconds).
      - `max_number_of_merges_with_ttl_in_pool` (Number). When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
      - `max_parts_in_total` (Number). Maximum number of parts in all partitions.
      - `max_replicated_merges_in_queue` (Number). Max replicated merges in queue: Maximum number of merge tasks that can be in the ReplicatedMergeTree queue at the same time.
      - `merge_max_block_size` (Number). The number of rows that are read from the merged parts into memory. Default value: 8192.
      - `merge_selecting_sleep_ms` (Number). Sleep time for merge selecting when no part is selected. Lower values increase ZooKeeper requests in large clusters.
      - `merge_with_recompression_ttl_timeout` (Number). Minimum delay in seconds before repeating a merge with recompression TTL. Default value: 14400 seconds (4 hours).
      - `merge_with_ttl_timeout` (Number). Minimum delay in seconds before repeating a merge with delete TTL. Default value: 14400 seconds (4 hours).
      - `min_age_to_force_merge_on_partition_only` (Bool). Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset.
      - `min_age_to_force_merge_seconds` (Number). Merge parts if every part in the range is older than the value of `min_age_to_force_merge_seconds`.
      - `min_bytes_for_wide_part` (Number). Minimum number of bytes in a data part that can be stored in Wide format. You can set one, both or none of these settings.
      - `min_compressed_bytes_to_fsync_after_fetch` (Number). Minimal number of rows to do fsync for part after merge. **0** means disabled.
      - `min_compressed_bytes_to_fsync_after_merge` (Number). Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled.
      - `min_rows_for_wide_part` (Number). Minimum number of rows in a data part that can be stored in Wide format. You can set one, both or none of these settings.
      - `min_rows_to_fsync_after_merge` (Number). Minimal number of rows to do fsync for part after merge. **0** means disabled.
      - `number_of_free_entries_in_pool_to_execute_mutation` (Number). When there is less than specified number of free entries in pool, do not execute part mutations. This is to leave free threads for regular merges and avoid `Too many parts`. Default value: 20.
      - `number_of_free_entries_in_pool_to_lower_max_size_of_merge` (Number). Number of free entries in pool to lower max size of merge: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, ClickHouse reduces the maximum size of a data part to merge. This helps handle small merges faster, rather than filling the pool with lengthy merges.
      - `parts_to_delay_insert` (Number). Parts to delay insert: Number of active data parts in a table, on exceeding which ClickHouse starts artificially reduce the rate of inserting data into the table
      - `parts_to_throw_insert` (Number). Parts to throw insert: Threshold value of active data parts in a table, on exceeding which ClickHouse throws the 'Too many parts ...' exception.
      - `replicated_deduplication_window` (Number). Replicated deduplication window: Number of recent hash blocks that ZooKeeper will store (the old ones will be deleted).
      - `replicated_deduplication_window_seconds` (Number). Replicated deduplication window seconds: Time during which ZooKeeper stores the hash blocks (the old ones will be deleted).
      - `ttl_only_drop_parts` (Bool). Enables zero-copy replication when a replica is located on a remote filesystem.
    - `metric_log_enabled` (Bool). Enable or disable metric_log system table.
    - `metric_log_retention_size` (Number). The maximum size that metric_log can grow to before old data will be removed.
    - `metric_log_retention_time` (Number). The maximum time that metric_log records will be retained before removal.
    - `mysql_protocol` (Bool). Enables or disables MySQL interface on ClickHouse server.
    - `opentelemetry_span_log_enabled` (Bool). Enable or disable opentelemetry_span_log system table.
    - `opentelemetry_span_log_retention_size` (Number). The maximum size that opentelemetry_span_log can grow to before old data will be removed.
    - `opentelemetry_span_log_retention_time` (Number). The maximum time that opentelemetry_span_log records will be retained before removal.
    - `part_log_retention_size` (Number). The maximum size that part_log can grow to before old data will be removed.
    - `part_log_retention_time` (Number). The maximum time that part_log records will be retained before removal.
    - `processors_profile_log_enabled` (Bool). Enables or disables processors_profile_log system table.
    - `processors_profile_log_retention_size` (Number). The maximum time that processors_profile_log records will be retained before removal. If set to **0**, automatic removal of processors_profile_log data based on time is disabled.
    - `processors_profile_log_retention_time` (Number). Enables or disables error_log system table.
    - `query_cache` [Block]. Query cache configuration.
      - `max_entries` (Number). The maximum number of SELECT query results stored in the cache. Default value: 1024.
      - `max_entry_size_in_bytes` (Number). The maximum size in bytes SELECT query results may have to be saved in the cache. Default value: 1048576 (1 MiB).
      - `max_entry_size_in_rows` (Number). The maximum number of rows SELECT query results may have to be saved in the cache. Default value: 30000000 (30 mil).
      - `max_size_in_bytes` (Number). The maximum cache size in bytes. 0 means the query cache is disabled. Default value: 1073741824 (1 GiB).
    - `query_log_retention_size` (Number). The maximum size that query_log can grow to before old data will be removed.
    - `query_log_retention_time` (Number). The maximum time that query_log records will be retained before removal.
    - `query_masking_rules` [Block]. Query masking rules configuration.
      - `name` (String). Name for the rule.
      - `regexp` (**Required**)(String). RE2 compatible regular expression.
      - `replace` (String). Substitution string for sensitive data. Default value: six asterisks.
    - `query_metric_log_enabled` (Bool). Enables or disables query_metric_log system table.
    - `query_metric_log_retention_size` (Number). The maximum size that query_metric_log can grow to before old data will be removed. If set to **0**, automatic removal of query_metric_log data based on size is disabled.
    - `query_metric_log_retention_time` (Number). The maximum time that query_metric_log records will be retained before removal. If set to **0**, automatic removal of query_metric_log data based on time is disabled.
    - `query_thread_log_enabled` (Bool). Enable or disable query_thread_log system table.
    - `query_thread_log_retention_size` (Number). The maximum size that query_thread_log can grow to before old data will be removed.
    - `query_thread_log_retention_time` (Number). The maximum time that query_thread_log records will be retained before removal.
    - `query_views_log_enabled` (Bool). Enable or disable query_views_log system table.
    - `query_views_log_retention_size` (Number). The maximum size that query_views_log can grow to before old data will be removed.
    - `query_views_log_retention_time` (Number). The maximum time that query_views_log records will be retained before removal.
    - `rabbitmq` [Block]. RabbitMQ connection configuration.
      - `password` (String). RabbitMQ user password.
      - `username` (String). RabbitMQ username.
      - `vhost` (String). RabbitMQ vhost. Default: `\`.
    - `restore_threads` (Number). The maximum number of threads to execute **RESTORE** requests.
    - `session_log_enabled` (Bool). Enable or disable session_log system table.
    - `session_log_retention_size` (Number). The maximum size that session_log can grow to before old data will be removed.
    - `session_log_retention_time` (Number). The maximum time that session_log records will be retained before removal.
    - `text_log_enabled` (Bool). Enable or disable text_log system table.
    - `text_log_level` (String). Logging level for text_log system table.
    - `text_log_retention_size` (Number). The maximum size that text_log can grow to before old data will be removed.
    - `text_log_retention_time` (Number). The maximum time that text_log records will be retained before removal.
    - `timezone` (String). The server's time zone.
    - `total_memory_profiler_step` (Number). Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect the allocating stack trace.
    - `total_memory_tracker_sample_probability` (Number). Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table with trace_type equal to a MemorySample with the specified probability.
    - `trace_log_enabled` (Bool). Enable or disable trace_log system table.
    - `trace_log_retention_size` (Number). The maximum size that trace_log can grow to before old data will be removed.
    - `trace_log_retention_time` (Number). The maximum time that trace_log records will be retained before removal.
    - `uncompressed_cache_size` (Number). Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. Zero means disabled.
    - `zookeeper_log_enabled` (Bool). Enable or disable zookeeper_log system table.
    - `zookeeper_log_retention_size` (Number). The maximum size that zookeeper_log can grow to before old data will be removed.
    - `zookeeper_log_retention_time` (Number). The maximum time that zookeeper_log records will be retained before removal.
  - `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
    - `disk_size_limit` (**Required**)(Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](https://yandex.cloud/en/docs/managed-postgresql/concepts/storage#auto-rescale) for details.
    - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
    - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
  - `resources` [Block]. Resources allocated to hosts.
    - `disk_size` (Number). Volume of the storage available to a host, in gigabytes.
    - `disk_type_id` (String). Type of the storage of hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
    - `resource_preset_id` (String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).
- `cloud_storage` [Block]. Cloud Storage settings.
  - `data_cache_enabled` (Bool). Enables temporary storage in the cluster repository of data requested from the object repository.
  - `data_cache_max_size` (Number). Defines the maximum amount of memory (in bytes) allocated in the cluster storage for temporary storage of data requested from the object storage.
  - `enabled` (**Required**)(Bool). Whether to use Yandex Object Storage for storing ClickHouse data. Can be either `true` or `false`.
  - `move_factor` (Number). Sets the minimum free space ratio in the cluster storage. If the free space is lower than this value, the data is transferred to Yandex Object Storage. Acceptable values are 0 to 1, inclusive.
  - `prefer_not_to_merge` (Bool). Disables merging of data parts in `Yandex Object Storage`.
- `cluster_id` (*Read-Only*) (String). ID of the ClickHouse cluster. This ID is assigned by MDB at creation time.
- `copy_schema_on_new_hosts` (Bool). Whether to copy schema on new ClickHouse hosts.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption.
- `embedded_keeper` (Bool). Whether to use ClickHouse Keeper as a coordination system.
- `environment` (**Required**)(String). Deployment environment of the ClickHouse cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hosts` [Block]. A host configuration of the ClickHouse cluster.
  - `assign_public_ip` (Bool). Whether the host should get a public IP address.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `shard_name` (String). The name of the shard to which the host belongs.
  - `subnet_id` (String). ID of the subnet where the host is located.
  - `type` (**Required**)(String). The type of the host to be deployed. Can be either `CLICKHOUSE` or `ZOOKEEPER`.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). Name of the ClickHouse cluster. Provided by the client when the cluster is created.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `shards` [Block]. A shards of the ClickHouse cluster.
  - `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
    - `disk_size_limit` (**Required**)(Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](https://yandex.cloud/en/docs/managed-postgresql/concepts/storage#auto-rescale) for details.
    - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
    - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
  - `resources` [Block]. Resources allocated to hosts.
    - `disk_size` (Number). Volume of the storage available to a host, in gigabytes.
    - `disk_type_id` (String). Type of the storage of hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
    - `resource_preset_id` (String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).
  - `weight` (Number). The weight of shard.
- `sql_database_management` (Bool). Grants `admin` user database management permission.
- `sql_user_management` (Bool). Enables `admin` user with user management permission.
- `version` (String). Version of the ClickHouse server software.
- `zookeeper` [Block]. Configuration of the ZooKeeper subcluster.
  - `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
    - `disk_size_limit` (**Required**)(Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](https://yandex.cloud/en/docs/managed-postgresql/concepts/storage#auto-rescale) for details.
    - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
    - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
  - `resources` [Block]. Resources allocated to hosts.
    - `disk_size` (Number). Volume of the storage available to a host, in gigabytes.
    - `disk_type_id` (String). Type of the storage of hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
    - `resource_preset_id` (String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).
- `format_schema` [Block]. A set of `protobuf` or `capnproto` format schemas.
  - `name` (**Required**)(String). The name of the format schema.
  - `type` (**Required**)(String). Type of the format schema.
  - `uri` (**Required**)(String). Format schema file URL. You can only use format schemas stored in Yandex Object Storage.
- `maintenance_window` [Block]. Maintenance window settings.
  - `day` (String). Day of week for maintenance window if window type is weekly. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
  - `hour` (Number). Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `ml_model` [Block]. A group of machine learning models.
  - `name` (**Required**)(String). The name of the ml model.
  - `type` (**Required**)(String). Type of the model.
  - `uri` (**Required**)(String). Model file URL. You can only use models stored in Yandex Object Storage.
- `shard_group` [Block]. A group of clickhouse shards.
  - `description` (String). Description of the shard group.
  - `name` (**Required**)(String). The name of the shard group, used as cluster name in Distributed tables.
  - `shard_names` (**Required**)(List Of String). List of shards names that belong to the shard group.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_clickhouse_cluster_v2.<resource Name> <resource Id>
terraform import yandex_mdb_clickhouse_cluster_v2.my_cluster cluster_id
```
