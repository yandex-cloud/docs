## Service: {{ mos-full-name }} {#managed-opensearch}

Common labels for all {{ mos-full-name }} service metrics:

| Label | Value |
----|----
| service | Service ID: `managed-opensearch` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |

### CPU metrics {#managed-opensearch-cpu-metrics}
The load on processor cores.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance. |
| `cpu.guarantee`<br/>`DGAUGE`, pcs | Guaranteed number of cores. |
| `cpu.limit`<br/>`DGAUGE`, pcs | Limit on CPUs in use. |
| `cpu.guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type. |
| `cpu.idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type. |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type. |
| `cpu.irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type. |
| `cpu.nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type. |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type. |
| `cpu.steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type. |
| `cpu.system`<br/>`DGAUGE`, % | CPU usage, `system` usage type. |
| `cpu.user`<br/>`DGAUGE`, % | CPU usage, `user` usage type. |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load in 15 minutes. |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load per 1 minute. |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load in 5 minutes. |

### Disk metrics {#managed-opensearch-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space. |
| `disk.free_inodes`<br/>`DGAUGE`, pcs | Number of free inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space. |
| `disk.total_inodes`<br/>`DGAUGE`, pcs | Available inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_inodes`<br/>`DGAUGE`, pcs | Used inodes. |

### Disk operation metrics {#managed-opensearch-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time. |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time. |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk. |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk. |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk. |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk. |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk. |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a specific disk. |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk. |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a specific disk. |
| `io.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed. |
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second. |
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second. |
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization. |
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed. |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second. |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second. |

### RAM metrics {#managed-opensearch-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory. |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit. |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type. |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type. |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type. |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type. |

### Network metrics {#managed-opensearch-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network. |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second. | Rate of sending data over the network. |
| `net.dropin`<br/>`DGAUGE`, pcs | Packets dropped upon receipt.  |
| `net.dropout`<br/>`DGAUGE`, pcs | Packets dropped when being sent.  |
| `net.errin`<br/>`DGAUGE`, pcs | Number of errors upon receipt. |
| `net.errout`<br/>`DGAUGE`, pcs | Number of errors at sending. |
| `net.packets_recv`<br/>`DGAUGE`, packets per second. | Rate of receiving packets over the network. |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network. |

### Service metrics {#managed-opensearch-metrics}
##### {{ OS }} native metrics {#managed-opensearch-system-metrics}

| Name<br/>Type, units |
| ----- | 
| `opensearch_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_fs_io_stats_total_operations`<br/>`DGAUGE`, pcs |
| `opensearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, KB |
| `opensearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, pcs |
| `opensearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, KB |
| `opensearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, pcs |
| `opensearch_fs_total_available_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_fs_total_free_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_fs_total_total_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_fs_total_used_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_fs_total_used_percent`<br/>`DGAUGE`, pcs |
| `opensearch_http_current_open`<br/>`DGAUGE`, pcs |
| `opensearch_http_total_opened`<br/>`DGAUGE`, pcs |
| `opensearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_docs_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_docs_deleted`<br/>`DGAUGE`, pcs |
| `opensearch_indices_fielddata_evictions`<br/>`DGAUGE`, pcs |
| `opensearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_flush_periodic`<br/>`DGAUGE`, pcs |
| `opensearch_indices_flush_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_get_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_get_exists_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_get_missing_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_get_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_get_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_delete_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_indexing_delete_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_index_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_index_failed`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_indexing_index_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_is_throttled`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_merges_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_merges_current_docs`<br/>`DGAUGE`, pcs |
| `opensearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_merges_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_merges_total_docs`<br/>`DGAUGE`, pcs |
| `opensearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_query_cache_cache_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_query_cache_cache_size`<br/>`DGAUGE`, |  |
| `opensearch_indices_query_cache_evictions`<br/>`DGAUGE`, pcs |
| `opensearch_indices_query_cache_hit_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_query_cache_miss_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_query_cache_total_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_recovery_current_as_source`<br/>`DGAUGE`, |  |
| `opensearch_indices_recovery_current_as_target`<br/>`DGAUGE`, |  |
| `opensearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_refresh_external_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_refresh_listeners`<br/>`DGAUGE`, pcs |
| `opensearch_indices_refresh_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_request_cache_evictions`<br/>`DGAUGE`, pcs |
| `opensearch_indices_request_cache_hit_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_request_cache_miss_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_fetch_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_fetch_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_open_contexts`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_query_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_query_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_scroll_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_scroll_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_suggest_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_suggest_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_segments_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, timestamp |
| `opensearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_shard_stats_total_count`<br/>`DGAUGE`, pcs |
| `opensearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_store_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_store_total_data_set_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, pcs |
| `opensearch_indices_translog_operations`<br/>`DGAUGE`, pcs |
| `opensearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, pcs |  |
| `opensearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_indices_warmer_current`<br/>`DGAUGE`, pcs |
| `opensearch_indices_warmer_total`<br/>`DGAUGE`, pcs |
| `opensearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, pcs |
| `opensearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, pcs |
| `opensearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_jvm_mem_heap_pressure`<br/>`DGAUGE` |
| `opensearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, pcs |
| `opensearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_number_of_data_nodes`<br/>`DGAUGE`, pcs |
| `opensearch_number_of_in_flight_fetch`<br/>`DGAUGE`, pcs |
| `opensearch_number_of_nodes`<br/>`DGAUGE`, pcs |
| `opensearch_number_of_pending_tasks`<br/>`DGAUGE`, pcs |
| `opensearch_process_cpu_percent`<br/>`DGAUGE`, pcs |
| `opensearch_process_cpu_total_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_process_max_file_descriptors`<br/>`DGAUGE`, pcs |
| `opensearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_process_open_file_descriptors`<br/>`DGAUGE`, pcs |
| `opensearch_process_timestamp`<br/>`DGAUGE`, timestamp |
| `opensearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, pcs |
| `opensearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, pcs |
| `opensearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, pcs |
| `opensearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, pcs |
| `opensearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, pcs |
| `opensearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, pcs |
| `opensearch_transport_rx_count`<br/>`DGAUGE`, pcs |
| `opensearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, bytes |
| `opensearch_transport_server_open`<br/>`DGAUGE`, pcs |
| `opensearch_transport_total_outbound_connections`<br/>`DGAUGE`, pcs |
| `opensearch_transport_tx_count`<br/>`DGAUGE`, pcs |
| `opensearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, bytes |

