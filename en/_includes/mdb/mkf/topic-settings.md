* **Cleanup policy** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-cleanup-policy}

    In the management console, this setting corresponds to **Cleanup policy**.

    Retention policy to use on old log messages:
    * `Delete` (`CLEANUP_POLICY_DELETE` for {{ TF }} and API): Delete log segments when either their retention time or log size limit is reached.
    * `Compact` (`CLEANUP_POLICY_COMPACT` for {{ TF }} and API): Compress messages in the log.
    * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` for {{ TF }} and API): Both compact and delete log segments.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#cleanup.policy).

* **Compression type** {{ tag-all }} {#settings-topic-compression-type }

    In the management console, this setting corresponds to **Compression type**.

    See the [Compression type](#settings-compression-type) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_compression.type).

* **Delete delay, ms** {{ tag-all }} {#settings-topic-file-delete-delay}

    In the management console, this setting corresponds to **Delete delay, ms**.

    The time to wait before deleting a file from the filesystem.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#file.delete.delay.ms).

* **Delete retention** {{ tag-con }} {#settings-delete-retention}

    Time in milliseconds to retain delete tombstone markers for log compacted topics. This setting only applies if the [log cleanup policy](#settings-topic-cleanup-policy) is set to `Compact` or `CompactAndDelete`.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#retention.ms).

* **Flush messages** {{ tag-all }} {#settings-topic-flush-messages}

    In the management console, this setting corresponds to **Flush messages**.

    See the [Log flush interval messages](#settings-log-flush-interval-messages) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_flush.messages).

* **Flush, ms** {{ tag-all }} {#settings-topic-flush-ms}

    In the management console, this setting corresponds to **Flush, ms**.

    See the [Log flush interval ms](#settings-log-flush-interval-ms) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_flush.ms).

* **Maximum batch size** {{ tag-all }} {#settings-topic-max-message-bytes}

    In the management console, this setting corresponds to **Maximum batch size**.

    See the [Log segment bytes](#settings-log-segment-bytes) cluster-level setting.

    The minimum value is `0`. Defaults to `1048588` (1 MB).

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#retention.bytes).

* **Min compaction lag, ms** {{ tag-all }} {#settings-topic-max-compaction-lag-ms}

    In the management console, this setting corresponds to **Minimum compaction lag, ms**.

    The minimum time a message will remain uncompacted in the log.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#min.compaction.lag.ms).

* **Minimum number of in-sync replicas** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-min-insync-replicas}

    In the management console, this setting corresponds to **Minimum number of in-sync replicas**.

    The minimum number of replicas that have to acknowledge a write for the message to be considered successfully written to a topic. Use this setting if the Producer has to wait too long for a successful write acknowledgement from all the broker hosts in the cluster.

    The minimum value depends on the number of [broker hosts](../../../managed-kafka/concepts/brokers.md):
    * For clusters with a single broker host: `1`.
    * For clusters with at least two broker hosts: `2`.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_min.insync.replicas).

* **Num partitions** {{ tag-all }} {#settings-topic-num-partitions}

    In the management console, this setting corresponds to **Number of partitions**.

    The number of log partitions per topic.

    The minimum value is `1` (default).

    See also the [Num partitions](#settings-num-partitions) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Preallocate** {{ tag-cli }} {{ tag-tf }} {#settings-topic-preallocate}

    See the [Log preallocate](#settings-log-preallocate) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_preallocate).

* **Replication factor** {{ tag-all }} {#settings-topic-replication-factor}

    In the management console, this setting corresponds to **Replication factor**.

    The number of [data copies](../../../managed-kafka/concepts/brokers.md) for a topic.

    The minimum value is `1` (default). The maximum value is equal to the number of broker hosts in the cluster.

    See also the [Default replication factor](#settings-default-replication-factor) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#streamsconfigs_replication.factor).

* **Retention, bytes** {{ tag-all }} {#settings-topic-retention-bytes}

    In the management console, this setting corresponds to **Retention, bytes**.

    See the [Log retention bytes](#settings-log-retention-bytes) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_retention.bytes).

* **Retention, ms** {{ tag-all }} {#settings-topic-log-retention-ms}

    In the management console, this setting corresponds to **Retention, ms**.

    See the [Log retention ms](#settings-log-retention-ms) cluster-level setting.

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_retention.ms).

* **Segment bytes** {{ tag-cli }} {{ tag-tf }} {#settings-topic-segment-bytes}

    Segment size for log files, in bytes.

    The minimum value is `14`. Defaults to `1073741824` (1 GB).

    For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_segment.bytes).

