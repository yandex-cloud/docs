---
subcategory: Managed Service for ClickHouse
page_title: 'Yandex: yandex_mdb_clickhouse_cluster'
description: Manages a ClickHouse cluster within Yandex Cloud.
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_clickhouse_cluster.md
---

# yandex_mdb_clickhouse_cluster (Resource)

Manages a ClickHouse cluster within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).

## Example usage

```terraform
//
// Create a new MDB Clickhouse Cluster.
//
resource "yandex_mdb_clickhouse_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  clickhouse {
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 32
    }

    config {
      log_level                       = "TRACE"
      max_connections                 = 100
      max_concurrent_queries          = 50
      keep_alive_timeout              = 3000
      uncompressed_cache_size         = 8589934592
      mark_cache_size                 = 5368709120
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

      merge_tree {
        replicated_deduplication_window                           = 100
        replicated_deduplication_window_seconds                   = 604800
        parts_to_delay_insert                                     = 150
        parts_to_throw_insert                                     = 300
        max_replicated_merges_in_queue                            = 16
        number_of_free_entries_in_pool_to_lower_max_size_of_merge = 8
        max_bytes_to_merge_at_min_space_in_pool                   = 1048576
        max_bytes_to_merge_at_max_space_in_pool                   = 161061273600
      }

      kafka {
        security_protocol = "SECURITY_PROTOCOL_PLAINTEXT"
        sasl_mechanism    = "SASL_MECHANISM_GSSAPI"
        sasl_username     = "user1"
        sasl_password     = "pass1"
      }

      kafka_topic {
        name = "topic1"
        settings {
          security_protocol = "SECURITY_PROTOCOL_SSL"
          sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_256"
          sasl_username     = "user2"
          sasl_password     = "pass2"
        }
      }

      kafka_topic {
        name = "topic2"
        settings {
          security_protocol = "SECURITY_PROTOCOL_SASL_PLAINTEXT"
          sasl_mechanism    = "SASL_MECHANISM_PLAIN"
        }
      }

      rabbitmq {
        username = "rabbit_user"
        password = "rabbit_pass"
      }

      compression {
        method              = "LZ4"
        min_part_size       = 1024
        min_part_size_ratio = 0.5
      }

      compression {
        method              = "ZSTD"
        min_part_size       = 2048
        min_part_size_ratio = 0.7
      }

      graphite_rollup {
        name = "rollup1"
        pattern {
          regexp   = "abc"
          function = "func1"
          retention {
            age       = 1000
            precision = 3
          }
        }
      }

      graphite_rollup {
        name = "rollup2"
        pattern {
          function = "func2"
          retention {
            age       = 2000
            precision = 5
          }
        }
      }
    }
  }

  database {
    name = "db_name"
  }

  user {
    name     = "user"
    password = "your_password"
    permission {
      database_name = "db_name"
    }
    settings {
      max_memory_usage_for_user               = 1000000000
      read_overflow_mode                      = "throw"
      output_format_json_quote_64bit_integers = true
    }
    quota {
      interval_duration = 3600000
      queries           = 10000
      errors            = 1000
    }
    quota {
      interval_duration = 79800000
      queries           = 50000
      errors            = 5000
    }
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.foo.id
  }

  format_schema {
    name = "test_schema"
    type = "FORMAT_SCHEMA_TYPE_CAPNPROTO"
    uri  = "https://storage.yandexcloud.net/ch-data/schema.proto"
  }

  ml_model {
    name = "test_model"
    type = "ML_MODEL_TYPE_CATBOOST"
    uri  = "https://storage.yandexcloud.net/ch-data/train.csv"
  }

  service_account_id = "your_service_account_id"

  cloud_storage {
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
resource "yandex_mdb_clickhouse_cluster" "my_cluster" {
  name        = "ha"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  clickhouse {
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  zookeeper {
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  database {
    name = "db_name"
  }

  user {
    name     = "user"
    password = "password"
    permission {
      database_name = "db_name"
    }
    settings {
      max_memory_usage_for_user               = 1000000000
      read_overflow_mode                      = "throw"
      output_format_json_quote_64bit_integers = true
    }
    quota {
      interval_duration = 3600000
      queries           = 10000
      errors            = 1000
    }
    quota {
      interval_duration = 79800000
      queries           = 50000
      errors            = 5000
    }
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.foo.id
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.bar.id
  }

  host {
    type      = "ZOOKEEPER"
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.foo.id
  }

  host {
    type      = "ZOOKEEPER"
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.bar.id
  }

  host {
    type      = "ZOOKEEPER"
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.baz.id
  }

  cloud_storage {
    enabled = false
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
resource "yandex_mdb_clickhouse_cluster" "my_cluster" {
  name        = "sharded"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.foo.id

  clickhouse {
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  zookeeper {
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  database {
    name = "db_name"
  }

  user {
    name     = "user"
    password = "password"
    permission {
      database_name = "db_name"
    }
    settings {
      max_memory_usage_for_user               = 1000000000
      read_overflow_mode                      = "throw"
      output_format_json_quote_64bit_integers = true
    }
    quota {
      interval_duration = 3600000
      queries           = 10000
      errors            = 1000
    }
    quota {
      interval_duration = 79800000
      queries           = 50000
      errors            = 5000
    }
  }

  shard {
    name   = "shard1"
    weight = 110
  }

  shard {
    name   = "shard2"
    weight = 300
  }

  host {
    type       = "CLICKHOUSE"
    zone       = "ru-central1-a"
    subnet_id  = yandex_vpc_subnet.foo.id
    shard_name = "shard1"
  }

  host {
    type       = "CLICKHOUSE"
    zone       = "ru-central1-b"
    subnet_id  = yandex_vpc_subnet.bar.id
    shard_name = "shard1"
  }

  host {
    type       = "CLICKHOUSE"
    zone       = "ru-central1-b"
    subnet_id  = yandex_vpc_subnet.bar.id
    shard_name = "shard2"
  }

  host {
    type       = "CLICKHOUSE"
    zone       = "ru-central1-d"
    subnet_id  = yandex_vpc_subnet.baz.id
    shard_name = "shard2"
  }

  shard_group {
    name        = "single_shard_group"
    description = "Cluster configuration that contain only shard1"
    shard_names = [
      "shard1",
    ]
  }

  cloud_storage {
    enabled = false
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

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `environment` (String) Deployment environment of the ClickHouse cluster. Can be either `PRESTABLE` or `PRODUCTION`.
- `host` (Block List, Min: 1) A host of the ClickHouse cluster. (see [below for nested schema](#nestedblock--host))
- `name` (String) The resource name.
- `network_id` (String) The `VPC Network ID` of subnets which resource attached to.

### Optional

- `access` (Block List, Max: 1) Access policy to the ClickHouse cluster. (see [below for nested schema](#nestedblock--access))
- `admin_password` (String, Sensitive) A password used to authorize as user `admin` when `sql_user_management` enabled.
- `backup_retain_period_days` (Number) The period in days during which backups are stored.
- `backup_window_start` (Block List, Max: 1) Time to start the daily backup, in the UTC timezone. (see [below for nested schema](#nestedblock--backup_window_start))
- `clickhouse` (Block List, Max: 1) Configuration of the ClickHouse subcluster. (see [below for nested schema](#nestedblock--clickhouse))
- `cloud_storage` (Block List, Max: 1) Cloud Storage settings. (see [below for nested schema](#nestedblock--cloud_storage))
- `cluster_id` (String) The cluster identifier.
- `copy_schema_on_new_hosts` (Boolean) Whether to copy schema on new ClickHouse hosts.
- `database` (Block Set, Deprecated) A database of the ClickHouse cluster. (see [below for nested schema](#nestedblock--database))
- `deletion_protection` (Boolean) The `true` value means that resource is protected from accidental deletion.
- `description` (String) The resource description.
- `disk_encryption_key_id` (String) ID of the KMS key for cluster disk encryption.
- `embedded_keeper` (Boolean) Whether to use ClickHouse Keeper as a coordination system and place it on the same hosts with ClickHouse. If not, it's used ZooKeeper with placement on separate hosts.
- `folder_id` (String) The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `format_schema` (Block Set) A set of `protobuf` or `capnproto` format schemas. (see [below for nested schema](#nestedblock--format_schema))
- `labels` (Map of String) A set of key/value label pairs which assigned to resource.
- `maintenance_window` (Block List, Max: 1) (see [below for nested schema](#nestedblock--maintenance_window))
- `ml_model` (Block Set) A group of machine learning models. (see [below for nested schema](#nestedblock--ml_model))
- `security_group_ids` (Set of String) The list of security groups applied to resource or their components.
- `service_account_id` (String) [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `shard` (Block Set) A shard of the ClickHouse cluster. (see [below for nested schema](#nestedblock--shard))
- `shard_group` (Block List) A group of clickhouse shards. (see [below for nested schema](#nestedblock--shard_group))
- `sql_database_management` (Boolean) Grants `admin` user database management permission.
- `sql_user_management` (Boolean) Enables `admin` user with user management permission.
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `user` (Block Set, Deprecated) A user of the ClickHouse cluster. (see [below for nested schema](#nestedblock--user))
- `version` (String) Version of the ClickHouse server software.
- `zookeeper` (Block List, Max: 1) Configuration of the ZooKeeper subcluster. (see [below for nested schema](#nestedblock--zookeeper))

### Read-Only

- `created_at` (String) The creation timestamp of the resource.
- `health` (String) Aggregated health of the cluster. Can be `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-clickhouse/api-ref/Cluster/).
- `id` (String) The ID of this resource.
- `status` (String) Status of the cluster. Can be `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-clickhouse/api-ref/Cluster/).

<a id="nestedblock--host"></a>
### Nested Schema for `host`

Required:

- `type` (String) The type of the host to be deployed. Can be either `CLICKHOUSE` or `ZOOKEEPER`.
- `zone` (String) The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.

Optional:

- `assign_public_ip` (Boolean) Sets whether the host should get a public IP address on creation. Can be either `true` or `false`.
- `shard_name` (String) The name of the shard to which the host belongs.
- `subnet_id` (String) The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.

Read-Only:

- `fqdn` (String) The fully qualified domain name of the host.


<a id="nestedblock--access"></a>
### Nested Schema for `access`

Optional:

- `data_lens` (Boolean) Allow access for DataLens.
- `data_transfer` (Boolean) Allow access for DataTransfer.
- `metrika` (Boolean) Allow access for Yandex.Metrika.
- `serverless` (Boolean) Allow access for Serverless.
- `web_sql` (Boolean) Allow access for Web SQL.
- `yandex_query` (Boolean) Allow access for YandexQuery.


<a id="nestedblock--backup_window_start"></a>
### Nested Schema for `backup_window_start`

Optional:

- `hours` (Number) The hour at which backup will be started.
- `minutes` (Number) The minute at which backup will be started.


<a id="nestedblock--clickhouse"></a>
### Nested Schema for `clickhouse`

Optional:

- `config` (Block List, Max: 1) ClickHouse server parameters. For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/settings-list). (see [below for nested schema](#nestedblock--clickhouse--config))
- `resources` (Block List, Max: 1) Resources allocated to hosts of the ClickHouse subcluster. (see [below for nested schema](#nestedblock--clickhouse--resources))

<a id="nestedblock--clickhouse--config"></a>
### Nested Schema for `clickhouse.config`

Optional:

- `asynchronous_insert_log_enabled` (Boolean) Enable or disable asynchronous_insert_log system table.
- `asynchronous_insert_log_retention_size` (Number) The maximum size that asynchronous_insert_log can grow to before old data will be removed.
- `asynchronous_insert_log_retention_time` (Number) The maximum time that asynchronous_insert_log records will be retained before removal.
- `asynchronous_metric_log_enabled` (Boolean) Enable or disable asynchronous_metric_log system table.
- `asynchronous_metric_log_retention_size` (Number) The maximum size that asynchronous_metric_log can grow to before old data will be removed.
- `asynchronous_metric_log_retention_time` (Number) The maximum time that asynchronous_metric_log records will be retained before removal.
- `background_buffer_flush_schedule_pool_size` (Number) The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.
- `background_common_pool_size` (Number) The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.
- `background_distributed_schedule_pool_size` (Number) The maximum number of threads that will be used for executing distributed sends.
- `background_fetches_pool_size` (Number) The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.
- `background_merges_mutations_concurrency_ratio` (Number) Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.
- `background_message_broker_schedule_pool_size` (Number) The maximum number of threads that will be used for executing background operations for message streaming.
- `background_move_pool_size` (Number) The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.
- `background_pool_size` (Number) Sets the number of threads performing background merges and mutations for MergeTree-engine tables.
- `background_schedule_pool_size` (Number) The maximum number of threads that will be used for constantly executing some lightweight periodic operations for replicated tables, Kafka streaming, and DNS cache updates.
- `compression` (Block List) Data compression configuration. (see [below for nested schema](#nestedblock--clickhouse--config--compression))
- `default_database` (String) Default database name.
- `dictionaries_lazy_load` (Boolean) Lazy loading of dictionaries. If true, then each dictionary is loaded on the first use.
- `geobase_enabled` (Boolean) Enable or disable geobase.
- `geobase_uri` (String) Address of the archive with the user geobase in Object Storage.
- `graphite_rollup` (Block List) Graphite rollup configuration. (see [below for nested schema](#nestedblock--clickhouse--config--graphite_rollup))
- `jdbc_bridge` (Block List, Max: 1) JDBC bridge configuration. (see [below for nested schema](#nestedblock--clickhouse--config--jdbc_bridge))
- `kafka` (Block List, Max: 1) Kafka connection configuration. (see [below for nested schema](#nestedblock--clickhouse--config--kafka))
- `kafka_topic` (Block List) Kafka topic connection configuration. (see [below for nested schema](#nestedblock--clickhouse--config--kafka_topic))
- `keep_alive_timeout` (Number) The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.
- `log_level` (String) Logging level.
- `mark_cache_size` (Number) Maximum size of cache for marks
- `max_concurrent_queries` (Number) Limit on total number of concurrently executed queries.
- `max_connections` (Number) Max server connections.
- `max_partition_size_to_drop` (Number) Restriction on dropping partitions.
- `max_table_size_to_drop` (Number) Restriction on deleting tables.
- `merge_tree` (Block List, Max: 1) MergeTree engine configuration. (see [below for nested schema](#nestedblock--clickhouse--config--merge_tree))
- `metric_log_enabled` (Boolean) Enable or disable metric_log system table.
- `metric_log_retention_size` (Number) The maximum size that metric_log can grow to before old data will be removed.
- `metric_log_retention_time` (Number) The maximum time that metric_log records will be retained before removal.
- `opentelemetry_span_log_enabled` (Boolean) Enable or disable opentelemetry_span_log system table.
- `opentelemetry_span_log_retention_size` (Number) The maximum size that opentelemetry_span_log can grow to before old data will be removed.
- `opentelemetry_span_log_retention_time` (Number) The maximum time that opentelemetry_span_log records will be retained before removal.
- `part_log_retention_size` (Number) The maximum size that part_log can grow to before old data will be removed.
- `part_log_retention_time` (Number) The maximum time that part_log records will be retained before removal.
- `query_cache` (Block List, Max: 1) Query cache configuration. (see [below for nested schema](#nestedblock--clickhouse--config--query_cache))
- `query_log_retention_size` (Number) The maximum size that query_log can grow to before old data will be removed.
- `query_log_retention_time` (Number) The maximum time that query_log records will be retained before removal.
- `query_masking_rules` (Block List) Query masking rules configuration. (see [below for nested schema](#nestedblock--clickhouse--config--query_masking_rules))
- `query_thread_log_enabled` (Boolean) Enable or disable query_thread_log system table.
- `query_thread_log_retention_size` (Number) The maximum size that query_thread_log can grow to before old data will be removed.
- `query_thread_log_retention_time` (Number) The maximum time that query_thread_log records will be retained before removal.
- `query_views_log_enabled` (Boolean) Enable or disable query_views_log system table.
- `query_views_log_retention_size` (Number) The maximum size that query_views_log can grow to before old data will be removed.
- `query_views_log_retention_time` (Number) The maximum time that query_views_log records will be retained before removal.
- `rabbitmq` (Block List, Max: 1) RabbitMQ connection configuration. (see [below for nested schema](#nestedblock--clickhouse--config--rabbitmq))
- `session_log_enabled` (Boolean) Enable or disable session_log system table.
- `session_log_retention_size` (Number) The maximum size that session_log can grow to before old data will be removed.
- `session_log_retention_time` (Number) The maximum time that session_log records will be retained before removal.
- `text_log_enabled` (Boolean) Enable or disable text_log system table.
- `text_log_level` (String) Logging level for text_log system table.
- `text_log_retention_size` (Number) The maximum size that text_log can grow to before old data will be removed.
- `text_log_retention_time` (Number) The maximum time that text_log records will be retained before removal.
- `timezone` (String) The server's time zone.
- `total_memory_profiler_step` (Number) Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect the allocating stack trace.
- `trace_log_enabled` (Boolean) Enable or disable trace_log system table.
- `trace_log_retention_size` (Number) The maximum size that trace_log can grow to before old data will be removed.
- `trace_log_retention_time` (Number) The maximum time that trace_log records will be retained before removal.
- `uncompressed_cache_size` (Number) Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. Zero means disabled.
- `zookeeper_log_enabled` (Boolean) Enable or disable zookeeper_log system table.
- `zookeeper_log_retention_size` (Number) The maximum size that zookeeper_log can grow to before old data will be removed.
- `zookeeper_log_retention_time` (Number) The maximum time that zookeeper_log records will be retained before removal.

<a id="nestedblock--clickhouse--config--compression"></a>
### Nested Schema for `clickhouse.config.compression`

Required:

- `method` (String) Compression method. Two methods are available: `LZ4` and `zstd`.
- `min_part_size` (Number) Min part size: Minimum size (in bytes) of a data part in a table. ClickHouse only applies the rule to tables with data parts greater than or equal to the Min part size value.
- `min_part_size_ratio` (Number) Min part size ratio: Minimum table part size to total table size ratio. ClickHouse only applies the rule to tables in which this ratio is greater than or equal to the Min part size ratio value.

Optional:

- `level` (Number) Compression level for `ZSTD` method.


<a id="nestedblock--clickhouse--config--graphite_rollup"></a>
### Nested Schema for `clickhouse.config.graphite_rollup`

Required:

- `name` (String) Graphite rollup configuration name.

Optional:

- `path_column_name` (String) The name of the column storing the metric name (Graphite sensor). Default value: Path.
- `pattern` (Block List) Set of thinning rules. (see [below for nested schema](#nestedblock--clickhouse--config--graphite_rollup--pattern))
- `time_column_name` (String) The name of the column storing the time of measuring the metric. Default value: Time.
- `value_column_name` (String) The name of the column storing the value of the metric at the time set in `time_column_name`. Default value: Value.
- `version_column_name` (String) The name of the column storing the version of the metric. Default value: Timestamp.

<a id="nestedblock--clickhouse--config--graphite_rollup--pattern"></a>
### Nested Schema for `clickhouse.config.graphite_rollup.pattern`

Required:

- `function` (String) Aggregation function name.

Optional:

- `regexp` (String) Regular expression that the metric name must match.
- `retention` (Block List) Retain parameters. (see [below for nested schema](#nestedblock--clickhouse--config--graphite_rollup--pattern--retention))

<a id="nestedblock--clickhouse--config--graphite_rollup--pattern--retention"></a>
### Nested Schema for `clickhouse.config.graphite_rollup.pattern.retention`

Required:

- `age` (Number) Minimum data age in seconds.
- `precision` (Number) Accuracy of determining the age of the data in seconds.




<a id="nestedblock--clickhouse--config--jdbc_bridge"></a>
### Nested Schema for `clickhouse.config.jdbc_bridge`

Required:

- `host` (String) Host of jdbc bridge.

Optional:

- `port` (Number) Port of jdbc bridge. Default value: 9019.


<a id="nestedblock--clickhouse--config--kafka"></a>
### Nested Schema for `clickhouse.config.kafka`

Optional:

- `auto_offset_reset` (String) Action to take when there is no initial offset in offset store or the desired offset is out of range: 'smallest','earliest' - automatically reset the offset to the smallest offset, 'largest','latest' - automatically reset the offset to the largest offset, 'error' - trigger an error (ERR__AUTO_OFFSET_RESET) which is retrieved by consuming messages and checking 'message->err'.
- `debug` (String) A comma-separated list of debug contexts to enable.
- `enable_ssl_certificate_verification` (Boolean) Enable verification of SSL certificates.
- `max_poll_interval_ms` (Number) Maximum allowed time between calls to consume messages (e.g., `rd_kafka_consumer_poll()` for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member.
- `sasl_mechanism` (String) SASL mechanism used in kafka authentication.
- `sasl_password` (String, Sensitive) User password on kafka server.
- `sasl_username` (String) Username on kafka server.
- `security_protocol` (String) Security protocol used to connect to kafka server.
- `session_timeout_ms` (Number) Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance.


<a id="nestedblock--clickhouse--config--kafka_topic"></a>
### Nested Schema for `clickhouse.config.kafka_topic`

Required:

- `name` (String) Kafka topic name.

Optional:

- `settings` (Block List, Max: 1) Kafka connection settings. (see [below for nested schema](#nestedblock--clickhouse--config--kafka_topic--settings))

<a id="nestedblock--clickhouse--config--kafka_topic--settings"></a>
### Nested Schema for `clickhouse.config.kafka_topic.settings`

Optional:

- `auto_offset_reset` (String) Action to take when there is no initial offset in offset store or the desired offset is out of range: 'smallest','earliest' - automatically reset the offset to the smallest offset, 'largest','latest' - automatically reset the offset to the largest offset, 'error' - trigger an error (ERR__AUTO_OFFSET_RESET) which is retrieved by consuming messages and checking 'message->err'.
- `debug` (String) A comma-separated list of debug contexts to enable.
- `enable_ssl_certificate_verification` (Boolean) Enable verification of SSL certificates.
- `max_poll_interval_ms` (Number) Maximum allowed time between calls to consume messages (e.g., `rd_kafka_consumer_poll()` for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member.
- `sasl_mechanism` (String) SASL mechanism used in kafka authentication.
- `sasl_password` (String, Sensitive) User password on kafka server.
- `sasl_username` (String) Username on kafka server.
- `security_protocol` (String) Security protocol used to connect to kafka server.
- `session_timeout_ms` (Number) Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance.



<a id="nestedblock--clickhouse--config--merge_tree"></a>
### Nested Schema for `clickhouse.config.merge_tree`

Optional:

- `allow_remote_fs_zero_copy_replication` (Boolean) When this setting has a value greater than zero only a single replica starts the merge immediately if merged part on shared storage and allow_remote_fs_zero_copy_replication is enabled.
- `check_sample_column_is_correct` (Boolean) Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64. Default value: true.
- `cleanup_delay_period` (Number) Minimum period to clean old queue logs, blocks hashes and parts.
- `inactive_parts_to_delay_insert` (Number) If the number of inactive parts in a single partition in the table at least that many the inactive_parts_to_delay_insert value, an INSERT artificially slows down. It is useful when a server fails to clean up parts quickly enough.
- `inactive_parts_to_throw_insert` (Number) If the number of inactive parts in a single partition more than the inactive_parts_to_throw_insert value, INSERT is interrupted with the `Too many inactive parts (N). Parts cleaning are processing significantly slower than inserts` exception.
- `max_avg_part_size_for_too_many_parts` (Number) The `too many parts` check according to `parts_to_delay_insert` and `parts_to_throw_insert` will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.
- `max_bytes_to_merge_at_max_space_in_pool` (Number) The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available. max_bytes_to_merge_at_max_space_in_pool -- roughly corresponds to the maximum possible part size created by an automatic background merge.
- `max_bytes_to_merge_at_min_space_in_pool` (Number) Max bytes to merge at min space in pool: Maximum total size of a data part to merge when the number of free threads in the background pool is minimum.
- `max_cleanup_delay_period` (Number) Maximum period to clean old queue logs, blocks hashes and parts. Default value: 300 seconds.
- `max_merge_selecting_sleep_ms` (Number) Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters. Default value: 60000 milliseconds (60 seconds).
- `max_number_of_merges_with_ttl_in_pool` (Number) When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
- `max_parts_in_total` (Number) Maximum number of parts in all partitions.
- `max_replicated_merges_in_queue` (Number) Max replicated merges in queue: Maximum number of merge tasks that can be in the ReplicatedMergeTree queue at the same time.
- `merge_max_block_size` (Number) The number of rows that are read from the merged parts into memory. Default value: 8192.
- `merge_selecting_sleep_ms` (Number) Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters.
- `merge_with_recompression_ttl_timeout` (Number) Minimum delay in seconds before repeating a merge with recompression TTL. Default value: 14400 seconds (4 hours).
- `merge_with_ttl_timeout` (Number) Minimum delay in seconds before repeating a merge with delete TTL. Default value: 14400 seconds (4 hours).
- `min_age_to_force_merge_on_partition_only` (Boolean) Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset.
- `min_age_to_force_merge_seconds` (Number) Merge parts if every part in the range is older than the value of `min_age_to_force_merge_seconds`.
- `min_bytes_for_wide_part` (Number) Minimum number of bytes in a data part that can be stored in Wide format. You can set one, both or none of these settings.
- `min_rows_for_wide_part` (Number) Minimum number of rows in a data part that can be stored in Wide format. You can set one, both or none of these settings.
- `number_of_free_entries_in_pool_to_execute_mutation` (Number) When there is less than specified number of free entries in pool, do not execute part mutations. This is to leave free threads for regular merges and avoid `Too many parts`. Default value: 20.
- `number_of_free_entries_in_pool_to_lower_max_size_of_merge` (Number) Number of free entries in pool to lower max size of merge: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, ClickHouse reduces the maximum size of a data part to merge. This helps handle small merges faster, rather than filling the pool with lengthy merges.
- `parts_to_delay_insert` (Number) Parts to delay insert: Number of active data parts in a table, on exceeding which ClickHouse starts artificially reduce the rate of inserting data into the table
- `parts_to_throw_insert` (Number) Parts to throw insert: Threshold value of active data parts in a table, on exceeding which ClickHouse throws the 'Too many parts ...' exception.
- `replicated_deduplication_window` (Number) Replicated deduplication window: Number of recent hash blocks that ZooKeeper will store (the old ones will be deleted).
- `replicated_deduplication_window_seconds` (Number) Replicated deduplication window seconds: Time during which ZooKeeper stores the hash blocks (the old ones wil be deleted).
- `ttl_only_drop_parts` (Boolean) Enables zero-copy replication when a replica is located on a remote filesystem.


<a id="nestedblock--clickhouse--config--query_cache"></a>
### Nested Schema for `clickhouse.config.query_cache`

Optional:

- `max_entries` (Number) The maximum number of SELECT query results stored in the cache. Default value: 1024.
- `max_entry_size_in_bytes` (Number) The maximum size in bytes SELECT query results may have to be saved in the cache. Default value: 1048576 (1 MiB).
- `max_entry_size_in_rows` (Number) The maximum number of rows SELECT query results may have to be saved in the cache. Default value: 30000000 (30 mil).
- `max_size_in_bytes` (Number) The maximum cache size in bytes. 0 means the query cache is disabled. Default value: 1073741824 (1 GiB).


<a id="nestedblock--clickhouse--config--query_masking_rules"></a>
### Nested Schema for `clickhouse.config.query_masking_rules`

Required:

- `regexp` (String) RE2 compatible regular expression.

Optional:

- `name` (String) Name for the rule.
- `replace` (String) Substitution string for sensitive data. Default value: six asterisks.


<a id="nestedblock--clickhouse--config--rabbitmq"></a>
### Nested Schema for `clickhouse.config.rabbitmq`

Optional:

- `password` (String, Sensitive) RabbitMQ user password.
- `username` (String) RabbitMQ username.
- `vhost` (String) RabbitMQ vhost. Default: `\`.



<a id="nestedblock--clickhouse--resources"></a>
### Nested Schema for `clickhouse.resources`

Optional:

- `disk_size` (Number) Volume of the storage available to a ClickHouse host, in gigabytes.
- `disk_type_id` (String) Type of the storage of ClickHouse hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
- `resource_preset_id` (String) The ID of the preset for computational resources available to a ClickHouse host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).



<a id="nestedblock--cloud_storage"></a>
### Nested Schema for `cloud_storage`

Required:

- `enabled` (Boolean) Whether to use Yandex Object Storage for storing ClickHouse data. Can be either `true` or `false`.

Optional:

- `data_cache_enabled` (Boolean) Enables temporary storage in the cluster repository of data requested from the object repository.
- `data_cache_max_size` (Number) Defines the maximum amount of memory (in bytes) allocated in the cluster storage for temporary storage of data requested from the object storage.
- `move_factor` (Number) Sets the minimum free space ratio in the cluster storage. If the free space is lower than this value, the data is transferred to Yandex Object Storage. Acceptable values are 0 to 1, inclusive.
- `prefer_not_to_merge` (Boolean) Disables merging of data parts in `Yandex Object Storage`.


<a id="nestedblock--database"></a>
### Nested Schema for `database`

Required:

- `name` (String) The name of the database.


<a id="nestedblock--format_schema"></a>
### Nested Schema for `format_schema`

Required:

- `name` (String) The name of the format schema.
- `type` (String) Type of the format schema.
- `uri` (String) Format schema file URL. You can only use format schemas stored in Yandex Object Storage.


<a id="nestedblock--maintenance_window"></a>
### Nested Schema for `maintenance_window`

Required:

- `type` (String) Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.

Optional:

- `day` (String) Day of week for maintenance window if window type is weekly. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
- `hour` (Number) Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.


<a id="nestedblock--ml_model"></a>
### Nested Schema for `ml_model`

Required:

- `name` (String) The name of the ml model.
- `type` (String) Type of the model.
- `uri` (String) Model file URL. You can only use models stored in Yandex Object Storage.


<a id="nestedblock--shard"></a>
### Nested Schema for `shard`

Required:

- `name` (String) The name of shard.

Optional:

- `resources` (Block List, Max: 1) Resources allocated to host of the shard. The resources specified for the shard takes precedence over the resources specified for the cluster. (see [below for nested schema](#nestedblock--shard--resources))
- `weight` (Number) The weight of shard.

<a id="nestedblock--shard--resources"></a>
### Nested Schema for `shard.resources`

Optional:

- `disk_size` (Number) Volume of the storage available to a ClickHouse host, in gigabytes.
- `disk_type_id` (String) Type of the storage of ClickHouse hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
- `resource_preset_id` (String) The ID of the preset for computational resources available to a ClickHouse host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).



<a id="nestedblock--shard_group"></a>
### Nested Schema for `shard_group`

Required:

- `name` (String) The name of the shard group, used as cluster name in Distributed tables.
- `shard_names` (List of String) List of shards names that belong to the shard group.

Optional:

- `description` (String) Description of the shard group.


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `delete` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
- `update` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


<a id="nestedblock--user"></a>
### Nested Schema for `user`

Required:

- `name` (String) The name of the user.

Optional:

- `generate_password` (Boolean) Generate password using Connection Manager. Allowed values: `true` or `false`. It's used only during user creation and is ignored during updating.

{% note warning %}

**Must specify either password or generate_password**.

{% endnote %}

- `password` (String, Sensitive) The password of the user.
- `permission` (Block Set) Set of permissions granted to the user. (see [below for nested schema](#nestedblock--user--permission))
- `quota` (Block Set) Set of user quotas. (see [below for nested schema](#nestedblock--user--quota))
- `settings` (Block List, Max: 1) Custom settings for user. (see [below for nested schema](#nestedblock--user--settings))

Read-Only:

- `connection_manager` (Map of String) Connection Manager connection configuration. Filled in by the server automatically.

<a id="nestedblock--user--permission"></a>
### Nested Schema for `user.permission`

Required:

- `database_name` (String) The name of the database that the permission grants access to.


<a id="nestedblock--user--quota"></a>
### Nested Schema for `user.quota`

Required:

- `interval_duration` (Number) Duration of interval for quota in milliseconds.

Optional:

- `errors` (Number) The number of queries that threw exception.
- `execution_time` (Number) The total query execution time, in milliseconds (wall time).
- `queries` (Number) The total number of queries.
- `read_rows` (Number) The total number of source rows read from tables for running the query, on all remote servers.
- `result_rows` (Number) The total number of rows given as the result.


<a id="nestedblock--user--settings"></a>
### Nested Schema for `user.settings`

Optional:

- `add_http_cors_header` (Boolean) Include CORS headers in HTTP responses.
- `allow_ddl` (Boolean) Allows or denies DDL queries.
- `allow_introspection_functions` (Boolean) Enables introspections functions for query profiling.
- `allow_suspicious_low_cardinality_types` (Boolean) Allows specifying LowCardinality modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.
- `any_join_distinct_right_table_keys` (Boolean) Enables legacy ClickHouse server behavior in ANY INNER|LEFT JOIN operations.
- `async_insert` (Boolean) Enables asynchronous inserts. Disabled by default.
- `async_insert_busy_timeout` (Number) The maximum timeout in milliseconds since the first INSERT query before inserting collected data. If the parameter is set to 0, the timeout is disabled. Default value: 200.
- `async_insert_max_data_size` (Number) The maximum size of the unparsed data in bytes collected per query before being inserted. If the parameter is set to 0, asynchronous insertions are disabled. Default value: 100000.
- `async_insert_stale_timeout` (Number) The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the async_insert_busy_timeout with every INSERT query as long as async_insert_max_data_size is not exceeded.
- `async_insert_threads` (Number) The maximum number of threads for background data parsing and insertion. If the parameter is set to 0, asynchronous insertions are disabled. Default value: 16.
- `async_insert_use_adaptive_busy_timeout` (Boolean) If it is set to true, use adaptive busy timeout for asynchronous inserts.
- `cancel_http_readonly_queries_on_client_close` (Boolean) Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response. Default value: false.
- `compile` (Boolean) Enable compilation of queries.
- `compile_expressions` (Boolean) Turn on expression compilation.
- `connect_timeout` (Number) Connect timeout in milliseconds on the socket used for communicating with the client.
- `connect_timeout_with_failover` (Number) The timeout in milliseconds for connecting to a remote server for a Distributed table engine, if the ‘shard’ and ‘replica’ sections are used in the cluster definition. If unsuccessful, several attempts are made to connect to various replicas. Default value: 50.
- `count_distinct_implementation` (String) Specifies which of the uniq* functions should be used to perform the COUNT(DISTINCT …) construction.
- `data_type_default_nullable` (Boolean) Allows data types without explicit modifiers NULL or NOT NULL in column definition will be Nullable.
- `date_time_input_format` (String) Allows choosing a parser of the text representation of date and time, one of: `best_effort`, `basic`, `best_effort_us`. Default value: `basic`. Cloud default value: `best_effort`.
- `date_time_output_format` (String) Allows choosing different output formats of the text representation of date and time, one of: `simple`, `iso`, `unix_timestamp`. Default value: `simple`.
- `deduplicate_blocks_in_dependent_materialized_views` (Boolean) Enables or disables the deduplication check for materialized views that receive data from `Replicated` tables.
- `distinct_overflow_mode` (String) Sets behavior on overflow when using DISTINCT. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `distributed_aggregation_memory_efficient` (Boolean) Determine the behavior of distributed subqueries.
- `distributed_ddl_task_timeout` (Number) Timeout for DDL queries, in milliseconds.
- `distributed_product_mode` (String) Changes the behavior of distributed subqueries.
- `do_not_merge_across_partitions_select_final` (Boolean) Enable or disable independent processing of partitions for **SELECT** queries with **FINAL**.
- `empty_result_for_aggregation_by_empty_set` (Boolean) Allows to return empty result.
- `enable_analyzer` (Boolean) Enable new query analyzer.
- `enable_http_compression` (Boolean) Enables or disables data compression in the response to an HTTP request.
- `enable_reads_from_query_cache` (Boolean) If turned on, results of SELECT queries are retrieved from the query cache.
- `enable_writes_to_query_cache` (Boolean) If turned on, results of SELECT queries are stored in the query cache.
- `fallback_to_stale_replicas_for_distributed_queries` (Boolean) Forces a query to an out-of-date replica if updated data is not available.
- `flatten_nested` (Boolean) Sets the data format of a nested columns.
- `force_index_by_date` (Boolean) Disables query execution if the index can’t be used by date.
- `force_primary_key` (Boolean) Disables query execution if indexing by the primary key is not possible.
- `format_avro_schema_registry_url` (String) Avro schema registry URL.
- `format_regexp` (String) Regular expression (for Regexp format).
- `format_regexp_skip_unmatched` (Boolean) Skip lines unmatched by regular expression.
- `group_by_overflow_mode` (String) Sets behavior on overflow while GROUP BY operation. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
* `any` - perform approximate GROUP BY operation by continuing aggregation for the keys that got into the set, but don’t add new keys to the set.
- `group_by_two_level_threshold` (Number) Sets the threshold of the number of keys, after that the two-level aggregation should be used.
- `group_by_two_level_threshold_bytes` (Number) Sets the threshold of the number of bytes, after that the two-level aggregation should be used.
- `hedged_connection_timeout_ms` (Number) Connection timeout for establishing connection with replica for Hedged requests. Default value: 50 milliseconds.
- `http_connection_timeout` (Number) Timeout for HTTP connection in milliseconds.
- `http_headers_progress_interval` (Number) Sets minimal interval between notifications about request process in HTTP header X-ClickHouse-Progress.
- `http_max_field_name_size` (Number) Maximum length of field name in HTTP header.
- `http_max_field_value_size` (Number) Maximum length of field value in HTTP header.
- `http_receive_timeout` (Number) Timeout for HTTP connection in milliseconds.
- `http_send_timeout` (Number) Timeout for HTTP connection in milliseconds.
- `idle_connection_timeout` (Number) Timeout to close idle TCP connections after specified number of seconds. Default value: 3600 seconds.
- `ignore_materialized_views_with_dropped_target_table` (Boolean) Ignore materialized views with dropped target table during pushing to views.
- `input_format_defaults_for_omitted_fields` (Boolean) When performing INSERT queries, replace omitted input column values with default values of the respective columns.
- `input_format_import_nested_json` (Boolean) Enables or disables the insertion of JSON data with nested objects.
- `input_format_null_as_default` (Boolean) Enables or disables the initialization of NULL fields with default values, if data type of these fields is not nullable.
- `input_format_parallel_parsing` (Boolean) Enables or disables order-preserving parallel parsing of data formats. Supported only for TSV, TKSV, CSV and JSONEachRow formats.
- `input_format_values_interpret_expressions` (Boolean) Enables or disables the full SQL parser if the fast stream parser can’t parse the data.
- `input_format_with_names_use_header` (Boolean) Enables or disables checking the column order when inserting data.
- `insert_keeper_max_retries` (Number) The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries.
- `insert_null_as_default` (Boolean) Enables the insertion of default values instead of NULL into columns with not nullable data type. Default value: true.
- `insert_quorum` (Number) Enables the quorum writes.
- `insert_quorum_parallel` (Boolean) Enables or disables parallelism for quorum INSERT queries.
- `insert_quorum_timeout` (Number) Write to a quorum timeout in milliseconds.
- `join_algorithm` (List of String) Specifies which JOIN algorithm is used. Possible values:
* `hash` - hash join algorithm is used. The most generic implementation that supports all combinations of kind and strictness and multiple join keys that are combined with OR in the JOIN ON section.
* `parallel_hash` - a variation of hash join that splits the data into buckets and builds several hash tables instead of one concurrently to speed up this process.
* `partial_merge` - a variation of the sort-merge algorithm, where only the right table is fully sorted.
* `direct` - this algorithm can be applied when the storage for the right table supports key-value requests.
* `auto` - when set to auto, hash join is tried first, and the algorithm is switched on the fly to another algorithm if the memory limit is violated.
* `full_sorting_merge` - sort-merge algorithm with full sorting joined tables before joining.
* `prefer_partial_merge` - clickHouse always tries to use partial_merge join if possible, otherwise, it uses hash. Deprecated, same as partial_merge,hash.
- `join_overflow_mode` (String) Sets behavior on overflow in JOIN. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `join_use_nulls` (Boolean) Sets the type of JOIN behavior. When merging tables, empty cells may appear. ClickHouse fills them differently based on this setting.
- `joined_subquery_requires_alias` (Boolean) Require aliases for subselects and table functions in FROM that more than one table is present.
- `load_balancing` (String) Specifies the algorithm of replicas selection that is used for distributed query processing, one of: random, nearest_hostname, in_order, first_or_random, round_robin. Default value: random.
- `local_filesystem_read_method` (String) Method of reading data from local filesystem. Possible values:
* `read` - abort query execution, return an error.
* `pread` - abort query execution, return an error.
* `pread_threadpool` - stop query execution, return partial result. If the parameter is set to 0 (default), no hops is allowed.
- `log_processors_profiles` (Boolean) Enabled or disable logging of processors level profiling data to the the system.log_processors_profiles table.
- `log_queries_probability` (Number) Log queries with the specified probability.
- `log_query_threads` (Boolean) Setting up query threads logging. Query threads log into the system.query_thread_log table. This setting has effect only when log_queries is true. Queries’ threads run by ClickHouse with this setup are logged according to the rules in the query_thread_log server configuration parameter. Default value: `true`.
- `log_query_views` (Boolean) Enables or disables query views logging to the the system.query_views_log table.
- `low_cardinality_allow_in_native_format` (Boolean) Allows or restricts using the LowCardinality data type with the Native format.
- `max_ast_depth` (Number) Maximum abstract syntax tree depth.
- `max_ast_elements` (Number) Maximum abstract syntax tree elements.
- `max_block_size` (Number) A recommendation for what size of the block (in a count of rows) to load from tables.
- `max_bytes_before_external_group_by` (Number) Limit in bytes for using memory for GROUP BY before using swap on disk.
- `max_bytes_before_external_sort` (Number) This setting is equivalent of the max_bytes_before_external_group_by setting, except for it is for sort operation (ORDER BY), not aggregation.
- `max_bytes_in_distinct` (Number) Limits the maximum size of a hash table in bytes (uncompressed data) when using DISTINCT.
- `max_bytes_in_join` (Number) Limit on maximum size of the hash table for JOIN, in bytes.
- `max_bytes_in_set` (Number) Limit on the number of bytes in the set resulting from the execution of the IN section.
- `max_bytes_to_read` (Number) Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.
- `max_bytes_to_sort` (Number) Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting.
- `max_bytes_to_transfer` (Number) Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.
- `max_columns_to_read` (Number) Limits the maximum number of columns that can be read from a table in a single query.
- `max_concurrent_queries_for_user` (Number) The maximum number of concurrent requests per user. Default value: 0 (no limit).
- `max_execution_time` (Number) Limits the maximum query execution time in milliseconds.
- `max_expanded_ast_elements` (Number) Maximum abstract syntax tree depth after after expansion of aliases.
- `max_final_threads` (Number) Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier.
- `max_http_get_redirects` (Number) Limits the maximum number of HTTP GET redirect hops for URL-engine tables.
- `max_insert_block_size` (Number) The size of blocks (in a count of rows) to form for insertion into a table.
- `max_insert_threads` (Number) The maximum number of threads to execute the INSERT SELECT query. Default value: 0.
- `max_memory_usage` (Number) Limits the maximum memory usage (in bytes) for processing queries on a single server.
- `max_memory_usage_for_user` (Number) Limits the maximum memory usage (in bytes) for processing of user's queries on a single server.
- `max_network_bandwidth` (Number) Limits the speed of the data exchange over the network in bytes per second.
- `max_network_bandwidth_for_user` (Number) Limits the speed of the data exchange over the network in bytes per second.
- `max_parser_depth` (Number) Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. Zero means unlimited.
- `max_query_size` (Number) The maximum part of a query that can be taken to RAM for parsing with the SQL parser.
- `max_read_buffer_size` (Number) The maximum size of the buffer to read from the filesystem.
- `max_replica_delay_for_distributed_queries` (Number) Disables lagging replicas for distributed queries.
- `max_result_bytes` (Number) Limits the number of bytes in the result.
- `max_result_rows` (Number) Limits the number of rows in the result.
- `max_rows_in_distinct` (Number) Limits the maximum number of different rows when using DISTINCT.
- `max_rows_in_join` (Number) Limit on maximum size of the hash table for JOIN, in rows.
- `max_rows_in_set` (Number) Limit on the number of rows in the set resulting from the execution of the IN section.
- `max_rows_to_group_by` (Number) Limits the maximum number of unique keys received from aggregation function.
- `max_rows_to_read` (Number) Limits the maximum number of rows that can be read from a table when running a query.
- `max_rows_to_sort` (Number) Limits the maximum number of rows that can be read from a table for sorting.
- `max_rows_to_transfer` (Number) Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.
- `max_temporary_columns` (Number) Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.
- `max_temporary_data_on_disk_size_for_query` (Number) The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited.
- `max_temporary_data_on_disk_size_for_user` (Number) The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited.
- `max_temporary_non_const_columns` (Number) Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.
- `max_threads` (Number) The maximum number of query processing threads, excluding threads for retrieving data from remote servers.
- `memory_overcommit_ratio_denominator` (Number) It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
- `memory_overcommit_ratio_denominator_for_user` (Number) It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
- `memory_profiler_sample_probability` (Number) Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation. Possible values: from 0 to 1. Default: 0.
- `memory_profiler_step` (Number) Memory profiler step (in bytes). If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing. Default value: 4194304 (4 MB). Zero means disabled memory profiler.
- `memory_usage_overcommit_max_wait_microseconds` (Number) Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown.
- `merge_tree_max_bytes_to_use_cache` (Number) If ClickHouse should read more than merge_tree_max_bytes_to_use_cache bytes in one query, it doesn’t use the cache of uncompressed blocks.
- `merge_tree_max_rows_to_use_cache` (Number) If ClickHouse should read more than merge_tree_max_rows_to_use_cache rows in one query, it doesn’t use the cache of uncompressed blocks.
- `merge_tree_min_bytes_for_concurrent_read` (Number) If the number of bytes to read from one file of a MergeTree-engine table exceeds merge_tree_min_bytes_for_concurrent_read, then ClickHouse tries to concurrently read from this file in several threads.
- `merge_tree_min_rows_for_concurrent_read` (Number) If the number of rows to be read from a file of a MergeTree table exceeds merge_tree_min_rows_for_concurrent_read then ClickHouse tries to perform a concurrent reading from this file on several threads.
- `min_bytes_to_use_direct_io` (Number) The minimum data volume required for using direct I/O access to the storage disk.
- `min_count_to_compile` (Number) How many times to potentially use a compiled chunk of code before running compilation.
- `min_count_to_compile_expression` (Number) A query waits for expression compilation process to complete prior to continuing execution.
- `min_execution_speed` (Number) Minimal execution speed in rows per second.
- `min_execution_speed_bytes` (Number) Minimal execution speed in bytes per second.
- `min_insert_block_size_bytes` (Number) Sets the minimum number of bytes in the block which can be inserted into a table by an INSERT query.
- `min_insert_block_size_rows` (Number) Sets the minimum number of rows in the block which can be inserted into a table by an INSERT query.
- `output_format_json_quote_64bit_integers` (Boolean) If the value is true, integers appear in quotes when using JSON* Int64 and UInt64 formats (for compatibility with most JavaScript implementations); otherwise, integers are output without the quotes.
- `output_format_json_quote_denormals` (Boolean) Enables +nan, -nan, +inf, -inf outputs in JSON output format.
- `prefer_localhost_replica` (Boolean) Enables/disables preferable using the localhost replica when processing distributed queries. Default value: true.
- `priority` (Number) Query priority.
- `query_cache_max_entries` (Number) The maximum number of query results the current user may store in the query cache. 0 means unlimited.
- `query_cache_max_size_in_bytes` (Number) The maximum amount of memory (in bytes) the current user may allocate in the query cache. 0 means unlimited.
- `query_cache_min_query_duration` (Number) Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.
- `query_cache_min_query_runs` (Number) Minimum number of times a SELECT query must run before its result is stored in the query cache.
- `query_cache_share_between_users` (Boolean) If turned on, the result of SELECT queries cached in the query cache can be read by other users. It is not recommended to enable this setting due to security reasons.
- `query_cache_tag` (String) A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.
- `query_cache_ttl` (Number) After this time in seconds entries in the query cache become stale.
- `quota_mode` (String) Quota accounting mode.
- `read_overflow_mode` (String) Sets behavior on overflow while read. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `readonly` (Number) Restricts permissions for reading data, write data and change settings queries.
- `receive_timeout` (Number) Receive timeout in milliseconds on the socket used for communicating with the client.
- `remote_filesystem_read_method` (String) Method of reading data from remote filesystem, one of: `read`, `threadpool`.
- `replication_alter_partitions_sync` (Number) For ALTER ... ATTACH|DETACH|DROP queries, you can use the replication_alter_partitions_sync setting to set up waiting.
- `result_overflow_mode` (String) Sets behavior on overflow in result. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `s3_use_adaptive_timeouts` (Boolean) Enables or disables adaptive timeouts for S3 requests.
- `select_sequential_consistency` (Boolean) Enables or disables sequential consistency for SELECT queries.
- `send_progress_in_http_headers` (Boolean) Enables or disables `X-ClickHouse-Progress` HTTP response headers in clickhouse-server responses.
- `send_timeout` (Number) Send timeout in milliseconds on the socket used for communicating with the client.
- `set_overflow_mode` (String) Sets behavior on overflow in the set resulting. Possible values:
  * `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `skip_unavailable_shards` (Boolean) Enables or disables silently skipping of unavailable shards.
