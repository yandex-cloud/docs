---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-clickhouse/cli-ref/cluster/update-config.md
---

# yc managed-clickhouse cluster update-config

Update the configuration of a ClickHouse cluster.

#### Command Usage

Syntax:

`yc managed-clickhouse cluster update-config <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the ClickHouse cluster. ||
|| `--name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--set` | `key1=value1[,key2=value2][,"key3=val3a,val3b"]`

Set a parameter for a ClickHouse cluster. Can be specified multiple times. Acceptable keys:

- `background_pool_size`: Sets the number of threads performing background merges and mutations for MergeTree-engine tables.

  Default value: **16**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_pool_size).

- `background_merges_mutations_concurrency_ratio`: Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.

  For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently.
This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority.

  Default value: **2**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).

- `background_schedule_pool_size`: The maximum number of threads that will be used for constantly executing some lightweight periodic operations
for replicated tables, Kafka streaming, and DNS cache updates.

  Default value: **512**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_schedule_pool_size).

- `background_fetches_pool_size`: The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.

  Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_fetches_pool_size).

- `background_move_pool_size`: The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.

  Default value: **8**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_move_pool_size).

- `background_distributed_schedule_pool_size`: The maximum number of threads that will be used for executing distributed sends.

  Default value: **16**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_distributed_schedule_pool_size).

- `background_buffer_flush_schedule_pool_size`: The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.

  Default value: **16**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_buffer_flush_schedule_pool_size).

- `background_message_broker_schedule_pool_size`: The maximum number of threads that will be used for executing background operations for message streaming.

  Default value: **16**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_message_broker_schedule_pool_size).

- `background_common_pool_size`: The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.

  Default value: **8**.

  Change of the setting is applied with restart on value decrease and without restart on value increase.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_common_pool_size).

- `dictionaries_lazy_load`: Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup.

  Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#dictionaries_lazy_load).

- `log_level`: Logging level.

- `query_log_retention_size`: The maximum size that query_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_log data based on size is disabled.

  Default value: **1073741824** (1 GiB).

- `query_log_retention_time`: The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `query_thread_log_enabled`: Enables or disables query_thread_log system table.

  Default value: **true**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_thread_log).

- `query_thread_log_retention_size`: The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_thread_log data based on size is disabled.

  Default value: **536870912** (512 MiB).

- `query_thread_log_retention_time`: The maximum time that query_thread_log records will be retained before removal. If set to **0**,
automatic removal of query_thread_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `part_log_retention_size`: The maximum size that part_log can grow to before old data will be removed. If set to **0**,
automatic removal of part_log data based on size is disabled.

  Default value: **536870912** (512 MiB).

- `part_log_retention_time`: The maximum time that part_log records will be retained before removal. If set to **0**,
automatic removal of part_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `metric_log_enabled`: Enables or disables metric_log system table.

  Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/metric_log).

- `metric_log_retention_size`: The maximum size that metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of metric_log data based on size is disabled.

  Default value: **536870912** (512 MiB).

- `metric_log_retention_time`: The maximum time that metric_log records will be retained before removal. If set to **0**,
automatic removal of metric_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `trace_log_enabled`: Enables or disables trace_log system table.

  Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/trace_log).

- `trace_log_retention_size`: The maximum size that trace_log can grow to before old data will be removed. If set to **0**,
automatic removal of trace_log data based on size is disabled.

  Default value: **536870912** (512 MiB).

- `trace_log_retention_time`: The maximum time that trace_log records will be retained before removal. If set to **0**,
automatic removal of trace_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `text_log_enabled`: Enables or disables text_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/text_log).

- `text_log_retention_size`: The maximum size that text_log can grow to before old data will be removed. If set to **0**,
automatic removal of text_log data based on size is disabled.

  Default value: **536870912** (512 MiB).

- `text_log_retention_time`: The maximum time that text_log records will be retained before removal. If set to **0**,
automatic removal of text_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `text_log_level`: Logging level for text_log system table.

  Default value: **TRACE**.

  Change of the setting is applied with restart.

- `opentelemetry_span_log_enabled`: Enables or disables opentelemetry_span_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/opentelemetry_span_log).

- `opentelemetry_span_log_retention_size`: The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**,
automatic removal of opentelemetry_span_log data based on size is disabled.

  Default value: **0**.

- `opentelemetry_span_log_retention_time`: The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**,
automatic removal of opentelemetry_span_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `query_views_log_enabled`: Enables or disables query_views_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_views_log).

- `query_views_log_retention_size`: The maximum size that query_views_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_views_log data based on size is disabled.

  Default value: **0**.

- `query_views_log_retention_time`: The maximum time that query_views_log records will be retained before removal. If set to **0**,
automatic removal of query_views_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `asynchronous_metric_log_enabled`: Enables or disables asynchronous_metric_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_metric_log).

- `asynchronous_metric_log_retention_size`: The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_metric_log data based on size is disabled.

  Default value: **0**.

- `asynchronous_metric_log_retention_time`: The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_metric_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `session_log_enabled`: Enables or disables session_log system table.

  Default value: **true** for versions 25.3 and higher, **false** for versions 25.2 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log).

- `session_log_retention_size`: The maximum size that session_log can grow to before old data will be removed. If set to **0**,
automatic removal of session_log data based on size is disabled.

  Default value: **536870912** (512 MiB) for versions 25.3 and higher, **0** for versions 25.2 and lower.

- `session_log_retention_time`: The maximum time that session_log records will be retained before removal. If set to **0**,
automatic removal of session_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `zookeeper_log_enabled`: Enables or disables zookeeper_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/zookeeper_log).

- `zookeeper_log_retention_size`: The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**,
automatic removal of zookeeper_log data based on size is disabled.

  Default value: **0**.

- `zookeeper_log_retention_time`: The maximum time that zookeeper_log records will be retained before removal. If set to **0**,
automatic removal of zookeeper_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `asynchronous_insert_log_enabled`: Enables or disables asynchronous_insert_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_insert_log).

- `asynchronous_insert_log_retention_size`: The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_insert_log data based on size is disabled.

  Default value: **0**.

- `asynchronous_insert_log_retention_time`: The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_insert_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `processors_profile_log_enabled`: Enables or disables processors_profile_log system table.

  Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/processors_profile_log).

- `processors_profile_log_retention_size`: The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**,
automatic removal of processors_profile_log data based on size is disabled.

  Default value: **0**.

- `processors_profile_log_retention_time`: The maximum time that processors_profile_log records will be retained before removal. If set to **0**,
automatic removal of processors_profile_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `error_log_enabled`: Enables or disables error_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/error_log).

- `error_log_retention_size`: The maximum size that error_log can grow to before old data will be removed. If set to **0**,
automatic removal of error_log data based on size is disabled.

  Default value: **0**.

- `error_log_retention_time`: The maximum time that error_log records will be retained before removal. If set to **0**,
automatic removal of error_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `query_metric_log_enabled`: Enables or disables query_metric_log system table.

  Default value: **false**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_metric_log).

- `query_metric_log_retention_size`: The maximum size that query_metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_metric_log data based on size is disabled.

  Default value: **536870912** (512 MiB).

- `query_metric_log_retention_time`: The maximum time that query_metric_log records will be retained before removal. If set to **0**,
automatic removal of query_metric_log data based on time is disabled.

  Default value: **2592000000** (30 days).

- `access_control_improvements.select_from_system_db_requires_grant`: Sets whether **SELECT * FROM system.&lt;table&gt;** requires any grants and can be executed by any user.
If set to true then this query requires **GRANT SELECT ON system.&lt;table&gt;** just as for non-system tables.

  Default value: **false**.

- `access_control_improvements.select_from_information_schema_requires_grant`: Sets whether **SELECT * FROM information_schema.&lt;table&gt;** requires any grants and can be executed by any user.
If set to true, then this query requires **GRANT SELECT ON information_schema.&lt;table&gt;**, just as for ordinary tables.

  Default value: **false**.

- `max_connections`: Maximum number of inbound connections.

  Default value: **4096**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_connections).

- `max_concurrent_queries`: Maximum number of concurrently executed queries.

  Default value: **500**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_concurrent_queries).

- `max_table_size_to_drop`: Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query.

  Default value: **50000000000** (48828125 KiB).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_table_size_to_drop).

- `max_partition_size_to_drop`: Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query.

  Default value: **50000000000** (48828125 KiB).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_partition_size_to_drop).

- `keep_alive_timeout`: The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.

  Default value: **3** for versions 25.10 and higher, **30** for versions 25.9 and lower.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#keep_alive_timeout).

- `uncompressed_cache_size`: Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#uncompressed_cache_size).

- `mark_cache_size`: Maximum size (in bytes) of the cache of "marks" used by MergeTree tables.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#mark_cache_size).

- `timezone`: The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.

  Default value: **Europe/Moscow**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#timezone).

- `geobase_enabled`: Enables or disables geobase.

  Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower.

  Change of the setting is applied with restart.

- `geobase_uri`: Address of the archive with the user geobase in Object Storage.

  Change of the setting is applied with restart.

- `default_database`: The default database.

  Default value: **default**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#default_database).

- `total_memory_profiler_step`: Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect
the allocating stack trace. **0** means disabled memory profiler.

  Default value: **0**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_profiler_step).

- `total_memory_tracker_sample_probability`: Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table
with trace_type equal to a MemorySample with the specified probability.

  Default value: **0**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_tracker_sample_probability).

- `async_insert_threads`: Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled.

  Default value: **16**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#async_insert_threads).

- `backup_threads`: The maximum number of threads to execute **BACKUP** requests.

  Default value: **16**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#backup_threads).

- `restore_threads`: The maximum number of threads to execute **RESTORE** requests.

  Default value: **16**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#restore_threads).

- `vector_similarity_index_cache_size`: Size of cache for vector similarity indexes, in bytes. **0** means disabled.

  Default value: **5368709120** (5 GiB).

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#vector_similarity_index_cache_size).

- `vector_similarity_index_cache_max_entries`: Size of cache for vector similarity indexes, in entries. **0** means disabled.

  Default value: **10000000**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#vector_similarity_index_cache_max_entries).

- `max_build_vector_similarity_index_thread_pool_size`: The maximum number of threads to use for building vector indexes. **0** means unlimited.

  Default value: **16**.

  Change of the setting is applied with restart.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_build_vector_similarity_index_thread_pool_size).

- `merge_tree.parts_to_delay_insert`: If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down.

  Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_delay_insert).

- `merge_tree.parts_to_throw_insert`: If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT**
is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts".

  Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_throw_insert).

- `merge_tree.inactive_parts_to_delay_insert`: If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value,
an **INSERT** is artificially slowed down.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_delay_insert).

- `merge_tree.inactive_parts_to_throw_insert`: If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value,
**INSERT** is interrupted with an error.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_throw_insert).

- `merge_tree.max_avg_part_size_for_too_many_parts`: The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average
part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold,
**INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server
if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.

  Default value: **1073741824** (1 GiB).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_avg_part_size_for_too_many_parts).

- `merge_tree.max_parts_in_total`: If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value,
an **INSERT** is interrupted with the error "Too many parts (N)".

  Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_parts_in_total).

- `merge_tree.max_replicated_merges_in_queue`: How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.

  Default value: **32** for versions 25.8 and higher, **16** for versions 25.7 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_replicated_merges_in_queue).

- `merge_tree.number_of_free_entries_in_pool_to_lower_max_size_of_merge`: When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of
merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges.

  Default value: **8**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_lower_max_size_of_merge).

- `merge_tree.number_of_free_entries_in_pool_to_execute_mutation`: When there is less than specified number of free entries in pool, do not execute part mutations.
This is to leave free threads for regular merges and to avoid "Too many parts" errors.

  Default value: **20**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_mutation).

- `merge_tree.max_bytes_to_merge_at_min_space_in_pool`: The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool.

  Default value: **1048576** (1 MiB).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_min_space_in_pool).

- `merge_tree.max_bytes_to_merge_at_max_space_in_pool`: The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available.
Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled.

  Default value: **161061273600** (150 GiB).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_max_space_in_pool).

- `merge_tree.min_bytes_for_wide_part`: Minimum number of bytes in a data part that can be stored in Wide format.

  Default value: **10485760** (10 MiB).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_bytes_for_wide_part).

- `merge_tree.min_rows_for_wide_part`: Minimum number of rows in a data part that can be stored in Wide format.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_for_wide_part).

- `merge_tree.cleanup_delay_period`: Minimum period to clean old queue logs, blocks hashes and parts.

  Default value: **30**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#cleanup_delay_period).

- `merge_tree.max_cleanup_delay_period`: Maximum period to clean old queue logs, blocks hashes and parts.

  Default value: **300** (5 minutes).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_cleanup_delay_period).

- `merge_tree.merge_selecting_sleep_ms`: Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

  Default value: **5000** (5 seconds).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_selecting_sleep_ms).

- `merge_tree.max_merge_selecting_sleep_ms`: Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

  Default value: **60000** (1 minute).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_merge_selecting_sleep_ms).

- `merge_tree.min_age_to_force_merge_seconds`: Merge parts if every part in the range is older than the specified value. **0** means disabled.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).

- `merge_tree.min_age_to_force_merge_on_partition_only`: Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset.

  Default value: **false**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).

- `merge_tree.merge_max_block_size`: The number of rows that are read from the merged parts into memory.

  Default value: **8192**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_max_block_size).

- `merge_tree.deduplicate_merge_projection_mode`: Determines the behavior of background merges for MergeTree tables with projections.

  Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).

- `merge_tree.lightweight_mutation_projection_mode`: Determines the behavior of lightweight deletes for MergeTree tables with projections.

  Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

- `merge_tree.replicated_deduplication_window`: The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.

  Default value: **10000** for versions 25.9 and higher, **1000** for versions from 23.11 to 25.8, **100** for versions 23.10 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window).

- `merge_tree.replicated_deduplication_window_seconds`: The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.

  Default value: **3600** (1 hour) for versions 25.10 and higher, **604800** (7 days) for versions 25.9 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds).

- `merge_tree.fsync_after_insert`: Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts.

  Default value: **false**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_after_insert).

- `merge_tree.fsync_part_directory`: Do fsync for part directory after all part operations (writes, renames, etc.).

  Default value: **false**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_part_directory).

- `merge_tree.min_compressed_bytes_to_fsync_after_fetch`: Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_fetch).

- `merge_tree.min_compressed_bytes_to_fsync_after_merge`: Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_merge).

- `merge_tree.min_rows_to_fsync_after_merge`: Minimal number of rows to do fsync for part after merge. **0** means disabled.

  Default value: **0**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_to_fsync_after_merge).

- `merge_tree.ttl_only_drop_parts`: Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings.
* **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings.
* **false** - only the rows that have expired based on their **TTL** settings are removed.

  Default value: **false**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#ttl_only_drop_parts).

- `merge_tree.merge_with_ttl_timeout`: Minimum delay in seconds before repeating a merge with delete TTL.

  Default value: **14400** (4 hours).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_ttl_timeout).

- `merge_tree.merge_with_recompression_ttl_timeout`: Minimum delay in seconds before repeating a merge with recompression TTL.

  Default value: **14400** (4 hours).

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout).

- `merge_tree.max_number_of_merges_with_ttl_in_pool`: When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
This is to leave free threads for regular merges and avoid "Too many parts" errors.

  Default value: **2**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_number_of_merges_with_ttl_in_pool).

- `merge_tree.materialize_ttl_recalculate_only`: Only recalculate ttl info when **MATERIALIZE TTL**.

  Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only).

- `merge_tree.check_sample_column_is_correct`: Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct.
The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64.

  Default value: **true**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#check_sample_column_is_correct).

- `merge_tree.allow_remote_fs_zero_copy_replication`: Setting is automatically enabled if cloud storage is enabled, disabled otherwise.

  Default value: **true**.

- `kafka.security_protocol`: Protocol used to communicate with brokers.

  Default value: **SECURITY_PROTOCOL_PLAINTEXT**.

- `kafka.sasl_mechanism`: SASL mechanism to use for authentication.

  Default value: **SASL_MECHANISM_GSSAPI**.

- `kafka.sasl_username`: SASL username for use with the PLAIN and SASL-SCRAM mechanisms.

- `kafka.sasl_password`: SASL password for use with the PLAIN and SASL-SCRAM mechanisms.

- `kafka.enable_ssl_certificate_verification`: Enable OpenSSL's builtin broker (server) certificate verification.

  Default value: **true**.

- `kafka.max_poll_interval_ms`: Maximum allowed time between calls to consume messages for high-level consumers.
If this interval is exceeded the consumer is considered failed and the group will
rebalance in order to reassign the partitions to another consumer group member.

  Default value: **300000** (5 minutes).

- `kafka.session_timeout_ms`: Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
the session timeout, the broker will remove the consumer from the group and trigger a rebalance.

  Default value: **45000** (45 seconds).

- `kafka.debug`: Debug context to enable.

- `kafka.auto_offset_reset`: Action to take when there is no initial offset in offset store or the desired offset is out of range.

  Default value: **AUTO_OFFSET_RESET_LARGEST**.

- `kafka.message_max_bytes`: Maximum Kafka protocol request message size.

  Default value: **1000000**.

- `kafka.batch_size`: Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead.

  Default value: **1000000**.

- `kafka_topics.name`: Kafka topic name.

- `kafka_topics.settings.security_protocol`: Protocol used to communicate with brokers.

  Default value: **SECURITY_PROTOCOL_PLAINTEXT**.

- `kafka_topics.settings.sasl_mechanism`: SASL mechanism to use for authentication.

  Default value: **SASL_MECHANISM_GSSAPI**.

- `kafka_topics.settings.sasl_username`: SASL username for use with the PLAIN and SASL-SCRAM mechanisms.

- `kafka_topics.settings.sasl_password`: SASL password for use with the PLAIN and SASL-SCRAM mechanisms.

- `kafka_topics.settings.enable_ssl_certificate_verification`: Enable OpenSSL's builtin broker (server) certificate verification.

  Default value: **true**.

- `kafka_topics.settings.max_poll_interval_ms`: Maximum allowed time between calls to consume messages for high-level consumers.
If this interval is exceeded the consumer is considered failed and the group will
rebalance in order to reassign the partitions to another consumer group member.

  Default value: **300000** (5 minutes).

- `kafka_topics.settings.session_timeout_ms`: Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
the session timeout, the broker will remove the consumer from the group and trigger a rebalance.

  Default value: **45000** (45 seconds).

- `kafka_topics.settings.debug`: Debug context to enable.

- `kafka_topics.settings.auto_offset_reset`: Action to take when there is no initial offset in offset store or the desired offset is out of range.

  Default value: **AUTO_OFFSET_RESET_LARGEST**.

- `kafka_topics.settings.message_max_bytes`: Maximum Kafka protocol request message size.

  Default value: **1000000**.

- `kafka_topics.settings.batch_size`: Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead.

  Default value: **1000000**.

- `rabbitmq.username`: RabbitMQ username.

- `rabbitmq.password`: RabbitMQ password.

- `rabbitmq.vhost`: RabbitMQ virtual host.

- `query_masking_rules.name`: Name for the rule.

- `query_masking_rules.regexp`: RE2 compatible regular expression.

- `query_masking_rules.replace`: Substitution string for sensitive data.

  Default value: six asterisks.

- `query_cache.max_size_in_bytes`: The maximum cache size in bytes.

  Default value: **1073741824** (1 GiB).

- `query_cache.max_entries`: The maximum number of **SELECT** query results stored in the cache.

  Default value: **1024**.

- `query_cache.max_entry_size_in_bytes`: The maximum size in bytes **SELECT** query results may have to be saved in the cache.

  Default value: **1048576** (1 MiB).

- `query_cache.max_entry_size_in_rows`: The maximum number of rows **SELECT** query results may have to be saved in the cache.

  Default value: **30000000**.

- `jdbc_bridge.host`: Host of jdbc bridge.

- `jdbc_bridge.port`: Port of jdbc bridge.

  Default value: **9019**.

- `mysql_protocol`: Enables or disables MySQL interface on ClickHouse server

  Default value: **false**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/interfaces/mysql).

- `custom_macros.name`: Name of the macro.

- `custom_macros.value`: Value of the macro.

- `builtin_dictionaries_reload_interval`: The interval in seconds before reloading built-in dictionaries.

  Default value: **3600**.

  For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval). ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#