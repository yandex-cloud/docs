## Сервис {{ mos-full-name }} {#managed-opensearch}

Общие метки для всех метрик сервиса {{ mos-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-opensearch`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста

### Метрики CPU {#managed-opensearch-cpu-metrics}
Загрузка процессорных ядер.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Гарантированная доля vCPU. | 
| `cpu.guarantee`<br/>`DGAUGE`, штуки | Гарантированное число ядер. | 
| `cpu.limit`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. | 
| `cpu.guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. | 
| `cpu.idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. | 
| `cpu.iowait`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `iowait`. | 
| `cpu.irq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `irq`. | 
| `cpu.nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `nice`. | 
| `cpu.softirq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `softirq`. | 
| `cpu.steal`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `steal`. | 
| `cpu.system`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `system`. | 
| `cpu.user`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `user`. |
| `load.avg_15min`<br/>`DGAUGE`, % | Средняя нагрузка за 15 минут. | 
| `load.avg_1min`<br/>`DGAUGE`, % | Средняя нагрузка за 1 минуту. | 
| `load.avg_5min`<br/>`DGAUGE`, % | Средняя нагрузка за 5 минут. |

### Метрики диска {#managed-opensearch-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |

### Метрики дисковых операций {#managed-opensearch-diskio-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с дисков. | 
| `io.avg_write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на диски. | 
| `io.disk*.avg_read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с конкретного диска. | 
| `io.disk*.avg_write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на конкретный диск. | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с конкретного диска. | 
| `io.disk*.read_count`<br/>`DGAUGE`, операций/с | Количество операций чтения с конкретного диска в секунду. | 
| `io.disk*.read_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций чтения с конкретного диска в секунду. | 
| `io.disk*.utilization`<br/>`DGAUGE`, % | Использование конкретного диска. Не работает для сетевых дисков. | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на конкретный диск. | 
| `io.disk*.write_count`<br/>`DGAUGE`, операций/с | Количество операций записи на конкретный диск в секунду. | 
| `io.disk*.write_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций записи на конкретный диск в секунду. |
| `io.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с дисков. | 
| `io.read_count`<br/>`DGAUGE`, операций/с | Количество операций чтения в секунду. | 
| `io.read_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций чтения в секунду. | 
| `io.utilization`<br/>`DGAUGE`, % | Использование дисков. | 
| `io.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на диски. | 
| `io.write_count`<br/>`DGAUGE`, операций/с | Количество операций записи в секунду. | 
| `io.write_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций записи в секунду. |

### Метрики RAM {#managed-opensearch-ram-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, байты | Гарантированный размер оперативной памяти. | 
| `mem.limit_bytes`<br/>`DGAUGE`, байты | Предельный размер оперативной памяти. | 
| `mem.active_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. | 
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`. | 
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. | 
| `mem.free_bytes`<br/>`DGAUGE`, байты | Объем свободной оперативной памяти, доступной для использования, без учета `mem.buffers_bytes` и `mem.cached_bytes`. |
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы. | 

### Метрики сети {#managed-opensearch-net-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, байт/с | Скорость получения данных по сети. | 
| `net.bytes_sent`<br/>`DGAUGE`, байт/с | Скорость отправки данных по сети. | 
| `net.dropin`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при получении. | 
| `net.dropout`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при отправке. | 
| `net.errin`<br/>`DGAUGE`, штуки | Количество ошибок при получении. | 
| `net.errout`<br/>`DGAUGE`, штуки | Количество ошибок при отправке. | 
| `net.packets_recv`<br/>`DGAUGE`, пакетов/с | Интенсивность получения данных по сети. | 
| `net.packets_sent`<br/>`DGAUGE`, пакетов/с | Интенсивность отправки данных по сети. | 

### Метрики сервиса {#managed-opensearch-metrics}
##### Нативные метрики {{ OS }} {#managed-opensearch-system-metrics}

| Имя<br/>Тип, единицы измерения | 
| ----- | 
| `opensearch_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `opensearch_fs_io_stats_total_operations`<br/>`DGAUGE`, штуки | 
| `opensearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, килобайты | 
| `opensearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, штуки | 
| `opensearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, килобайты | 
| `opensearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, штуки | 
| `opensearch_fs_total_available_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_free_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_total_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_used_percent`<br/>`DGAUGE`, штуки | 
| `opensearch_http_current_open`<br/>`DGAUGE`, штуки |
| `opensearch_http_total_opened`<br/>`DGAUGE`, штуки |
| `opensearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_docs_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_docs_deleted`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_fielddata_evictions`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_flush_periodic`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_flush_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_exists_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_missing_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_get_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_total`<br/>`DGAUGE`, штуки |
| `opensearch_indices_indexing_delete_current`<br/>`DGAUGE`, штуки |
| `opensearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_indexing_delete_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_index_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_index_failed`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `opensearch_indices_indexing_index_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_is_throttled`<br/>`DGAUGE`, штуки |
| `opensearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_merges_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_current_docs`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_merges_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_merges_total_docs`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_query_cache_cache_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_cache_size`<br/>`DGAUGE`, байты | 
| `opensearch_indices_query_cache_evictions`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_query_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_total_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_recovery_current_as_source`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_recovery_current_as_target`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_refresh_external_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_refresh_listeners`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_refresh_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_request_cache_evictions`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_request_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_request_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_fetch_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_search_fetch_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_open_contexts`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_query_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_search_query_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_scroll_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_search_scroll_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_suggest_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_search_suggest_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_segments_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, таймстамп | 
| `opensearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_shard_stats_total_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_store_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_store_total_data_set_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_translog_operations`<br/>`DGAUGE`, штуки |
| `opensearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, штуки |  | 
| `opensearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_warmer_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_warmer_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, штуки | 
| `opensearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, штуки | 
| `opensearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_heap_pressure`<br/>`DGAUGE` | 
| `opensearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, штуки | 
| `opensearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_number_of_data_nodes`<br/>`DGAUGE`, штуки | 
| `opensearch_number_of_in_flight_fetch`<br/>`DGAUGE`, штуки | 
| `opensearch_number_of_nodes`<br/>`DGAUGE`, штуки | 
| `opensearch_number_of_pending_tasks`<br/>`DGAUGE`, штуки | 
| `opensearch_process_cpu_percent`<br/>`DGAUGE`, штуки | 
| `opensearch_process_cpu_total_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_process_max_file_descriptors`<br/>`DGAUGE`, штуки | 
| `opensearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_process_open_file_descriptors`<br/>`DGAUGE`, штуки | 
| `opensearch_process_timestamp`<br/>`DGAUGE`, таймстамп | 
| `opensearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_rx_count`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_transport_server_open`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_total_outbound_connections`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_tx_count`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, байты |

##### Нативные метрики Dashboards {#managed-opensearch-dashboards-system-metrics}

| Имя<br/>Тип, единицы измерения | 
| ----- |
| `dashboards_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `dashboards_fs_io_stats_total_operations`<br/>`DGAUGE`, штуки | 
| `dashboards_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, килобайты | 
| `dashboards_fs_io_stats_total_read_operations`<br/>`DGAUGE`, штуки | 
| `dashboards_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, килобайты | 
| `dashboards_fs_io_stats_total_write_operations`<br/>`DGAUGE`, штуки | 
| `dashboards_fs_total_available_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_fs_total_free_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_fs_total_total_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_fs_total_used_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_fs_total_used_percent`<br/>`DGAUGE`, штуки | 
| `dashboards_http_current_open`<br/>`DGAUGE`, штуки |
| `dashboards_http_total_opened`<br/>`DGAUGE`, штуки |
| `dashboards_indices_completion_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_docs_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_docs_deleted`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_fielddata_evictions`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_flush_periodic`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_flush_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_flush_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_get_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_get_exists_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_get_exists_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_get_missing_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_get_missing_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_get_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_get_total`<br/>`DGAUGE`, штуки |
| `dashboards_indices_indexing_delete_current`<br/>`DGAUGE`, штуки |
| `dashboards_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_indexing_delete_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_indexing_index_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_indexing_index_failed`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `dashboards_indices_indexing_index_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_indexing_is_throttled`<br/>`DGAUGE`, штуки |
| `dashboards_indices_indexing_noop_update_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_merges_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_merges_current_docs`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_merges_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_merges_total_docs`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_merges_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_query_cache_cache_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_query_cache_cache_size`<br/>`DGAUGE`, байты | 
| `dashboards_indices_query_cache_evictions`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_query_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_query_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_query_cache_total_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_recovery_current_as_source`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_recovery_current_as_target`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_refresh_external_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_indices_refresh_listeners`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_refresh_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_indices_request_cache_evictions`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_request_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_request_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_fetch_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_indices_search_fetch_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_open_contexts`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_query_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_query_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_indices_search_query_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_scroll_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_indices_search_scroll_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_suggest_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_indices_search_suggest_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_segments_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, таймстамп | 
| `dashboards_indices_segments_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_shard_stats_total_count`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_store_reserved_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_store_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_store_total_data_set_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_translog_operations`<br/>`DGAUGE`, штуки |
| `dashboards_indices_translog_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_translog_uncommitted_operations`<br/>`DGAUGE`, штуки |  | 
| `dashboards_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_indices_warmer_current`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_warmer_total`<br/>`DGAUGE`, штуки | 
| `dashboards_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, штуки | 
| `dashboards_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, штуки | 
| `dashboards_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_jvm_mem_heap_pressure`<br/>`DGAUGE` | 
| `dashboards_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_jvm_mem_heap_used_percent`<br/>`DGAUGE`, штуки | 
| `dashboards_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_number_of_data_nodes`<br/>`DGAUGE`, штуки | 
| `dashboards_number_of_in_flight_fetch`<br/>`DGAUGE`, штуки | 
| `dashboards_number_of_nodes`<br/>`DGAUGE`, штуки | 
| `dashboards_number_of_pending_tasks`<br/>`DGAUGE`, штуки | 
| `dashboards_process_cpu_percent`<br/>`DGAUGE`, штуки | 
| `dashboards_process_cpu_total_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `dashboards_process_max_file_descriptors`<br/>`DGAUGE`, штуки | 
| `dashboards_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_process_open_file_descriptors`<br/>`DGAUGE`, штуки | 
| `dashboards_process_timestamp`<br/>`DGAUGE`, таймстамп | 
| `dashboards_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, миллисекунды |
| `dashboards_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, штуки | 
| `dashboards_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, штуки | 
| `dashboards_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, штуки | 
| `dashboards_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, штуки | 
| `dashboards_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, штуки | 
| `dashboards_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, штуки | 
| `dashboards_transport_rx_count`<br/>`DGAUGE`, штуки | 
| `dashboards_transport_rx_size_in_bytes`<br/>`DGAUGE`, байты | 
| `dashboards_transport_server_open`<br/>`DGAUGE`, штуки | 
| `dashboards_transport_total_outbound_connections`<br/>`DGAUGE`, штуки | 
| `dashboards_transport_tx_count`<br/>`DGAUGE`, штуки | 
| `dashboards_transport_tx_size_in_bytes`<br/>`DGAUGE`, байты |

##### Прочие метрики {#managed-opensearch-other-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `opensearch_active_primary_shards`<br/>`DGAUGE`, штуки | Количество активных [первичных шардов](../../../managed-opensearch/concepts/scalability-and-resilience.md) и общее количество активных шардов в кластере. | 
| `opensearch_active_shards`<br/>`DGAUGE`, штуки | Количество активных шардов. | 
| `opensearch_active_shards_percent_as_number`<br/>`DGAUGE`, штуки | Процент активных шардов. | 
| `opensearch_delayed_unassigned_shards`<br/>`DGAUGE`, штуки | Количество отложенных к назначению шардов. |
| `opensearch_initializing_shards`<br/>`DGAUGE`, штуки | Количество шардов в состоянии инициализации. | 
| `opensearch_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `opensearch_relocating_shards`<br/>`DGAUGE`, штуки | Количество перемещаемых шардов. | 
| `opensearch_status`<br/>`DGAUGE`, 0/1/2 | Уровень работоспособности и техническое состояние кластера:<br/>`0` — красный: неработоспособное или частично работоспособное состояние. Хотя бы один из первичных шардов недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.<br/>`1` — желтый: работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.<br/>`2` — зеленый: исправное состояние. Все шарды кластера доступны. |
| `opensearch_unassigned_shards`<br/>`DGAUGE`, штуки | Количество неактивных шардов с неназначенным хостом. |
| `dashboards_active_primary_shards`<br/>`DGAUGE`, штуки | Количество активных [первичных шардов](../../../managed-opensearch/concepts/scalability-and-resilience.md) и общее количество активных шардов в кластере. | 
| `dashboards_active_shards`<br/>`DGAUGE`, штуки | Количество активных шардов. | 
| `dashboards_active_shards_percent_as_number`<br/>`DGAUGE`, штуки | Процент активных шардов. | 
| `dashboards_delayed_unassigned_shards`<br/>`DGAUGE`, штуки | Количество отложенных к назначению шардов. |
| `dashboards_initializing_shards`<br/>`DGAUGE`, штуки | Количество шардов в состоянии инициализации. | 
| `dashboards_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `dashboards_relocating_shards`<br/>`DGAUGE`, штуки | Количество перемещаемых шардов. | 
| `dashboards_status`<br/>`DGAUGE`, 0/1/2 | Уровень работоспособности и техническое состояние кластера:<br/>`0` — красный: неработоспособное или частично работоспособное состояние. Хотя бы один из первичных шардов недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.<br/>`1` — желтый: работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.<br/>`2` — зеленый: исправное состояние. Все шарды кластера доступны. |
| `dashboards_unassigned_shards`<br/>`DGAUGE`, штуки | Количество неактивных шардов с неназначенным хостом. |

Подробнее о сервисе в документации [{{ mos-name }}](../../../managed-opensearch/).