##### Dashboards native metrics {#managed-opensearch-dashboards-system-metrics}

| Name<br/>Type, units |
| ----- |
| `dashboards_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_fs_io_stats_total_operations`<br/>`DGAUGE`, pcs |
| `dashboards_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, KB |
| `dashboards_fs_io_stats_total_read_operations`<br/>`DGAUGE`, pcs |
| `dashboards_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, KB |
| `dashboards_fs_io_stats_total_write_operations`<br/>`DGAUGE`, pcs |
| `dashboards_fs_total_available_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_fs_total_free_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_fs_total_total_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_fs_total_used_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_fs_total_used_percent`<br/>`DGAUGE`, pcs |
| `dashboards_http_current_open`<br/>`DGAUGE`, pcs |
| `dashboards_http_total_opened`<br/>`DGAUGE`, pcs |
| `dashboards_indices_completion_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_docs_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_docs_deleted`<br/>`DGAUGE`, pcs |
| `dashboards_indices_fielddata_evictions`<br/>`DGAUGE`, pcs |
| `dashboards_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_flush_periodic`<br/>`DGAUGE`, pcs |
| `dashboards_indices_flush_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_flush_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_get_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_get_exists_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_get_exists_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_get_missing_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_get_missing_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_get_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_get_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_delete_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_indexing_delete_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_index_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_index_failed`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_indexing_index_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_is_throttled`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_noop_update_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_merges_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_merges_current_docs`<br/>`DGAUGE`, pcs |
| `dashboards_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_merges_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_merges_total_docs`<br/>`DGAUGE`, pcs |
| `dashboards_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_merges_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_query_cache_cache_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_query_cache_cache_size`<br/>`DGAUGE`, |  |
| `dashboards_indices_query_cache_evictions`<br/>`DGAUGE`, pcs |
| `dashboards_indices_query_cache_hit_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_query_cache_miss_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_query_cache_total_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_recovery_current_as_source`<br/>`DGAUGE`, |  |
| `dashboards_indices_recovery_current_as_target`<br/>`DGAUGE`, |  |
| `dashboards_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_refresh_external_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_refresh_listeners`<br/>`DGAUGE`, pcs |
| `dashboards_indices_refresh_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_request_cache_evictions`<br/>`DGAUGE`, pcs |
| `dashboards_indices_request_cache_hit_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_request_cache_miss_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_fetch_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_search_fetch_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_open_contexts`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_query_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_query_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_search_query_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_scroll_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_search_scroll_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_suggest_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_indices_search_suggest_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_segments_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, timestamp |
| `dashboards_indices_segments_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_shard_stats_total_count`<br/>`DGAUGE`, pcs |
| `dashboards_indices_store_reserved_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_store_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_store_total_data_set_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, pcs |
| `dashboards_indices_translog_operations`<br/>`DGAUGE`, pcs |
| `dashboards_indices_translog_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_translog_uncommitted_operations`<br/>`DGAUGE`, pcs |  |
| `dashboards_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_indices_warmer_current`<br/>`DGAUGE`, pcs |
| `dashboards_indices_warmer_total`<br/>`DGAUGE`, pcs |
| `dashboards_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, pcs |
| `dashboards_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, pcs |
| `dashboards_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_jvm_mem_heap_pressure`<br/>`DGAUGE` |
| `dashboards_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_jvm_mem_heap_used_percent`<br/>`DGAUGE`, pcs |
| `dashboards_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_number_of_data_nodes`<br/>`DGAUGE`, pcs |
| `dashboards_number_of_in_flight_fetch`<br/>`DGAUGE`, pcs |
| `dashboards_number_of_nodes`<br/>`DGAUGE`, pcs |
| `dashboards_number_of_pending_tasks`<br/>`DGAUGE`, pcs |
| `dashboards_process_cpu_percent`<br/>`DGAUGE`, pcs |
| `dashboards_process_cpu_total_in_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_process_max_file_descriptors`<br/>`DGAUGE`, pcs |
| `dashboards_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_process_open_file_descriptors`<br/>`DGAUGE`, pcs |
| `dashboards_process_timestamp`<br/>`DGAUGE`, timestamp |
| `dashboards_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, milliseconds |
| `dashboards_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, pcs |
| `dashboards_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, pcs |
| `dashboards_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, pcs |
| `dashboards_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, pcs |
| `dashboards_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, pcs |
| `dashboards_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, pcs |
| `dashboards_transport_rx_count`<br/>`DGAUGE`, pcs |
| `dashboards_transport_rx_size_in_bytes`<br/>`DGAUGE`, bytes |
| `dashboards_transport_server_open`<br/>`DGAUGE`, pcs |
| `dashboards_transport_total_outbound_connections`<br/>`DGAUGE`, pcs |
| `dashboards_transport_tx_count`<br/>`DGAUGE`, pcs |
| `dashboards_transport_tx_size_in_bytes`<br/>`DGAUGE`, bytes |

