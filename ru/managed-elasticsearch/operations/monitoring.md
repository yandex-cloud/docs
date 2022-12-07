# Мониторинг состояния {{ ES }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mes-name }}:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Active shards** — количество активных [первичных шардов](../concepts/scalability-and-resilience.md) и общее количество активных шардов в кластере.
    * **Deletion rate** — количество операций удаления в секунду, для каждого хоста.
    * **Disk space usage percent** — использование дискового пространства, для каждого хоста (в процентах).
    * **Flushes** — количество операций сохранения лога транзакций (flush), для каждого хоста.

    * **Health status** — уровень работоспособности и техническое состояние кластера:

        * 0 — <q>красный</q>: неработоспособное или частично работоспособное состояние. Хотя бы один из первичных шардов недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.
        * 1 — <q>желтый</q>: работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.
        * 2 — <q>зеленый</q>: исправное состояние. Все шарды кластера доступны.

    * **Indexing rate** — интенсивность индексирования, для каждого хоста (операций/с).
    * **JVM heap** — использование памяти кучи JVM, для каждого хоста (в байтах).
    * **JVM heap pressure** — использование пула долгоживущих объектов JVM, для каждого хоста (в процентах).
    * **JVM old collections** — количество циклов сборки мусора в пуле долгоживущих объектов JVM, для каждого хоста.
    * **JVM young collections** — количество циклов сборки мусора в пуле новых объектов JVM, для каждого хоста.
    * **Merges** — количество слияний сегментов индексов, для каждого хоста.
    * **Nodes** — количество хостов с [ролью `Data node`](../concepts/hosts-roles.md) и общее количество хостов в кластере.
    * **Open file descriptors** — количество открытых файловых дескрипторов, для каждого хоста.
    * **Other shards** — количество неактивных шардов в каждом из состояний:

        * Delayed unassigned — назначение хоста отложено;
        * Unassigned — нет назначенного хоста;
        * Relocating — перемещаются на другой хост;
        * Initializing — инициализируются.

    * **Process CPU** — загрузка процессорных ядер, которую создает процесс JVM {{ ES }}, для каждого хоста.
    * **Query cache** — количество запросов в кеше, для каждого хоста.
    * **Read bytes** — скорость чтения с диска, для каждого хоста (байт/с).
    * **Read operations** — интенсивность чтения с диска, для каждого хоста (операций/с).
    * **Refreshes** — количество операций обновления сегментов индексов (refresh), для каждого хоста.
    * **Search queries** — количество запросов поиска в секунду, для каждого хоста.
    * **Segments** — количество сегментов индексов, для каждого хоста.
    * **Store size** — размер хранилища индексов на диске (в байтах).
    * **Write bytes** — скорость записи на диск, для каждого хоста (байт/с).
    * **Write operations** — интенсивность записи на диск, для каждого хоста (операций/с).

    {% note info %}

    {% include [monitoring-provides](../../_includes/mdb/monitoring-provides.md) %}

    {% endnote %}

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mes-name }}:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{mes-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**
    1. Выберите вкладку **Мониторинги**.
    1. Выберите нужный хост из выпадающего списка.

    На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

    * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
    * **Disk Bytes** — скорость дисковых операций (байт/с).
    * **Disk IOPS** — интенсивность дисковых операций (операций/с).
    * **Memory** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
    * **Network Bytes** — скорость обмена данными по сети (байт/с).
    * **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

{% endlist %}

{% if audience != "internal" %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
  1. В блоке **Сервисные дашборды** выберите:

      * **{{ mes-name }}** для настройки алертов кластера;
      * **{{ mes-name }} — Host Overview** для настройки алертов хостов.

  1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов [см. документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `Alarm` и `Warning` для срабатывания алерта.
  1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                      |                Обозначение                |         Формула        |              `Alarm`              |             `Warning`             |
|----------------------------------------------|:-----------------------------------------:|:----------------------:|:---------------------------------:|:---------------------------------:|
| Статус кластера                              |           `elasticsearch_status`          |     `bottom_last(1)`   |              `равно 0`            |              `равно 1`            |
| Число неназначенных шардов                   |     `elasticsearch_unassigned_shards`     |      `top_last(1)`     |             `больше 0`            |                                   |
| Число перемещаемых шардов                    |     `elasticsearch_relocating_shards`     |      `top_last(1)`     |             `больше 0`            |                                   |
| Число инициализируемых шардов                |    `elasticsearch_initializing_shards`    |      `top_last(1)`     |             `больше 0`            |                                   |
| Число отложенных к назначению шардов         | `elasticsearch_delayed_unassigned_shards` |      `top_last(1)`     |             `больше 0`            |                                   |
| Объем использованной памяти кучи JVM         | `elasticsearch_jvm_mem_heap_used_percent` |      `top_last(1)`     | больше 90% от объема RAM на хосте |                                   |
| Объем использованного хранилища              |   `elasticsearch_fs_total_used_percent`   |      `top_last(1)`     |  больше 90% от размера хранилища  |  больше 85% от размера хранилища  |
| Использование пула долгоживущих объектов JVM |   `elasticsearch_jvm_mem_heap_pressure`   |      `top_last(1)`     | больше 90% от объема RAM на хосте | больше 75% от объема RAM на хосте |

Текущий размер хранилища и объем RAM на хостах можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster).

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-elasticsearch).

{% endif %}

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите **{{ mes-name }}**.
    1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Метрики Solomon {#solomon}

Здесь приведены описания метрик {{ mes-name }}, которые автоматически собираются в Solomon.

Имя метрики пишется в метку `name`.

{% cut "Общие метки для всех метрик сервиса" %}

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-elasticsearch`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста

{% endcut %}

{% cut "Метрики CPU" %}

Загрузка процессорных ядер.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu-avg.md) %}

{% endcut %}

{% cut "Метрики диска" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Метрики дисковых операций" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "Метрики RAM" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Метрики сети" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Нативные метрики {{ ES }}" %}

Метрики, собранные через [API](https://www.elastic.co/guide/en/elasticsearch/reference/master/cluster-nodes-stats.html#cluster-nodes-stats-api-response-body).

| Имя<br/>Тип, единицы измерения | 
| ----- | 
| `elasticsearch_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `elasticsearch_fs_io_stats_total_operations`<br/>`DGAUGE`, штуки | 
| `elasticsearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, килобайты | 
| `elasticsearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, штуки | 
| `elasticsearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, килобайты | 
| `elasticsearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, штуки | 
| `elasticsearch_fs_total_available_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_fs_total_free_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_fs_total_total_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_fs_total_used_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_fs_total_used_percent`<br/>`DGAUGE`, штуки | 
| `elasticsearch_http_current_open`<br/>`DGAUGE`, штуки |
| `elasticsearch_http_total_opened`<br/>`DGAUGE`, штуки |
| `elasticsearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_docs_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_docs_deleted`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_fielddata_evictions`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_flush_periodic`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_flush_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_get_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_get_exists_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_get_missing_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_get_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_get_total`<br/>`DGAUGE`, штуки |
| `elasticsearch_indices_indexing_delete_current`<br/>`DGAUGE`, штуки |
| `elasticsearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_indexing_delete_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_indexing_index_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_indexing_index_failed`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `elasticsearch_indices_indexing_index_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_indexing_is_throttled`<br/>`DGAUGE`, штуки |
| `elasticsearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_merges_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_merges_current_docs`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_merges_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_merges_total_docs`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_query_cache_cache_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_query_cache_cache_size`<br/>`DGAUGE`, |  | 
| `elasticsearch_indices_query_cache_evictions`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_query_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_query_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_query_cache_total_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_recovery_current_as_source`<br/>`DGAUGE`, |  | 
| `elasticsearch_indices_recovery_current_as_target`<br/>`DGAUGE`, |  | 
| `elasticsearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_refresh_external_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_indices_refresh_listeners`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_refresh_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_indices_request_cache_evictions`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_request_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_request_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_fetch_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_indices_search_fetch_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_open_contexts`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_query_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_indices_search_query_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_scroll_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_indices_search_scroll_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_suggest_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_indices_search_suggest_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_segments_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, таймстамп | 
| `elasticsearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_shard_stats_total_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_store_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_store_total_data_set_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_translog_operations`<br/>`DGAUGE`, штуки |
| `elasticsearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, штуки |  | 
| `elasticsearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_indices_warmer_current`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_warmer_total`<br/>`DGAUGE`, штуки | 
| `elasticsearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_jvm_mem_heap_pressure`<br/>`DGAUGE` | 
| `elasticsearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, штуки | 
| `elasticsearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_number_of_data_nodes`<br/>`DGAUGE`, штуки | 
| `elasticsearch_number_of_in_flight_fetch`<br/>`DGAUGE`, штуки | 
| `elasticsearch_number_of_nodes`<br/>`DGAUGE`, штуки | 
| `elasticsearch_number_of_pending_tasks`<br/>`DGAUGE`, штуки | 
| `elasticsearch_process_cpu_percent`<br/>`DGAUGE`, штуки | 
| `elasticsearch_process_cpu_total_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `elasticsearch_process_max_file_descriptors`<br/>`DGAUGE`, штуки | 
| `elasticsearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_process_open_file_descriptors`<br/>`DGAUGE`, штуки | 
| `elasticsearch_process_timestamp`<br/>`DGAUGE`, таймстамп | 
| `elasticsearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, миллисекунды |
| `elasticsearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, штуки | 
| `elasticsearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, штуки | 
| `elasticsearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, штуки | 
| `elasticsearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, штуки | 
| `elasticsearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, штуки | 
| `elasticsearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, штуки | 
| `elasticsearch_transport_rx_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, байты | 
| `elasticsearch_transport_server_open`<br/>`DGAUGE`, штуки | 
| `elasticsearch_transport_total_outbound_connections`<br/>`DGAUGE`, штуки | 
| `elasticsearch_transport_tx_count`<br/>`DGAUGE`, штуки | 
| `elasticsearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, байты |

{% endcut %}

{% cut "Прочие метрики" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `elasticsearch_active_primary_shards`<br/>`DGAUGE`, штуки | Количество активных [первичных шардов](https://cloud.yandex.ru/docs/managed-elasticsearch/concepts/scalability-and-resilience) и общее количество активных шардов в кластере. | 
| `elasticsearch_active_shards`<br/>`DGAUGE`, штуки | Количество активных шардов. | 
| `elasticsearch_active_shards_percent_as_number`<br/>`DGAUGE`, штуки | Процент активных шардов. | 
| `elasticsearch_delayed_unassigned_shards`<br/>`DGAUGE`, штуки | Количество отложенных к назначению шардов. |
| `elasticsearch_initializing_shards`<br/>`DGAUGE`, штуки | Количество шардов в состоянии инициализации. | 
| `elasticsearch_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `elasticsearch_relocating_shards`<br/>`DGAUGE`, штуки | Количество перемещаемых шардов. | 
| `elasticsearch_status`<br/>`DGAUGE`, 0/1/2 | Уровень работоспособности и техническое состояние кластера:<br/>`0` — красный: неработоспособное или частично работоспособное состояние. Хотя бы один из первичных шардов недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.<br/>`1` — желтый: работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.<br/>`2` — зеленый: исправное состояние. Все шарды кластера доступны. |
| `elasticsearch_unassigned_shards`<br/>`DGAUGE`, штуки | Количество неактивных шардов с неназначенным хостом. |

{% endcut %}

{% endif %}
