---
editable: false
noIndex: true
---

# yc beta managed-kafka cluster create

Creates a new Apache Kafka® cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-kafka cluster create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--config-spec` | `shorthand/json`

Kafka and hosts configuration the Apache Kafka® cluster.

Shorthand Syntax:

```hcl
{
  access = {
    data-transfer = boolean
  },
  assign-public-ip = boolean,
  brokers-count = integer,
  disk-size-autoscaling = {
    disk-size-limit = integer,
    emergency-usage-threshold = integer,
    planned-usage-threshold = integer
  },
  kafka = {
    kafka-config = kafka-config-2-8={
      auto-create-topics-enable = boolean,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      default-replication-factor = integer,
      log-flush-interval-messages = integer,
      log-flush-interval-ms = integer,
      log-flush-scheduler-interval-ms = integer,
      log-preallocate = boolean,
      log-retention-bytes = integer,
      log-retention-hours = integer,
      log-retention-minutes = integer,
      log-retention-ms = integer,
      log-segment-bytes = integer,
      message-max-bytes = integer,
      num-partitions = integer,
      offsets-retention-minutes = integer,
      replica-fetch-max-bytes = integer,
      sasl-enabled-mechanisms = [
        SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512, ...
      ],
      socket-receive-buffer-bytes = integer,
      socket-send-buffer-bytes = integer,
      ssl-cipher-suites = string,...
    } | kafka-config-3={
      auto-create-topics-enable = boolean,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      default-replication-factor = integer,
      log-flush-interval-messages = integer,
      log-flush-interval-ms = integer,
      log-flush-scheduler-interval-ms = integer,
      log-preallocate = boolean,
      log-retention-bytes = integer,
      log-retention-hours = integer,
      log-retention-minutes = integer,
      log-retention-ms = integer,
      log-segment-bytes = integer,
      message-max-bytes = integer,
      num-partitions = integer,
      offsets-retention-minutes = integer,
      replica-fetch-max-bytes = integer,
      sasl-enabled-mechanisms = [
        SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512, ...
      ],
      socket-receive-buffer-bytes = integer,
      socket-send-buffer-bytes = integer,
      ssl-cipher-suites = string,...
    } | kafka-config-4={
      auto-create-topics-enable = boolean,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      default-replication-factor = integer,
      log-flush-interval-messages = integer,
      log-flush-interval-ms = integer,
      log-flush-scheduler-interval-ms = integer,
      log-retention-bytes = integer,
      log-retention-hours = integer,
      log-retention-minutes = integer,
      log-retention-ms = integer,
      log-segment-bytes = integer,
      message-max-bytes = integer,
      num-partitions = integer,
      offsets-retention-minutes = integer,
      replica-fetch-max-bytes = integer,
      sasl-enabled-mechanisms = [
        SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512, ...
      ],
      socket-receive-buffer-bytes = integer,
      socket-send-buffer-bytes = integer,
      ssl-cipher-suites = string,...
    },
    resources = {
      disk-size = integer,
      disk-type-id = string,
      resource-preset-id = string
    }
  },
  kafka-ui-config = {
    enabled = boolean
  },
  kraft = {
    resources = {
      disk-size = integer,
      disk-type-id = string,
      resource-preset-id = string
    }
  },
  patch-version = string,
  rest-api-config = {
    enabled = boolean
  },
  schema-registry = boolean,
  unmanaged-topics = boolean,
  version = string,
  zone-id = string,...,
  zookeeper = {
    resources = {
      disk-size = integer,
      disk-type-id = string,
      resource-preset-id = string
    }
  }
}
```

JSON Syntax:

```json
{
  "access": {
    "data-transfer": "boolean"
  },
  "assign-public-ip": "boolean",
  "brokers-count": "integer",
  "disk-size-autoscaling": {
    "disk-size-limit": "integer",
    "emergency-usage-threshold": "integer",
    "planned-usage-threshold": "integer"
  },
  "kafka": {
    "kafka-config": {
      "kafka-config-2-8": {
        "auto-create-topics-enable": "boolean",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "default-replication-factor": "integer",
        "log-flush-interval-messages": "integer",
        "log-flush-interval-ms": "integer",
        "log-flush-scheduler-interval-ms": "integer",
        "log-preallocate": "boolean",
        "log-retention-bytes": "integer",
        "log-retention-hours": "integer",
        "log-retention-minutes": "integer",
        "log-retention-ms": "integer",
        "log-segment-bytes": "integer",
        "message-max-bytes": "integer",
        "num-partitions": "integer",
        "offsets-retention-minutes": "integer",
        "replica-fetch-max-bytes": "integer",
        "sasl-enabled-mechanisms": [
          "SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512", ...
        ],
        "socket-receive-buffer-bytes": "integer",
        "socket-send-buffer-bytes": "integer",
        "ssl-cipher-suites": [
          "string", ...
        ]
      },
      "kafka-config-3": {
        "auto-create-topics-enable": "boolean",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "default-replication-factor": "integer",
        "log-flush-interval-messages": "integer",
        "log-flush-interval-ms": "integer",
        "log-flush-scheduler-interval-ms": "integer",
        "log-preallocate": "boolean",
        "log-retention-bytes": "integer",
        "log-retention-hours": "integer",
        "log-retention-minutes": "integer",
        "log-retention-ms": "integer",
        "log-segment-bytes": "integer",
        "message-max-bytes": "integer",
        "num-partitions": "integer",
        "offsets-retention-minutes": "integer",
        "replica-fetch-max-bytes": "integer",
        "sasl-enabled-mechanisms": [
          "SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512", ...
        ],
        "socket-receive-buffer-bytes": "integer",
        "socket-send-buffer-bytes": "integer",
        "ssl-cipher-suites": [
          "string", ...
        ]
      },
      "kafka-config-4": {
        "auto-create-topics-enable": "boolean",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "default-replication-factor": "integer",
        "log-flush-interval-messages": "integer",
        "log-flush-interval-ms": "integer",
        "log-flush-scheduler-interval-ms": "integer",
        "log-retention-bytes": "integer",
        "log-retention-hours": "integer",
        "log-retention-minutes": "integer",
        "log-retention-ms": "integer",
        "log-segment-bytes": "integer",
        "message-max-bytes": "integer",
        "num-partitions": "integer",
        "offsets-retention-minutes": "integer",
        "replica-fetch-max-bytes": "integer",
        "sasl-enabled-mechanisms": [
          "SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512", ...
        ],
        "socket-receive-buffer-bytes": "integer",
        "socket-send-buffer-bytes": "integer",
        "ssl-cipher-suites": [
          "string", ...
        ]
      }
    },
    "resources": {
      "disk-size": "integer",
      "disk-type-id": "string",
      "resource-preset-id": "string"
    }
  },
  "kafka-ui-config": {
    "enabled": "boolean"
  },
  "kraft": {
    "resources": {
      "disk-size": "integer",
      "disk-type-id": "string",
      "resource-preset-id": "string"
    }
  },
  "patch-version": "string",
  "rest-api-config": {
    "enabled": "boolean"
  },
  "schema-registry": "boolean",
  "unmanaged-topics": "boolean",
  "version": "string",
  "zone-id": [
    "string", ...
  ],
  "zookeeper": {
    "resources": {
      "disk-size": "integer",
      "disk-type-id": "string",
      "resource-preset-id": "string"
    }
  }
}
```

Fields:

```
access -> (struct)
  Access policy for external services.
  data-transfer -> (boolean)
    Allow access for DataTransfer.
