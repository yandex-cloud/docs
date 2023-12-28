* **Asynchronous insert log enabled**{#setting-asynchronous-insert-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Determines whether information about asynchronous inserts will be logged. These logs are saved to the `system.asynchronous_insert_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/system-tables/asynchronous_insert_log).

* **Asynchronous insert log retention size**{#setting-asynchronous-insert-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The size of the `system.asynchronous_insert_log` table (in bytes), which, when exceeded, will cause old records to be deleted from this table.

   The default value is `0` (old records will not be deleted as the table grows in size).

* **Asynchronous insert log retention time**{#setting-asynchronous-insert-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Time (in milliseconds) between making an entry in the `system.asynchronous_insert_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Asynchronous metric log enabled**{#setting-asynchronous-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Determines whether historical metric values from the `system.asynchronous_metrics` table will be logged to the `system.asynchronous_metric_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/asynchronous_metric_log).

* **Asynchronous metric log retention size**{#setting-asynchronous-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The size of the `system.asynchronous_metric_log` table (in bytes), which, when exceeded, will cause old records to be deleted from this table.

   The default value is `0` (old records will not be deleted as the table grows in size).

* **Asynchronous metric log retention time**{#setting-asynchronous-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Time (in milliseconds) between making an entry in the `system.asynchronous_metric_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Background buffer flush schedule pool size**{#setting-background-buffer-flush-schedule-pool-size} {{ tag-con }}

   The number of threads for background data flushing in [Buffer]({{ ch.docs }}/engines/table-engines/special/buffer) tables.

   The minimum value is `1`, while the default one is `16`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_buffer_flush_schedule_pool_size).

* **Background common pool size**{#setting-background-common-pool-size} {{ tag-con }} {{ tag-api }}

   The number of threads for executing common background operations, such as cleaning up the file system, in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

   The minimum value is `1`, while the default one is `8`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_common_pool_size).

* **Background distributed schedule pool size**{#setting-background-distributed-schedule-pool-size} {{ tag-con }}

   The number of threads for executing background operations in [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) tables.

   The minimum value is `1`, while the default one is `16`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_distributed_schedule_pool_size).

* **Background fetches pool size**{#setting-background-fetches-pool-size} {{ tag-con }} {{ tag-api }}

   The number of threads for executing background operations to copy data from a replica in [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication) tables.

   The minimum value is `1`, while the default one is `8`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_fetches_pool_size).

* **Background merges mutations concurrency ratio**{#setting-background-merges-mutations-concurrency-ratio} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The number of background merges and mutations that can be concurrently executed by each thread.

   The default value is `2`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).

* **Background message broker schedule pool size**{#setting-background-message-broker-schedule-pool-size} {{ tag-con }}

   The number of threads for executing background message translation operations. This setting is set to a new value when restarting the {{ CH }} server.

   The minimum value is `1`, while the default one is `16`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_message_broker_schedule_pool_size).

* **Background move pool size**{#setting-background-move-pool-size} {{ tag-con }}

   The number of threads for background moves of data parts in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

   The minimum value is `1`, while the default one is `8`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_move_pool_size).

* **Background pool size**{#setting-background-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The number of threads for executing background merges and [mutations]({{ ch.docs }}/sql-reference/statements/alter/#mutations) in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

   The minimum value is `1`, while the default one is `16`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_pool_size).

* **Background schedule pool size**{#setting-background-schedule-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The number of threads for background jobs. Used for replicated tables, streams in {{ KF }}, and updating a record's IP address in the internal DNS cache.

   The minimum value is `1`, while the default one is `128`. Changes to the setting take effect after restarting the cluster.

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Rules for compressing data in the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. For each rule, specify:

   * **Level**: Compression level. Only available for the [zstd]({{ ch.docs }}/sql-reference/statements/create/table#zstd) compression method. The minimum value is `1`, while the maximum one is `12`. The default value is `9`.
   * **Method**: Compression method. There are two methods available: [LZ4](https://lz4.github.io/lz4/) and [zstd](https://facebook.github.io/zstd/).
   * **Min part size**: Minimum size (in bytes) of a [data part]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/).
   * **Min part size ratio**: Ratio of the smallest table chunk to the overall table size. {{ CH }} will only apply the rule to those tables where this ratio does not exceed **Min part size ratio**.

   You can add multiple compression rules. {{ CH }} will check **Min part size** and **Min part size ratio** and apply the rules to tables that meet both conditions. If multiple rules can be applied to the same table, {{ CH }} applies the first one. If none of the rules are applicable, {{ CH }} uses the [LZ4](https://lz4.github.io/lz4/) compression method.

   Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings).

* **Default database**{#setting-default-database} {{ tag-con }} {{ tag-api }}

   Default database. To learn how to get a list of cluster databases, see [Managing databases](../../managed-clickhouse/operations/databases.md#list-db).

   Changes to the setting take effect after restarting the cluster.

* **Geobase enabled**{#setting-geobase-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Enables/disables the [built-in geobase dictionary](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts).

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Address of the archive containing the [user geobase](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) in {{ objstorage-name }}.

   Changes to the setting take effect after restarting the cluster.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree) engine configurations for [Graphite](http://graphite.readthedocs.io/en/latest/index.html) data thinning and aggregation/rollup:
   * **Name**: Configuration name.
   * **Patterns**: Set of thinning rules. A rule applies if the metric name matches the **Regexp** parameter value and the age of the data matches the **Retention** parameter group value.
      * **Function**: Aggregation function name.
      * **Regexp**: Regular expression that the metric name must match.
      * **Retention**: Retention parameters. The function is applied to the data age interval of [Age, Age + Precision]. You can set multiple groups of such parameters.
         * **Age**: Minimum data age (in seconds).
         * **Precision**: Accuracy of determining the data age (in seconds). The value must be a multiple of `86400` (number of seconds in 24 hours).

   You can set up multiple configurations and use them for different tables. Changes to the setting take effect after restarting the cluster.

   To learn more about Graphite support, see the [documentation for {{ CH }}]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/).

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Global authentication settings for [integration with {{ KF }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/):
   * **Enable ssl certificate verification**: Determines whether to perform SSL certificate verification. The default value is `false`.
   * **Max poll interval ms**: Maximum interval (in milliseconds) between polls to get messages for high-level consumers. If exceeded, the user is removed from the group and rebalancing starts. The default value is `300000` (5 minutes).
   * **Sasl mechanism**: SASL authentication mechanism:
      * `GSSAPI`: Authentication [using Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
      * `PLAIN`: Authentication [using a username-password pair as plain text](https://kafka.apache.org/documentation/#security_sasl_plain).
      * `SCRAM-SHA-256` and `SCRAM-SHA-512`: Authentication [using the SCRAM family of mechanisms](https://kafka.apache.org/documentation/#security_sasl_scram).
   * **Sasl password**: {{ KF }} account password.
   * **Sasl username**: {{ KF }} account username.
   * **Security protocol**: Security protocol used for authentication:
      * `PLAINTEXT`: Authentication credentials are sent as plain text.
      * `SSL`: Authentication credentials are sent with SSL encryption.
      * `SASL_PLAINTEXT`: Authentication credentials are sent as plain text with SASL transport.
      * `SASL_SSL`: Authentication credentials are sent with SSL encryption and SASL as transport.
   * **Session timeout ms**: Timeout (in milliseconds) for a periodic signal from a user to maintain a client group session. If exceeded, the broker removes the user from the group and runs rebalancing. The default value is `45000` (45 seconds).

   Changes to the settings take effect after restarting the cluster.

* **Kafka topics**{#setting-kafka-topics} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   [Topic](../../managed-kafka/concepts/topics.md)-level authentication settings for [integration with {{ KF }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/):

   * **Name**: {{ KF }} topic name.
   * **Settings**: Topic-level authentication settings similar to the global authentication settings in the [**Kafka**](#setting-kafka) section.

      If topic-level authentication settings are not specified for a table using the Kafka engine, global settings from the **Kafka** section will be used.

      Changes to the settings take effect after restarting the cluster.

      For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#security).

* **Keep alive timeout**{#setting-keep-alive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   The time (in seconds) since {{ CH }} received its last query before a connection was interrupted. If a new query comes in during this time, the connection does not terminate.

   The default value is `3`. Changes to the setting take effect after restarting the cluster.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Event logging level. At each next level, the log will contain complete information from the previous one:
   1. `ERROR`: Information about errors in the cluster.
   1. `WARNING`: Information about events that may cause errors in the cluster.
   1. `INFORMATION`: Confirmations and information about events that do not lead to errors in the cluster.
   1. `DEBUG`: System information for subsequent use in debugging.
   1. `TRACE`: All available information on cluster operation.

   For more information about log levels, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Approximate size (in bytes) of the mark cache used by table engines in the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family. The cache is shared by a cluster host. Memory is allocated as needed.

   The selected setting value is not a hard limit. {{ CH }} can use a little more or less memory for this cache.

   The default value is `5368709120`. Changes to the setting take effect after restarting the cluster.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Maximum number of simultaneously processed requests.

   The minimum value is `10`, while the default one is `500`. Changes to the setting take effect after restarting the cluster.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Maximum number of inbound client connections. This setting does not account for housekeeping connections established to run distributed subqueries.

   The minimum value is `10`, while the default one is `4096`. Changes to the setting take effect after restarting the cluster.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Maximum [partition]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key) size (bytes) for the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family, at which a table can be deleted using the `DROP TABLE` query. You can use this setting to protect tables with real data from inadvertent deletion, as these tables will normally be larger than test ones.

   The default value is `53687091200` (50 GB). When the value is set to `0`, you can delete tables of any size.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Maximum size (in bytes) of a table in the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family that you can delete using the `DROP TABLE` query. You can use this setting to protect tables with real data from inadvertent deletion, as these tables will normally be larger than test ones.

   The default value is `53687091200` (50 GB). When the value is set to `0`, you can delete tables of any size.

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   MergeTree engine configuration:

   * **Allow remote fs zero copy replication**: Determines whether to allow remote zero copy replication for S3 and HDFS disks.

      The default value is `false`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/integrations/s3#disable-zero-copy-replication).

   * **Cleanup delay period**: Interval (in seconds) between running [distributed DDL queries]({{ ch.docs }}/sql-reference/distributed-ddl) to clean up outdated data.

      The default value is `60` (one minute). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_move_pool_size).

   * **Inactive parts to delay insert**: Number of inactive data parts in a table. When exceeded, {{ CH }} will throttle the speed of table data inserts.

      This setting is disabled by default (`0`). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-delay-insert).

   * **Inactive parts to throw insert**: Number of inactive data parts in a table. When exceeded, {{ CH }} throws the `Too many inactive parts ...` exception.

      This setting is disabled by default (`0`). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-throw-insert).

   * **Max avg part size for too many parts**: Maximum average size of active data parts in a table (in bytes) that triggers **Parts to delay insert** and **Parts to throw insert** checks. If exceeded, data inserts into the table will neither slow down nor get rejected.

      The minimum value is `0`. The default value is `1073741824` (1 GB). Changes to the setting take effect after restarting the cluster.

   * **Max bytes to merge at max space in pool**: Maximum total size of data parts (in bytes) to merge when the background pool has available resources.

      The default value is `161061273600` (150 GB). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-max-space-in-pool).

   * **Max bytes to merge at min space in pool**: Maximum total data chunk size to merge with the background pool at minimum available resources.

      The default value is `1048576` (1 MB). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool).

   * **Max number of merges with ttl in pool**: Maximum number of TTL-based merges in the background pool.

      The default value is `2`. Changes to the setting take effect after restarting the cluster.

   * **Max parts in total**: Number of active data parts in all table partitions. When exceeded, {{ CH }} throws the `Too many parts ...` exception.

      The default value is `100000`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-parts-in-total).

   * **Max replicated merges in queue**: Maximum number of merge tasks that can be in the `ReplicatedMergeTree` queue at the same time.

      The default value is `16`. Changes to the setting take effect after restarting the cluster.

   * **Merge selecting sleep ms**: Timeout (in milliseconds) before merging a selection if no data part is selected.

      The default value is `5000` (5 seconds). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#merge_selecting_sleep_ms).

   * **Merge with recompression TTL timeout**: Minimum timeout (in seconds) before merges with recompression of data with expired TTL.

      The default value is `14400` (four hours). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

   * **Merge with TTL timeout**: Minimum timeout (in seconds) before merges to delete data with expired TTL.

      The default value is `14400` (four hours). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

   * **Min age to force merge on partition only**: Determines whether to only merge [partitions]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key) based on the **Min age to force merge seconds** setting value.

      Forcing merges on partitions only is disabled by default. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).

   * **Min age to force merge seconds**: Minimum age (in seconds) for a data part to be merged.

      The default value is `0` (merges are disabled). Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).

   * **Min bytes for wide part**: Minimum number of bytes in a data part that can be stored in `Wide` format. You can set it along with the **Min rows for wide part** parameter.

      If the number of bytes in a data part is less than the set value, it is stored in `Compact` format.

      Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

   * **Min rows for wide part**: Minimum number of rows in a data part that can be stored in `Wide` format. You can set it along with the **Min bytes for wide part** parameter.

      If the number of rows in a data part is less than the set value, it is stored in `Compact` format.

      Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

   * **Number of free entries in pool to execute mutation**: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} stops executing [mutation]({{ ch.docs }}/sql-reference/statements/alter/#mutations) operations. This allows having free threads available for merges and avoiding the `Too many parts ...` exception.

      The default value is `20`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings/#number-of-free-entries-in-pool-to-execute-mutation).

   * **Number of free entries in pool to lower max size of merge**: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} reduces the maximum size of a data part to merge. This helps handle small merges faster.

      The default value is `8`. Changes to the setting take effect after restarting the cluster.

   * **Parts to delay insert**: Number of active data chunks in a table. When it is exceeded, {{ CH }} will throttle the speed of table data inserts. An active chunk is a new chunk of data resulting from a merge.

      The default value is `150`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-delay-insert).

   * **Parts to throw insert**: Threshold value of active data parts in a table. When exceeded, {{ CH }} throws the `Too many parts ...` exception.

      The default value is `300`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-throw-insert).

   * **Replicated deduplication window**: Number of blocks for recent hash inserts that {{ ZK }} will store. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

      The default value is `100`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window).

   * **Replicated deduplication window seconds**: Time interval during which {{ ZK }} stores blocks of recent hash inserts. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

      The default value is `604800`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window-seconds).

   * **TTL only drop parts**: Sets data drop mode based on TTL:

      * `true`: Drop complete data parts.
      * `false`: Drop data row by row with additional data merges. This mode uses much more resources than dropping complete data parts.

      The default value is `false`. Changes to the setting take effect after restarting the cluster.

      For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#ttl_only_drop_parts).

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Determines whether metric values from the `system.metrics` and the `system.events` tables will be logged to `system.metric_log`.

   The default value is `true`. Changes to the setting take effect after restarting the cluster.

* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The size of the `system.metric_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default value is `536870912` (0.5 GB). When the value is set to `0`, old records will not be deleted as the table grows in size.

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Time (in milliseconds) between making an entry in the `system.metric_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Opentelemetry span log enabled**{#setting-opentelemetry-span-log-enabled} {{ tag-con }}

   Determines whether to log trace and metric values from a distributed application. These logs are saved to the `system.opentelemetry_span_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/opentelemetry).

* **Opentelemetry span log retention size**{#setting-opentelemetry-span-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The size of the `system.opentelemetry_span_log` table (in bytes), which, when exceeded, will cause old records to be deleted from this table.

   The default value is `0` (old records will not be deleted as the table grows in size).

* **Opentelemetry span log retention time**{#setting-opentelemetry-span-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Time (in milliseconds) between the making of an entry in the `system.opentelemetry_span_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The size of the `system.part_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default value is `536870912` (0.5 GB). When the value is set to `0`, old records will not be deleted as the table grows in size.

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Time (in milliseconds) between the making of an entry in the `system.part_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The size of the `system.query_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default value is `1073741824` (1 GB). When the value is set to `0`, old records will not be deleted as the table grows in size.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Time (in milliseconds) between the making of an entry in the `system.query_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Determines whether information about the threads used to run queries will be logged. Logs are saved to the `system.query_thread_log` table.

   The default value is `true`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/query_thread_log).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The size of the `system.query_thread_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default value is `536870912` (0.5 GB). When the value is set to `0`, old records will not be deleted as the table grows in size.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Time (in milliseconds) between the making of an entry in the `system.query_thread_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Query views log enabled**{#setting-query-views-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Determines whether information about dependent views executed when running queries will be logged. These logs are saved to the `system.query_views_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/query_views_log).

* **Query views log retention size**{#setting-query-views-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The size of the `system.query_views_log` table (in bytes), which, when exceede, will cause old records to be deleted from this table.

   The default value is `0` (old records will not be deleted as the table grows in size).

* **Query views log retention time**{#setting-query-views-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Time (in milliseconds) between making an entry in the `system.query_views_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Global authentication settings for [integration with {{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/):

   * **Password**: {{ RMQ }} account password.
   * **Username**: {{ RMQ }} account username.
   * **Vhost**: {{ RMQ }} virtual host address.

   Changes to the settings take effect after restarting the cluster.

* **Session log enabled**{#setting-session-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Determines whether information about successful and failed login/logout events will be logged. These logs are saved to the `system.session_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/session_log).

* **Session log retention size**{#setting-session-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The size of the `system.session_log` table (in bytes), which, when exceeded, will cause old records to be deleted from this table.

   The default value is `0` (old records will not be deleted as the table grows in size).

* **Session log retention time**{#setting-session-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Time (in milliseconds) between making an entry in the `system.session_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Determines whether system logs will be made. These logs are saved to the `system.text_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The level of event logging in the [system.text_log]({{ ch.docs }}/operations/system-tables/text_log) table. At each next level, the log will contain complete information from the previous one:

   * `ERROR`: Information about errors in the DBMS.
   * `WARNING`: Information about events that may cause errors in the DBMS.
   * `INFORMATION`: Confirmation and information about events that do not lead to errors in the DBMS.
   * `DEBUG`: System information for subsequent use in debugging.
   * `TRACE`: All available information on the DBMS operation.

   `TRACE` is the default. Changes to the setting take effect after restarting the cluster.

* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The size of the `system.text_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default value is `536870912` (0.5 GB). When the value is set to `0`, old records will not be deleted as the table grows in size.

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Time (in milliseconds) between the making of an entry in the `system.text_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Server time zone. Specified by the IANA identifier as the UTC time zone or geographical location (for example, Africa/Abidjan).

   Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).

* **Total memory profiler step**{#setting-total-memory-profiler-step} {{ tag-con }} {{ tag-api }}

   RAM (in bytes) for a stack trace at each memory allocation step. Data is stored in the `system.trace_log` housekeeping table. The `query_id` value is an empty string.

   The default value is `4194304` (4 MB). Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-profiler-step).

* **Total memory tracker sample probability**{#setting-total-memory-tracker-sample-probability} {{ tag-con }}

   Probability of logging information about accidental memory allocation and release (%). The log records are stored in the `system.trace_log` system view. The `trace_type` parameter takes the `MemorySample` parameter value. The probability refers to each memory allocation or release event, regardless of the amount of the allocated memory. Information is only selected when the amount of untracked memory exceeds the [Total memory profiler step](#setting-total-memory-profiler-step) setting value.

   By default, logging of accidental memory allocation and release is disabled (`0`). Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-tracker-sample-probability).

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Determines whether stack traces collected by the query profiler will be logged. Stack traces are saved to the `system.trace_log` table.

   The default value is `true`. Changes to the setting take effect after restarting the cluster.

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   The size of the `system.trace_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default value is `536870912` (0.5 GB). When the value is set to `0`, old records will not be deleted as the table grows in size.

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

   Time (in milliseconds) between the making of an entry in the `system.trace_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.

* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

   Cache size (in bytes) for uncompressed data used by the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table engines.

   The default value is `8589934592` (8 GB). Changes to the setting take effect after restarting the cluster.

* **Zookeeper log enabled**{#setting-zookeeper-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Determines whether {{ ZK }} server request and response parameters will be logged. These logs are saved to the `system.zookeeper_log` table.

   The default value is `false`. Changes to the setting take effect after restarting the cluster.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/zookeeper_log).

* **Zookeeper log retention size**{#setting-zookeeper-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   The size of the `system.zookeeper_log` table (in bytes), which, when exceeded, will cause old records to be deleted from this table.

   The default value is `0` (old records will not be deleted as the table grows in size).

* **Zookeeper log retention time**{#setting-zookeeper-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Time (in milliseconds) between making an entry in the `system.zookeeper_log` table and its deletion. The value must be a multiple of 1000.

   The default value is `2592000000` (30 days). When the value is `0`, the records will be stored for an unlimited period of time.
