# Monitoring the state of {{ ES }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mes-name }} cluster status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster and open the **Monitoring** tab.

   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   The page displays the following charts:

   * **Active shards**: The number of active [primary shards](../concepts/scalability-and-resilience.md) and the total number of active shards in the cluster.
   * **Deletion rate**: The number of delete operations per second per host.
   * **Disk space usage percent**: Shows how much disk space is used on each host (%).
   * **Flushes**: The number of transaction log flush operations per host.

   * **Health status**: Shows the cluster's health and technical condition:

      * 0 (<q>red</q>): The cluster is unhealthy or partially functional. At least one of the primary shards is unavailable. If the cluster responds to queries, incomplete search results will be returned.
      * 1 (<q>yellow</q>): The cluster is healthy. There is no access to at least one of the replica shards. The search results in the cluster responses are complete, but if there're more unavailable shards, the cluster's performance will be disrupted.
      * 2 (<q>green</q>): The cluster is healthy. All cluster shards are available.

   * **Indexing rate**: The number of indexing operations per second per host.
   * **JVM heap**: The use of JVM heap memory per host (in bytes).
   * **JVM heap pressure**: The use of a pool of long-lived JVM objects per host (%).
   * **JVM old collections**: The number of garbage collection cycles in the pool of long-lived JVM objects per host.
   * **JVM young collections**: The number of garbage collection cycles in the pool of new JVM objects per host.
   * **Merges**: The number of index segment merges per host.
   * **Nodes**: The number of hosts with the [`Data node` role](../concepts/hosts-roles.md) and the total number of hosts in the cluster.
   * **Open file descriptors**: The number of open file descriptors per host.
   * **Other shards**: The number of inactive shards in each of the following states:

      * Delayed unassigned: Host assignment is delayed.
      * Unassigned: There is no assigned host.
      * Relocating: Moving to another host.
      * Initializing: Being initialized.

   * **Process CPU**: Usage of processor cores on each host due to the JVM {{ ES }} process.
   * **Query cache**: The number of queries in the cache on each host.
   * **Read bytes**: Disk read rate on each host (bytes per second).
   * **Read operations**: The number of read operations per second per host.
   * **Refreshes**: The number of index segment refresh operations per host.
   * **Search queries**: The number of search queries per second per host.
   * **Segments**: The number of index segments per host.
   * **Store size**: The size of index storage on disk (in bytes).
   * **Write bytes**: Disk write rate on each host (bytes per second).
   * **Write operations**: The number of write operations per second per host.

   {% note info %}

   {% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

   {% endnote %}

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mes-name }} hosts:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{mes-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Select the **Monitoring** tab.
   1. Select the host from the drop-down list.

   This page displays charts showing the load on an individual host in the cluster:

   * **CPU**: The load on processor cores. As the load goes up, the `Idle` value goes down.
   * **Disk bytes**: The speed of disk operations (bytes per second).
   * **Disk IOPS**: The number of disk operations per second.
   * **Memory**: The use of RAM in bytes. At high loads, the value of `Free` goes down while the other values go up.
   * **Network Bytes**: The speed of data exchange over the network (bytes per second).
   * **Network Packets**: The number of packets exchanged over the network per second.

{% endlist %}

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select:

      * **{{ mes-name }}** to configure cluster alerts.
      * **{{ mes-name }} — Host Overview** to configure host alerts.

   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter | Formula | `Alarm` | `Warning` |
|----------------------------------------------|:-----------------------------------------:|:----------------------:|:---------------------------------:|:---------------------------------:|
| Cluster status | `elasticsearch_status` | `bottom_last(1)` | `Equal to 0` | `Equal to 1` |
| Number of unassigned shards | `elasticsearch_unassigned_shards` | `top_last(1)` | `Greater than 0` |                                   |
| Number of relocated shards | `elasticsearch_relocating_shards` | `top_last(1)` | `Greater than 0` |                                   |
| Number of initialized shards | `elasticsearch_initializing_shards` | `top_last(1)` | `Greater than 0` |                                   |
| Number of delayed assignment shards | `elasticsearch_delayed_unassigned_shards` | `top_last(1)` | `Greater than 0` |                                   |
| JVM heap memory used | `elasticsearch_jvm_mem_heap_used_percent` | `top_last(1)` | Over 90% of host RAM |                                   |
| Storage space used | `elasticsearch_fs_total_used_percent` | `top_last(1)` | Over 90% of the storage size | Over 85% of the storage size |
| Using the JVM long-lived object pool | `elasticsearch_jvm_mem_heap_pressure` | `top_last(1)` | Over 90% of host RAM | Over 75% of host RAM |

You can view the host's current storage size and RAM amount in the [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-elasticsearch).

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

{% endlist %}

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mes-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %}

| Label | Value |
----|----
| service | Service ID: `managed-elasticsearch` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu-avg.md) %}

{% endcut %}

{% cut "Disk metrics" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Disk operation metrics" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "RAM metrics" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Network metrics" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "{{ ES }} native metrics" %}

