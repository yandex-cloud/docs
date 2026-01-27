---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kafka/cli-ref-beta/cluster/update.md
---

# yc beta managed-kafka cluster update

Updates the specified Apache Kafka® cluster.

#### Command Usage

Syntax:

`yc beta managed-kafka cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the Apache Kafka® cluster to update. To get the Apache Kafka® cluster ID, make a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

New configuration and resources for hosts in the Apache Kafka® cluster. Use [update_mask] to prevent reverting all cluster settings that are not listed in [config_spec] to their default values.

Shorthand Syntax:

```hcl
{
  access = {
    data-transfer = bool
  },
  assign-public-ip = bool,
  brokers-count = int,
  disk-size-autoscaling = {
    disk-size-limit = int,
    emergency-usage-threshold = int,
    planned-usage-threshold = int
  },
  kafka = {
    kafka-config = kafka-config-2-8={
      auto-create-topics-enable = bool,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      default-replication-factor = int,
      log-flush-interval-messages = int,
      log-flush-interval-ms = int,
      log-flush-scheduler-interval-ms = int,
      log-preallocate = bool,
      log-retention-bytes = int,
      log-retention-hours = int,
      log-retention-minutes = int,
      log-retention-ms = int,
      log-segment-bytes = int,
      message-max-bytes = int,
      num-partitions = int,
      offsets-retention-minutes = int,
      replica-fetch-max-bytes = int,
      sasl-enabled-mechanisms = [
        SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512, ...
      ],
      socket-receive-buffer-bytes = int,
      socket-send-buffer-bytes = int,
      ssl-cipher-suites = str,...
    } | kafka-config-3={
      auto-create-topics-enable = bool,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      default-replication-factor = int,
      log-flush-interval-messages = int,
      log-flush-interval-ms = int,
      log-flush-scheduler-interval-ms = int,
      log-preallocate = bool,
      log-retention-bytes = int,
      log-retention-hours = int,
      log-retention-minutes = int,
      log-retention-ms = int,
      log-segment-bytes = int,
      message-max-bytes = int,
      num-partitions = int,
      offsets-retention-minutes = int,
      replica-fetch-max-bytes = int,
      sasl-enabled-mechanisms = [
        SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512, ...
      ],
      socket-receive-buffer-bytes = int,
      socket-send-buffer-bytes = int,
      ssl-cipher-suites = str,...
    } | kafka-config-4={
      auto-create-topics-enable = bool,
      compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
      default-replication-factor = int,
      log-flush-interval-messages = int,
      log-flush-interval-ms = int,
      log-flush-scheduler-interval-ms = int,
      log-retention-bytes = int,
      log-retention-hours = int,
      log-retention-minutes = int,
      log-retention-ms = int,
      log-segment-bytes = int,
      message-max-bytes = int,
      num-partitions = int,
      offsets-retention-minutes = int,
      replica-fetch-max-bytes = int,
      sasl-enabled-mechanisms = [
        SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512, ...
      ],
      socket-receive-buffer-bytes = int,
      socket-send-buffer-bytes = int,
      ssl-cipher-suites = str,...
    },
    resources = {
      disk-size = int,
      disk-type-id = str,
      resource-preset-id = str
    }
  },
  kafka-ui-config = {
    enabled = bool
  },
  kraft = {
    resources = {
      disk-size = int,
      disk-type-id = str,
      resource-preset-id = str
    }
  },
  patch-version = str,
  rest-api-config = {
    enabled = bool
  },
  schema-registry = bool,
  unmanaged-topics = bool,
  version = str,
  zone-id = str,...,
  zookeeper = {
    resources = {
      disk-size = int,
      disk-type-id = str,
      resource-preset-id = str
    }
  }
}
```

JSON Syntax:

```json
{
  "access": {
    "data-transfer": "bool"
  },
  "assign-public-ip": "bool",
  "brokers-count": "int",
  "disk-size-autoscaling": {
    "disk-size-limit": "int",
    "emergency-usage-threshold": "int",
    "planned-usage-threshold": "int"
  },
  "kafka": {
    "kafka-config": {
      "kafka-config-2-8": {
        "auto-create-topics-enable": "bool",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "default-replication-factor": "int",
        "log-flush-interval-messages": "int",
        "log-flush-interval-ms": "int",
        "log-flush-scheduler-interval-ms": "int",
        "log-preallocate": "bool",
        "log-retention-bytes": "int",
        "log-retention-hours": "int",
        "log-retention-minutes": "int",
        "log-retention-ms": "int",
        "log-segment-bytes": "int",
        "message-max-bytes": "int",
        "num-partitions": "int",
        "offsets-retention-minutes": "int",
        "replica-fetch-max-bytes": "int",
        "sasl-enabled-mechanisms": [
          "SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512", ...
        ],
        "socket-receive-buffer-bytes": "int",
        "socket-send-buffer-bytes": "int",
        "ssl-cipher-suites": [
          "str", ...
        ]
      },
      "kafka-config-3": {
        "auto-create-topics-enable": "bool",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "default-replication-factor": "int",
        "log-flush-interval-messages": "int",
        "log-flush-interval-ms": "int",
        "log-flush-scheduler-interval-ms": "int",
        "log-preallocate": "bool",
        "log-retention-bytes": "int",
        "log-retention-hours": "int",
        "log-retention-minutes": "int",
        "log-retention-ms": "int",
        "log-segment-bytes": "int",
        "message-max-bytes": "int",
        "num-partitions": "int",
        "offsets-retention-minutes": "int",
        "replica-fetch-max-bytes": "int",
        "sasl-enabled-mechanisms": [
          "SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512", ...
        ],
        "socket-receive-buffer-bytes": "int",
        "socket-send-buffer-bytes": "int",
        "ssl-cipher-suites": [
          "str", ...
        ]
      },
      "kafka-config-4": {
        "auto-create-topics-enable": "bool",
        "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
        "default-replication-factor": "int",
        "log-flush-interval-messages": "int",
        "log-flush-interval-ms": "int",
        "log-flush-scheduler-interval-ms": "int",
        "log-retention-bytes": "int",
        "log-retention-hours": "int",
        "log-retention-minutes": "int",
        "log-retention-ms": "int",
        "log-segment-bytes": "int",
        "message-max-bytes": "int",
        "num-partitions": "int",
        "offsets-retention-minutes": "int",
        "replica-fetch-max-bytes": "int",
        "sasl-enabled-mechanisms": [
          "SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512", ...
        ],
        "socket-receive-buffer-bytes": "int",
        "socket-send-buffer-bytes": "int",
        "ssl-cipher-suites": [
          "str", ...
        ]
      }
    },
    "resources": {
      "disk-size": "int",
      "disk-type-id": "str",
      "resource-preset-id": "str"
    }
  },
  "kafka-ui-config": {
    "enabled": "bool"
  },
  "kraft": {
    "resources": {
      "disk-size": "int",
      "disk-type-id": "str",
      "resource-preset-id": "str"
    }
  },
  "patch-version": "str",
  "rest-api-config": {
    "enabled": "bool"
  },
  "schema-registry": "bool",
  "unmanaged-topics": "bool",
  "version": "str",
  "zone-id": [
    "str", ...
  ],
  "zookeeper": {
    "resources": {
      "disk-size": "int",
      "disk-type-id": "str",
      "resource-preset-id": "str"
    }
  }
}
```

Fields:

```
access -> (struct)
  Access policy for external services.
  data-transfer -> (bool)
    Allow access for DataTransfer.