##### Other metrics {#managed-opensearch-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `opensearch_active_primary_shards`<br/>`DGAUGE`, pcs | Number of active [primary shards](https://cloud.yandex.ru/docs/managed-opensearch/concepts/scalability-and-resilience) and total number of active shards in the cluster. |
| `opensearch_active_shards`<br/>`DGAUGE`, pcs | Number of active shards. |
| `opensearch_active_shards_percent_as_number`<br/>`DGAUGE`, pcs | Percentage of active shards. |
| `opensearch_delayed_unassigned_shards`<br/>`DGAUGE`, pcs | Number of delayed assignment shards. |
| `opensearch_initializing_shards`<br/>`DGAUGE`, pcs | Number of shards being initialized. |
| `opensearch_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `opensearch_relocating_shards`<br/>`DGAUGE`, pcs | Number of shards being relocated. |
| `opensearch_status`<br/>`DGAUGE`, 0/1/2 | Cluster health and technical condition: <br/>`0` (red): The cluster is unhealthy or partially functional.  At least one of the primary shards is unavailable. If the cluster responds to queries, incomplete search results will be returned.<br/>`1` (yellow): The cluster is healthy. There is no access to at least one of the replica shards. The search results in the cluster responses are complete, but if there are more unavailable shards, the cluster's performance will be disrupted.<br/>`2` (green): The cluster is healthy. All cluster shards are available. |
| `opensearch_unassigned_shards`<br/>`DGAUGE`, pcs | Number of inactive shards with no host assigned. |
| `dashboards_active_primary_shards`<br/>`DGAUGE`, pcs | Number of active [primary shards](https://cloud.yandex.ru/docs/managed-opensearch/concepts/scalability-and-resilience) and total number of active shards in the cluster. |
| `dashboards_active_shards`<br/>`DGAUGE`, pcs | Number of active shards. |
| `dashboards_active_shards_percent_as_number`<br/>`DGAUGE`, pcs | Percentage of active shards. |
| `dashboards_delayed_unassigned_shards`<br/>`DGAUGE`, pcs | Number of delayed assignment shards. |
| `dashboards_initializing_shards`<br/>`DGAUGE`, pcs | Number of shards being initialized. |
| `dashboards_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `dashboards_relocating_shards`<br/>`DGAUGE`, pcs | Number of shards being relocated. |
| `dashboards_status`<br/>`DGAUGE`, 0/1/2 | Cluster health and technical condition: <br/>`0` (red): The cluster is unhealthy or partially functional.  At least one of the primary shards is unavailable. If the cluster responds to queries, incomplete search results will be returned.<br/>`1` (yellow): The cluster is healthy. There is no access to at least one of the replica shards. The search results in the cluster responses are complete, but if there are more unavailable shards, the cluster's performance will be disrupted.<br/>`2` (green): The cluster is healthy. All cluster shards are available. |
| `dashboards_unassigned_shards`<br/>`DGAUGE`, pcs | Number of inactive shards with no host assigned. |

Read more about the service in the [{{ mos-full-name }}](../../../managed-opensearch/) documentation.