assign-public-ip -> (boolean)
  The flag that defines whether a public IP address is assigned to the cluster. If the value is 'true', then Apache Kafka® cluster is available on the Internet via it's public IP address.
brokers-count -> (integer)
  The number of Kafka brokers deployed in each availability zone.
disk-size-autoscaling -> (struct)
  DiskSizeAutoscaling settings
  disk-size-limit -> (integer)
    New storage size (in bytes) that is set when one of the thresholds is achieved.
  emergency-usage-threshold -> (integer)
    Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
  planned-usage-threshold -> (integer)
    Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
kafka -> (struct)
  Configuration and resource allocation for Kafka brokers.
  resources -> (struct)
    Resources allocated to Kafka brokers.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.
    disk-type-id -> (string)
      Type of the storage environment for the host.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
  kafka-config -> (oneof<kafka-config-2-8|kafka-config-3|kafka-config-4>)
    Oneof kafka-config field
    kafka-config-2-8 -> (struct)
      Configuration of an Apache Kafka® 2.8 broker.
      auto-create-topics-enable -> (boolean)
        Enable auto creation of topic on the server
      compression-type -> (struct)
        Cluster topics compression type.
      default-replication-factor -> (integer)
        Default replication factor of the topic on the whole cluster
      log-flush-interval-messages -> (integer)
        The number of messages accumulated on a log partition before messages are flushed to disk. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages] setting.
      log-flush-interval-ms -> (integer)
        The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of [log_flush_scheduler_interval_ms] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms] setting.
      log-flush-scheduler-interval-ms -> (integer)
        The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.
      log-preallocate -> (boolean)
        Should pre allocate file when create new segment? This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate] setting. Deprecated. Feature useless for Yandex Cloud.
      log-retention-bytes -> (integer)
        Partition size limit; Kafka will discard old log segments to free up space if 'delete' [TopicConfig2_8.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes] setting.
      log-retention-hours -> (integer)
        The number of hours to keep a log segment file before deleting it.
      log-retention-minutes -> (integer)
        The number of minutes to keep a log segment file before deleting it. If not set, the value of [log_retention_hours] is used.
      log-retention-ms -> (integer)
        The number of milliseconds to keep a log segment file before deleting it. If not set, the value of [log_retention_minutes] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms] setting.
      log-segment-bytes -> (integer)
        The maximum size of a single log file. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes] setting.
      message-max-bytes -> (integer)
        The largest record batch size allowed by Kafka. Default value: 1048588.
      num-partitions -> (integer)
        Default number of partitions per topic on the whole cluster
      offsets-retention-minutes -> (integer)
        Offset storage time after a consumer group loses all its consumers. Default: 10080.
      replica-fetch-max-bytes -> (integer)
        The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.
      sasl-enabled-mechanisms -> ([]struct)
        The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].
      socket-receive-buffer-bytes -> (integer)
        The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      socket-send-buffer-bytes -> (integer)
        The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      ssl-cipher-suites -> ([]string)
        A list of cipher suites.
    kafka-config-3 -> (struct)
      Configuration of an Apache Kafka® 3.x broker.
      auto-create-topics-enable -> (boolean)
        Enable auto creation of topic on the server
      compression-type -> (struct)
        Cluster topics compression type.
      default-replication-factor -> (integer)
        Default replication factor of the topic on the whole cluster
      log-flush-interval-messages -> (integer)
        The number of messages accumulated on a log partition before messages are flushed to disk. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages] setting.
      log-flush-interval-ms -> (integer)
        The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of [log_flush_scheduler_interval_ms] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms] setting.
      log-flush-scheduler-interval-ms -> (integer)
        The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.
      log-preallocate -> (boolean)
        Should pre allocate file when create new segment? This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate] setting. Deprecated. Feature useless for Yandex Cloud.
      log-retention-bytes -> (integer)
        Partition size limit; Kafka will discard old log segments to free up space if 'delete' [TopicConfig3.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes] setting.
      log-retention-hours -> (integer)
        The number of hours to keep a log segment file before deleting it.
      log-retention-minutes -> (integer)
        The number of minutes to keep a log segment file before deleting it. If not set, the value of [log_retention_hours] is used.
      log-retention-ms -> (integer)
        The number of milliseconds to keep a log segment file before deleting it. If not set, the value of [log_retention_minutes] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms] setting.
      log-segment-bytes -> (integer)
        The maximum size of a single log file. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes] setting.
      message-max-bytes -> (integer)
        The largest record batch size allowed by Kafka. Default value: 1048588.
      num-partitions -> (integer)
        Default number of partitions per topic on the whole cluster
      offsets-retention-minutes -> (integer)
        Offset storage time after a consumer group loses all its consumers. Default: 10080.
      replica-fetch-max-bytes -> (integer)
        The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.
      sasl-enabled-mechanisms -> ([]struct)
        The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].
      socket-receive-buffer-bytes -> (integer)
        The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      socket-send-buffer-bytes -> (integer)
        The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      ssl-cipher-suites -> ([]string)
        A list of cipher suites.
    kafka-config-4 -> (struct)
      Configuration of an Apache Kafka® 4.x broker.
      auto-create-topics-enable -> (boolean)
        Enable auto creation of topic on the server
      compression-type -> (struct)
        Cluster topics compression type.
      default-replication-factor -> (integer)
        Default replication factor of the topic on the whole cluster
      log-flush-interval-messages -> (integer)
        The number of messages accumulated on a log partition before messages are flushed to disk. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages] setting.
      log-flush-interval-ms -> (integer)
        The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of [log_flush_scheduler_interval_ms] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.flush_ms] setting.
      log-flush-scheduler-interval-ms -> (integer)
        The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.
      log-retention-bytes -> (integer)
        Partition size limit; Kafka will discard old log segments to free up space if 'delete' [TopicConfig4.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes] setting.
      log-retention-hours -> (integer)
        The number of hours to keep a log segment file before deleting it.
      log-retention-minutes -> (integer)
        The number of minutes to keep a log segment file before deleting it. If not set, the value of [log_retention_hours] is used.
      log-retention-ms -> (integer)
        The number of milliseconds to keep a log segment file before deleting it. If not set, the value of [log_retention_minutes] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.retention_ms] setting.
      log-segment-bytes -> (integer)
        The maximum size of a single log file. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.segment_bytes] setting.
      message-max-bytes -> (integer)
        The largest record batch size allowed by Kafka. Default value: 1048588.
      num-partitions -> (integer)
        Default number of partitions per topic on the whole cluster
      offsets-retention-minutes -> (integer)
        Offset storage time after a consumer group loses all its consumers. Default: 10080.
      replica-fetch-max-bytes -> (integer)
        The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.
      sasl-enabled-mechanisms -> ([]struct)
        The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].
      socket-receive-buffer-bytes -> (integer)
        The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      socket-send-buffer-bytes -> (integer)
        The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      ssl-cipher-suites -> ([]string)
        A list of cipher suites.