- `sort_overflow_mode` (String) Sets behavior on overflow while sort. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `timeout_before_checking_execution_speed` (Number) Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in min_execution_speed parameter. Must be at least 1000.
- `timeout_overflow_mode` (String) Sets behavior on overflow. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `transfer_overflow_mode` (String) Sets behavior on overflow. Possible values:
* `throw` - abort query execution, return an error.
* `break` - stop query execution, return partial result.
- `transform_null_in` (Boolean) Enables equality of NULL values for IN operator.
- `use_hedged_requests` (Boolean) Enables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within hedged_connection_timeout or no data was received within receive_data_timeout. Query uses the first connection which send non empty progress packet (or data packet, if allow_changing_replica_until_first_data_packet); other connections are cancelled. Queries with max_parallel_replicas > 1 are supported. Default value: true.
- `use_query_cache` (Boolean) If turned on, SELECT queries may utilize the query cache.
- `use_uncompressed_cache` (Boolean) Whether to use a cache of uncompressed blocks.
- `wait_for_async_insert` (Boolean) Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.
- `wait_for_async_insert_timeout` (Number) The timeout (in seconds) for waiting for processing of asynchronous insertion. Value must be at least 1000 (1 second).



<a id="nestedblock--zookeeper"></a>
### Nested Schema for `zookeeper`

Optional:

- `resources` (Block List, Max: 1) Resources allocated to hosts of the ZooKeeper subcluster. (see [below for nested schema](#nestedblock--zookeeper--resources))

<a id="nestedblock--zookeeper--resources"></a>
### Nested Schema for `zookeeper.resources`

Optional:

- `disk_size` (Number) Volume of the storage available to a ZooKeeper host, in gigabytes.
- `disk_type_id` (String) Type of the storage of ZooKeeper hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
- `resource_preset_id` (String) The ID of the preset for computational resources available to a ZooKeeper host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts).

## Import

The resource can be imported by using their `resource ID`. For getting the resource ID you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or [YC CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_clickhouse_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_clickhouse_cluster.my_cluster ...
```
