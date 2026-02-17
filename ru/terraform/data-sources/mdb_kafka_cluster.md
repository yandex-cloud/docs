---
subcategory: Managed Service for Apache Kafka®
---

# yandex_mdb_kafka_cluster (DataSource)

Get information about a Yandex Managed Kafka cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).

{% note warning %}

Either `cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing MDB Kafka Cluster.
//
data "yandex_mdb_kafka_cluster" "my_cluster" {
  name = "test"
}

output "network_id" {
  value = data.yandex_mdb_kafka_cluster.my_cluster.network_id
}
```

## Arguments & Attributes Reference

- `cluster_id` (String). The ID of the Kafka cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key to encrypt cluster disks.
- `environment` (String). Deployment environment of the Kafka cluster. Can be either `PRESTABLE` or `PRODUCTION`. The default is `PRODUCTION`.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster. Can be either `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-kafka/api-ref/Cluster/).
- `host` (*Read-Only*) (Set Of Object). A host of the Kafka cluster.
  - `assign_public_ip` . 
  - `health` . 
  - `name` . 
  - `role` . 
  - `subnet_id` . 
  - `zone_id` . 
- `host_group_ids` (Set Of String). A list of IDs of the host groups to place VMs of the cluster on.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance policy of the Kafka cluster.
  - `day` (String). Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
  - `hour` (Number). Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster. Can be either `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-kafka/api-ref/Cluster/).
- `subnet_ids` (List Of String). The list of VPC subnets identifiers which resource is attached.
- `config` [Block]. Configuration of the Kafka cluster.
  - `assign_public_ip` (Bool). Determines whether each broker will be assigned a public IP address. The default is `false`.
  - `brokers_count` (Number). Count of brokers per availability zone. The default is `1`.
  - `patch_version` (*Read-Only*) (String). Patch version of the Kafka server software.
  - `schema_registry` (Bool). Enables managed schema registry on cluster. The default is `false`.
  - `unmanaged_topics` (Bool). 
  - `version` (**Required**)(String). Version of the Kafka server software.
  - `zones` (**Required**)(List Of String). List of availability zones.
  - `access` [Block]. Access policy to the Kafka cluster.
    - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
  - `disk_size_autoscaling` [Block]. Disk autoscaling settings of the Kafka cluster.
    - `disk_size_limit` (**Required**)(Number). Maximum possible size of disk in bytes.
    - `emergency_usage_threshold` (Number). Percent of disk utilization. Disk will autoscale immediately, if this threshold reached. Value is between 0 and 100. Default value is 0 (autoscaling disabled). Must be not less then 'planned_usage_threshold' value.
    - `planned_usage_threshold` (Number). Percent of disk utilization. During maintenance disk will autoscale, if this threshold reached. Value is between 0 and 100. Default value is 0 (autoscaling disabled).
  - `kafka` [Block]. Configuration of the Kafka subcluster.
    - `kafka_config` [Block]. User-defined settings for the Kafka cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/operations/cluster-update) and [the Kafka documentation](https://kafka.apache.org/documentation/#configuration).
      - `auto_create_topics_enable` (Bool). Enable auto creation of topic on the server.
      - `compression_type` (String). Compression type of kafka topics.
      - `default_replication_factor` (String). The replication factor for automatically created topics, and for topics created with -1 as the replication factor.
      - `log_flush_interval_messages` (String). The number of messages accumulated on a log partition before messages are flushed to disk.
      - `log_flush_interval_ms` (String). The maximum time in ms that a message in any topic is kept in memory before flushed to disk. If not set, the value in log.flush.scheduler.interval.ms is used.
      - `log_flush_scheduler_interval_ms` (String). The frequency in ms that the log flusher checks whether any log needs to be flushed to disk.
      - `log_preallocate` (Bool). Should pre allocate file when create new segment?
      - `log_retention_bytes` (String). The maximum size of the log before deleting it.
      - `log_retention_hours` (String). The number of hours to keep a log file before deleting it (in hours), tertiary to log.retention.ms property.
      - `log_retention_minutes` (String). The number of minutes to keep a log file before deleting it (in minutes), secondary to log.retention.ms property. If not set, the value in log.retention.hours is used.
      - `log_retention_ms` (String). The number of milliseconds to keep a log file before deleting it (in milliseconds), If not set, the value in log.retention.minutes is used. If set to -1, no time limit is applied.
      - `log_segment_bytes` (String). The maximum size of a single log file.
      - `message_max_bytes` (String). The largest record batch size allowed by Kafka (after compression if compression is enabled).
      - `num_partitions` (String). The default number of log partitions per topic.
      - `offsets_retention_minutes` (String). For subscribed consumers, committed offset of a specific partition will be expired and discarded after this period of time.
      - `replica_fetch_max_bytes` (String). The number of bytes of messages to attempt to fetch for each partition.
      - `sasl_enabled_mechanisms` (Set Of String). The list of SASL mechanisms enabled in the Kafka server.
      - `socket_receive_buffer_bytes` (String). The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      - `socket_send_buffer_bytes` (String). The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      - `ssl_cipher_suites` (Set Of String). A list of cipher suites.
    - `resources` [Block]. Resources allocated to hosts of the Kafka subcluster.
      - `disk_size` (**Required**)(Number). Volume of the storage available to a Kafka host, in gigabytes.
      - `disk_type_id` (**Required**)(String). Type of the storage of Kafka hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts/storage).
      - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a Kafka host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).
  - `kafka_ui` [Block]. KAFKA UI settings of the Kafka cluster.
    - `enabled` (Bool). Enables KAFKA UI on cluster. The default is `false`.
  - `kraft` [Block]. Configuration of the KRaft-controller subcluster.
    - `resources` [Block]. Resources allocated to hosts of the KRaft-controller subcluster.
      - `disk_size` (Number). Volume of the storage available to a KRaft-controller host, in gigabytes.
      - `disk_type_id` (String). Type of the storage of KRaft-controller hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts/storage).
      - `resource_preset_id` (String). The ID of the preset for computational resources available to a KRaft-controller host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).
  - `rest_api` [Block]. REST API settings of the Kafka cluster.
    - `enabled` (Bool). Enables REST API on cluster. The default is `false`.
  - `zookeeper` [Block]. Configuration of the ZooKeeper subcluster.
    - `resources` [Block]. Resources allocated to hosts of the ZooKeeper subcluster.
      - `disk_size` (Number). Volume of the storage available to a ZooKeeper host, in gigabytes.
      - `disk_type_id` (String). Type of the storage of ZooKeeper hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts/storage).
      - `resource_preset_id` (String). The ID of the preset for computational resources available to a ZooKeeper host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).
