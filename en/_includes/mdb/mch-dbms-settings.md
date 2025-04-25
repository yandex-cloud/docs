* **Asynchronous insert log enabled**{#setting-asynchronous-insert-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Determines whether information about asynchronous inserts will be logged. These logs are saved to the `system.asynchronous_insert_log` table.

    Default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/system-tables/asynchronous_insert_log).

* **Asynchronous insert log retention size**{#setting-asynchronous-insert-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The size of the `system.asynchronous_insert_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    Default value is `0` (old records will not be deleted as the table grows in size).

* **Asynchronous insert log retention time**{#setting-asynchronous-insert-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in milliseconds) between adding an entry to the `system.asynchronous_insert_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Asynchronous metric log enabled**{#setting-asynchronous-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Determines whether to log historical metric values from the `system.asynchronous_metrics` table to the `system.asynchronous_metric_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/asynchronous_metric_log).

* **Asynchronous metric log retention size**{#setting-asynchronous-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The size of the `system.asynchronous_metric_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `0` (old records will not be deleted as the table grows in size).

* **Asynchronous metric log retention time**{#setting-asynchronous-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in milliseconds) between adding an entry to the `system.asynchronous_metric_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Background buffer flush schedule pool size**{#setting-background-buffer-flush-schedule-pool-size} {{ tag-con }}

    Number of threads for background data flushing in [Buffer]({{ ch.docs }}/engines/table-engines/special/buffer) tables.

    Minimum value: `1`; default value: `16`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_buffer_flush_schedule_pool_size).

* **Background common pool size**{#setting-background-common-pool-size} {{ tag-con }} {{ tag-api }}

    Number of threads for common background operations, such as file system clean up, in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

    Minimum value: `1`; default value: `8`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_common_pool_size).

* **Background distributed schedule pool size**{#setting-background-distributed-schedule-pool-size} {{ tag-con }}

    Number of threads for background operations in [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) tables.

    The minimum value is `1`; the default value is `16`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_distributed_schedule_pool_size).

* **Background fetches pool size**{#setting-background-fetches-pool-size} {{ tag-con }} {{ tag-api }}

    Number of threads for background jobs of copying data from a replica in [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication) tables.

    The minimum value is `1`; the default value is `8`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_fetches_pool_size).

* **Background merges mutations concurrency ratio**{#setting-background-merges-mutations-concurrency-ratio} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The number of background merges and mutations that can be concurrently executed by each thread.

    Default value is `2`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).

* **Background message broker schedule pool size**{#setting-background-message-broker-schedule-pool-size} {{ tag-con }}

    Number of threads for background message translation operations. This setting is set to a new value when restarting the {{ CH }} server.

    The minimum value is `1`; the default value is `16`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_message_broker_schedule_pool_size).

* **Background move pool size**{#setting-background-move-pool-size} {{ tag-con }}

    Number of threads for background moves of data parts in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

    The minimum value is `1`; the default value is `8`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_move_pool_size).

* **Background pool size**{#setting-background-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Number of threads for background merges and [mutations]({{ ch.docs }}/sql-reference/statements/alter/#mutations) in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

    The minimum value is `1`; the default value is `16`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_pool_size).

* **Background schedule pool size**{#setting-background-schedule-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    The number of threads for background jobs. Used for replicated tables, streams in {{ KF }}, and updating a record's IP address in the internal DNS cache.

    Minimum value: `1`; default value: `128`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Data compression rules for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. For each rule, specify:

    * **Level**: Compression level. Only available for the [zstd]({{ ch.docs }}/sql-reference/statements/create/table#zstd) compression method. Minimum value: `1`; maximum value: `12`; default: `9`.
    * **Method**: Compression method. Available methods: [LZ4](https://lz4.github.io/lz4/) and [zstd](https://facebook.github.io/zstd/).
    * **Min part size**: Minimum size (in bytes) of a [data part]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/).
    * **Min part size ratio**: Ratio between the smallest table part size and full table size. {{ CH }} will only apply the rule to tables where this ratio does not exceed **Min part size ratio**.

    You can add multiple compression rules. {{ CH }} will check the **Min part size** and **Min part size ratio** conditions and apply the rules to those tables that meet both of them. If multiple rules can be applied to the same table, {{ CH }} applies the first one. If none of the rules are applicable, {{ CH }} uses the [LZ4](https://lz4.github.io/lz4/) compression method.

    Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings).

* **Default database**{#setting-default-database} {{ tag-con }} {{ tag-api }}

    Default database. To learn how to get a list of cluster databases, see [Managing databases](../../managed-clickhouse/operations/databases.md#list-db).

    Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Dictionaries lazy load**{#setting-dictionaries-lazy-load} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

    With this setting enabled, each dictionary is loaded the first time it is used. If the loading fails, the function that uses the dictionary will return an exception.

    If the setting is disabled, the dictionaries are loaded when the server starts. The server waits for all the dictionaries to be loaded before it starts processing connections.

    This setting is on by default.

    For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings#server_configuration_parameters-dictionaries_lazy_load).

* **Geobase enabled**{#setting-geobase-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Enables/disables the [built-in geobase dictionary](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts).

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Address of the archive containing the [user geobase](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) in {{ objstorage-name }}.

    Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree) engine configurations for [Graphite](http://graphite.readthedocs.io/en/latest/index.html) data thinning and aggregation (rollup):
    * **Name**: Configuration name.
    * **Patterns**: Set of thinning rules. A rule applies if the metric name matches the **Regexp** parameter value and the age of the data matches the **Retention** parameter group value.
        * **Function**: Aggregation function name.
        * **Regexp**: Regular expression that the metric name must match.
        * **Retention**: Retention parameters. The function is applied to the data age interval of [Age, Age + Precision]. You can set multiple groups of such parameters.
            * **Age**: Minimum data age (in seconds).
            * **Precision**: Accuracy of determining the data age (in seconds). The value must be a multiple of `86400` (number of seconds in 24 hours).

    You can set up multiple configurations and use them for different tables. Changing this setting will restart {{ CH }} servers on cluster hosts.

    To create `GraphiteMergeTree` tables, specify column names for each one of such tables:

    * **Path column name**: Column with the name of the metric (`Graphite` sensor). The default value is `Path`.
    * **Time column name**: Column with the time the metric was measured. The default value is `Time`.
    * **Value column name**: Column with the metric value. The default value is `Value`.
    * **Version column name**: Column with the metric version. The default value is `Timestamp`.

    To learn more about Graphite support, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/).

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Global authentication settings for [integration with {{ KF }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/):

    * **Auto offset reset**: Initial position from which the [consumer](../../managed-kafka/concepts/producers-consumers.md) starts reading messages. Starting from there, the consumer adds shifts for new messages as it moves forward reading the incoming messages. By default, the value is not set (equivalent to `latest`). For more information, see the [Confluent documentation](https://docs.confluent.io/platform/current/clients/consumer.html#offset-management).
    * **Debug**: Context for debugging purposes. By default, the value is not set. You can only specify one value in the setting. For the list of possible values, see the `librdkafka` library documentation on [GitHub](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).
    * **Enable ssl certificate verification**: Determines whether to perform SSL certificate verification. The default value is `false`.
    * **Max poll interval ms**: Maximum interval (in milliseconds) between polls to get messages for high-level consumers. If exceeded, the user is removed from the group and rebalancing starts. No value is set by default (equivalent to `300000`, 5 minutes).
    * **Sasl mechanism**: SASL authentication mechanism:
      * `GSSAPI` (default): Authentication [using Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
      * `PLAIN`: Authentication [using a username-password pair as plain text](https://kafka.apache.org/documentation/#security_sasl_plain).
      * `SCRAM-SHA-256` and `SCRAM-SHA-512`: Authentication [using the SCRAM family methods](https://kafka.apache.org/documentation/#security_sasl_scram).

      By default, the value is not set (equivalent to `GSSAPI`).

    * **Sasl password**: {{ KF }} account password.
    * **Sasl username**: {{ KF }} account username.
    * **Security protocol**: Security protocol used for authentication:
        * `PLAINTEXT`: Authentication credentials are sent as plain text.
        * `SSL`: Authentication credentials are sent SSL encrypted.
        * `SASL_PLAINTEXT`: Authentication credentials are sent as plain text through SASL.
        * `SASL_SSL`: Authentication credentials are sent SSL encrypted through SASL.

        By default, the value is not set (equivalent to `PLAINTEXT`).

    * **Session timeout ms**: Timeout (in milliseconds) for a periodic signal from a user to maintain a client group session. If exceeded, the broker removes the user from the group and runs rebalancing. By default, the value is not set (equivalent to `45000`, 45 seconds).

    Changing these settings will restart {{ CH }} servers on the cluster hosts.

* **Kafka topics**{#setting-kafka-topics} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    [Topic](../../managed-kafka/concepts/topics.md)-level authentication settings for [{{ KF }} integration]({{ ch.docs }}/engines/table-engines/integrations/kafka/):

    * **Name**: {{ KF }} topic name.
    * **Settings**: Topic-level authentication settings similar to the global authentication settings in the [**Kafka**](#setting-kafka) section.

        If topic-level authentication settings are not specified for a table using the Kafka engine, global settings from the **Kafka** section will be used.

        Changing these settings will restart {{ CH }} servers on the cluster hosts.

        For more information, see the relevant [{{ KF }} documentation](https://kafka.apache.org/documentation/#security).

* **Keep alive timeout**{#setting-keep-alive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    The time (in seconds) since {{ CH }} received its last query before a connection was interrupted. If a new query comes in during this time, the connection does not terminate.

    Default value is `3`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Event logging level. At each next level, the log will contain complete information from the previous one:
    1. `ERROR`: Information about cluster errors.
    1. `WARNING`: Information about events that may lead to cluster errors.
    1. `INFORMATION`: Confirmations and information about events not leading to cluster errors.
    1. `DEBUG`: System information for subsequent use in debugging.
    1. `TRACE`: All available information on cluster operation.

    For more information about logging levels, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Approximate size (in bytes) of the mark cache used by [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table engines. The cache is shared by a cluster host. Memory is allocated as needed.

    The selected parameter value is not a hard and fast restriction. {{ CH }} can make this cache a little smaller or larger.

    Default value is `5368709120`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum number of simultaneously processed requests.

    Minimum value: `10`; default value: `500`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum number of inbound client connections. This setting does not account for housekeeping connections established to run distributed subqueries.

    Minimum value: `10`; default value: `4096`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table [partition]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key) size (in bytes) at which the table can be deleted with a `DROP TABLE` query. You can use this setting to protect tables with real data from inadvertent deletion, as these tables will normally be larger than test ones.

    Default value is `53687091200` (50 GB). When set to `0`, you can delete tables of any size.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum size (in bytes) of a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table you can delete with a `DROP TABLE` query. You can use this setting to protect tables with real data from inadvertent deletion, as these tables will normally be larger than test ones.

    Default value is `53687091200` (50 GB). When set to `0`, you can delete tables of any size.

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    MergeTree engine configuration:

    * **Allow remote fs zero copy replication**: Determines whether to allow remote zero copy replication for S3 and HDFS disks.

        The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/integrations/s3#disable-zero-copy-replication).

    * **Check sample column is correct**: When creating a table, checks that column data type is correct for sampling or sampling expressions.

        By default, the check is enabled. You can disable it if you already have tables with incorrect sampling expressions. This will eliminate false positives and exceptions when starting the server.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings#check_sample_column_is_correct).

    * **Cleanup delay period**: Interval (in seconds) between running [distributed DDL queries]({{ ch.docs }}/sql-reference/distributed-ddl) to clean up outdated data.

        The default value is `60` (one minute). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server-settings-distributed_ddl).

    * **Inactive parts to delay insert**: Number of inactive table data parts which, when exceeded, will cause {{ CH }} to throttle the speed of table data inserts.

        This setting is disabled by default (`0`). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-delay-insert).

    * **Inactive parts to throw insert**: Number of inactive table data parts which, when exceeded, will cause {{ CH }} to throw the `Too many inactive parts ...` exception.

        This setting is disabled by default (`0`). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-throw-insert).

    * **Max avg part size for too many parts**: Maximum average size of active data parts in a table (in bytes) that triggers **Parts to delay insert** and **Parts to throw insert** checks. If exceeded, data inserts into the table will neither slow down nor get rejected.

        Minimum value: `0`; default value: `1073741824` (1 GB). Changing this setting will restart {{ CH }} servers on cluster hosts.

    * **Max bytes to merge at max space in pool**: Maximum total size of data parts (in bytes) to merge when the background pool has available resources.

        Default value is `161061273600` (150 GB). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-max-space-in-pool).

    * **Max bytes to merge at min space in pool**: Maximum total data chunk size to merge with the background pool at minimum available resources.

        Default value is `1048576` (1 MB). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool).

    * **Max cleanup delay period**: Maximum period (in seconds) to clean up outdated data, such as query logs, data block and data part hashes.

        Specify a value not smaller than that of **Cleanup delay period**.

        The default value is `300`.

    * **Max merge selecting sleep ms**: Maximum timeout (in milliseconds) before merging a selection.

        Specify a value not smaller than that of **Merge selecting sleep ms**.

        The default value is `60000` (one minute). If you specify a smaller value, selection jobs to often run in the background job pool. Thus, high capacity clusters will accumulate a large number of requests to {{ ZK }}.

    * **Max number of merges with ttl in pool**: Maximum number of TTL-based merges in the background pool.

        The default value is `2`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    * **Max parts in total**: Number of active data parts in all table partitions which, when exceeded, will cause {{ CH }} to throw the `Too many parts ...` exception.

        Default value is `100000`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-parts-in-total).

    * **Max replicated merges in queue**: Maximum number of merge tasks that can be in a `ReplicatedMergeTree` queue at the same time.

        Default value is `16`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    * **Merge max block size**: Number of rows in the blocks forming the data parts for merging.

        The database reads rows from these data parts, then merges those rows and writes them to a new data part. The rows being read are stored in RAM, so the setting affects its size required to merge rows. The smaller the value, the less RAM is available, which slows down row merging.

        The default value is `8192`.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings#merge-max-block-size).

    * **Merge selecting sleep ms**: Timeout (in milliseconds) before merging a selection if no data part is selected.

        Default value is `5000` (five seconds). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#merge_selecting_sleep_ms).

    * **Merge with recompression TTL timeout**: Minimum timeout (in seconds) before merges with recompression of data with expired TTL.

        Default value is `14400` (four hours). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

    * **Merge with TTL timeout**: Minimum timeout (in seconds) before merges to delete data with expired TTL.

        Default value is `14400` (four hours). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

    * **Min age to force merge on partition only**: Whether to apply the merge from the **Min age to force merge seconds** setting only to [partitions]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key).

        Forcing merges on partitions only is disabled by default. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).

    * **Min age to force merge seconds**: Minimum age (in seconds) for a data part to be merged.

        Default value is `0` (merge disabled). Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).

    * **Min bytes for wide part**: Minimum number of bytes a data part must have to be stored in `Wide` format. You can set it together with the **Min rows for wide part** parameter.

        If a data part has fewer bytes than the set value, it will be stored in `Compact` format.

        Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    * **Min rows for wide part**: Minimum number of rows a data part must have to be stored in `Wide` format. You can set it together with the **Min bytes for wide part** parameter.

        If the number of rows in a data part is less than the set value, the data part will be stored in `Compact` format.

        Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    * **Number of free entries in pool to execute mutation**: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} stops executing [mutation]({{ ch.docs }}/sql-reference/statements/alter/#mutations) operations. This allows to leave free threads for merges and to avoid the `Too many parts ...` exception.

        Default value is `20`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings/#number-of-free-entries-in-pool-to-execute-mutation).

    * **Number of free entries in pool to lower max size of merge**: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} reduces the maximum size of a data part to merge. This helps handle small merges faster.

        Default value is `8`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    * **Parts to delay insert**: Number of active table data parts which, when exceeded, will cause {{ CH }} to throttle the speed of table data inserts. An active chunk is a new chunk of data resulting from a merge.

        Default value is `150`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-delay-insert) documentation.

    * **Parts to throw insert**: Threshold value of active table data parts which, when exceeded, will cause {{ CH }} to throw the `Too many parts ...` exception.

        Default value is `300`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-throw-insert).

    * **Replicated deduplication window**: Number of blocks for recent hash inserts that {{ ZK }} will store. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

        Default value is `100`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window).

    * **Replicated deduplication window seconds**: Time interval during which {{ ZK }} stores blocks of recent hash inserts. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

        Default value is `604800`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window-seconds).

    * **TTL only drop parts**: Sets data drop mode based on TTL:

        * `true`: Drop complete data parts.
        * `false`: Drop data row by row with additional data merges. This mode uses much more resources than dropping complete data parts.

        The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

        For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#ttl_only_drop_parts).

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Determines whether to log metric values from the `system.metrics` and `system.events` tables to the `system.metric_log` table.

    Default value is `true`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    The size of the `system.metric_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    Default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted as the table grows in size.

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time (in milliseconds) between adding an entry to the `system.metric_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Opentelemetry span log enabled**{#setting-opentelemetry-span-log-enabled} {{ tag-con }}

    Determines whether to log trace and metric values from a distributed application. These logs are saved to the `system.opentelemetry_span_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/opentelemetry).

* **Opentelemetry span log retention size**{#setting-opentelemetry-span-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The size of the `system.opentelemetry_span_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `0` (old records will not be deleted as the table grows in size).

* **Opentelemetry span log retention time**{#setting-opentelemetry-span-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in milliseconds) between adding an entry to the `system.opentelemetry_span_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    The size of the `system.part_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted as the table grows in size.

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time (in milliseconds) between adding an entry to the `system.part_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Query cache**{#setting-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    [Query cache](https://clickhouse.com/docs/en/operations/query-cache) settings. The cache allows you to execute `SELECT` queries only once and use the saved results in subsequent operations. This reduces latency and cluster resource consumption when processing queries.

    Available query cache settings:

    * **Max entries**: Maximum number of `SELECT` query results that can be cached. The default value is `1024`.
    * **Max entry size in bytes**: Maximum number of bytes that can be allocated in the cache for each `SELECT` query result. The default value is `1048576` (1 MB).
    * **Max entry size in rows**: Maximum number of rows that can be allocated in the cache for each `SELECT` query result. The default value is `30000000`.
    * **Max size in bytes**: Maximum cache size in bytes. If set to `0`, the query cache will be disabled. The default value is `1048576` (1 GB).

    For more information about the settings, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters_query-cache).

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    The size of the `system.query_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    Default value is `1073741824` (1 GB). When set to `0`, old records will not be deleted as the table grows in size.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time (in milliseconds) between adding an entry to the `system.query_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Query masking rules**{#setting-query-masking-rules} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    [Query masking]({{ ch.docs }}/operations/server-configuration-parameters/settings#query-masking-rules) settings. Use these to apply regular expressions to queries and messages stored in logs. This makes data logging secure, as regular expressions help prevent leakage of sensitive data, such as names, emails, or bank card details.

    Available settings for the query masking rules:

    * **Name**: Rule name. This is an optional parameter.
    * **Regexp**: RE2 regular expression.
    * **Replace**: Expression to replace the sensitive data. Six asterisks are used by default.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Activates the `system.query_thread_log` table to log query threads in it. The logging also requires that the [Log query threads](../../managed-clickhouse/concepts/settings-list.md#setting-log-query-threads) setting is enabled.

    The default value is `true`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/query_thread_log).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    The size of the `system.query_thread_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted as the table grows in size.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time (in milliseconds) between adding an entry to the `system.query_thread_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Query views log enabled**{#setting-query-views-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Determines whether information about dependent views executed when running queries will be logged. These logs are saved to the `system.query_views_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/query_views_log).

* **Query views log retention size**{#setting-query-views-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The size of the `system.query_views_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `0` (old records will not be deleted as the table grows in size).

* **Query views log retention time**{#setting-query-views-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in milliseconds) between adding an entry to the `system.query_views_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Global authentication settings for [integration with {{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/):

    * **Password**: {{ RMQ }} account password.
    * **Username**: {{ RMQ }} account username.
    * **Vhost**: {{ RMQ }} virtual host address.

    Changing these settings will restart {{ CH }} servers on the cluster hosts.

* **Session log enabled**{#setting-session-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Determines whether information about successful and failed login/logout events will be logged. These logs are saved to the `system.session_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/session_log).

* **Session log retention size**{#setting-session-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The size of the `system.session_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `0` (old records will not be deleted as the table grows in size).

* **Session log retention time**{#setting-session-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in milliseconds) between adding an entry to the `system.session_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Determines whether system logs will be made. These logs are saved to the `system.text_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Event logging level in the [system.text_log]({{ ch.docs }}/operations/system-tables/text_log) table. At each next level, the log will contain complete information from the previous one:

    * `ERROR`: Information about DBMS errors.
    * `WARNING`: Information about events that may lead to DBMS errors.
    * `INFORMATION`: Confirmation and information about events not leading to DBMS errors.
    * `DEBUG`: System information for subsequent use in debugging.
    * `TRACE`: All available information on DBMS operation.

    Default value is `TRACE`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    The size of the `system.text_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted as the table grows in size.

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time (in milliseconds) between adding an entry to the `system.text_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Server time zone. Specified by the IANA identifier as the UTC time zone or geographical location (for example, Africa/Abidjan).

    Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).

* **Total memory profiler step**{#setting-total-memory-profiler-step} {{ tag-con }} {{ tag-api }}

    RAM (in bytes) for a stack trace at each memory allocation step. The data is stored in the `system.trace_log` system table. The `query_id` value is an empty string.

    Default value is `4194304` (4 MB). Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-profiler-step).

* **Total memory tracker sample probability**{#setting-total-memory-tracker-sample-probability} {{ tag-con }}

    Probability of logging information about accidental memory allocation and release (%). These log records are stored in the `system.trace_log` system table. The `trace_type` parameter takes the value of the `MemorySample` parameter. The probability is valid for each memory allocation or release event, regardless of the allocation size. Information is only selected when the amount of untracked memory exceeds the [Total memory profiler step](#setting-total-memory-profiler-step) setting value.

    By default, accidental memory allocations and releases are not logged (`0`). Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-tracker-sample-probability).

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Determines whether stack traces collected by the query profiler will be logged. Stack traces are saved to the `system.trace_log` table.

    The default value is `true`. Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    The size of the `system.trace_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted as the table grows in size.

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time (in milliseconds) between adding an entry to the `system.trace_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Cache size (in bytes) for uncompressed data used by the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table engines.

    Default value is `8589934592` (8 GB). Changing this setting will restart {{ CH }} servers on cluster hosts.

* **Zookeeper log enabled**{#setting-zookeeper-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Determines whether {{ ZK }} server request and response parameters will be logged. These logs are saved to the `system.zookeeper_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on cluster hosts.

    For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/system-tables/zookeeper_log).

* **Zookeeper log retention size**{#setting-zookeeper-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    The size of the `system.zookeeper_log` table (in bytes), which, when exceeded, will cause old records to be deleted from that table.

    The default value is `0` (old records will not be deleted as the table grows in size).

* **Zookeeper log retention time**{#setting-zookeeper-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time (in milliseconds) between adding an entry to the `system.zookeeper_log` table and deleting the entry. The value must be a multiple of 1000.

    Default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.
