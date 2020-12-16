* **Geobase uri**: Address of the archive with the [user geobase](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) in {{ objstorage-name }}.

* **Keep alive timeout**: Amount of time in seconds after the last request to {{ CH }}, during which the server waits for a new request. If no requests are received during this time, {{ CH }} breaks the connection. To learn more, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#keep-alive-timeout).

* **Log level**: Event logging level. At each next level, the log will contain complete information from the previous one:
   1. `ERROR`: Information about errors in the cluster.
   1. `WARNING`: Information about events that may cause errors in the cluster.
   1. `INFORMATION`: Confirmations, information about events that don't lead to errors in the cluster.
   1. `DEBUG`: System information to be used later in debugging.
   1. `TRACE`: All available information about cluster performance.

   For more information about log levels, see the [{{ CH }} documentation](https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).

* **Mark cache size**: Approximate size (in bytes) of the mark cache used by MergeTree table engines. The cache is shared by the server and memory is allocated as needed. To learn more about logging in {{ CH }}, see the [documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#server-mark-cache-size).

* **Max concurrent queries**: Maximum number of queries processed simultaneously. To learn more, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max-concurrent-queries).

* **Max connections**: Maximum number of inbound connections. To learn more, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max-connections).

* **Max partition size to drop**: Maximum size (in bytes) of a [partition](https://clickhouse.yandex/docs/en/operations/table_engines/custom_partitioning_key/) in a [MergeTree](https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/) table, which you can delete using a `DROP` query.

* **Max table size to drop**: Maximum size (in bytes) of a [MergeTree](https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/) table, which you can delete using a `DROP` query. If 0, you can delete all tables without restrictions. To learn more, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max-table-size-to-drop).