assign-public-ip -> (bool)
  The flag that defines whether a public IP address is assigned to the cluster. If the value is 'true', then Apache Kafka® cluster is available on the Internet via it's public IP address.
brokers-count -> (int)
  The number of Kafka brokers deployed in each availability zone.
disk-size-autoscaling -> (struct)
  DiskSizeAutoscaling settings
  disk-size-limit -> (int)
    New storage size (in bytes) that is set when one of the thresholds is achieved.
  emergency-usage-threshold -> (int)
    Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
  planned-usage-threshold -> (int)
    Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
kafka -> (struct)
  Configuration and resource allocation for Kafka brokers.
  resources -> (struct)
    Resources allocated to Kafka brokers.
    disk-size -> (int)
      Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.
    disk-type-id -> (string)
      Type of the storage environment for the host.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
  kafka-config -> (oneof<kafka-config-2-8|kafka-config-3|kafka-config-4>)
    Oneof kafka-config field
    kafka-config-2-8 -> (struct)
      Configuration of an Apache Kafka® 2.8 broker.
      auto-create-topics-enable -> (bool)
        Enable auto creation of topic on the server
      compression-type -> (struct)
        Cluster topics compression type.
      default-replication-factor -> (int)
        Default replication factor of the topic on the whole cluster
      log-flush-interval-messages -> (int)
        The number of messages accumulated on a log partition before messages are flushed to disk. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages] setting.
      log-flush-interval-ms -> (int)
        The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of [log_flush_scheduler_interval_ms] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms] setting.
      log-flush-scheduler-interval-ms -> (int)
        The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.
      log-preallocate -> (bool)
        Should pre allocate file when create new segment? This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate] setting. Deprecated. Feature useless for Yandex Cloud.
      log-retention-bytes -> (int)
        Partition size limit; Kafka will discard old log segments to free up space if 'delete' [TopicConfig2_8.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes] setting.
      log-retention-hours -> (int)
        The number of hours to keep a log segment file before deleting it.
      log-retention-minutes -> (int)
        The number of minutes to keep a log segment file before deleting it. If not set, the value of [log_retention_hours] is used.
      log-retention-ms -> (int)
        The number of milliseconds to keep a log segment file before deleting it. If not set, the value of [log_retention_minutes] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms] setting.
      log-segment-bytes -> (int)
        The maximum size of a single log file. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes] setting.
      message-max-bytes -> (int)
        The largest record batch size allowed by Kafka. Default value: 1048588.
      num-partitions -> (int)
        Default number of partitions per topic on the whole cluster
      offsets-retention-minutes -> (int)
        Offset storage time after a consumer group loses all its consumers. Default: 10080.
      replica-fetch-max-bytes -> (int)
        The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.
      sasl-enabled-mechanisms -> ([]struct)
        The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].
      socket-receive-buffer-bytes -> (int)
        The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      socket-send-buffer-bytes -> (int)
        The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      ssl-cipher-suites -> ([]string)
        A list of cipher suites.
    kafka-config-3 -> (struct)
      Configuration of an Apache Kafka® 3.x broker.
      auto-create-topics-enable -> (bool)
        Enable auto creation of topic on the server
      compression-type -> (struct)
        Cluster topics compression type.
      default-replication-factor -> (int)
        Default replication factor of the topic on the whole cluster
      log-flush-interval-messages -> (int)
        The number of messages accumulated on a log partition before messages are flushed to disk. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages] setting.
      log-flush-interval-ms -> (int)
        The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of [log_flush_scheduler_interval_ms] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms] setting.
      log-flush-scheduler-interval-ms -> (int)
        The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.
      log-preallocate -> (bool)
        Should pre allocate file when create new segment? This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate] setting. Deprecated. Feature useless for Yandex Cloud.
      log-retention-bytes -> (int)
        Partition size limit; Kafka will discard old log segments to free up space if 'delete' [TopicConfig3.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes] setting.
      log-retention-hours -> (int)
        The number of hours to keep a log segment file before deleting it.
      log-retention-minutes -> (int)
        The number of minutes to keep a log segment file before deleting it. If not set, the value of [log_retention_hours] is used.
      log-retention-ms -> (int)
        The number of milliseconds to keep a log segment file before deleting it. If not set, the value of [log_retention_minutes] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms] setting.
      log-segment-bytes -> (int)
        The maximum size of a single log file. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes] setting.
      message-max-bytes -> (int)
        The largest record batch size allowed by Kafka. Default value: 1048588.
      num-partitions -> (int)
        Default number of partitions per topic on the whole cluster
      offsets-retention-minutes -> (int)
        Offset storage time after a consumer group loses all its consumers. Default: 10080.
      replica-fetch-max-bytes -> (int)
        The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.
      sasl-enabled-mechanisms -> ([]struct)
        The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].
      socket-receive-buffer-bytes -> (int)
        The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      socket-send-buffer-bytes -> (int)
        The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      ssl-cipher-suites -> ([]string)
        A list of cipher suites.
    kafka-config-4 -> (struct)
      Configuration of an Apache Kafka® 4.x broker.
      auto-create-topics-enable -> (bool)
        Enable auto creation of topic on the server
      compression-type -> (struct)
        Cluster topics compression type.
      default-replication-factor -> (int)
        Default replication factor of the topic on the whole cluster
      log-flush-interval-messages -> (int)
        The number of messages accumulated on a log partition before messages are flushed to disk. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages] setting.
      log-flush-interval-ms -> (int)
        The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of [log_flush_scheduler_interval_ms] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.flush_ms] setting.
      log-flush-scheduler-interval-ms -> (int)
        The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.
      log-retention-bytes -> (int)
        Partition size limit; Kafka will discard old log segments to free up space if 'delete' [TopicConfig4.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes] setting.
      log-retention-hours -> (int)
        The number of hours to keep a log segment file before deleting it.
      log-retention-minutes -> (int)
        The number of minutes to keep a log segment file before deleting it. If not set, the value of [log_retention_hours] is used.
      log-retention-ms -> (int)
        The number of milliseconds to keep a log segment file before deleting it. If not set, the value of [log_retention_minutes] is used. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.retention_ms] setting.
      log-segment-bytes -> (int)
        The maximum size of a single log file. This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.segment_bytes] setting.
      message-max-bytes -> (int)
        The largest record batch size allowed by Kafka. Default value: 1048588.
      num-partitions -> (int)
        Default number of partitions per topic on the whole cluster
      offsets-retention-minutes -> (int)
        Offset storage time after a consumer group loses all its consumers. Default: 10080.
      replica-fetch-max-bytes -> (int)
        The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.
      sasl-enabled-mechanisms -> ([]struct)
        The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].
      socket-receive-buffer-bytes -> (int)
        The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      socket-send-buffer-bytes -> (int)
        The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.
      ssl-cipher-suites -> ([]string)
        A list of cipher suites.
