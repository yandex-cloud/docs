# Метрики дашборда {{ CH }}

Дашборд {{ CH }} в {{ grafana-name }} предоставляет комплексный мониторинг кластера СУБД {{ CH }}. Дашборд содержит метрики производительности, состояния репликации, использования ресурсов и других важных параметров работы кластера.

Чтобы открыть дашборд кластера:

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **{{ CH }} Clusters**.
1. Выберите кластер.
1. Нажмите кнопку **Мониторинг кластера**.

Откроется дашборд кластера.

## Общая информация

**Название дашборда**: {{ CH }}
**UID**: `clickhouse-operator`
**Интервал обновления**: 10 секунд
**Источник данных**: {{ prometheus-name }}

## Переменные дашборда

Дашборд использует следующие переменные для фильтрации данных:

* **Cluster** (`chi`) — выбор кластера {{ CH }};
* **Server** (`hostname`) — выбор конкретного сервера;
* **Namespace** (`namespace`) — проект Stackland, где развернут {{ CH }} Operator.

## Панели и метрики

### 1. Uptime (logarithmic)

**Описание**: Время работы серверов {{ CH }} с момента последнего запуска. График использует логарифмическую шкалу для удобного отображения больших значений.

**Метрика**: `chi_clickhouse_metric_Uptime`

**Единица измерения**: секунды

### 2. Failed Pods

**Описание**: Количество подов, с которых metrics-exporter не может получить метрики от clickhouse-server. Ненулевое значение указывает на проблемы с доступностью серверов.

**Метрика**: `chi_clickhouse_metric_fetch_errors`

**Единица измерения**: количество

**Рекомендации**: При обнаружении ошибок проверьте статус подов командой `kubectl get pods --all-namespaces | grep clickhouse`.

