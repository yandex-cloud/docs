---
title: "Мониторинг состояния {{ CH }}-кластера и хостов"
description: "Из статьи вы узнаете, как осуществлять мониторинг состояния {{ CH }}-кластера и хостов."
---

# Мониторинг состояния {{ CH }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mch-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  Если в кластере используется механизм репликации и распределения запросов с использованием [{{ ZK }}](../concepts/replication.md#zk), на вкладке **Мониторинг** появляются две вкладки:

  * **Clickhouse** — графики, которые показывают работу всего кластера и хостов {{ CH }}.
  * **Zookeeper** — графики, которые характеризуют работу хостов {{ ZK }}.

  Если репликация не используется или использует механизм [{{ CK }}](../concepts/replication.md#ck), графики с вкладки **Clickhouse** показываются на общей вкладке **Мониторинг**.

{% endlist %}

{% list tabs %}

- Clickhouse

  * **Active locks per host** — количество активных блокировок, для каждого хоста.
  * **Average insert query time per host** — среднее время исполнения запросов вставки, для каждого хоста.
  * **Average query time per host** — среднее время исполнения запросов, для каждого хоста.
  * **Average select query time per host** — среднее время исполнения запросов выборки, для каждого хоста.
  * **Connections per host** — количество подключений, для каждого хоста.
  * **CPU cores usage** — количество занятых процессорных ядер.
  * **CPU cores usage per host** — количество занятых процессорных ядер, для каждого хоста.
  * **CPU usage per host** — загрузка процессорных ядер, для каждого хоста.
  * **Disk read per host** — скорость чтения с диска, для каждого хоста (байт/с).
  * **Disk space usage** — занятое дисковое пространство (в байтах).
  * **Disk space usage per host** — занятое дисковое пространство, для каждого хоста (выводится два графика: в байтах и в процентах).
  * **Disk usage per host** — скорость дисковых операций, для каждого хоста (байт/с).
  * **Disk write per host** — скорость записи на диск, для каждого хоста (байт/с).
  * **Failed insert queries per host** — количество неуспешных запросов вставки в секунду, для каждого хоста.
  * **Failed queries per host** — общее количество неуспешных запросов в секунду, для каждого хоста.
  * **Failed select queries per host** — количество неуспешных запросов выборки в секунду, для каждого хоста.
  * **Inserted data** — скорость вставки данных (байт/с).
  * **Inserted data per host** — скорость вставки данных, для каждого хоста (байт/с).
  * **Inserted rows per host** — скорость вставки данных, для каждого хоста (строк/с).
  * **Insert queries** — количество запросов вставки в секунду.
  * **Insert queries per host** — количество запросов вставки в секунду, для каждого хоста.
  * **Max data parts per partition** — количество кусков данных в партиции, наибольшее среди всех таблиц. Лимит для этой величины определяется [настройками СУБД](../concepts/settings-list#setting-merge-tree). Приближение к лимиту указывает на чрезмерную нагрузку или низкую эффективность вставки данных.
  * **Max replication delay across tables** — задержка репликации, наибольшая среди всех таблиц. Значения больше нескольких секунд могут указывать на чрезмерную нагрузку или проблемы в работе репликации.
  * **Max replication queue across tables** — максимальная длина очереди репликации таблиц. Значения больше нескольких единиц могут указывать на чрезмерную нагрузку или проблемы в работе репликации.
  * **Memory usage** — использование оперативной памяти (в байтах).
  * **Memory usage per host** — использование оперативной памяти, для каждого хоста (выводится два графика: в байтах и в процентах).
  * **Merged data** — скорость слияния данных (байт/с).
  * **Merged data per host** — скорость слияния данных, для каждого хоста (байт/с).
  * **Merged rows per host** — скорость слияния данных, для каждого хоста (строк/с).
  * **Network data received per host** — скорость приема данных из сети, для каждого хоста (байт/с).
  * **Network data sent per host** — скорость отправки данных в сеть, для каждого хоста (байт/с).
  * **Network usage per host** — скорость обмена данными по сети, для каждого хоста (байт/с).
  * **Read data** — скорость чтения данных (байт/с).
  * **Read data per host** — скорость чтения данных, для каждого хоста (байт/с).
  * **Read parts per host** — скорость чтения кусков данных, для каждого хоста (строк/с).
  * **Select queries** — количество запросов выборки в секунду.
  * **Select queries per host** — количество запросов выборки в секунду, для каждого хоста.
  * **Total queries** — общее количество запросов в секунду.
  * **Total queries per host** — общее количество запросов в секунду, для каждого хоста.
  * **Waiting locks per host** — количество ожидающих блокировок, для каждого хоста.

- Zookeeper

  * **Average latency per ZooKeeper host** — средняя задержка ответа, для каждого хоста ZooKeeper.
  * **Average transaction time per ClickHouse host** — среднее время транзакции, для каждого хоста ClickHouse. Характеризует время, затрачиваемое ClickHouse на обращения к ZooKeeper.
  * **Connections per ZooKeeper host** — количество подключений, для каждого хоста ZooKeeper.
  * **CPU cores usage** — количество занятых процессорных ядер.
  * **CPU cores usage per host** — количество занятых процессорных ядер, для каждого хоста.
  * **CPU usage per host** — загрузка процессорных ядер, для каждого хоста.
  * **Disk read per host** — скорость чтения с диска, для каждого хоста (байт/с).
  * **Disk space usage** — занятое дисковое пространство (в байтах). Выводится два графика: для каждого хоста и для всех хостов.
  * **Disk space usage per host** — использование дискового пространства, для каждого хоста (в процентах).
  * **Disk usage per host** — скорость дисковых операций, для каждого хоста (байт/с).
  * **Disk write per host** — скорость записи на диск, для каждого хоста (байт/с).
  * **Ephemeral nodes** — количество объектов Ephemeral node.

  {% note info %}

  Подробнее об объектах Znode, Ephemeral node и Watch см. в [документации {{ ZK }}](https://zookeeper.apache.org/doc/current/zookeeperOver.html). {#zookeeper-objects}

  {% endnote %}

  * **Memory usage** — использование оперативной памяти (в байтах).
  * **Memory usage per host** — использование оперативной памяти, для каждого хоста (выводится два графика: в байтах и в процентах).
  * **Network data received per host** — скорость приема данных из сети, для каждого хоста (байт/с).
  * **Network data sent per host** — скорость отправки данных в сеть, для каждого хоста (байт/с).
  * **Network usage per host** — скорость обмена данными по сети, для каждого хоста (байт/с).
  * **Outstanding requests per ZooKeeper host** — количество запросов, находящихся в обработке, для каждого хоста ZooKeeper.
  * **Transactions** — количество транзакций в секунду.
  * **Transactions per ClickHouse host** — количество транзакций в секунду, для каждого хоста ClickHouse.
  * **Watches** — количество объектов Watch.
  * **Znodes** — количество объектов Znode.

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mch-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Выберите вкладку **Мониторинги**.
  1. Выберите нужный хост из выпадающего списка. Возле имени хоста будет показан его тип: `CLICKHOUSE` или `ZOOKEEPER`.

  На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

  * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
  * **Disk Bytes** — скорость дисковых операций (байт/с).
  * **Disk IOPS** — интенсивность дисковых операций (операций/с).
  * **Memory** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
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
      * **{{ mch-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mch-name }} — ZooKeeper** для настройки алертов хостов ZooKeeper.
      * **{{ mch-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите **Создать алерт**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов [см. в документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `Alarm` и `Warning` для срабатывания алерта.
  1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                      | Обозначение                                        | `Alarm`                      | `Warning`                    |
|----------------------------------------------|:--------------------------------------------------:|:----------------------------:|:----------------------------:|
| Максимальное число кусков данных в разделе   | `ch_system_async_metrics_MaxPartCountForPartition` | `250`                        | `150`                        |
| Количество запросов, завершившихся с ошибкой | `ch_system_events_FailedQuery_rate`                | 20% от общего числа запросов | 10% от общего числа запросов |
| Размер использованного хранилища             | `disk.used_bytes`                                  | 95% от размера хранилища     | 80% от размера хранилища     |
| Количество работоспособных хостов            | `is_alive`                                         | `<количество хостов> - 2`    | `<количество хостов> - 1`    |

Чтобы определить пороговые значения метрики `ch_system_events_FailedQuery_rate`, используйте значение показателя `Total queries` [для кластера](#monitoring-cluster).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster).

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-clickhouse).

{% endif %}

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите **{{ mch-name }}**.
  1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Метрики Solomon {#solomon}

Здесь приведены описания метрик {{ mch-name }}, которые автоматически собираются в Solomon.

Имя метрики пишется в метку `name`.

{% cut "Общие метки для всех метрик сервиса" %}

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-clickhouse`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `replica`, `follower`, `leader`
subcluster_name | Тип подкластера: `clickhouse_subcluster`, `zookeeper_subcluster`
shard | Идентификатор шарда

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

{% cut "Метрики системных событий" %}

Нативные метрики ClickHouse из таблицы [system.events]({{ ch.docs }}/operations/system-tables/events). По каждой метрике считается прирост `inc` и скорость изменения `rate` за единицу времени.

| Имя<br/>Тип| 
| ----- | 
| `ch_system_events_ArenaAllocBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_ArenaAllocBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_ArenaAllocChunks_inc`<br/>`DGAUGE` | 
| `ch_system_events_ArenaAllocChunks_rate`<br/>`DGAUGE` | 
| `ch_system_events_CannotWriteToWriteBufferDiscard_inc`<br/>`DGAUGE` | 
| `ch_system_events_CannotWriteToWriteBufferDiscard_rate`<br/>`DGAUGE` | 
| `ch_system_events_CompileExpressionsBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_CompileExpressionsBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_CompileExpressionsMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_CompileExpressionsMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_CompileFunction_inc`<br/>`DGAUGE` | 
| `ch_system_events_CompileFunction_rate`<br/>`DGAUGE` | 
| `ch_system_events_CompressedReadBufferBlocks_inc`<br/>`DGAUGE` | 
| `ch_system_events_CompressedReadBufferBlocks_rate`<br/>`DGAUGE` | 
| `ch_system_events_CompressedReadBufferBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_CompressedReadBufferBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_ContextLock_inc`<br/>`DGAUGE` | 
| `ch_system_events_ContextLock_rate`<br/>`DGAUGE` | 
| `ch_system_events_CreatedHTTPConnections_inc`<br/>`DGAUGE` | 
| `ch_system_events_CreatedHTTPConnections_rate`<br/>`DGAUGE` | 
| `ch_system_events_CreatedLogEntryForMerge_inc`<br/>`DGAUGE` | 
| `ch_system_events_CreatedLogEntryForMerge_rate`<br/>`DGAUGE` | 
| `ch_system_events_CreatedReadBufferOrdinary_inc`<br/>`DGAUGE` | 
| `ch_system_events_CreatedReadBufferOrdinary_rate`<br/>`DGAUGE` | 
| `ch_system_events_DiskReadElapsedMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_DiskReadElapsedMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_DiskWriteElapsedMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_DiskWriteElapsedMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_DuplicatedInsertedBlocks_inc`<br/>`DGAUGE` | 
| `ch_system_events_DuplicatedInsertedBlocks_rate`<br/>`DGAUGE` | 
| `ch_system_events_FailedQuery_inc`<br/>`DGAUGE` | 
| `ch_system_events_FailedQuery_rate`<br/>`DGAUGE` | 
| `ch_system_events_FailedSelectQuery_inc`<br/>`DGAUGE` | 
| `ch_system_events_FailedSelectQuery_rate`<br/>`DGAUGE` | 
| `ch_system_events_FileOpen_inc`<br/>`DGAUGE` | 
| `ch_system_events_FileOpen_rate`<br/>`DGAUGE` | 
| `ch_system_events_FunctionExecute_inc`<br/>`DGAUGE` | 
| `ch_system_events_FunctionExecute_rate`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocs_inc`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocs_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertQueryTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertQueryTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertQuery_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertQuery_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertedRows_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertedRows_rate`<br/>`DGAUGE` | 
| `ch_system_events_MainConfigLoads_inc`<br/>`DGAUGE` | 
| `ch_system_events_MainConfigLoads_rate`<br/>`DGAUGE` | 
| `ch_system_events_MarkCacheHits_inc`<br/>`DGAUGE` | 
| `ch_system_events_MarkCacheHits_rate`<br/>`DGAUGE` | 
| `ch_system_events_MarkCacheMisses_inc`<br/>`DGAUGE` | 
| `ch_system_events_MarkCacheMisses_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterBlocks_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterBlocks_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterCompressedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterCompressedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterRows_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterRows_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_Merge_inc`<br/>`DGAUGE` | 
| `ch_system_events_Merge_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergedRows_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergedRows_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergedUncompressedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergedUncompressedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_MergesTimeMilliseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergesTimeMilliseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_NetworkReceiveBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_NetworkReceiveBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_NetworkReceiveElapsedMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_NetworkReceiveElapsedMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_NetworkSendBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_NetworkSendBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_NetworkSendElapsedMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_NetworkSendElapsedMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_NotCreatedLogEntryForMerge_inc`<br/>`DGAUGE` | 
| `ch_system_events_NotCreatedLogEntryForMerge_rate`<br/>`DGAUGE` | 
| `ch_system_events_OSCPUVirtualTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_OSCPUVirtualTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_OSCPUWaitMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_OSCPUWaitMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_OSIOWaitMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_OSIOWaitMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_ObsoleteReplicatedParts_inc`<br/>`DGAUGE` | 
| `ch_system_events_ObsoleteReplicatedParts_rate`<br/>`DGAUGE` | 
| `ch_system_events_OpenedFileCacheHits_inc`<br/>`DGAUGE` | 
| `ch_system_events_OpenedFileCacheHits_rate`<br/>`DGAUGE` | 
| `ch_system_events_OpenedFileCacheMisses_inc`<br/>`DGAUGE` | 
| `ch_system_events_OpenedFileCacheMisses_rate`<br/>`DGAUGE` | 
| `ch_system_events_QueryProfilerRuns_inc`<br/>`DGAUGE` | 
| `ch_system_events_QueryProfilerRuns_rate`<br/>`DGAUGE` | 
| `ch_system_events_QueryTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_QueryTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_Query_inc`<br/>`DGAUGE` | 
| `ch_system_events_Query_rate`<br/>`DGAUGE` | 
| `ch_system_events_RWLockAcquiredReadLocks_inc`<br/>`DGAUGE` | 
| `ch_system_events_RWLockAcquiredReadLocks_rate`<br/>`DGAUGE` | 
| `ch_system_events_RWLockReadersWaitMilliseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_RWLockReadersWaitMilliseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReadBufferFromFileDescriptorRead_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReadBufferFromFileDescriptorRead_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReadCompressedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReadCompressedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_RealTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_RealTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_RegexpCreated_inc`<br/>`DGAUGE` | 
| `ch_system_events_RegexpCreated_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartChecksFailed_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartChecksFailed_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartChecks_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartChecks_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartFailedFetches_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartFailedFetches_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartFetchesOfMerged_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartFetchesOfMerged_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartFetches_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartFetches_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartMerges_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReplicatedPartMerges_rate`<br/>`DGAUGE` | 
| `ch_system_events_ScalarSubqueriesCacheMiss_inc`<br/>`DGAUGE` | 
| `ch_system_events_ScalarSubqueriesCacheMiss_rate`<br/>`DGAUGE` | 
| `ch_system_events_Seek_inc`<br/>`DGAUGE` | 
| `ch_system_events_Seek_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectQueryTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectQueryTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectQuery_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectQuery_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedMarks_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedMarks_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedParts_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedParts_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedRanges_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedRanges_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedRows_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedRows_rate`<br/>`DGAUGE` | 
| `ch_system_events_SoftPageFaults_inc`<br/>`DGAUGE` | 
| `ch_system_events_SoftPageFaults_rate`<br/>`DGAUGE` | 
| `ch_system_events_SystemTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_SystemTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_UserTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_UserTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_WriteBufferFromFileDescriptorWrite_inc`<br/>`DGAUGE` | 
| `ch_system_events_WriteBufferFromFileDescriptorWrite_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperBytesReceived_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperBytesReceived_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperBytesSent_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperBytesSent_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperCreate_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperCreate_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperExists_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperExists_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperGet_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperGet_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperInit_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperInit_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperList_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperList_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperMulti_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperMulti_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperRemove_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperRemove_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperSet_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperSet_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperTransactions_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperTransactions_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperUserExceptions_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperUserExceptions_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperWaitMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperWaitMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperWatchResponse_inc`<br/>`DGAUGE` | 
| `ch_system_events_ZooKeeperWatchResponse_rate`<br/>`DGAUGE` | 

{% endcut %}

{% cut "Метрики текущих событий" %}

Нативные метрики ClickHouse из таблицы [system.metrics]({{ ch.docs }}/operations/system-tables/metrics/).

| Имя<br/>Тип| 
| ----- | 
| `ch_system_metrics_ActiveAsyncDrainedConnections`<br/>`DGAUGE` | 
| `ch_system_metrics_ActiveSyncDrainedConnections`<br/>`DGAUGE` | 
| `ch_system_metrics_AsyncDrainedConnections`<br/>`DGAUGE` | 
| `ch_system_metrics_AsynchronousReadWait`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundCommonPoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundDistributedSchedulePoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundFetchesPoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundMergesAndMutationsPoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundMovePoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` | 
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDictionaryUpdateQueueBatches`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDictionaryUpdateQueueKeys`<br/>`DGAUGE` | 
| `ch_system_metrics_Connection`<br/>`DGAUGE` | 
| `ch_system_metrics_ContextLockWait`<br/>`DGAUGE` | 
| `ch_system_metrics_DelayedInserts`<br/>`DGAUGE` | 
| `ch_system_metrics_DictCacheRequests`<br/>`DGAUGE` | 
| `ch_system_metrics_DiskSpaceReservedForMerge`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedFilesToInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedSend`<br/>`DGAUGE` | 
| `ch_system_metrics_EphemeralNode`<br/>`DGAUGE` | 
| `ch_system_metrics_GlobalThread`<br/>`DGAUGE` | 
| `ch_system_metrics_GlobalThreadActive`<br/>`DGAUGE` | 
| `ch_system_metrics_HTTPConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_InterserverConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_LocalThread`<br/>`DGAUGE` | 
| `ch_system_metrics_LocalThreadActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MMappedFileBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFiles`<br/>`DGAUGE` | 
| `ch_system_metrics_MaxDDLEntryID`<br/>`DGAUGE` | 
| `ch_system_metrics_MaxPushedDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTracking`<br/>`DGAUGE` | 
| `ch_system_metrics_Merge`<br/>`DGAUGE` | 
| `ch_system_metrics_MySQLConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_NetworkReceive`<br/>`DGAUGE` | 
| `ch_system_metrics_NetworkSend`<br/>`DGAUGE` | 
| `ch_system_metrics_OpenFileForRead`<br/>`DGAUGE` | 
| `ch_system_metrics_OpenFileForWrite`<br/>`DGAUGE` | 
| `ch_system_metrics_PartMutation`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsCommitted`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsCompact`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsDeleteOnDestroy`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsDeleting`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsInMemory`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsOutdated`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsPreActive`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsPreCommitted`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsTemporary`<br/>`DGAUGE` | 
| `ch_system_metrics_PartsWide`<br/>`DGAUGE` | 
| `ch_system_metrics_PendingAsyncInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_PostgreSQLConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_Query`<br/>`DGAUGE` | 
| `ch_system_metrics_QueryPreempted`<br/>`DGAUGE` | 
| `ch_system_metrics_QueryThread`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockActiveReaders`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockActiveTotal`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockActiveWriters`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockWaitingReaders`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockWaitingTotal`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockWaitingWriters`<br/>`DGAUGE` | 
| `ch_system_metrics_Read`<br/>`DGAUGE` | 
| `ch_system_metrics_ReadonlyReplica`<br/>`DGAUGE` | 
| `ch_system_metrics_ReplicatedChecks`<br/>`DGAUGE` | 
| `ch_system_metrics_ReplicatedFetch`<br/>`DGAUGE` | 
| `ch_system_metrics_ReplicatedSend`<br/>`DGAUGE` | 
| `ch_system_metrics_Revision`<br/>`DGAUGE` | 
| `ch_system_metrics_SendExternalTables`<br/>`DGAUGE` | 
| `ch_system_metrics_SendScalars`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageBufferBytes`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageBufferRows`<br/>`DGAUGE` | 
| `ch_system_metrics_SyncDrainedConnections`<br/>`DGAUGE` | 
| `ch_system_metrics_TCPConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_TablesToDropQueueSize`<br/>`DGAUGE` | 
| `ch_system_metrics_VersionInteger`<br/>`DGAUGE` | 
| `ch_system_metrics_Write`<br/>`DGAUGE` | 
| `ch_system_metrics_ZooKeeperRequest`<br/>`DGAUGE` | 
| `ch_system_metrics_ZooKeeperSession`<br/>`DGAUGE` | 
| `ch_system_metrics_ZooKeeperWatch`<br/>`DGAUGE` | 

{% endcut %}

{% cut "Метрики очереди запросов" %}

Нативные метрики ClickHouse из таблицы [system.query_log]({{ ch.docs }}/operations/system-tables/query_log). По каждой метрике считается прирост за единицу времени (секунда).

| Имя<br/>Тип| 
| ----- | 
| `ch_system_query_log_insert_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_read_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_read_rows_inc`<br/>`DGAUGE` |
| `ch_system_query_log_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_result_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_result_rows_inc`<br/>`DGAUGE` |
| `ch_system_query_log_select_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_written_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_written_rows_inc`<br/>`DGAUGE` |

{% endcut %}

{% cut "Метрики Zookeeper" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `zk_avg_latency`<br/>`DGAUGE`, миллисекунды | Cредняя задержка ответа хоста Zookeeper. | 
| `zk_ephemerals_count`<br/>`DGAUGE`, штуки | Количество объектов Ephemeral node. | 
| `zk_num_alive_connections`<br/>`DGAUGE`, штуки | Количество подключений. | 
| `zk_outstanding_requests`<br/>`DGAUGE`, штуки | Количество запросов, находящихся в обработке. | 
| `zk_watch_count`<br/>`DGAUGE`, штуки | Количество объектов Watch. | 
| `zk_znode_count`<br/>`DGAUGE`, штуки | Количество объектов Znode. |

{% endcut %}

{% cut "Метрики репликации" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_replication-future_parts`<br/>`DGAUGE`, штуки | Количество блоков данных после завершения слияний и операций INSERT.| 
| `ch_replication-inserts_in_queue`<br/>`DGAUGE`, штуки | Количество блоков данных, ожидающих вставки. | 
| `ch_replication-is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности репликации.<br/>Принимает значение `1`, если репликация БД работает, `0`, если нет. | 
| `ch_replication-max_absolute_delay`<br/>`DGAUGE`, секунды | Максимальное время задержки репликации. | 
| `ch_replication-merges_in_queue`<br/>`DGAUGE`, штуки | Количество слияний в очереди. | 
| `ch_replication-parts_to_check`<br/>`DGAUGE`, штуки | Количество блоков данных, ожидающих проверки. | 
| `ch_replication-queue_size`<br/>`DGAUGE`, штуки | Размер очереди операций слияния и вставок. | 
| `ch_replication-tables`<br/>`DGAUGE`, штуки | Количество реплицируемых таблиц. |

{% endcut %}

{% cut "Системные метрики" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_config_merge_tree_parts_to_throw_insert`<br/>`DGAUGE`, штуки | Предельное число активных кусков данных таблицы, при превышении которого ClickHouse отправляет исключение `Too many parts ....` Задается в [настройках](https://cloud.yandex.ru/docs/managed-clickhouse/concepts/settings-list#setting-merge-tree). Имеет смысл анализировать в паре с метрикой `ch_system_async_metrics_MaxPartCountForPartition`. |
| `ch_local_disk_parts_size`<br/>`DGAUGE`, байты | Размер партиций на локальных дисках. |
| `ch_system_async_metrics_MaxPartCountForPartition`<br/>`DGAUGE`, штуки | Максимальное число кусков данных в разделе. | 
| `ch_system_async_metrics_ReplicasMaxAbsoluteDelay`<br/>`DGAUGE`, секунды | Максимальное время задержки репликации. | 
| `ch_system_async_metrics_ReplicasMaxQueueSize`<br/>`DGAUGE`, штуки | Максимальный размер очереди репликации. |

{% endcut %}

{% cut "Прочие метрики" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. |

{% endcut %}

{% endif %}