* **Metric log enabled**: Enables or disables logging of the history of metric values from the [system.metrics](https://clickhouse.tech/docs/en/operations/system-tables/metrics) and [system.events](https://clickhouse.tech/docs/en/operations/system-tables/events) tables to the [system.metric_log](https://clickhouse.tech/docs/en/operations/system-tables/metric_log) table. Logging is enabled by default (`true`).

* **Metric log retention size**: The maximum size in bytes that the [system.metric_log](https://clickhouse.tech/docs/en/operations/system-tables/metric_log) table can reach before old records start being deleted from it. A value of 0 means that the old records aren't deleted as the table size grows. Default value: 536870912 (0.5 GB).

* **Metric log retention time**: The period of time in milliseconds after which a record in the [system.metric_log](https://clickhouse.tech/docs/en/operations/system-tables/metric_log) table is deleted. Time is counted as soon as the record is created in the table. A value of 0 means that records aren't deleted when the time elapses. The value must be a multiple of 1000. Default value: 2592000000 (30 days).

* **Part log retention size**: The maximum size in bytes that the [system.part_log](https://clickhouse.tech/docs/en/operations/system-tables/part_log) table can reach before old records start being deleted from it. A value of 0 means that the old records aren't deleted as the table size grows. Default value: 536870912 (0.5 GB).

* **Part log retention time**: The period of time in milliseconds after which a record in the [system.part_log](https://clickhouse.tech/docs/en/operations/system-tables/part_log) table is deleted. Time is counted as soon as the record is created in the table. A value of 0 means that records aren't deleted when the time elapses. The value must be a multiple of 1000. Default value: 2592000000 (30 days).

* **Query log retention size**: The maximum size in bytes that the [system.query_log](https://clickhouse.tech/docs/en/operations/system-tables/query_log) table can reach before old records start being deleted from it. A value of 0 means that the old records aren't deleted as the table size grows. Default value: 1073741824 (1 GB).

* **Query log retention time**: The period of time in milliseconds after which a record in the [system.query_log](https://clickhouse.tech/docs/en/operations/system-tables/query_log) table is deleted. Time is counted as soon as the record is created in the table. A value of 0 means that records aren't deleted when the time elapses. The value must be a multiple of 1000. Default value: 2592000000 (30 days).

* **Query thread log enabled**: Enables or disables logging of information about the threads that execute requests, such as the name of the thread, time it was started, and how long a request was processed. Logs are written to the [system.query_thread_log](https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log) table. Logging is enabled by default (`true`).

* **Query thread log retention size**: The maximum size in bytes that the [system.query_thread_log](https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log) table can reach before old records start being deleted from it. A value of 0 means that the old records aren't deleted as the table size grows. Default value: 536870912 (0.5 GB).

* **Query thread log retention time**: The period of time in milliseconds after which a record in the [system.query_thread_log](https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log) table is deleted. Time is counted as soon as the record is created in the table. A value of 0 means that records aren't deleted when the time elapses. The value must be a multiple of 1000. Default value: 2592000000 (30 days).

* **Text log enabled**: Enables or disables writing of system logs to the [system.text_log](https://clickhouse.tech/docs/en/operations/system-tables/text_log) table. Logging is disabled by default (`false`).

* **Text log level**: The level of event logging in the [system.text_log](https://clickhouse.tech/docs/en/operations/system-tables/text_log) table. At each next level, the log will contain complete information from the previous one:
   1. `ERROR`: Information about errors in the DBMS.
   1. `WARNING`: Information about events that may cause errors in the DBMS.
   1. `INFORMATION`: Confirmation and information about events that don't lead to errors in the DBMS.
   1. `DEBUG`: System information to be used later in debugging.
   1. `TRACE`: All available information about DBMS performance.

* **Text log retention size**: The maximum size in bytes that the [system.text_log](https://clickhouse.tech/docs/en/operations/system-tables/text_log) table can reach before old records start being deleted from it. A value of 0 means that the old records aren't deleted as the table size grows. Default value: 536870912 (0.5 GB).

* **Text log retention time**: The period of time in milliseconds after which a record in the [system.text_log](https://clickhouse.tech/docs/en/operations/system-tables/text_log) table is deleted. Time is counted as soon as the record is created in the table. A value of 0 means that records aren't deleted when the time elapses. The value must be a multiple of 1000. Default value: 2592000000 (30 days).

* **Timezone**: Server time zone. Specified by the IANA identifier as the UTC time zone or geographical location (for example, Africa/Abidjan). For more information, see the [{{ CH }} documentation](https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).

* **Trace log enabled**: Enables or disables logging of stack traces collected by the request profiler to the [system.trace_log](https://clickhouse.tech/docs/en/operations/system-tables/trace_log) table. Logging is enabled by default (`true`).

* **Trace log retention size**: The maximum size in bytes that the [system.trace_log](https://clickhouse.tech/docs/en/operations/system-tables/trace_log) table can reach before old records start being deleted from it. A value of 0 means that the old records aren't deleted as the table size grows. Default value: 536870912 (0.5 GB).

* **Trace log retention time**: The period of time in milliseconds after which a record in the [system.trace_log](https://clickhouse.tech/docs/en/operations/system-tables/trace_log) table is deleted. Time is counted as soon as the record is created in the table. A value of 0 means that records aren't deleted when the time elapses. The value must be a multiple of 1000. Default value: 2592000000 (30 days).

* **Uncompressed cache size**: Cache size in bytes for uncompressed data used by the MergeTree table engines. To learn more, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#server-settings-uncompressed_cache_size).

* **Compression**: Rules for compressing data in [MergeTree]( https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree) tables.
   * **Method**: Compression method. Two methods are available: [LZ4](https://lz4.github.io/lz4/) and [zstd](https://facebook.github.io/zstd/).
   * **Min part size**: Minimum size (in bytes) of a [data part](https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/#mergetree-data-storage) in a table. {{ CH }} only applies the rule to tables with data parts greater than or equal to the **Min part size** value.
   * **Min part size ratio**: Minimum ratio of table part size to total table size. {{ CH }} only applies the rule to tables in which this ratio is greater than or equal to the **Min part size ratio** value.

    You can add multiple compression rules. {{ CH }} checks the **Min part size** and **Min part size ratio** conditions and applies the rules to those tables that meet both of them. If multiple rules can be applied to the same table, {{ CH }} applies the first one. If none of the rules are applicable, {{ CH }} uses the LZ4 compression method. To learn more, see the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression)

* **Graphite rollup**: [GraphiteMergeTree](https://clickhouse.yandex/docs/en/operations/table_engines/graphitemergetree/) engine configurations for thinning and aggregating/averaging (rollup) [Graphite](http://graphite.readthedocs.io/en/latest/index.html) data. You can set up multiple configurations and use them for different tables.

  To learn more about Graphite support in {{ CH }}, see the [documentation](https://clickhouse.yandex/docs/en/operations/table_engines/graphitemergetree/).
   * **Name**: Configuration name.
   * **Patterns**: Set of thinning rules. A rule applies if the metric name matches the **Regexp** parameter value and the age of the data matches the **Retention** parameter group value.
      * **Function**: Aggregation function name.
      * **Regexp**: Regular expression that the metric name must match.
      * **Retention**: Retention parameters. The function applies to data whose age is in the range of [Age, Age + Precision]. You can set several groups of these parameters.
         * **Age**: Minimum data age, in seconds.
         * **Precision**: Accuracy of determining the age of the data, in seconds. Must be a divisor of 86,400 (the number of seconds in 24 hours).

* **Merge tree**: MergeTree engine configuration. For more information, see the [{{ CH }} documentation](https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree)
   * **Max bytes to merge at min space in pool**: Maximum total size of a [data part](https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/#mergetree-data-storage) to merge when the number of free threads in the background pool is minimum.
   * **Max replicated merges in queue**: Maximum number of merge tasks that can be in the `ReplicatedMergeTree` queue at the same time.
   * **Number of free entries in pool to lower max size of merge**: Threshold value of free entries in the pool. If the number of entries in the pool falls below this value, {{ CH }} reduces the maximum size of a data part to merge. This helps handle small merges faster, rather than filling the pool with lengthy merges.
   * **Parts to delay insert**: Number of active data parts in a table. When exceed, {{ CH }} starts artificially reducing the rate of inserting data into the table.
   * **Parts to throw insert**: Threshold value of active data parts in a table. When exceeded,{{ CH }} throws the 'Too many parts ...' exception.
   * **Replicated deduplication window**: Number of recent hash blocks that {{ ZK }} stores (old ones are deleted).
   * **Replicated deduplication window seconds**: Time during which {{ ZK }} stores hash blocks (old ones are deleted).

