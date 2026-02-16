* **Access control improvements**{#setting-access-control-improvements} {{ tag-con }}

    Access control system settings:

    * **Select from information schema requires grant**{#setting-select-from-information-schema-requires-grant}: Sets whether the `SELECT * FROM information_schema.<table>` query requires any permissions and whether any user can run the query. The default value is `false`. When set to `true`, you need the `GRANT SELECT ON information_schema.<table>` permission to run the query, same as for ordinary tables.

    * **Select from system db requires grant**{#setting-select-from-system-db-requires-grant}: Sets whether the `SELECT * FROM system.<table>` query requires any permissions and whether any user can run the query. The default value is `false`. When set to `true`, you need the `GRANT SELECT ON system.<table>` permission to run the query, same as for ordinary tables.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings#access_control_improvements).

* **Asynchronous insert log enabled**{#setting-asynchronous-insert-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Sets whether to log information about asynchronous inserts. Such logs will be saved to the `system.asynchronous_insert_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/system-tables/asynchronous_insert_log).

* **Asynchronous insert log retention size**{#setting-asynchronous-insert-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Size of the `system.asynchronous_insert_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Asynchronous insert log retention time**{#setting-asynchronous-insert-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time interval, in milliseconds, between adding a record to the `system.asynchronous_insert_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Asynchronous metric log enabled**{#setting-asynchronous-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Sets whether to log historical metric values from the `system.asynchronous_metrics` table to the `system.asynchronous_metric_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/system-tables/asynchronous_metric_log).

* **Asynchronous metric log retention size**{#setting-asynchronous-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Size of the `system.asynchronous_metric_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Asynchronous metric log retention time**{#setting-asynchronous-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time interval, in milliseconds, between adding a record to the `system.asynchronous_metric_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Background buffer flush schedule pool size**{#setting-background-buffer-flush-schedule-pool-size} {{ tag-con }}

    Number of threads for background data flushing in [Buffer]({{ ch.docs }}/engines/table-engines/special/buffer) tables.

    The minimum value is `1` and the default is `16`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_buffer_flush_schedule_pool_size).

* **Background common pool size**{#setting-background-common-pool-size} {{ tag-con }} {{ tag-api }}

    Number of threads for common background operations, such as file system clean up, in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

    The minimum value is `1` and the default is `8`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_common_pool_size).

* **Background distributed schedule pool size**{#setting-background-distributed-schedule-pool-size} {{ tag-con }}

    Number of threads for background operations in [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) tables.

    The minimum value is `1` and the default is `16`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_distributed_schedule_pool_size).

* **Background fetches pool size**{#setting-background-fetches-pool-size} {{ tag-con }} {{ tag-api }}

    Number of threads for background data copying from a replica in [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication) tables.

    The minimum value is `1`; for {{ CH }} 24.12 or lower, the default value is `16`; for 25.1 or higher, `32`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_fetches_pool_size).

* **Background merges mutations concurrency ratio**{#setting-background-merges-mutations-concurrency-ratio} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Number of background merges and mutations that each thread can run concurrently.

    The default value is `2`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).

* **Background message broker schedule pool size**{#setting-background-message-broker-schedule-pool-size} {{ tag-con }}

    Number of threads for background message translation operations. This setting gets a new value when restarting the {{ CH }} server.

    The minimum value is `1` and the default is `16`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_message_broker_schedule_pool_size).

* **Background move pool size**{#setting-background-move-pool-size} {{ tag-con }}

    Number of threads for background moves of data parts in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

    The minimum value is `1` and the default is `8`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_move_pool_size).

* **Background pool size**{#setting-background-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Number of threads for background merges and [mutations]({{ ch.docs }}/sql-reference/statements/alter/#mutations) in [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

    The minimum value is `1` and the default is `16`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_pool_size).

* **Background schedule pool size**{#setting-background-schedule-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Number of threads for background jobs. It is used for replicated tables, streams in {{ KF }}, and updating IP addresses of records in the internal DNS cache.

    The minimum value is `1` and the default is `128`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Data compression rules for [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables. For each rule, you need to specify the following:

    * **Level**: Compression level. It is only available for the [zstd]({{ ch.docs }}/sql-reference/statements/create/table#zstd) compression method. The minimum value is `1`, the maximum value is `12`, and the default value is `9`.
    * **Method**: Compression method. You can use either [LZ4](https://lz4.github.io/lz4/) or [zstd](https://facebook.github.io/zstd/).
    * **Min part size**: Minimum size of a [data part]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/), in bytes.
    * **Min part size ratio**: Ratio between the smallest table part size and full table size. {{ CH }} will only apply the rule to the tables where this ratio does not exceed **Min part size ratio**.

    You can add multiple compression rules. {{ CH }} will check the **Min part size** and **Min part size ratio** conditions and apply the rules to those tables that meet both of them. If multiple rules may apply to the same table, {{ CH }} applies the first one. If none of the rules apply, {{ CH }} will use the [LZ4](https://lz4.github.io/lz4/) compression method.

    Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/settings).

* **Default database**{#setting-default-database} {{ tag-con }} {{ tag-api }}

    Default database. To learn how to get a list of cluster databases, see [Managing databases](../../managed-clickhouse/operations/databases.md#list-db).

    Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Dictionaries lazy load**{#setting-dictionaries-lazy-load} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

    With this setting enabled, each dictionary is loaded when you first use it. If the loading fails, the function that uses the dictionary will return an exception.

    If the setting is disabled, the dictionaries are loaded when the server starts. The server waits for all the dictionaries to load before it starts processing connections.

    By default, the setting is disabled for {{ CH }} 24.12 or lower and enabled for 25.1 or higher.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings#server_configuration_parameters-dictionaries_lazy_load).

* **Geobase enabled**{#setting-geobase-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Enables/disables the [built-in geobase dictionary](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts).

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Address of the archive containing the [custom geobase](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) in {{ objstorage-name }}.

    Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree) engine configurations for [Graphite](http://graphite.readthedocs.io/en/latest/index.html) data thinning and aggregation (rollup):
    * **Name**: Configuration name.
    * **Patterns**: Thinning rules. A rule applies if the metric name matches the **Regexp** parameter value and the age of data matches the **Retention** parameter group value.
        * **Function**: Aggregation function name.
        * **Regexp**: Regular expression the metric name must match.
        * **Retention**: Retention parameters. The function applies to the data with the age interval of [Age, Age + Precision]. You can set multiple groups of such parameters.
            * **Age**: Minimum data age, in seconds.
            * **Precision**: Accuracy of determining the age of the data, in seconds. The value must be a multiple of `86400` (number of seconds in 24 hours).

    You can set up multiple configurations and use them for different tables. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    To create `GraphiteMergeTree` tables, specify column names for each one of such tables:

    * **Path column name**: Column with the metric name (`Graphite` sensor). The default value is `Path`.
    * **Time column name**: Column with the time of measuring the metric. The default value is `Time`.
    * **Value column name**: Column with the metric value. The default value is `Value`.
    * **Version column name**: Column with the metric version. The default value is `Timestamp`.

    To learn more about Graphite support, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/).

* **Jdbc bridge**{#setting-jdbc-bridge} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    JDBC bridge for queries against external databases. Specify the host and, optionally, port for accessing the data source.

    Changing these settings will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/integrations/jdbc/jdbc-with-clickhouse).

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Global authentication settings for [integration with {{ KF }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/):

    * **Auto offset reset**: Initial position from which a [consumer](../../managed-kafka/concepts/producers-consumers.md) starts reading messages. Starting from there, as the consumer reads incoming messages, it commits offsets for new ones. By default, no value is set (equivalent to `latest`). For more information, see [this Confluent guide](https://docs.confluent.io/platform/current/clients/consumer.html#offset-management).
    * **Debug**: Context for debugging purposes. By default, the value is not set. You can only specify one value for this setting. For the list of possible values, see the `librdkafka` library page on [GitHub](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).
    * **Enable ssl certificate verification**: Sets whether to verify SSL certificates. The default value is `false`.
    * **Max poll interval ms**: Maximum interval, in milliseconds, between polls to get messages for high-level consumers. If exceeded, the user is removed from the group and a rebalance starts. No value is set by default (equivalent to `300000`, 5 minutes).
    * **Sasl mechanism**: SASL authentication:
      * `GSSAPI` (default): Authentication [using Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
      * `PLAIN`: Authentication [using an unencrypted username-password pair](https://kafka.apache.org/documentation/#security_sasl_plain).
      * `SCRAM-SHA-256` and `SCRAM-SHA-512`: Authentication [using the SCRAM family mechanisms](https://kafka.apache.org/documentation/#security_sasl_scram).

      By default, no value is set (equivalent to `GSSAPI`).

    * **Sasl password**: {{ KF }} account password.
    * **Sasl username**: {{ KF }} account name.
    * **Security protocol**: Security protocol used for authentication:
        * `PLAINTEXT`: Authentication credentials are sent as plain text.
        * `SSL`: Authentication credentials are sent SSL encrypted.
        * `SASL_PLAINTEXT`: Authentication credentials are sent as plain text using SASL.
        * `SASL_SSL`: Authentication credentials are sent SSL encrypted using SASL.

        By default, no value is set (equivalent to `PLAINTEXT`).

    * **Session timeout ms**: Timeout, in milliseconds, for a periodic signal from a user to maintain a client group session. If exceeded, the broker removes the user from the group and runs a rebalance. For {{ CH }} 25.1 or lower, the default value is `45000` (45 s); for 25.2 or higher, `30000` (30 s).

    Changing these settings will restart {{ CH }} servers on the cluster hosts.

    {% note tip %}

    If you want to specify authentication settings at the [topic](../../managed-kafka/concepts/topics.md) level, specify them when [creating the Kafka table]({{ ch.docs }}/engines/table-engines/integrations/kafka#creating-a-table) or reuse them with [named collections]({{ ch.docs }}/operations/named-collections#named-collections-for-accessing-kafka).

    {% endnote %}

* **Keep alive timeout**{#setting-keep-alive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Time period, in seconds, from the moment {{ CH }} receives the last query until the connection is terminated. If a new query comes during this time interval, the connection is not terminated.

    The default value is `3`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Event logging level. At each next level, the log will contain complete information from the previous one:
    1. `ERROR`: Information about cluster errors.
    1. `WARNING`: Information about events that may result in cluster errors.
    1. `INFORMATION`: Confirmations and information about events that do not result in cluster errors.
    1. `DEBUG`: System information for debugging.
    1. `TRACE`: All available information on the cluster operation.

    For more information about logging levels, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Approximate size, in bytes, of the mark cache used by [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table engines. The cache is shared by a cluster host. Memory is allocated as needed.

    The selected setting value is not a strict limit. {{ CH }} can make this cache a little smaller or larger.

    The default value is `5368709120`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum number of concurrent queries.

    The minimum value is `10` and the default is `500`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum number of inbound client connections. This setting does not account for connections established to run distributed subqueries.

    The minimum value is `10` and the default is `4096`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table [partition]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key) size, in bytes, at which you can delete the table using a `DROP TABLE` query. You can use this setting to avoid accidental deletion of tables with real data, as these tables tend to be larger than test ones.

    The default value is `53687091200` (50 GB). When set to `0`, you can delete tables of any size.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Maximum size, in bytes, of a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table you can delete using a `DROP TABLE` query. You can use this setting to avoid accidental deletion of tables with real data, as these tables tend to be larger than test ones.

    The default value is `53687091200` (50 GB). When set to `0`, you can delete tables of any size.

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    MergeTree engine configuration:

    * **Allow remote fs zero copy replication**: Sets whether to allow remote zero copy replication for S3 and HDFS disks.

        The default value is `true`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/integrations/s3#disable-zero-copy-replication).

    * **Check sample column is correct**: When creating a table, checks that column data type is correct for sampling or sampling expressions.

        By default, the check is enabled. You can disable it if you already have tables with incorrect sampling expressions. This will eliminate false negatives and exceptions when starting the server.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings#check_sample_column_is_correct).

    * **Cleanup delay period**: Time interval, in seconds, between running [distributed DDL queries]({{ ch.docs }}/sql-reference/distributed-ddl) to clean up outdated data.

        The default value is `30`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server-settings-distributed_ddl).

    * **Deduplicate merge projection mode** {{ tag-con }} {{ tag-cli }}: Sets the background merge behavior in tables with projections:

        * `ignore`: Ignore the parameter. Use this value only to ensure compatibility.
        * `throw`: Generate an exception to prevent the projection parts from getting desynchronized.
        * `drop`: Delete the affected part of the projection table.
        * `rebuild`: Rebuild the affected part of the projection table.

        By default, no value is set (equivalent to `throw`). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).

    * **Inactive parts to delay insert**: Number of inactive table data parts, exceeding which will trigger {{ CH }} to throttle the speed of table data inserts.

        This setting is disabled by default (`0`). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-delay-insert).

    * **Inactive parts to throw insert**: Number of inactive table data parts, exceeding which will trigger {{ CH }} to throw the `Too many inactive parts ...` exception.

        This setting is disabled by default (`0`). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-throw-insert).

    * **Lightweight mutation projection mode** {{ tag-con }} {{ tag-cli }}: Sets the simplified deletion behavior in tables with projections:

        * `throw`: Generate an exception to prevent the projection parts from getting desynchronized.
        * `drop`: Delete the affected part of the projection table.
        * `rebuild`: Rebuild the affected part of the projection table.

        By default, no value is set (equivalent to `throw`). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

    * **Materialize ttl recalculate only** {{ tag-con }} {{ tag-cli }}: Enables applying modified TTL rules for tables or rows only when the query explicitly specifies `MATERIALIZE TTL`.

        The default value is:

        * For {{ CH }} versions 25.2 or higher: `true`. Recalculates only the TTL info, which simplifies TTL materialization.
        * For {{ CH }} versions 25.1 or lower: `false`. Complete TTL materialization is performed.

        Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only).

    * **Max avg part size for too many parts**: Maximum average size of active data parts in a table, in bytes, that triggers the **Parts to delay insert** and **Parts to throw insert** checks. If exceeded, data inserts into the table will neither slow down nor get rejected.

        The minimum value is `0` and the default is `1073741824` (1 GB). Changing this setting will restart {{ CH }} servers on the cluster hosts.

    * **Max bytes to merge at max space in pool**: Maximum total size of data parts, in bytes, to merge when the background pool has available resources.

        The default value is `161061273600` (150 GB). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-max-space-in-pool).

    * **Max bytes to merge at min space in pool**: Maximum total size of data parts to merge when the background pool has minimum available resources.

        The default value is `1048576` (1 MB). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool).

    * **Max cleanup delay period**: Maximum period, in seconds, to clean up outdated data, such as query logs, data block and data part hashes.

        Specify a value not smaller than that of **Cleanup delay period**.

        The default value is `300`.

    * **Max merge selecting sleep ms**: Maximum timeout, in milliseconds, before trying to select parts to merge.

        Specify a value not smaller than that of **Merge selecting sleep ms**.

        The default value is `60000` (one minute). If you specify a smaller value, selecting tasks will frequently run in the background task pool, which will result in a large amount of requests to {{ ZK }} in large-scale clusters.

    * **Max number of merges with ttl in pool**: Maximum number of TTL-based merges in the background pool.

        The default value is `2`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    * **Max parts in total**: Number of active data parts in all table partitions, exceeding which will trigger {{ CH }} to throw the `Too many parts ...` exception.

        For {{ CH }} 25.1 or lower, the default value is `100000`; for 25.2 or higher, `20000`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-parts-in-total).

    * **Max replicated merges in queue**: Maximum number of concurrent merge jobs in a `ReplicatedMergeTree` queue.

        The default value is `16`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    * **Merge max block size**: Number of rows in the blocks forming the data parts for merging.

        The database reads rows from these data parts, then merges those rows and writes them to a new data part. The rows being read are stored in RAM, so this setting affects its size required to merge rows. The smaller the value, the less RAM is available, which slows down row merging.

        The default value is `8192`.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings#merge-max-block-size).

    * **Merge selecting sleep ms**: Timeout, in milliseconds, before trying to select data parts to merge after no parts were selected.

        The default value is `5000` (five seconds). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/settings#merge_selecting_sleep_ms).

    * **Merge with recompression TTL timeout**: Minimum timeout, in seconds, before merges with recompression of data with expired TTL.

        The default value is `14400` (four hours). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

    * **Merge with TTL timeout**: Minimum timeout, in seconds, before merges to delete data with expired TTL.

        The default value is `14400` (four hours). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

    * **Min age to force merge on partition only**: Sets whether to only merge [partitions]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key) based on the **Min age to force merge seconds** setting value.

        Forcing merges on partitions only is disabled by default. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).

    * **Min age to force merge seconds**: Minimum time, in seconds, before a data part is merged.

        The default value is `0` (merging is disabled). Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).

    * **Min bytes for wide part**: Minimum number of bytes a data part must have to be stored in `Wide` format. You can set it together with **Min rows for wide part**.

        If a data part has fewer bytes than the set value, it will be stored in `Compact` format.

        Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    * **Min rows for wide part**: Minimum number of rows a data part must have to be stored in `Wide` format. You can set it together with **Min bytes for wide part**.

        If the number of rows in a data part is fewer than the set value, it will be stored in `Compact` format.

        Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    * **Number of free entries in pool to execute mutation**: Threshold for free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} stops running [mutations]({{ ch.docs }}/sql-reference/statements/alter/#mutations). Thus, you can have free threads for merges and avoid the `Too many parts ...` exception.

        The default value is `20`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings/#number-of-free-entries-in-pool-to-execute-mutation).

    * **Number of free entries in pool to lower max size of merge**: Threshold for free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} reduces the maximum size of a data part to merge. This helps handle small merges faster.

        The default value is `8`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    * **Parts to delay insert**: Number of active table data parts, exceeding which will trigger {{ CH }} to throttle the speed of table data inserts. An active data part is a new data part you get from a merge.

        For {{ CH }} 24.12 or lower, the default value is `150`; for 25.1 or higher, `1000`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-delay-insert).

    * **Parts to throw insert**: Threshold for active table data parts, exceeding which will trigger {{ CH }} to throw the `Too many parts ...` exception.

        For {{ CH }} 24.12 or lower, the default value is `300`; for 25.1 or higher, `3000`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-throw-insert).

    * **Replicated deduplication window**: Number of blocks for recent hash inserts that {{ ZK }} will store. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

        The default value is `100`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window).

    * **Replicated deduplication window seconds**: Time interval during which {{ ZK }} stores blocks of recent hash inserts. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

        The default value is `604800`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window-seconds).

    * **TTL only drop parts**: Sets data drop mode based on TTL:

        * `true`: Drop complete data parts.
        * `false`: Drop data row by row with additional data merges. This mode uses much more resources than dropping complete data parts.

        The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

        For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/settings/settings/#ttl_only_drop_parts).

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Sets whether to log metric values from the `system.metrics` and `system.events` tables to the `system.metric_log` table.

    The default value is `true`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Size of the `system.metric_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted irrespective of the table size.

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time interval, in milliseconds, between adding a record to the `system.metric_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Opentelemetry span log enabled**{#setting-opentelemetry-span-log-enabled} {{ tag-con }}

    Sets whether to log trace and metric values from a distributed application. Such logs will be saved to the `system.opentelemetry_span_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/opentelemetry).

* **Opentelemetry span log retention size**{#setting-opentelemetry-span-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Size of the `system.opentelemetry_span_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Opentelemetry span log retention time**{#setting-opentelemetry-span-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time interval, in milliseconds, between adding a record to the `system.opentelemetry_span_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Size of the `system.part_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted irrespective of the table size.

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time interval, in milliseconds, between adding a record to the `system.part_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Processors profile log enabled**{#setting-processors-profile-log-enabled} {{ tag-con }} {{ tag-cli }}

    Sets whether to log information about processor-level profiling. Such logs will be saved to the `system.processors_profile_log` table.

    The default value is:

    * For {{ CH }} versions 25.2 or higher: `true`.
    * For {{ CH }} versions 25.1 or lower: `false`.

    Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Processors profile log retention size**{#setting-processors-profile-log-retention-size} {{ tag-con }} {{ tag-cli }}

    Maximum size of the `system.processors_profile_log` table, in bytes, exceeding which will trigger automatic deletion of old records from that table.

   The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Processors profile log retention time**{#setting-processors-profile-log-retention-time} {{ tag-con }} {{ tag-cli }}

    Time interval, in milliseconds, between adding a record to the `system.processors_profile_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Query cache**{#setting-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    [Query cache]({{ ch.docs }}/operations/query-cache) settings. The cache allows you to run `SELECT` queries only once and use the saved results in subsequent operations. This reduces latency and cluster resource consumption when processing queries.

    The available query cache settings include:

    * **Max entries**: Maximum number of `SELECT` query results that can be cached. The default value is `1024`.
    * **Max entry size in bytes**: Maximum number of bytes to allocate in the cache for each `SELECT` query result. The default value is `1048576` (1 MB).
    * **Max entry size in rows**: Maximum number of rows to allocate in the cache for each `SELECT` query result. The default value is `30000000`.
    * **Max size in bytes**: Maximum cache size, in bytes. If set to `0`, the query cache will be disabled. The default value is `1073741824` (1 GB).

    You can learn more about these settings in [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters_query-cache).

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Size of the `system.query_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `1073741824` (1 GB). When set to `0`, old records will not be deleted irrespective of the table size.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time interval, in milliseconds, between adding a record to the `system.query_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Query masking rules**{#setting-query-masking-rules} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    [Query masking]({{ ch.docs }}/operations/server-configuration-parameters/settings#query-masking-rules) settings. Use these to apply regular expressions to queries and messages stored in logs. This makes data logging secure, as regular expressions help prevent leakage of sensitive data, such as names, emails, or bank card details.

    The available settings for the query masking rules include:

    * **Name**: Rule name. This is an optional setting.
    * **Regexp**: RE2 regular expression.
    * **Replace**: Expression to replace the sensitive data. Six asterisks are used by default.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Activates the `system.query_thread_log` table to log query threads in it. The logging also requires enabling the [Log query threads](../../managed-clickhouse/concepts/settings-list.md#setting-log-query-threads) setting.

    The default value is `true`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/system-tables/query_thread_log).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Size of the `system.query_thread_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted irrespective of the table size.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time interval, in milliseconds, between adding a record to the `system.query_thread_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Query views log enabled**{#setting-query-views-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Sets whether to log information about dependent views executed when running queries. Such logs will be saved to the `system.query_views_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/system-tables/query_views_log).

* **Query views log retention size**{#setting-query-views-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Size of the `system.query_views_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Query views log retention time**{#setting-query-views-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time interval, in milliseconds, between adding a record to the `system.query_views_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Global authentication settings for [integration with {{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/):

    * **Password**: {{ RMQ }} account password.
    * **Username**: {{ RMQ }} account name.
    * **Vhost**: {{ RMQ }} virtual host address.

    Changing these settings will restart {{ CH }} servers on the cluster hosts.

* **Session log enabled**{#setting-session-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Sets whether to log information about successful and failed login/logout events. Such logs will be saved to the `system.session_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/system-tables/session_log).

* **Session log retention size**{#setting-session-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Size of the `system.session_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Session log retention time**{#setting-session-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time interval, in milliseconds, between adding a record to the `system.session_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Sets whether to write system logs. Such logs will be saved to the `system.text_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Event logging level in the [system.text_log]({{ ch.docs }}/operations/system-tables/text_log) table. At each next level, the log will contain complete information from the previous one:

    * `ERROR`: Information about DBMS errors.
    * `WARNING`: Information about events that may result in DBMS errors.
    * `INFORMATION`: Confirmations and information about events that do not result in DBMS errors.
    * `DEBUG`: System information for debugging.
    * `TRACE`: All available information on the DBMS operation.

    The default value is `TRACE`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Size of the `system.text_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted irrespective of the table size.

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time interval, in milliseconds, between adding a record to the `system.text_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Server time zone. It is specified by the IANA identifier as the UTC time zone or geographical location, e.g., Africa/Abidjan.

    Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).

* **Total memory profiler step**{#setting-total-memory-profiler-step} {{ tag-con }} {{ tag-api }}

    RAM, in bytes, for a stack trace at each memory allocation step. Data is stored in the `system.trace_log` table. The `query_id` value is an empty string.

    The default value is `4194304` (4 MB). Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-profiler-step).

* **Total memory tracker sample probability**{#setting-total-memory-tracker-sample-probability} {{ tag-con }}

    Percentage probability of logging information about accidental memory allocation and release. Such log records are stored in the `system.trace_log` table. The `trace_type` parameter takes the value of the `MemorySample` parameter. The probability is valid for each memory allocation or release event, regardless of the allocation size. Information is only selected when the amount of untracked memory exceeds the [Total memory profiler step](#setting-total-memory-profiler-step) setting value.

    By default, accidental memory allocations and releases are not logged (`0`). Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-tracker-sample-probability).

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Sets whether to log stack traces collected by the query profiler. Stack traces are saved to the `system.trace_log` table.

    The default value is `true`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Size of the `system.trace_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `536870912` (0.5 GB). When set to `0`, old records will not be deleted irrespective of the table size.

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Time interval, in milliseconds, between adding a record to the `system.trace_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.

* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Cache size, in bytes, for uncompressed data used by the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table engines.

    The default value is `8589934592` (8 GB). Changing this setting will restart {{ CH }} servers on the cluster hosts.

* **Zookeeper log enabled**{#setting-zookeeper-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Sets whether to log {{ ZK }} server request and response parameters. Such logs will be saved to the `system.zookeeper_log` table.

    The default value is `false`. Changing this setting will restart {{ CH }} servers on the cluster hosts.

    For more information, see [this {{ CH }} guide]({{ ch.docs }}/operations/system-tables/zookeeper_log).

* **Zookeeper log retention size**{#setting-zookeeper-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Size of the `system.zookeeper_log` table, in bytes, exceeding which will trigger deletion of old records from that table.

    The default value is `0`, i.e., old records will not be deleted irrespective of the table size.

* **Zookeeper log retention time**{#setting-zookeeper-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Time interval, in milliseconds, between adding a record to the `system.zookeeper_log` table and deleting the record. This value must be a multiple of 1,000.

    The default value is `2592000000` (30 days). If `0`, the records will be stored indefinitely.