kafka-ui-config -> (struct)
  Configuration of Kafka UI.
  enabled -> (boolean)
    Is Kafka UI enabled for this cluster.
kraft -> (struct)
  Configuration and resource allocation for KRaft-controller hosts.
  resources -> (struct)
    Resources allocated to KRaft controller hosts.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.
    disk-type-id -> (string)
      Type of the storage environment for the host.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
patch-version -> (string)
  Patch or release version ex. 3.9.1, 4.0.1 etc
rest-api-config -> (struct)
  Configuration of REST API.
  enabled -> (boolean)
    Is REST API enabled for this cluster.
schema-registry -> (boolean)
  Enables managed schema registry on cluster
unmanaged-topics -> (boolean)
  Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently.
version -> (string)
  Version of Apache Kafka® used in the cluster. Possible values: '2.8', '3.0', '3.1', '3.2', '3.3', '3.4', '3.5', '3.6'.
zone-id -> ([]string)
  IDs of availability zones where Kafka brokers reside.
zookeeper -> (struct)
  Configuration and resource allocation for ZooKeeper hosts.
  resources -> (struct)
    Resources allocated to ZooKeeper hosts.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.
    disk-type-id -> (string)
      Type of the storage environment for the host.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the Apache Kafka® cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the Apache Kafka® cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the Apache Kafka® cluster in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--host-group-ids` | `[]string`

Host groups to place VMs of cluster on. ||
|| `--labels` | `map<string><string>`

Custom labels for the Apache Kafka® cluster as 'key:value' pairs. For example, "project": "mvp" or "source": "dictionary". ||
|| `--maintenance-window` | `shorthand/json`

Window of maintenance operations.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
  weekly-maintenance-window -> (struct)
    day -> (struct)
    hour -> (integer)
      Hour of the day in UTC.
``` ||
|| `--name` | `string`

