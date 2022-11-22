* **Cleanup policy** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-cleanup-policy}

   In the management console, this setting corresponds to **Cleanup policy**.

   Retention policy to use on old log messages:

   * `Delete` (`CLEANUP_POLICY_DELETE` for {{ TF }} and API): Delete log segments when either their retention time or log size limit is reached.
   * `Compact` (`CLEANUP_POLICY_COMPACT` for {{ TF }} and API): Compress messages in the log.
   * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` for {{ TF }} and API): Both compact and delete log segments.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#cleanup.policy).

* **Compression type** {{ tag-all }} {#settings-topic-compression-type }

   In the management console, this setting corresponds to **Compression type**.

   See a description of the [Compression type](#settings-compression-type) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_compression.type).

* **Delete delay, ms** {{ tag-all }} {#settings-topic-file-delete-delay}

   In the management console, this setting corresponds to **Delete delay, ms**.

   The time to wait before deleting a file from the filesystem.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#file.delete.delay.ms).

* **Delete retention** {{ tag-con }} {#settings-delete-retention}

   Time in milliseconds to retain delete tombstone markers for log compacted topics. This setting only applies if the [log cleanup policy](#settings-topic-cleanup-policy) is set to `Compact` or to `CompactAndDelete`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#delete.retention.ms).

* **Flush messages** {{ tag-all }} {#settings-topic-flush-messages}

   In the management console, this setting corresponds to **Flush messages**.

   See a description of the [Log flush interval messages](#settings-log-flush-interval-messages) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_flush.messages).

* **Flush, ms** {{ tag-all }} {#settings-topic-flush-ms}

   In the management console, this setting corresponds to **Flush, ms**.

   See a description of the [Log flush interval ms](#settings-log-flush-interval-ms) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_flush.ms).

* **Message max bytes** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-message-max-bytes}

   In the management console, this setting corresponds to **Maximum batch size**.

   Producer's message maximum size in bytes.

   The minimum value is `0` (unlimited size). Defaults to `1048588`. The setting value must not exceed the [Replica fetch max bytes](../../../_includes/mdb/mkf/kafka-settings.md#settings-replica-fetch-max-bytes) value by more than 12 bytes.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_max.message.bytes).

* **Min compaction lag, ms** {{ tag-all }} {#settings-topic-max-compaction-lag-ms}

   In the management console, this setting corresponds to **Minimum compaction lag, ms**.

   The minimum time a message will remain uncompacted in the log.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#min.compaction.lag.ms).

* **Minimum number of in-sync replicas** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-min-insync-replicas}

   In the management console, this setting corresponds to **Minimum number of in-sync replicas**.

   The minimum number of replicas to wait for the record confirmation from in order to consider a message successfully written to a topic. Use this setting if the Producer has to wait too long for a successful write acknowledgement from all the broker hosts in the cluster.

   The minimum value depends on the number of [broker hosts](../../../managed-kafka/concepts/brokers.md):

   * For clusters with a single broker host: `1`.
   * For clusters with at least two broker hosts: `2`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_min.insync.replicas).

* **Num partitions** {{ tag-all }} {#settings-topic-num-partitions}

   In the management console, this setting corresponds to **Number of partitions**.

   The number of log partitions per topic.

   The minimum value is `1` (default).

   See a description of the [Num partitions](#settings-num-partitions) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Pre-allocation of the segment file** {{ tag-cli }} {{ tag-tf }} {#settings-topic-preallocate}

   In the management console, this corresponds to **Pre-allocation of the segment file**.

   See a description of the [Log preallocate](#settings-log-preallocate) cluster-level setting.

   By default, space for log file segments is allocated as logs become full (`false`).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_preallocate).

* **Replication factor** {{ tag-all }} {#settings-topic-replication-factor}

   In the management console, this setting corresponds to **Replication factor**.

   Number of [copies of data](../../../managed-kafka/concepts/brokers.md) for a topic.

   The minimum value is `1` (default). The maximum value is equal to the number of broker hosts in the cluster.

   See a description of the [Default replication factor](#settings-default-replication-factor) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#streamsconfigs_replication.factor).

* **Retention, bytes** {{ tag-all }} {#settings-topic-retention-bytes}

   In the management console, this setting corresponds to **Maximum partition size, bytes**.

   See a description of the [Log retention bytes](#settings-log-retention-bytes) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_retention.bytes).

* **Retention, ms** {{ tag-all }} {#settings-topic-log-retention-ms}

   In the management console, this setting corresponds to **Retention, ms**.

   See a description of the [Log retention ms](#settings-log-retention-ms) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_retention.ms).

* **Segment bytes** {{ tag-all }} {#settings-topic-segment-bytes}

   Segment size for log files, in bytes.

   Segment files are saved and cleared file-by-file. The smaller the specified segment size, the more files will be in the log, but storage control will be more flexible.

   The minimum value is `14`. Defaults to `1073741824` (1 GB).

   See a description of the [Log segment bytes](#settings-log-segment-bytes) cluster-level setting.

   For more information, see [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) and the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_segment.bytes).
