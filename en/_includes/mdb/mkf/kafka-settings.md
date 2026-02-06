* **Auto create topics enable** {{ tag-all }}{#settings-auto-create-topics}

    Manages automatic topic creation.

    This option is disabled by default (`false`).

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_auto.create.topics.enable).

* **Compression type** {{ tag-all }} {#settings-compression-type}    

    Codecs used for message compression:

    | Management console, {{ TF }}, and API | CLI            | Description                                                                                         |
    | ---------------------------------- | -------------- | ------------------------------------------------------------------------------------------------ |
    | `COMPRESSION_TYPE_UNCOMPRESSED`    | `uncompressed` | Compression is disabled.                                                                                 |
    | `COMPRESSION_TYPE_ZSTD`            | `zstd`         | [zstd](https://facebook.github.io/zstd/)                                                   |
    | `COMPRESSION_TYPE_LZ4`             | `lz4`          | [lz4](https://lz4.github.io/lz4/)                                                          |
    | `COMPRESSION_TYPE_SNAPPY`          | `snappy`       | [snappy](https://github.com/google/snappy)                                                 |
    | `COMPRESSION_TYPE_GZIP`            | `gzip`         | [gzip](https://www.gzip.org)                                                               |
    | `COMPRESSION_TYPE_PRODUCER`        | `producer`     | The codec is set by the [producer](../../../managed-kafka/concepts/producers-consumers.md).|

    By default, the compression codec is set by the producer (`COMPRESSION_TYPE_PRODUCER`).

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-compression-type). In the management console, this setting appears as **{{ ui-key.yacloud.kafka.label_topic-compression-type }}**.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_compression.type).

* **Default replication factor** {{ tag-all }} {#settings-default-replication-factor}

    Number of [data replicas](../../../managed-kafka/concepts/brokers.md) per topic within a cluster.

    This setting only applies to [automatically created topics](#settings-auto-create-topics).

    The minimum and default value is `1`. The maximum value is equal to the number of broker hosts in the cluster.

    See also the [Replication factor](#settings-topic-replication-factor) topic-level setting.

    For more information, see [this {{ KF }} guide](http://kafka.apache.org/documentation/#brokerconfigs_default.replication.factor).

* **Log flush interval messages** {{ tag-all }} {#settings-log-flush-interval-messages}

    Number of topic messages that can accumulate in memory before being flushed to disk. For example, if set to `1`, each message will be flushed to disk once received. If set to `5`, messages will be flushed to disk in groups of five.

    The minimum value is `1`, the maximum and default one is `9223372036854775807`.

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-flush-messages). In the management console, this setting appears as **{{ ui-key.yacloud.kafka.label_topic-flush-messages }}**.

    For more information, see the [this {{ KF }} guide](https://kafka.apache.org/documentation/#flush.messages).

* **Log flush interval ms** {{ tag-all }} {#settings-log-flush-interval-ms}

    Maximum time in milliseconds a message can be stored in memory before being flushed to disk. If no value is specified, the [Log flush scheduler interval ms](#settings-log-flush-scheduler-interval-ms) value is used.

    The maximum value is `9223372036854775807`.

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-flush-ms).

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#flush.ms).

* **Log flush scheduler interval ms** {{ tag-all }} {#settings-log-flush-scheduler-interval-ms}

    Time period (in milliseconds) after which the log flusher checks for logs to flush to disk.

    The maximum and default value is `9223372036854775807`.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_log.flush.scheduler.interval.ms).

* **Log preallocate** {{ tag-all }} {#settings-log-preallocate}

    This setting determines whether to pre-allocate space for log segment files.

    By default, the space for log segment files is allocated as the segments get full (`false`).

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-preallocate).

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_log.preallocate).

* **Log retention bytes** {{ tag-all }} {#settings-log-retention-bytes}    

    Maximum size a partition can grow to. When a partition reaches this size, {{ KF }} starts deleting old log segments. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is effective.

    The minimum and default value is `-1`, which means the log size is unlimited. The maximum value is `9223372036854775807`.

    Use this setting if you need to manage the log size due to limited disk space.

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-retention-bytes). In the management console, this setting appears as **{{ ui-key.yacloud.kafka.label_topic-retention-bytes }}**.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes).

    See also the [Log retention ms](#settings-log-retention-ms) setting.

* **Log retention hours** {{ tag-all }} {#settings-log-retention-hours}

    Time (in hours) for {{ KF }} to keep a log segment file. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is effective; once the specified timeout expires, the segment file is deleted.

    The default value is `168`.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.hours).

* **Log retention minutes** {{ tag-all }} {#settings-log-retention-minutes}

    Time (in minutes) for {{ KF }} to keep a log segment file. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is effective; once the specified timeout expires, the segment file is deleted.

    The maximum value is `2147483647`. If no value is specified, the [Log retention hours](#settings-log-retention-hours) value is used.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.minutes).

* **Log retention ms** {{ tag-all }} {#settings-log-retention-ms}    

    Time (in milliseconds) for {{ KF }} to keep a log segment file. This setting applies if the `Delete` [log cleanup policy](#settings-topic-cleanup-policy) is effective; once the specified timeout expires, the segment file is deleted.

    The minimum value is `-1`, which means logs are stored without any time limit. The maximum value is `9223372036854775807`. If no value is specified, the [Log retention minutes](#settings-log-retention-minutes) value is used.

    {% note warning %}

    If both **Log retention bytes** and **Log retention ms** are set to `-1`, the log grows indefinitely. This can quickly exhaust the cluster storage space.

    {% endnote %}

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-log-retention-ms). In the management console, this setting appears as **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}**.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#retention.ms).

    See also the [Log retention bytes](#settings-log-retention-bytes) setting.

* **Log segment bytes** {{ tag-all }} {#settings-log-segment-bytes}

    This setting determines the segment size for log files, in bytes.

    Segment files are saved and cleared file-by-file. A smaller segment size results in more log files but offers more flexible storage management. 

    The valid values range from `14` to `2147483647`. The default value is `1073741824` (1 GB).

    This is a global cluster-level setting. You can override it at the [topic level](#settings-topic-segment-bytes).

    For more information, see [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) and [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_log.segment.bytes).

* **Message max bytes** {{ tag-all }} {#settings-message-max-bytes}

    Maximum size of a message sent by the producer.

    The minimum value is `0` (no limit); the default one is `1048588`. The setting value relates to the [Replica fetch max bytes](#settings-replica-fetch-max-bytes) value as follows:
    `replica.fetch.max.bytes >= message.max.bytes + 12`

    This is a global cluster-level setting.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#max.message.bytes).

* **Num partitions** {{ tag-all }} {#settings-num-partitions}

    Number of log partitions per topic in the cluster.

    This setting only applies to [automatically created topics](#settings-auto-create-topics).

    The minimum and default value is `1`.

    See also the [Num partitions](#settings-topic-num-partitions) topic-level setting.

    For more information, see [this {{ KF }} guide](http://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Offsets retention minutes** {{ tag-all }} {#settings-offsets-retention-minutes}

    Offset retention period for inactive [consumer groups](../../../managed-kafka/concepts/producers-consumers.md#consumer-groups) (in minutes).

    The minimum value is `1` and the default is `10080`.

    This is a global cluster-level setting.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.minutes).

* **Replica fetch max bytes** {{ tag-all }} {#settings-replica-fetch-max-bytes}

    Inter-broker message buffer size (in bytes).

    The minimum value is `0` (no limit); the default one is `1048576`. The setting value relates to the **Message max bytes** value as follows:
    `message.max.bytes <= replica.fetch.max.bytes - 12` 

    This is a global cluster-level setting.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.max.bytes).

* **Sasl enabled mechanisms** {{ tag-all }} {#settings-sasl-enabled-mechanisms}

    Encryption options for cluster connections.

    You can select one or more values:

    | Management console, {{ TF }}, and API | CLI             |
    | ---------------------------------- | --------------- |
    | `SASL_MECHANISM_SCRAM_SHA_256`     | `SCRAM-SHA-256` |
    | `SASL_MECHANISM_SCRAM_SHA_512`     | `SCRAM-SHA-512` |

    If the setting is not defined by the user, `SCRAM-SHA-512` is only used.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_sasl.enabled.mechanisms).

* **Socket receive buffer bytes** {{ tag-con }} {{ tag-tf }} {{ tag-api }}{#settings-socket-receive-buffer-bytes}

    Socket receive buffer size (in bytes).

    The minimum and default value is `-1`, which means the OS settings apply. The maximum value is `2147483647`.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_socket.receive.buffer.bytes).

* **Socket send buffer bytes** {{ tag-con }} {{ tag-tf }} {{ tag-api }}{#settings-socket-send-buffer-bytes}

    Socket send buffer size (in bytes).

    The minimum and default value is `-1`, which means the OS settings apply. The maximum value is `2147483647`.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_socket.send.buffer.bytes).

* **Ssl cipher suites** {{ tag-all }} {#settings-ssl-cipher-suites}

    List of cluster encryption algorithms.

    There is no default value, which means all supported encryption algorithms are enabled.

    This is a global cluster-level setting.

    For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#brokerconfigs_ssl.cipher.suites).