Name of the Apache Kafka® cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the Apache Kafka® cluster in. ||
|| `--security-group-ids` | `[]string`

User security groups ||
|| `--subnet-id` | `[]string`

IDs of subnets to create brokers in. ||
|| `--topic-specs` | `shorthand/json`

One or more configurations of topics to be created in the Apache Kafka® cluster.

Shorthand Syntax:

```hcl
[
  {
    name = string,
    partitions = integer,
    replication-factor = integer,
    topic-config = topic-config-2-8={
      cleanup-policy = CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      delete-retention-ms = integer,
      file-delete-delay-ms = integer,
      flush-messages = integer,
      flush-ms = integer,
      max-message-bytes = integer,
      message-timestamp-type = MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME,
      min-compaction-lag-ms = integer,
      min-insync-replicas = integer,
      preallocate = boolean,
      retention-bytes = integer,
      retention-ms = integer,
      segment-bytes = integer
    } | topic-config-3={
      cleanup-policy = CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      delete-retention-ms = integer,
      file-delete-delay-ms = integer,
      flush-messages = integer,
      flush-ms = integer,
      max-message-bytes = integer,
      message-timestamp-type = MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME,
      min-compaction-lag-ms = integer,
      min-insync-replicas = integer,
      preallocate = boolean,
      retention-bytes = integer,
      retention-ms = integer,
      segment-bytes = integer
    } | topic-config-4={
      cleanup-policy = CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      delete-retention-ms = integer,
      file-delete-delay-ms = integer,
      flush-messages = integer,
      flush-ms = integer,
      max-message-bytes = integer,
      message-timestamp-type = MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME,
      min-compaction-lag-ms = integer,
      min-insync-replicas = integer,
      preallocate = boolean,
      retention-bytes = integer,
      retention-ms = integer,
      segment-bytes = integer
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "name": "string",
    "partitions": "integer",
    "replication-factor": "integer",
    "topic-config": {
      "topic-config-2-8": {
        "cleanup-policy": "CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "delete-retention-ms": "integer",
        "file-delete-delay-ms": "integer",
        "flush-messages": "integer",
        "flush-ms": "integer",
        "max-message-bytes": "integer",
        "message-timestamp-type": "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME",
        "min-compaction-lag-ms": "integer",
        "min-insync-replicas": "integer",
        "preallocate": "boolean",
        "retention-bytes": "integer",
        "retention-ms": "integer",
        "segment-bytes": "integer"
      },
      "topic-config-3": {
        "cleanup-policy": "CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "delete-retention-ms": "integer",
        "file-delete-delay-ms": "integer",
        "flush-messages": "integer",
        "flush-ms": "integer",
        "max-message-bytes": "integer",
        "message-timestamp-type": "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME",
        "min-compaction-lag-ms": "integer",
        "min-insync-replicas": "integer",
        "preallocate": "boolean",
        "retention-bytes": "integer",
        "retention-ms": "integer",
        "segment-bytes": "integer"
      },
      "topic-config-4": {
        "cleanup-policy": "CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "delete-retention-ms": "integer",
        "file-delete-delay-ms": "integer",
        "flush-messages": "integer",
        "flush-ms": "integer",
        "max-message-bytes": "integer",
        "message-timestamp-type": "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME",
        "min-compaction-lag-ms": "integer",
        "min-insync-replicas": "integer",
        "preallocate": "boolean",
        "retention-bytes": "integer",
        "retention-ms": "integer",
        "segment-bytes": "integer"
      }
    }
  }, ...
]
```