**Ссылки**:
* [metric_fetch_errors на GitHub](https://github.com/Altinity/clickhouse-operator/search?q=metric_fetch_errors)

### 3. Version

**Описание**: Версия {{ CH }}, установленная на серверах. Версия отображается в числовом формате (например, версия 11.22.33 отображается как 11022033).

**Метрика**: `chi_clickhouse_metric_VersionInteger`

**Единица измерения**: числовое представление версии

### 4. Tables / Databases

**Описание**: Общее количество таблиц и баз данных в кластере.

**Метрики**:
* `chi_clickhouse_metric_NumberOfTables` — количество таблиц;
* `chi_clickhouse_metric_NumberOfDatabases` — количество баз данных.

**Единица измерения**: количество



### 5. ReadOnly replicas

**Описание**: Количество реплик, находящихся в режиме только для чтения. Ненулевое значение указывает на проблемы с репликацией.

**Метрика**: `chi_clickhouse_metric_ReadonlyReplica`

**Единица измерения**: количество



**Рекомендации**: Проверьте подключение к {{ ZK }}, свободное место на диске и сетевое соединение между репликами.

**Ссылки**:
* [Восстановление после сбоев](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication/#recovery-after-failures)
* [Восстановление после потери данных](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication/#recovery-after-complete-data-loss)

### 6. DNS and Distributed Connection Errors

**Описание**: Ошибки DNS и сбои соединений между серверами в распределенных таблицах.

**Метрики**:
* `chi_clickhouse_event_NetworkErrors` — сетевые ошибки;
* `chi_clickhouse_event_DistributedConnectionFailAtAll` — полные сбои распределенных соединений;
* `chi_clickhouse_event_DistributedConnectionFailTry` — попытки соединения, завершившиеся неудачей;
* `chi_clickhouse_event_DNSError` — ошибки DNS.

**Единица измерения**: количество событий в минуту

**Ссылки**:
* [Управление распределенными таблицами](https://clickhouse.com/docs/en/sql-reference/statements/system#managing-distributed-tables)
* [DNSError на GitHub](https://github.com/clickhouse/clickhouse/search?q=DNSError)

### 7. Replication and {{ ZK }} Exceptions

**Описание**: Метрики репликации и исключения при работе с {{ ZK }}.

**Метрики**:
* `chi_clickhouse_metric_ReadonlyReplica` — реплики только для чтения;
* `chi_clickhouse_event_ReplicaPartialShutdown` — частичное отключение реплик;
* `chi_clickhouse_event_{{ ZK }}UserExceptions` — пользовательские исключения {{ ZK }};
* `chi_clickhouse_event_{{ ZK }}Init` — инициализация {{ ZK }};
* `chi_clickhouse_metric_{{ ZK }}Session` — сессии {{ ZK }};
* `chi_clickhouse_event_{{ ZK }}HardwareExceptions` — аппаратные исключения {{ ZK }}.

**Единица измерения**: количество событий в минуту

**Ссылки**:
* [Рекомендуемые настройки {{ ZK }}](https://clickhouse.com/docs/en/operations/tips#zookeeper)
* [system.zookeeper](https://clickhouse.com/docs/en/operations/system-tables/zookeeper)

### 8. Delayed/Rejected/Pending Inserts

**Описание**: Метрики задержанных, отклоненных и ожидающих вставок данных.

**Метрики**:
* `chi_clickhouse_metric_DelayedInserts` — текущее количество задержанных запросов INSERT;
* `chi_clickhouse_event_DelayedInserts` — общий счетчик задержанных блоков;
* `chi_clickhouse_event_RejectedInserts` — количество отклоненных блоков;
* `chi_clickhouse_metric_DistributedFilesToInsert` — файлы, ожидающие вставки в распределенные таблицы;
* `chi_clickhouse_metric_BrokenDistributedFilesToInsert` — поврежденные файлы распределенных таблиц.

**Единица измерения**: количество

**Описание метрик**:
* **delayed query** — количество запросов INSERT, которые замедлены из-за большого количества активных частей данных;
* **delayed blocks** — количество блоков, вставка которых была замедлена;
* **rejected blocks** — количество блоков, вставка которых была отклонена с ошибкой «Too many parts».

**Рекомендации**: Проверьте параметры `parts_to_delay_insert` и `parts_to_throw_insert` в таблице `system.merge_tree_settings`.

**Ссылки**:
* [system.parts_log](https://clickhouse.com/docs/en/operations/system-tables/part_log)
* [system.merge_tree_settings](https://clickhouse.com/docs/en/operations/system-tables/merge_tree_settings)

### 9. Queries (running)

**Описание**: Количество выполняющихся запросов на каждом сервере и в целом по кластеру.

**Метрика**: `chi_clickhouse_metric_Query`

**Единица измерения**: количество

**Ссылки**:
* [max_concurrent_queries](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#max_concurrent_queries)
* [max_execution_time](https://clickhouse.com/docs/en/operations/settings/query-complexity#max-execution-time)

### 10. Select Queries (started per sec)

**Описание**: Количество запросов SELECT, запущенных в секунду.

**Метрика**: `chi_clickhouse_event_SelectQuery`

**Единица измерения**: запросов в секунду

### 11. Memory for Queries

**Описание**: Общий объем памяти, выделенной для выполняющихся запросов. Некоторые выделения памяти могут не учитываться.

**Метрика**: `chi_clickhouse_metric_MemoryTracking`

**Единица измерения**: байты

**Ссылки**:
* [max_memory_usage](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_memory_usage)

### 12. Insert Queries (running)

**Описание**: Количество выполняющихся запросов INSERT. Не включает запросы, которые не прошли парсинг или были отклонены из-за ограничений. Включает внутренние запросы, инициированные {{ CH }}

**Метрика**: `chi_clickhouse_event_InsertQuery`

**Единица измерения**: запросов в минуту

### 13. Insert Queries (started per sec)

**Описание**: Количество запросов INSERT, запущенных в секунду.

**Метрика**: `chi_clickhouse_event_InsertQuery`

**Единица измерения**: запросов в секунду

### 14. Rows Inserted

**Описание**: Количество строк, вставленных в таблицы.

**Метрика**: `chi_clickhouse_event_InsertedRows`

**Единица измерения**: строк в минуту

### 15. Replication Queue Jobs

**Описание**: Интенсивность обмена частями (parts) данных между репликами.

**Метрики**:
* `chi_clickhouse_event_ReplicatedDataLoss` — потеря данных при репликации;
* `chi_clickhouse_event_ReplicatedPartChecks` — счетчик проверок частей данных;
* `chi_clickhouse_event_ReplicatedPartChecksFailed` — счетчик неудачных проверок частей данных;
* `chi_clickhouse_event_ReplicatedPartFetches` — показатель сетевой репликационной активности;
* `chi_clickhouse_event_ReplicatedPartFailedFetches` — счетчик неудачных попыток получения частей данных;
* `chi_clickhouse_event_ReplicatedPartFetchesOfMerged` — получение объединенных частей данных;
* `chi_clickhouse_event_ReplicatedPartMerges` — объединение реплицированных частей данных;
* `chi_clickhouse_metric_ReplicasSumInsertsInQueue` — задержка репликации данных, показывает количество необработанных запросов в очереди;
* `chi_clickhouse_metric_ReplicasSumMergesInQueue` — задержка слияния данных, показывает количество еще невыполненных репликами слияний данных.

**Единица измерения**: количество событий в минуту



**Ссылки**:
* [Как работает репликация](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication)

### 16. Max Replica Delay

**Описание**: Задержка реплик относительно текущего времени при прямой вставке в таблицы `*ReplicatedMergeTree`.

**Метрики**:
* `chi_clickhouse_metric_ReplicasMaxAbsoluteDelay` — абсолютная задержка в секундах;
* `chi_clickhouse_metric_ReplicasMaxRelativeDelay` — относительная задержка в секундах.

**Единица измерения**: секунды



**Ссылки**:
* [Архитектура репликации](https://clickhouse.com/docs/en/development/architecture#replication)
* [ReplicatedMergeTree](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication)
* [max_replica_delay_for_distributed_queries](https://clickhouse.com/docs/en/operations/settings/settings#settings-max_replica_delay_for_distributed_queries)

### 17. Zookeeper Transactions

**Описание**: Количество транзакций {{ ZK }} в секунду.

**Метрика**: `chi_clickhouse_event_{{ ZK }}Transactions`

**Единица измерения**: транзакций в секунду



**Ссылки**:
* [Архитектура репликации](https://clickhouse.com/docs/en/development/architecture#replication)

### 18. Merges

**Описание**: Интенсивность фоновых процессов слияния частей данных.

**Метрика**: `chi_clickhouse_event_Merge`

**Единица измерения**: слияний в минуту



**Ссылки**:
* [START/STOP Merges](https://clickhouse.com/docs/en/sql-reference/statements/system#stop-merges)
* [MergeTree Engine](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree)

### 19. Merged Rows

**Описание**: Количество строк, обработанных в процессе слияния.

**Метрика**: `chi_clickhouse_event_MergedRows`

**Единица измерения**: строк в минуту



### 20. Merged Uncompressed Bytes

**Описание**: Объем несжатых данных, обработанных в процессе слияния.

**Метрика**: `chi_clickhouse_event_MergedUncompressedBytes`

**Единица измерения**: байты в минуту



### 21. Active Parts

**Описание**: Количество активных частей данных в таблицах.

**Метрика**: `chi_clickhouse_table_parts` (с фильтром `active="1"`)

**Единица измерения**: количество

**Ссылки**:
* [system.parts](https://clickhouse.com/docs/en/operations/system-tables/parts)
* [parts_to_delay_insert](https://github.com/clickhouse/clickhouse/search?q=parts_to_delay_insert)

### 22. Detached parts

**Описание**: Количество отсоединенных частей данных с указанием причины отсоединения.

**Метрики**:
* `chi_clickhouse_metric_DetachedParts` — количество отсоединённых частей данных;
* `chi_clickhouse_table_parts` (с фильтром `active="0"`) — неактивные части.

**Единица измерения**: количество

**Причины отсоединения**:
* `detached_by_user` — отсоединено пользователем;
* `broken` — поврежденные части;
* `clone` — клонированные части;
* `ignored` — игнорируемые части.

**Ссылки**:
* [system.detached_parts](https://clickhouse.com/docs/en/operations/system-tables/detached_parts/)

### 23. Max Part count for Partition

**Описание**: Максимальное количество физических частей данных в одной логической партиции.

**Метрика**: `chi_clickhouse_metric_MaxPartCountForPartition`

**Единица измерения**: количество



**Ссылки**:
* [Custom Partitioning Key](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/custom-partitioning-key/)
* [system.parts](https://clickhouse.com/docs/en/operations/system-tables/parts)
* [system.part_log](https://clickhouse.com/docs/en/operations/system-tables/part-log)

### 24. clickhouse-server Process Memory

**Описание**: Использование памяти процессом clickhouse-server (доступно с версии {{ CH }} 20.4+).

**Метрики**:
* `chi_clickhouse_metric_MemoryCode` — CODE (исполняемый код);
* `chi_clickhouse_metric_MemoryResident` — RSS (резидентная память);
* `chi_clickhouse_metric_MemoryShared` — SHR (разделяемая память);
* `chi_clickhouse_metric_MemoryDataAndStack` — DATA (данные и стек);
* `chi_clickhouse_metric_MemoryVirtual` — VIRT (виртуальная память).

**Единица измерения**: байты

**Описание типов памяти**:
* **VIRT** — общий объем виртуальной памяти (VIRT = SWAP + RSS);
* **SWAP** — объем выгруженной в swap памяти;
* **RSS** — физическая память, не выгруженная в swap (RSS = CODE + DATA);
* **CODE** — память для исполняемого кода (Text Resident Set);
* **DATA** — память для данных, отличных от исполняемого кода (Data Resident Set);
* **SHR** — разделяемая память, которая может использоваться другими процессами.

**Ссылки**:
* [Описание типов памяти Linux](https://elinux.org/Runtime_Memory_Measurement)

### 25. Primary Keys Memory

**Описание**: Объем памяти, выделенной для хранения первичных ключей.

**Метрика**: `chi_clickhouse_metric_MemoryPrimaryKeyBytesAllocated`

**Единица измерения**: байты



**Ссылки**:
* [Выбор первичного ключа](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#selecting-the-primary-key)

### 26. Dictionary Memory

**Описание**: Объем памяти, выделенной для словарей.

**Метрика**: `chi_clickhouse_metric_MemoryDictionaryBytesAllocated`

**Единица измерения**: байты



**Ссылки**:
* [system.dictionaries](https://clickhouse.com/docs/en/operations/system-tables/dictionaries)
* [CREATE DICTIONARY](https://clickhouse.com/docs/en/sql-reference/statements/create/dictionary)

### 27. Disk Space Free

**Описание**: Процент свободного места на дисках. Важно учитывать конфигурацию с несколькими томами, {{ k8s }} volume claims и {{ objstorage-name }} в качестве бэкенда хранения.

**Метрика**: `chi_clickhouse_metric_DiskFreeBytes / chi_clickhouse_metric_DiskTotalBytes`

**Единица измерения**: процент (0-1)



**Ссылки**:
* [system.disks](https://clickhouse.com/docs/en/operations/system-tables/disks/)
* [Multiple Disk Volumes](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes)

### 28. Table Stats

**Описание**: Статистика по таблицам: размер данных, количество строк, количество частей и средний размер строки.

**Метрики**:
* `chi_clickhouse_table_parts_bytes` — размер данных в байтах;
* `chi_clickhouse_table_parts_rows` — количество строк;
* `chi_clickhouse_table_parts` — количество частей.

**Единица измерения**:
* Bytes — байты;
* Rows — количество строк;
* Parts — количество частей;
* BytePerRow — байт на строку (вычисляемое поле).



### 29. Clickhouse Data size on Disk

**Описание**: Общий размер данных всех таблиц `*MergeTree` на диске.

**Метрика**: `chi_clickhouse_metric_DiskDataBytes`

**Единица измерения**: байты



**Ссылки**:
* [system.parts](https://clickhouse.com/docs/en/operations/system-tables/parts)

### 30. Background Tasks

**Описание**: Количество активных фоновых задач.

**Метрики**:
* `chi_clickhouse_metric_BackgroundPoolTask` — задачи слияния, мутаций, получения данных или управления очередью репликации;
* `chi_clickhouse_metric_BackgroundSchedulePoolTask` — периодические задачи ReplicatedMergeTree (очистка старых частей, изменение частей, реинициализация реплик);
* `chi_clickhouse_metric_BackgroundMovePoolTask` — задачи перемещения данных.

**Единица измерения**: количество



**Ссылки**:
* [FETCH PARTITION](https://clickhouse.com/docs/en/sql-reference/statements/alter/partition#fetch-partitionpart)
* [Mutations](https://clickhouse.com/docs/en/sql-reference/statements/alter#mutations)
* [Data TTL](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-ttl)
* [MOVE PARTITION](https://clickhouse.com/docs/en/sql-reference/statements/alter/partition#move-partitionpart)

### 31. Mutations

**Описание**: Количество активных мутаций (ALTER DELETE/ALTER UPDATE) и частей данных, ожидающих мутации.

**Метрики**:
* `chi_clickhouse_table_mutations` — количество мутаций;
* `chi_clickhouse_table_mutations_parts_to_do` — количество частей, ожидающих мутации.

**Единица измерения**: количество



**Ссылки**:
* [Mutations](https://clickhouse.com/docs/en/sql-reference/statements/alter#mutations)
* [system.mutations](https://clickhouse.com/docs/en/operations/system-tables/mutations)
* [KILL MUTATION](https://clickhouse.com/docs/en/sql-reference/statements/kill#kill-mutation)

### 32. Marks Cache Hit Rate

**Описание**: Процент попаданий в кэш файлов меток (.mrk), которые читаются из памяти вместо диска.

**Метрика**: `chi_clickhouse_event_MarkCacheHits / (chi_clickhouse_event_MarkCacheHits + chi_clickhouse_event_MarkCacheMisses)`

**Единица измерения**: процент (0-1)



**Ссылки**:
* [mark_cache_size](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#server-mark-cache-size)
* [MergeTree architecture](https://clickhouse.com/docs/en/development/architecture/#merge-tree)

### 33. CPU Time per second

**Описание**: Время, которое CPU тратит на различные типы активности.

**Метрики**:
* `chi_clickhouse_event_RealTimeMicroseconds` — реальное время выполнения;
* `chi_clickhouse_event_UserTimeMicroseconds` — время в пользовательском режиме;
* `chi_clickhouse_event_SystemTimeMicroseconds` — время в системном режиме;
* `chi_clickhouse_event_OSIOWaitMicroseconds` — ожидание операций ввода-вывода;
* `chi_clickhouse_event_OSCPUWaitMicroseconds` — ожидание CPU;
* `chi_clickhouse_event_OSCPUVirtualTimeMicroseconds` — виртуальное время CPU.

**Единица измерения**: микросекунды в секунду



### 34. Network / Disk CPU Time per second

**Описание**: Время CPU, затраченное на операции с сетью и диском.

**Метрики**:
* `chi_clickhouse_event_DiskReadElapsedMicroseconds` — время чтения с диска;
* `chi_clickhouse_event_DiskWriteElapsedMicroseconds` — время записи на диск;
* `chi_clickhouse_event_NetworkReceiveElapsedMicroseconds` — время приема данных по сети;
* `chi_clickhouse_event_NetworkSendElapsedMicroseconds` — время отправки данных по сети.

**Единица измерения**: микросекунды в секунду



### 35. Load Average 1m

**Описание**: Средняя загрузка системы за одну минуту, стандартный Unix Load Average. Нагрузка считается предельной, если показатель близок количеству доступных CPU или к выделенным для пода {{ CH }} лимитам.

**Метрика**: `chi_clickhouse_metric_LoadAverage1`

**Единица измерения**: безразмерная величина



### 36. CPU Time total

**Описание**: Общее время CPU, затраченное на различные типы активности за выбранный период.

**Метрики**:
* `chi_clickhouse_event_DiskReadElapsedMicroseconds` — чтение с диска;
* `chi_clickhouse_event_DiskWriteElapsedMicroseconds` — запись на диск;
* `chi_clickhouse_event_NetworkReceiveElapsedMicroseconds` — прием по сети;
* `chi_clickhouse_event_NetworkSendElapsedMicroseconds` — отправка по сети;
* `chi_clickhouse_event_RealTimeMicroseconds` — время выполнения запросов в реальном времени;
* `chi_clickhouse_event_UserTimeMicroseconds` — пользовательское время;
* `chi_clickhouse_event_SystemTimeMicroseconds` — системное время;
* `chi_clickhouse_event_OSIOWaitMicroseconds` — ожидание I/O;
* `chi_clickhouse_event_OSCPUWaitMicroseconds` — ожидание CPU;
* `chi_clickhouse_event_OSCPUVirtualTimeMicroseconds` — время на виртуальные процессы операционной системы;
* `chi_clickhouse_event_ThrottlerSleepMicroseconds` — время ожидания троттлера;
* `chi_clickhouse_event_DelayedInsertsMilliseconds` — задержанные вставки;
* `chi_clickhouse_event_{{ ZK }}WaitMicroseconds` — ожидание {{ ZK }};
* `chi_clickhouse_event_CompileExpressionsMicroseconds` — компиляция выражений;
* `chi_clickhouse_event_MergesTimeMilliseconds` — время слияний;
* `chi_clickhouse_event_RWLockReadersWaitMilliseconds` — ожидание блокировки чтения;
* `chi_clickhouse_event_RWLockWritersWaitMilliseconds` — ожидание блокировки записи;
* `chi_clickhouse_event_SelectQueryTimeMicroseconds` — время SELECT-запросов;
* `chi_clickhouse_event_InsertQueryTimeMicroseconds` — время INSERT-запросов;
* `chi_clickhouse_event_{{ objstorage-name }}ReadMicroseconds` — время чтения из {{ objstorage-name }};
* `chi_clickhouse_event_{{ objstorage-name }}WriteMicroseconds` — время записи в {{ objstorage-name }}.

**Единица измерения**: микросекунды



**Интервал**: 1 минута

### 37. Connections

**Описание**: Различные типы соединений для каждого сервера.

**Метрики**:
* `chi_clickhouse_metric_TCPConnection` — TCP-соединения (нативный протокол);
* `chi_clickhouse_metric_HTTPConnection` — HTTP-соединения;
* `chi_clickhouse_metric_InterserverConnection` — межсерверные соединения;
* `chi_clickhouse_metric_MySQLConnection` — MySQL-соединения.

**Единица измерения**: количество



**Ссылки**:
* [max_connections](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#max-connections)
* [max_distributed_connections](https://clickhouse.com/docs/en/operations/settings/settings#max-distributed-connections)
* [MySQL Protocol](https://clickhouse.com/docs/en/interfaces/mysql/)
* [HTTP Protocol](https://clickhouse.com/docs/en/interfaces/http/)
* [Native Protocol](https://clickhouse.com/docs/en/interfaces/tcp/)

## Рекомендации по мониторингу

### Критические метрики

Следующие метрики требуют немедленного внимания при отклонении от нормы:

1. **Failed Pods** — должно быть 0. Ненулевое значение указывает на недоступность серверов;
2. **ReadOnly replicas** — должно быть 0. Указывает на проблемы с репликацией;
3. **DNS and Distributed Connection Errors** — должны быть минимальными. Высокие значения указывают на сетевые проблемы;
4. **Delayed/Rejected Inserts** — высокие значения указывают на проблемы с производительностью записи;
5. **Disk Space Free** — следите за свободным местом, критический порог — менее 10%.

### Метрики производительности

Для оценки производительности кластера обращайте внимание на:

1. **Queries (running)** — количество одновременно выполняющихся запросов;
2. **Memory for Queries** — потребление памяти запросами;
3. **CPU Time per second** — загрузка процессора;
4. **Marks Cache Hit Rate** — эффективность кэширования (должна быть > 90%).

### Метрики репликации

Для контроля состояния репликации:

1. **Replication Queue Jobs** — размер очереди репликации;
2. **Max Replica Delay** — задержка реплик;
3. **Zookeeper Transactions** — интенсивность работы с {{ ZK }}.

### Метрики хранения

Для контроля использования дискового пространства:

1. **Active Parts** — количество активных частей данных;
2. **Detached parts** — отсоединенные части (должны быть минимальными);
3. **Max Part count for Partition** — количество частей в партиции;
4. **Clickhouse Data size on Disk** — общий размер данных.

## Дополнительные ресурсы

* [Официальная документация {{ CH }}](https://clickhouse.com/docs/);
* [{{ CH }} Operator на GitHub](https://github.com/Altinity/clickhouse-operator);
* [System Tables Reference](https://clickhouse.com/docs/en/operations/system-tables/);
* [Server Configuration Parameters](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings).
