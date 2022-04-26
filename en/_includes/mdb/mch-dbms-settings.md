* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Address of the archive with the [user geobase](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) in {{ objstorage-name }}.

* **Keep alive timeout**{#setting-} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    The time (in seconds) since {{ CH }} received its last query before a connection was interrupted. If a new query comes in during this time, the connection does not terminate.

    The default is `3`.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Event logging level. At each next level, the log will contain complete information from the previous one:
  1. `ERROR`: Information about errors in the cluster.
  1. `WARNING`: Information about events that may cause errors in the cluster.
  1. `INFORMATION`: Confirmations, information about events that don't lead to errors in the cluster.
  1. `DEBUG`: System information for subsequent use in debugging.
  1. `TRACE`: All available information on cluster operation.

  For more information about logging levels, see the [{{ CH }} documentation]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger){% endif %}.

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Approximate size (in bytes) of the mark cache used by table engines in the [MergeTree] family {% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/){% endif %}. The cache is shared by a cluster host. Memory is allocated as needed.

    The selected parameter value is not a hard and fast restriction. {{ CH }} can make this cache a little smaller or larger.

    The default is `5368709120`.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Maximum number of simultaneously processed requests.

    Minimum value is `10`. Default is `500`.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Maximum number of inbound client connections. This setting does not account for housekeeping connections established to run distributed subqueries.

    Minimum value is `10`. Default is `4096`.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Maximum size (in bytes) of the [partition]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/table_engines/custom_partitioning_key/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/table_engines/custom_partitioning_key/){% endif %} of a table in the [MergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/){% endif %} family at which you can delete a table using a `DROP TABLE` query. You can use the setting to protect tables with real data from inadvertent deletion because these tables will normally be larger than test ones.

    The default is `53687091200` (50 GB). When the value is `0`, you can delete tables of any size.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Maximum size (bytes) of a table in the [MergeTree] {% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/){% endif %} family that you can delete using a `DROP TABLE` query. You can use the setting to protect tables with real data from inadvertent deletion because these tables will normally be larger than test ones.

    The default is `53687091200` (50 GB). When the value is `0`, you can delete tables of any size.

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-tf }}

    Determines whether metric values from the `system.metrics` and the `system.events` tables will be logged to `system.metric_log`.

    The default is `true`.

* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-tf }}

    The size of the `system.metric_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

    The default is `536870912` (0.5 GB). When the value is `0`, old records will not be deleted as the table grows in size.

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-tf }}

    Time (in milliseconds) between making an entry in the `system.metric_log` table and its deletion. The value must be a multiple of 1000.

    The default is `2592000000` (30 days). When the value is `0`, records are stored indefinitely.

* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-tf }}

    The size of the `system.part_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

    The default is `536870912` (0.5 GB). When the value is `0`, old records will not be deleted as the table grows in size.

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-tf }}

    Time (in milliseconds) between the making of an entry in the `system.part_log` table and its deletion. The value must be a multiple of 1000.

    The default is `2592000000` (30 days). When the value is `0`, records are stored indefinitely.

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-tf }}

    The size of the `system.query_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

    The default is `1073741824` (1 GB). When the value is `0`, old records will not be deleted as the table grows in size.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-tf }}

    Time (in milliseconds) between the making of an entry in the `system.query_log` table and its deletion. The value must be a multiple of 1000.

    The default is `2592000000` (30 days). When the value is `0`, records are stored indefinitely.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-tf }}

    Determines whether information about the threads used to run queries will be logged. Logs are saved to the `system.query_thread_log` table.

    The default is `true`.

    For more information, see the [{{ CH }} documentation]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/system-tables/query_thread_log){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/system-tables/query_thread_log){% endif %}.

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-tf }}

    The size of the `system.query_thread_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

   The default is `536870912` (0.5 GB). When the value is `0`, old records will not be deleted as the table grows in size.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-tf }}

    Time (in milliseconds) between the making of an entry in the `system.query_thread_log` table and its deletion. The value must be a multiple of 1000.

    The default is `2592000000` (30 days). When the value is `0`, records are stored indefinitely.

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-tf }}

    Determines whether system logs will be made. These logs are saved to the `system.text_log` table.

    The default is `false`.

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-tf }}

  Event logging level for the [system.text_log]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/system-tables/text_log){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/system-tables/text_log){% endif %} table. At each next level, the log will contain complete information from the previous one:
  1. `ERROR`: Information about errors in the DBMS.
  1. `WARNING`: Information about events that may cause errors in the DBMS.
  1. `INFORMATION`: Confirmation and information about events that don't lead to errors in the DBMS.
  1. `DEBUG`: System information for subsequent use in debugging.
  1. `TRACE`: All available information on the DBMS operation.

    `TRACE` is the default.

* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-tf }}

    The size of the `system.text_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

    The default is `536870912` (0.5 GB). When the value is `0`, old records will not be deleted as the table grows in size.

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-tf }}

    Time (in milliseconds) between the making of an entry in the `system.text_log` table and its deletion. The value must be a multiple of 1000.

    The default is `2592000000` (30 days). When the value is `0`, records are stored indefinitely.

* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Server time zone. Specified by the IANA identifier as the UTC time zone or geographical location (for example, Africa/Abidjan).

  For more information, see the [{{ CH }}]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone){% endif %} documentation.

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-tf }}

    Determines whether stack traces collected by the query profiler will be logged. Stack traces are saved to the `system.trace_log`  table.

    The default is `true`.

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-tf }}

    The size of the `system.trace_log` table (in bytes), which will cause old records to be deleted from this table when exceeded.

    The default is `536870912` (0.5 GB). When the value is `0`, old records will not be deleted as the table grows in size.

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-tf }}

    Time (in milliseconds) between the making of an entry in the `system.trace_log` table and its deletion. The value must be a multiple of 1000.

    The default is `2592000000` (30 days). When the value is `0`, records are stored indefinitely.

* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Size (in bytes) of the uncompressed data cache used by table engines in the [MergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/){% endif %} family.

    The default is `8589934592` (8 GB).

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Data compression rules for tables in the [MergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/){% endif %} family. For each rule, specify:
    * **Method**: Compression method. Two methods are available: [LZ4](https://lz4.github.io/lz4/) and [zstd](https://facebook.github.io/zstd/).
    * **Min part size** is the minimum size of a [data part]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/custom-partitioning-key/){% endif %} (in bytes).
    * **Min part size ratio**: Minimum ratio of table part size to total table size. {{ CH }} only applies the rule to tables in which this ratio is greater than or equal to the **Min part size ratio** value.

    You can add multiple compression rules. {{ CH }} checks the **Min part size** and **Min part size ratio** conditions and applies the rules to those tables that meet both of them. If multiple rules can be applied to the same table, {{ CH }} applies the first one. If no rule fits, {{ CH }} will apply the [LZ4](https://lz4.github.io/lz4/) compression method.

    For more information, see the [{{ CH }}]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/server_settings/settings/#compression){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/server_settings/settings/#compression){% endif %} documentation.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Engine configuration for [GraphiteMergeTree]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/table_engines/graphitemergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/table_engines/graphitemergetree/){% endif %} to decimate and aggregate/roll up [Graphite](http://graphite.readthedocs.io/en/latest/index.html) data:
    * **Name**: Configuration name.
    * **Patterns**: Set of thinning rules. A rule applies if the metric name matches the **Regexp** parameter value and the age of the data matches the **Retention** parameter group value.
       * **Function**: Aggregation function name.
       * **Regexp**: Regular expression that the metric name must match.
       * **Retention**: Retention parameters. The function applies to data whose age is in the range of [Age, Age + Precision]. You can set several groups of these parameters.
         * **Age**: Minimum data age, in seconds.
         * **Precision**: Accuracy of determining the age of the data, in seconds. The value must be a multiple of `86400` (number of seconds in 24 hours).

    You can set up multiple configurations and use them for different tables.

    For more information on Graphite support, see the [{{ CH }}]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/graphitemergetree/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/graphitemergetree/){% endif %} documentation.

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-tf }}

  Global authentication settings for [integration with {{ KF }}]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/kafka/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/integrations/kafka/){% endif %}:
  * **Sasl mechanism**: SASL authentication mechanism:
    - `GSSAPI`: Authentication [using Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
    - `PLAIN`: Authentication [using the "username-password" pair passed as plain text](https://kafka.apache.org/documentation/#security_sasl_plain).
    - `SCRAM-SHA-256` and `SCRAM-SHA-512`: Authentication [using the SCRAM family mechanisms](https://kafka.apache.org/documentation/#security_sasl_scram).
  * **Sasl password**: Password of an {{ KF }} account.
  * **Sasl username**: Username of an {{ KF }} account.
  * **Security protocol**: Security protocol used for authentication:
    * `PLAINTEXT`: Authentication credentials are sent as plain text.
    * `SSL`: Authentication credentials are sent with SSL encryption.
    * `SASL_PLAINTEXT`: Authentication credentials are sent as plain text with SASL transport.
    * `SASL_SSL`: Authentication credentials are sent with SSL encryption and SASL as transport.

  For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#security).

* **Kafka topics**{#setting-kafka-topics} {{ tag-con }} {{ tag-tf }}

    Authentication settings at the [topics](../../managed-kafka/concepts/topics.md) level for [integration with {{ KF }}]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/kafka/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/integrations/kafka/){% endif %}:

     * **Name**: {{ KF }} topic name.

     * **Settings**: Topic-level authentication settings similar to the global authentication settings in the [**Kafka**](#setting-kafka) section.

       If topic-level authentication settings are not specified for a table using the Kafka engine, global settings from the **Kafka** section will be used.

       For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#security).

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    MergeTree engine configuration:

    * **Max bytes to merge at min space in pool**: Maximum total size of [data chunks]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool){% endif %} for merging when the number of free threads in the background pool is at its minimum.

      The default is `1048576` (1 MB).

    * **Max replicated merges in queue**: Maximum number of merge tasks that can be in the `ReplicatedMergeTree` queue at the same time.

      The default is `16`.

    * **Number of free entries in pool to lower max size of merge**: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} reduces the maximum size of a data part to merge. This helps handle small merges faster.

      The default is `8`.

    * **Parts to delay insert**: Number of active data chunks in a table. When it is exceeded, {{ CH }} will throttle the speed of table data inserts. An active chunk is a new chunk of data resulting from a merge.

      The default is `150`.

    * **Parts to throw insert**: Threshold number of active data chunks in a table. When it is exceeded, {{ CH }} throws the `Too many parts ...` exception.

      The default is `300`.

    * **Replicated deduplication window**: Number of blocks for recent hash inserts that {{ ZK }} will store. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

      The default is `100`.

    * **Replicated deduplication window seconds**: Time interval during which {{ ZK }} stores blocks of recent hash inserts. Deduplication only works for the most recently inserted data. Old blocks will be deleted.

      The default is `604800`.

    For more information, see the [{{ CH }} documentation]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree){% endif %}.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-tf }}

    Global authentication settings for [integration with {{ RMQ }}]{% if lang == "ru" %}(https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/rabbitmq/){% endif %}{% if lang == "en" %}(https://{{ ch-domain }}/docs/en/engines/table-engines/integrations/rabbitmq/){% endif %}:
    * **Password**: {{ RMQ }} Account password.
    * **Username**: {{ RMQ }} Account name.