- `topic` [Block]. To manage topics, please switch to using a separate resource type `yandex_mdb_kafka_topic`.
  - `name` (**Required**)(String). The name of the topic.
  - `partitions` (**Required**)(Number). The number of the topic's partitions.
  - `replication_factor` (**Required**)(Number). Amount of data copies (replicas) for the topic in the cluster.
  - `topic_config` [Block]. User-defined settings for the topic. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/operations/cluster-topics#update-topic) and [the Kafka documentation](https://kafka.apache.org/documentation/#configuration).
    - `cleanup_policy` (String). Retention policy to use on log segments.
    - `compression_type` (String). Compression type of kafka topic.
    - `delete_retention_ms` (String). The amount of time to retain delete tombstone markers for log compacted topics.
    - `file_delete_delay_ms` (String). The time to wait before deleting a file from the filesystem.
    - `flush_messages` (String). This setting allows specifying an interval at which we will force an fsync of data written to the log.
    - `flush_ms` (String). This setting allows specifying a time interval at which we will force an fsync of data written to the log.
    - `max_message_bytes` (String). The largest record batch size allowed by Kafka (after compression if compression is enabled).
    - `message_timestamp_type` (String). Define whether the timestamp in the message is message create time or log append time. Possible values: LOG_APPEND_TIME or CREATE_TIME.
    - `min_compaction_lag_ms` (String). The minimum time a message will remain uncompacted in the log. Only applicable for logs that are being compacted.
    - `min_insync_replicas` (String). When a producer sets acks to "all" (or "-1"), this configuration specifies the minimum number of replicas that must acknowledge a write for the write to be considered successful. 
    - `preallocate` (Bool). True if we should preallocate the file on disk when creating a new log segment.
    - `retention_bytes` (String). This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy.
    - `retention_ms` (String). This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy.
    - `segment_bytes` (String). This configuration controls the segment file size for the log.
- `user` [Block]. To manage users, please switch to using a separate resource type `yandex_mdb_kafka_user`.
  - `name` (**Required**)(String). The name of the user.
  - `password` (**Required**)(String). The password of the user.
  - `permission` [Block]. Set of permissions granted to the user.
    - `allow_hosts` (Set Of String). Set of hosts, to which this permission grants access to. Only ip-addresses allowed as value of single host.
    - `role` (**Required**)(String). The role type to grant to the topic.
    - `topic_name` (**Required**)(String). The name of the topic that the permission grants access to.