Fields:

```
name -> (string)
  Name of the topic.
partitions -> (integer)
  The number of the topic's partitions.
replication-factor -> (integer)
  Amount of copies of a topic data kept in the cluster.
topic-config -> (oneof<topic-config-2-8|topic-config-3|topic-config-4>)
  Oneof topic-config field
  topic-config-2-8 -> (struct)
    Configuration of the Apache Kafka® 2.8 topic.
    cleanup-policy -> (struct)
      Retention policy to use on old log messages.
    compression-type -> (struct)
      The compression type for a given topic.
    delete-retention-ms -> (integer)
      The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.
    file-delete-delay-ms -> (integer)
      The time to wait before deleting a file from the filesystem.
    flush-messages -> (integer)
      The number of messages accumulated on a log partition before messages are flushed to disk. This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages] setting on the topic level.
    flush-ms -> (integer)
      The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms] setting on the topic level.
    max-message-bytes -> (integer)
      The largest record batch size allowed in topic.
    message-timestamp-type -> (struct)
      Define whether the timestamp in the message is message create time or log append time.
    min-compaction-lag-ms -> (integer)
      The minimum time in milliseconds a message will remain uncompacted in the log.
    min-insync-replicas -> (integer)
      This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").
    preallocate -> (boolean)
      True if we should preallocate the file on disk when creating a new log segment. This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate] setting on the topic level.
    retention-bytes -> (integer)
      The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the 'delete' [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space. This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes] setting on the topic level.
    retention-ms -> (integer)
      The number of milliseconds to keep a log segment's file before deleting it. This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms] setting on the topic level.
    segment-bytes -> (integer)
      This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes] setting on the topic level.
  topic-config-3 -> (struct)
    Configuration of the Apache Kafka® 3.x topic.
    cleanup-policy -> (struct)
      Retention policy to use on old log messages.
    compression-type -> (struct)
      The compression type for a given topic.
    delete-retention-ms -> (integer)
      The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.
    file-delete-delay-ms -> (integer)
      The time to wait before deleting a file from the filesystem.
    flush-messages -> (integer)
      The number of messages accumulated on a log partition before messages are flushed to disk. This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages] setting on the topic level.
    flush-ms -> (integer)
      The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms] setting on the topic level.
    max-message-bytes -> (integer)
      The largest record batch size allowed in topic.
    message-timestamp-type -> (struct)
      Define whether the timestamp in the message is message create time or log append time.
    min-compaction-lag-ms -> (integer)
      The minimum time in milliseconds a message will remain uncompacted in the log.
    min-insync-replicas -> (integer)
      This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").
    preallocate -> (boolean)
      True if we should preallocate the file on disk when creating a new log segment. This setting overrides the cluster-level [KafkaConfig3.log_preallocate] setting on the topic level.
    retention-bytes -> (integer)
      The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the 'delete' [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space. This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes] setting on the topic level.
    retention-ms -> (integer)
      The number of milliseconds to keep a log segment's file before deleting it. This setting overrides the cluster-level [KafkaConfig3.log_retention_ms] setting on the topic level.
    segment-bytes -> (integer)
      This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes] setting on the topic level.
  topic-config-4 -> (struct)
    Configuration of the Apache Kafka® 4.x topic.
    cleanup-policy -> (struct)
      Retention policy to use on old log messages.
    compression-type -> (struct)
      The compression type for a given topic.
    delete-retention-ms -> (integer)
      The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.
    file-delete-delay-ms -> (integer)
      The time to wait before deleting a file from the filesystem.
    flush-messages -> (integer)
      The number of messages accumulated on a log partition before messages are flushed to disk. This setting overrides the cluster-level [KafkaConfig4.log_flush_interval_messages] setting on the topic level.
    flush-ms -> (integer)
      The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. This setting overrides the cluster-level [KafkaConfig4.log_flush_interval_ms] setting on the topic level.
    max-message-bytes -> (integer)
      The largest record batch size allowed in topic.
    message-timestamp-type -> (struct)
      Define whether the timestamp in the message is message create time or log append time.
    min-compaction-lag-ms -> (integer)
      The minimum time in milliseconds a message will remain uncompacted in the log.
    min-insync-replicas -> (integer)
      This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").
    preallocate -> (boolean)
      True if we should preallocate the file on disk when creating a new log segment. This setting overrides the cluster-level [KafkaConfig4.log_preallocate] setting on the topic level.
    retention-bytes -> (integer)
      The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the 'delete' [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space. This setting overrides the cluster-level [KafkaConfig4.log_retention_bytes] setting on the topic level.
    retention-ms -> (integer)
      The number of milliseconds to keep a log segment's file before deleting it. This setting overrides the cluster-level [KafkaConfig4.log_retention_ms] setting on the topic level.
    segment-bytes -> (integer)
      This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. This setting overrides the cluster-level [KafkaConfig4.log_segment_bytes] setting on the topic level.
``` ||
|| `--user-specs` | `shorthand/json`