kafka-ui-config -> (struct)
  Configuration of Kafka UI.
  enabled -> (bool)
    Is Kafka UI enabled for this cluster.
kraft -> (struct)
  Configuration and resource allocation for KRaft-controller hosts.
  resources -> (struct)
    Resources allocated to KRaft controller hosts.
    disk-size -> (int)
      Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.
    disk-type-id -> (string)
      Type of the storage environment for the host.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
patch-version -> (string)
  Patch or release version ex. 3.9.1, 4.0.1 etc
rest-api-config -> (struct)
  Configuration of REST API.
  enabled -> (bool)
    Is REST API enabled for this cluster.
schema-registry -> (bool)
  Enables managed schema registry on cluster
unmanaged-topics -> (bool)
  Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently.
version -> (string)
  Version of Apache Kafka® used in the cluster. Possible values: '2.8', '3.0', '3.1', '3.2', '3.3', '3.4', '3.5', '3.6'.
zone-id -> ([]string)
  IDs of availability zones where Kafka brokers reside.
zookeeper -> (struct)
  Configuration and resource allocation for ZooKeeper hosts.
  resources -> (struct)
    Resources allocated to ZooKeeper hosts.
    disk-size -> (int)
      Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.
    disk-type-id -> (string)
      Type of the storage environment for the host.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description of the Apache Kafka® cluster. ||
|| `--labels` | `stringToString`

Custom labels for the Apache Kafka® cluster as 'key:value' pairs. For example, "project": "mvp" or "source": "dictionary". The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--maintenance-window` | `shorthand/json`

New maintenance window settings for the cluster.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = int
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
      "hour": "int"
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
    hour -> (int)
      Hour of the day in UTC.
``` ||
|| `--name` | `string`

New name for the Apache Kafka® cluster. ||
|| `--network-id` | `string`

ID of the network to move the cluster to. ||
|| `--security-group-ids` | `strings`

User security groups ||
|| `--subnet-ids` | `strings`

IDs of subnets where the hosts are located or a new host is being created ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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