Metrics collected using the [API](https://www.elastic.co/guide/en/elasticsearch/reference/master/cluster-nodes-stats.html#cluster-nodes-stats-api-response-body).

| Name<br/>Type, units |
| ----- |
| `elasticsearch_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_fs_io_stats_total_operations`<br/>`DGAUGE`, pcs |
| `elasticsearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, KB |
| `elasticsearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, pcs |
| `elasticsearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, KB |
| `elasticsearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, pcs |
| `elasticsearch_fs_total_available_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_fs_total_free_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_fs_total_total_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_fs_total_used_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_fs_total_used_percent`<br/>`DGAUGE`, pcs |
| `elasticsearch_http_current_open`<br/>`DGAUGE`, pcs |
| `elasticsearch_http_total_opened`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_docs_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_docs_deleted`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_fielddata_evictions`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_flush_periodic`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_flush_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_get_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_get_exists_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_get_missing_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_get_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_get_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_delete_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_indexing_delete_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_index_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_index_failed`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_indexing_index_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_is_throttled`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_merges_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_merges_current_docs`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_merges_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_merges_total_docs`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_query_cache_cache_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_query_cache_cache_size`<br/>`DGAUGE`, |  |
| `elasticsearch_indices_query_cache_evictions`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_query_cache_hit_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_query_cache_miss_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_query_cache_total_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_recovery_current_as_source`<br/>`DGAUGE`, |  |
| `elasticsearch_indices_recovery_current_as_target`<br/>`DGAUGE`, |  |
| `elasticsearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_refresh_external_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_refresh_listeners`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_refresh_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_request_cache_evictions`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_request_cache_hit_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_request_cache_miss_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_fetch_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_search_fetch_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_open_contexts`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_query_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_search_query_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_scroll_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_search_scroll_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_suggest_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_indices_search_suggest_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_segments_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, timestamp |
| `elasticsearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_shard_stats_total_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_store_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_store_total_data_set_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_translog_operations`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, pcs |  |
| `elasticsearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_indices_warmer_current`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_warmer_total`<br/>`DGAUGE`, pcs |
| `elasticsearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_jvm_mem_heap_pressure`<br/>`DGAUGE` |
| `elasticsearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, pcs |
| `elasticsearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_number_of_data_nodes`<br/>`DGAUGE`, pcs |
| `elasticsearch_number_of_in_flight_fetch`<br/>`DGAUGE`, pcs |
| `elasticsearch_number_of_nodes`<br/>`DGAUGE`, pcs |
| `elasticsearch_number_of_pending_tasks`<br/>`DGAUGE`, pcs |
| `elasticsearch_process_cpu_percent`<br/>`DGAUGE`, pcs |
| `elasticsearch_process_cpu_total_in_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_process_max_file_descriptors`<br/>`DGAUGE`, pcs |
| `elasticsearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_process_open_file_descriptors`<br/>`DGAUGE`, pcs |
| `elasticsearch_process_timestamp`<br/>`DGAUGE`, timestamp |
| `elasticsearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, ms |
| `elasticsearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, pcs |
| `elasticsearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, pcs |
| `elasticsearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, pcs |
| `elasticsearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, pcs |
| `elasticsearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, pcs |
| `elasticsearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, pcs |
| `elasticsearch_transport_rx_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, bytes |
| `elasticsearch_transport_server_open`<br/>`DGAUGE`, pcs |
| `elasticsearch_transport_total_outbound_connections`<br/>`DGAUGE`, pcs |
| `elasticsearch_transport_tx_count`<br/>`DGAUGE`, pcs |
| `elasticsearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, bytes |

{% endcut %}

{% cut "Other metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `elasticsearch_active_primary_shards`<br/>`DGAUGE`, pcs | Number of active [primary shards](https://cloud.yandex.ru/docs/managed-elasticsearch/concepts/scalability-and-resilience) and total number of active shards in the cluster. |
| `elasticsearch_active_shards`<br/>`DGAUGE`, pcs | Number of active shards. |
| `elasticsearch_active_shards_percent_as_number`<br/>`DGAUGE`, pcs | Percentage of active shards. |
| `elasticsearch_delayed_unassigned_shards`<br/>`DGAUGE`, pcs | Number of delayed assignment shards. |
| `elasticsearch_initializing_shards`<br/>`DGAUGE`, pcs | Number of shards being initialized. |
| `elasticsearch_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `elasticsearch_relocating_shards`<br/>`DGAUGE`, pcs | Number of shards being relocated. |
| `elasticsearch_status`<br/>`DGAUGE`, 0/1/2 | Cluster health and technical condition: <br/>`0` (red): The cluster is unhealthy or partially functional.  At least one of the primary shards is unavailable. If the cluster responds to queries, incomplete search results will be returned.<br/>`1` (yellow): The cluster is healthy. There is no access to at least one of the replica shards. The search results in the cluster responses are complete, but if there are more unavailable shards, the cluster's performance will be disrupted.<br/>`2` (green): The cluster is healthy. All cluster shards are available. |
| `elasticsearch_unassigned_shards`<br/>`DGAUGE`, pcs | Number of inactive shards with no host assigned. |

{% endcut %}

{% endif %}