Configurations of accounts to be created in the Apache Kafka® cluster.

Shorthand Syntax:

```hcl
[
  {
    name = string,
    password = string,
    permissions = [
      {
        allow-hosts = string,...,
        role = ACCESS_ROLE_PRODUCER|ACCESS_ROLE_CONSUMER|ACCESS_ROLE_ADMIN|ACCESS_ROLE_TOPIC_ADMIN|ACCESS_ROLE_TOPIC_PRODUCER|ACCESS_ROLE_TOPIC_CONSUMER|ACCESS_ROLE_SCHEMA_READER|ACCESS_ROLE_SCHEMA_WRITER,
        topic-name = string
      }, ...
    ]
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "allow-hosts": [
          "string", ...
        ],
        "role": "ACCESS_ROLE_PRODUCER|ACCESS_ROLE_CONSUMER|ACCESS_ROLE_ADMIN|ACCESS_ROLE_TOPIC_ADMIN|ACCESS_ROLE_TOPIC_PRODUCER|ACCESS_ROLE_TOPIC_CONSUMER|ACCESS_ROLE_SCHEMA_READER|ACCESS_ROLE_SCHEMA_WRITER",
        "topic-name": "string"
      }, ...
    ]
  }, ...
]
```

Fields:

```
name -> (string)
  Name of the Kafka user.
password -> (string)
  Password of the Kafka user.
permissions -> ([]struct)
  Set of permissions granted to the user.
  allow-hosts -> ([]string)
    Lists hosts allowed for this permission. Only ip-addresses allowed as value of single host. When not defined, access from any host is allowed. Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the [allow_hosts] of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.
  role -> (struct)
    Access role type to grant to the user.
  topic-name -> (string)
    Name or prefix-pattern with wildcard for the topic that the permission grants access to. With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'. To get the topic name, make a [TopicService.List] request.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#