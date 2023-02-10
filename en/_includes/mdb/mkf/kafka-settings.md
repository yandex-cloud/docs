* **Auto create topics enable** {{ tag-con }} {#settings-auto-create-topics}

   Manages automatic creation of  topics.

   Automatic topic creation is disabled by default (`false`).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_auto.create.topics.enable).

* **Compression type** {{ tag-all }} {#settings-compression-type}

   In the management console, this setting corresponds to **Compression type**.

   Codec used for message compression:

   | Management console, {{ TF }}, and API | CLI | Description |
   | ---------------------------------- | -------------- | ------------------------------------------------------------------------------------------------ |
   | `COMPRESSION_TYPE_UNCOMPRESSED` | `uncompressed` | Compression is disabled |
   | `COMPRESSION_TYPE_ZSTD` | `zstd` | The [zstd](https://facebook.github.io/zstd/) codec |
   | `COMPRESSION_TYPE_LZ4` | `lz4` | The [lz4](https://lz4.github.io/lz4/) codec |
   | `COMPRESSION_TYPE_SNAPPY` | `snappy` | The [snappy](https://github.com/google/snappy) codec |
   | `COMPRESSION_TYPE_GZIP` | `gzip` | The [gzip](https://www.gzip.org) codec |
   | `COMPRESSION_TYPE_PRODUCER` | `producer` | The codec is set on the [producer](../../../managed-kafka/concepts/producers-consumers.md) side |

   By default, the compression codec is set by the producer (`COMPRESSION_TYPE_PRODUCER`).

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-compression-type).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_compression.type).

* **Default replication factor** {{ tag-all }} {#settings-default-replication-factor}

   Number of [copies of data](../../../managed-kafka/concepts/brokers.md) for a topic within a cluster.

   This setting only applies to [automatically created topics](#settings-auto-create-topics).

   The minimum value is `1` (default). The maximum value is equal to the number of broker hosts in the cluster.

   See a description of the [Replication factor](#settings-topic-replication-factor) topic-level setting.

   For more information, see the [{{ KF }} documentation](http://kafka.apache.org/documentation/#brokerconfigs_default.replication.factor).

* **Log flush interval messages** {{ tag-all }} {#settings-log-flush-interval-messages}

   In the management console, this setting corresponds to **Flush messages**.

   The number of topic messages that can be kept in memory before these messages are flushed to disk. For example, if the parameter is `1`, the disk is flushed after each message is received. If it's set to `5`, messages are flushed to the disk in groups of five.

   The minimum value is `1` and the maximum value is `9223372036854775807` (default).

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-flush-messages).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#flush.messages).

* **Log flush interval ms** {{ tag-all }} {#settings-log-flush-interval-ms}

   The maximum time in milliseconds that a message in the topic is kept in the memory before being flushed to the disk. If no value is specified, the value in [Log flush scheduler interval ms](#settings-log-flush-scheduler-interval-ms) is used.

   The maximum value is `9223372036854775807`.

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-flush-ms).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#flush.ms).

* **Log flush scheduler interval ms** {{ tag-all }} {#settings-log-flush-scheduler-interval-ms}

   The period (in milliseconds) to check the presence of logs to be flushed to the disk. This check is done by the log flusher.

   The maximum value is `9223372036854775807` (default).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_log.flush.scheduler.interval.ms).

* **Log preallocate** {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {#settings-log-preallocate}

   Determines whether to pre-allocate space for log file segments.

   By default, space for log file segments is allocated as logs become full (`false`).

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-preallocate).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_log.preallocate).

* **Log retention bytes** {{ tag-all }} {#settings-log-retention-bytes}

   In the management console, this setting corresponds to **Maximum partition size, bytes**.

   The maximum size a partition can grow to. When the partition reaches this size, {{ KF }} starts deleting the old log segments. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is in effect.

   The minimum value is `-1` (default: the log size is unlimited) and the maximum value is `9223372036854775807`.

   Use this setting if you need to control the log size due to limited disk space.

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-retention-bytes).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes).

   See the [Log retention ms](#settings-log-retention-ms) setting.

* **Log retention hours** {{ tag-all }} {#settings-log-retention-hours}

   Time (in hours) for {{ KF }} to keep a log segment file. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is active: once the specified timeout expires, the segment file is deleted.

   The maximum value is `168` (default).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.hours).

* **Log retention minutes** {{ tag-all }} {#settings-log-retention-minutes}

   Time (in minutes) for {{ KF }} to keep a log segment file. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is active: once the specified timeout expires, the segment file is deleted.

   The maximum value is `2147483647`. If no value is specified, the value in [Log retention hours](#settings-log-retention-hours) is used.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.minutes).

* **Log retention ms** {{ tag-all }} {#settings-log-retention-ms}

   In the management console, this setting corresponds to **Retention, ms**.

   Time (in milliseconds) for {{ KF }} to keep a log segment file. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is active: once the specified timeout expires, the segment file is deleted.

   The minimum value is `-1` (logs are stored without any time limits) and the maximum value is `9223372036854775807`. If no value is specified, the value in [Log retention minutes](#settings-log-retention-minutes) is used.

   {% note warning %}

   If both **Log retention bytes** and **Log retention ms** are set to `-1`, the log grows indefinitely. In this case, the cluster can run out of storage space quickly.

   {% endnote %}

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-log-retention-ms).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#retention.ms).

   See the [Log retention bytes](#settings-log-retention-bytes) setting.

* **Log segment bytes** {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {#settings-log-segment-bytes}

   Segment size for log files, in bytes.

   Segment files are saved and cleared file-by-file. The smaller the specified segment size, the more files will be in the log, but storage control will be more flexible.

   The minimum value is `14` and the maximum value is `2147483647`. Defaults to `1073741824` (1 GB).

   This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-segment-bytes).

   For more information, see [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) and the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_log.segment.bytes).

* **Message max bytes** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-message-max-bytes}

   Producer's message maximum size (in bytes).

   The minimum value is `0` (unlimited size). Defaults to `1048588`. The setting value must not exceed the [Replica fetch max bytes](#settings-replica-fetch-max-bytes) value by more than 12 bytes.

   This is a global cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#max.message.bytes).

* **Num partitions** {{ tag-all }} {#settings-num-partitions}

   The number of log partitions per topic in the cluster.

   This setting only applies to [automatically created topics](#settings-auto-create-topics).

   The minimum value is `1` (default).

   See a description of the [Num partitions](#settings-topic-num-partitions) topic-level setting.

   For more information, see the [{{ KF }} documentation](http://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Offsets retention minutes** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-offsets-retention-minutes}

   Offsets retention period in minutes after a consumer group loses all its consumers.

   The minimum value is `1` and the default value is `10080`.

   This is a global cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.minutes).

* **Replica fetch max bytes** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-replica-fetch-max-bytes}

   Size of the buffer for messages exchanged by brokers (in bytes).

   The minimum value is `0` (unlimited size). Defaults to `1048576`. The setting value must be at least 12 bytes larger than the **Message max bytes** setting value that is set at the [cluster](#settings-topic-message-max-bytes) or [topic](../../../_includes/mdb//mkf/topic-settings.md#settings-message-max-bytes) level.

   This is a global cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.max.bytes).

* **Sasl enabled mechanisms** {{ tag-all }} {#settings-sasl-enabled-mechanisms}

   Encryption mechanisms that can be used when connecting to a cluster.

   You can select one or more values:

   | Management console, {{ TF }}, and API | CLI |
   | ---------------------------------- | --------------- |
   | `SASL_MECHANISM_SCRAM_SHA_256` | `SCRAM-SHA-256` |
   | `SASL_MECHANISM_SCRAM_SHA_512` | `SCRAM-SHA-512` |

   If the setting is not defined by the user, the only used mechanism is `SCRAM-SHA-512`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_sasl.enabled.mechanisms).

* **Socket receive buffer bytes** {{ tag-con }} {#settings-socket-receive-buffer-bytes}

   The socket receive buffer size (in bytes).

   The minimum value is `-1` (default: use the OS settings) and the maximum value is `2147483647`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_socket.receive.buffer.bytes).

* **Socket send buffer bytes** {{ tag-con }} {#settings-socket-send-buffer-bytes}

   The send socket buffer size (in bytes).

   The minimum value is `-1` (default: use the OS settings) and the maximum value is `2147483647`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_socket.send.buffer.bytes).

* **Ssl cipher suites** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-ssl-cipher-suites}

   List of cluster encryption algorithms.

   There is no default value (all sets of algorithms for encryption are supported).

   This is a global cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_ssl.cipher.suites).
