* **Auto create topics enable** {{ tag-con }} {#settings-auto-create-topics}

    Manages automatic creation of topics.

    Automatic topic creation is disabled by default (`false`).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_auto.create.topics.enable).

* **Compression type** {{ tag-all }} {#settings-compression-type}

    In the management console, this setting corresponds to **Compression type**.

    The codec used for message compression:

    | Management console | CLI | {{ TF }} and API | Description |
    | ------------------ | -------------- | ------------------------------- | ------------------------------------------------ |
    | `Uncompressed` | `uncompressed` | `COMPRESSION_TYPE_UNCOMPRESSED` | Compression is disabled |
    | `Zstd` | `zstd` | `COMPRESSION_TYPE_ZSTD` | The [zstd](https://facebook.github.io/zstd/) codec |
    | `Lz4` | `lz4` | `COMPRESSION_TYPE_LZ4` | The [lz4](https://lz4.github.io/lz4/) codec |
    | `Snappy` | `snappy` | `COMPRESSION_TYPE_SNAPPY` | The [snappy](https://github.com/google/snappy) codec |
    | `Gzip` | `gzip` | `COMPRESSION_TYPE_GZIP` | The [gzip](https://www.gzip.org) codec |
    | `Producer` | `producer` | `COMPRESSION_TYPE_PRODUCER` | The codec is set on the side of the [producer](../../../managed-kafka/concepts/producers-consumers.md) |

    By default, the compression codec is set by the producer (`COMPRESSION_TYPE_PRODUCER`).

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-compression-type).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_compression.type).

* **Log flush interval messages** {{ tag-all }} {#settings-log-flush-interval-messages}

    In the management console, this setting corresponds to **Flush messages**.

    The number of topic messages that can be kept in memory before these messages are flushed to disk. For example, if the parameter is `1`, the disk is flushed after each message is received. If it's set to `5`, messages are flushed to disk in groups of five.

    The minimum value is `1`, the maximum value is `9223372036854775807` (default).

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-flush-messages).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#flush.messages).

* **Log flush interval ms** {{ tag-all }} {#settings-log-flush-interval-ms}

    The maximum time in milliseconds that a message in the topic is kept in the memory before being flushed to the disk. If the value is not set, the [Log flush scheduler interval ms](#settings-log-flush-scheduler-interval-ms) setting is used instead.

    The maximum value is `9223372036854775807`.

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-flush-ms).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#flush.ms).

* **Log flush scheduler interval ms** {{ tag-all }} {#settings-log-flush-scheduler-interval-ms}

    The period (in milliseconds) to check the presence of logs to be flushed to the disk. This check is done by the log flusher.

    The maximum value is `9223372036854775807` (default).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.flush.scheduler.interval.ms).

* **Log preallocate** {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {#settings-log-preallocate}

    Determines whether to preallocate log file space.

    By default, the space for log files is allocated as needed (`false`).

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-preallocate).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.preallocate).

* **Log retention bytes** {{ tag-all }} {#settings-log-retention-bytes}

    In the management console, this setting corresponds to **Retention, bytes**.

    The maximum size a partition can grow to, in bytes. When the partition reaches this size, {{ KF }} starts deleting the old log segments. The setting applies if the [log cleanup policy](#settings-topic-cleanup-policy) is in effect `Delete`.

    The minimum and default value is `-1` (log size is unlimited), the maximum value is `9223372036854775807`.

    Use this setting if you need to control the log size due to limited disk space.

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-retention-bytes).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes).

    See also the [Log retention ms](#settings-log-retention-ms) setting.

* **Log retention hours** {{ tag-all }} {#settings-log-retention-hours}

    Time (in hours) for {{ KF }} to keep a log segment file. This setting applies if the [log cleanup policy](#settings-topic-cleanup-policy) is in effect `Delete`: after the specified time, the segment file is deleted.

    The maximum value is `168` (default).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.hours).

* **Log retention minutes** {{ tag-all }} {#settings-log-retention-minutes}

    Time (in minutes) for {{ KF }} to keep a log segment file. This setting applies if the [log cleanup policy](#settings-topic-cleanup-policy) is in effect `Delete`: after the specified time, the segment file is deleted.

    The maximum value is `2147483647`. If no value is set, [Log retention hours](#settings-log-retention-hours) is used.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.minutes).

* **Log retention ms** {{ tag-all }} {#settings-log-retention-ms}

    In the management console, this setting corresponds to **Retention, ms**.

    Time (in milliseconds) for {{ KF }} to keep a log segment file. This setting applies if the [log cleanup policy](#settings-topic-cleanup-policy) is in effect `Delete`: after the specified time, the segment file is deleted.

    The minimum value is `-1` (logs are stored without any time limits), the maximum value is `9223372036854775807`. If no value is set, [Log retention minutes](#settings-log-retention-minutes) is used.

    {% note warning %}

    If both **Log retention bytes** and **Log retention ms** are set to `-1`, the log grows indefinitely. This way the cluster can run out of storage space quickly.

    {% endnote %}

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-log-retention-ms).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#retention.ms).

    See also the [Log retention bytes](#settings-log-retention-bytes) setting.

* **Log segment bytes** {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {#settings-log-segment-bytes}

    The maximum batch size of messages that {{ KF }} allows the producer to write to a topic or consumer to read from a topic (in bytes, after compression, if enabled).

    The minimum value is `14`, maximum value is `2147483647`, default value is `1073741824` (1 GB).

    This is a global cluster-level setting. It can be overridden on the [topic level](#settings-topic-log-segment-bytes).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.segment.bytes).

* **Socket receive buffer bytes** {{ tag-con }} {#settings-socket-receive-buffer-bytes}

    The buffer size for the receiving socket (in bytes).

    The minimum and default value is `-1` (use OS settings), the maximum value is `2147483647`.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_socket.receive.buffer.bytes).

* **Socket send buffer bytes** {{ tag-con }} {#settings-socket-send-buffer-bytes}

    The buffer size for the send socket (in bytes).

    The minimum and default value is `-1` (use OS settings), the maximum value is `2147483647`.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_socket.send.buffer.bytes).

