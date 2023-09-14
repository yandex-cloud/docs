* **Cleanup policy** {{ tag-all }} {#settings-topic-cleanup-policy}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**.

   It determines the retention policy for old log messages:

   * `Delete` (`CLEANUP_POLICY_DELETE` for {{ TF }} and API): Delete log segments when either their retention time or log size limit is reached.
   * `Compact` (`CLEANUP_POLICY_COMPACT` for {{ TF }} and API): Compress log messages.
   * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` for {{ TF }} and API): Both compress and delete log segments.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#cleanup.policy).

* **Compression type** {{ tag-all }} {#settings-topic-compression-type}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-compression-type }}**.

   See the description of the [Compression type](#settings-compression-type) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_compression.type).

* **Delete delay, ms** {{ tag-all }} {#settings-topic-file-delete-delay}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-delete-delay }}**.

   This is the time to wait before deleting a file from the file system.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#file.delete.delay.ms).

* **Delete retention** {{ tag-all }} {#settings-delete-retention}

   This setting determines the time in milliseconds to retain delete tombstone markers for topics with compressed logs. This setting only applies if the [log cleanup policy](#settings-topic-cleanup-policy) is either set to `Compact` or to `CompactAndDelete`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#delete.retention.ms).

* **Flush messages** {{ tag-all }} {#settings-topic-flush-messages}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-flush-messages }}**.

   See the description of the [Log flush interval messages](#settings-log-flush-interval-messages) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_flush.messages).

* **Flush, ms** {{ tag-all }} {#settings-topic-flush-ms}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-flush-ms }}**.

   See the description of the [Log flush interval ms](#settings-log-flush-interval-ms) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_flush.ms).

* **Message max bytes** {{ tag-all }} {#settings-topic-message-max-bytes}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_max-message-bytes }}**.

   This is maximum size in bytes for the producer's message.

   The minimum value is `0` (unlimited size), and the default one is `1048588`. This setting value must not exceed the **Replica fetch max bytes** value by more than 12 bytes.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_max.message.bytes).

* **Min compaction lag, ms** {{ tag-all }} {#settings-topic-max-compaction-lag-ms}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-min-compaction-lag }}**.

   It determines the minimum time a message will remain uncompressed in the log.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#min.compaction.lag.ms).

* **Minimum number of in-sync replicas** {{ tag-all }} {#settings-topic-min-insync-replicas}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_min-insync-replicas }}**.

   This is the minimum number of replicas to wait for the record confirmation from in order to consider a message successfully written to a topic. Use this setting if the producer has to wait for too long for a successful write acknowledgement from all broker hosts in the cluster.

   The minimum value depends on the number of [broker hosts](../../../managed-kafka/concepts/brokers.md):

   * For clusters with a single broker host: `1`.
   * For clusters with at least two broker hosts: `2`.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_min.insync.replicas).

* **Num partitions** {{ tag-all }} {#settings-topic-num-partitions}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_partitions }}**.

   It determines the number of log partitions per topic.

   The minimum and default value is `1`.

   See also the description of the [Num partitions](#settings-num-partitions) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Pre-allocation of the segment file** {{ tag-all }} {#settings-topic-preallocate}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-preallocate }}**.

   See also the description of the [Log preallocate](#settings-log-preallocate) cluster-level setting.

   By default, the space for the log file segments is allocated as logs become full (`false`).

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_preallocate).

* **Replication factor** {{ tag-all }} {#settings-topic-replication-factor}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_replication-factor }}**.

   It determines the number of [data copies](../../../managed-kafka/concepts/brokers.md) for a topic.

   The minimum and default value is `1`. The maximum value is equal to the number of broker hosts in the cluster.

   See also the description of the [Default replication factor](#settings-default-replication-factor) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#streamsconfigs_replication.factor).

* **Retention, bytes** {{ tag-all }} {#settings-topic-retention-bytes}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-retention-bytes }}**.

   See the description of the [Log retention bytes](#settings-log-retention-bytes) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_retention.bytes).

* **Retention, ms** {{ tag-all }} {#settings-topic-log-retention-ms}

   In the management console, this setting corresponds to **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}**.

   See the description of the [Log retention ms](#settings-log-retention-ms) cluster-level setting.

   For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_retention.ms).

* **Segment bytes** {{ tag-all }} {#settings-topic-segment-bytes}

   This setting determines the segment size for log files, in bytes.

   Segment files are saved and cleared file-by-file. The smaller the specified segment size, the more files will be in the log, while the storage management will be more flexible.

   The minimum value is `14` and the default one is `1073741824` (1 GB).

   See the description of the [Log segment bytes](#settings-log-segment-bytes) cluster-level setting.

   For more information, see [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) and the [{{ KF }} documentation](https://kafka.apache.org/documentation/#topicconfigs_segment.bytes).
