Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mch-name }}:

Метка | Значение
----|----
dc | Зона доступности ресурса: `rc1a`, `rc1b`, `rc1d`
host | FQDN хоста
node | Тип хоста: `replica`, `follower`, `leader`
resource_id | Идентификатор кластера
resource_type | Тип ресурса: `cluster`
service | Идентификатор сервиса: `managed-clickhouse`
shard | Идентификатор шарда
subcluster_name | Тип подкластера: `clickhouse_subcluster`, `zookeeper_subcluster`


## Метрики CPU {#managed-clickhouse-cpu-metrics}

Загрузка процессорных ядер.

Тип потребления пишется в метку `systag`.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Гарантированная доля vCPU. |
| `cpu.guarantee`<br/>`DGAUGE`, штуки | Гарантированное количество ядер. |
| `cpu.guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. |
| `cpu.idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. |
| `cpu.iowait`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `iowait`. |
| `cpu.irq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `irq`. |
| `cpu.limit`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. |
| `cpu.nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `nice`. |
| `cpu.softirq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `softirq`. |
| `cpu.steal`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `steal`. |
| `cpu.system`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `system`. |
| `cpu.user`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `user`. |
| `load.avg_15min`<br/>`DGAUGE`, % | Средняя нагрузка за 15 минут. |
| `load.avg_1min`<br/>`DGAUGE`, % | Средняя нагрузка за 1 минуту. |
| `load.avg_5min`<br/>`DGAUGE`, % | Средняя нагрузка за 5 минут. |


## Метрики диска {#managed-clickhouse-disk-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_s3_disk_parts_size`<br/>`DGAUGE`, байты | Место, занятое кусками таблиц [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) в сервисе {{ objstorage-full-name }} при настроенном [гибридном хранилище](../../../managed-clickhouse/concepts/storage.md#hybrid-storage-features) {{ mch-name }}. |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. |
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. |
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. |
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |


## Метрики дисковых операций {#managed-clickhouse-diskio-metrics}

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
| `io.utilization`<br/>`DGAUGE`, % | Использование дисков. Не работает для сетевых дисков. |
| `io.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на диски. |
| `io.write_count`<br/>`DGAUGE`, операций/с | Количество операций записи в секунду. |
| `io.write_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций записи в секунду. |


## Метрики RAM {#managed-clickhouse-ram-metrics}

Тип потребления пишется в метку `systag`.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. Тип потребления `active`. |
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. |
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`. |
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. |
| `mem.free_bytes`<br/>`DGAUGE`, байты | Объем свободной оперативной памяти, доступной для использования, без учета `mem.buffers_bytes` и `mem.cached_bytes`. Тип потребления `free`. |
| `mem.guarantee_bytes`<br/>`DGAUGE`, байты | Гарантированный объем оперативной памяти. |
| `mem.limit_bytes`<br/>`DGAUGE`, байты | Предельный размер оперативной памяти. |
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. |
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. |
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы. Тип потребления `used`. |


## Метрики сети {#managed-clickhouse-net-metrics}

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


## Метрики {{ ZK }} {#managed-clickhouse-zookeeper}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `zk_avg_latency`<br/>`DGAUGE`, миллисекунды | Средняя задержка ответа хоста {{ ZK }}. |
| `zk_ephemerals_count`<br/>`DGAUGE`, штуки | Количество объектов Ephemeral node. |
| `zk_num_alive_connections`<br/>`DGAUGE`, штуки | Количество подключений |
| `zk_outstanding_requests`<br/>`DGAUGE`, штуки | Количество запросов, находящихся в обработке. |
| `zk_server_state_follower`<br/>`DGAUGE`, 0/1 | Принимает значение `1`, если роль хоста {{ ZK }} — Follower, иначе `0`. |
| `zk_server_state_leader`<br/>`DGAUGE`, 0/1 | Принимает значение `1`, если роль хоста {{ ZK }} — Leader, иначе `0`. |
| `zk_watch_count`<br/>`DGAUGE`, штуки | Количество объектов Watch. |
| `zk_znode_count`<br/>`DGAUGE`, штуки | Количество объектов Znode. |


## Метрики сервиса {#managed-clickhouse-metrics}

#### Метрики системных событий {#managed-clickhouse-system-events-metrics}

Нативные метрики {{ CH }} из таблицы [system.events]({{ ch.docs }}/operations/system-tables/events).
По каждой метрике считается прирост `inc` и скорость изменения `rate` за единицу времени.

| Имя<br/>Тип |
| ----- |
| `ch_system_events_AddressesDiscovered_inc`<br/>`DGAUGE` |
| `ch_system_events_AddressesDiscovered_rate`<br/>`DGAUGE` |
| `ch_system_events_AnalyzePatchRangesMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_AnalyzePatchRangesMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_rate`<br/>`DGAUGE` |
| `ch_system_events_AsyncLoaderWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_AsyncLoaderWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_AsyncLoggingErrorFileLogTotalMessages_inc`<br/>`DGAUGE` |
| `ch_system_events_AsyncLoggingErrorFileLogTotalMessages_rate`<br/>`DGAUGE` |
| `ch_system_events_AsyncLoggingFileLogTotalMessages_inc`<br/>`DGAUGE` |
| `ch_system_events_AsyncLoggingFileLogTotalMessages_rate`<br/>`DGAUGE` |
| `ch_system_events_BackgroundLoadingMarksTasks_inc`<br/>`DGAUGE` |
| `ch_system_events_BackgroundLoadingMarksTasks_rate`<br/>`DGAUGE` |
| `ch_system_events_CannotRemoveEphemeralNode_inc`<br/>`DGAUGE` |
| `ch_system_events_CannotRemoveEphemeralNode_rate`<br/>`DGAUGE` |
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
| `ch_system_events_ConcurrencyControlSlotsAcquired_inc`<br/>`DGAUGE` |
| `ch_system_events_ConcurrencyControlSlotsAcquired_rate`<br/>`DGAUGE` |
| `ch_system_events_ConcurrencyControlSlotsAcquiredNonCompeting_inc`<br/>`DGAUGE` |
| `ch_system_events_ConcurrencyControlSlotsAcquiredNonCompeting_rate`<br/>`DGAUGE` |
| `ch_system_events_ConcurrencyControlSlotsGranted_inc`<br/>`DGAUGE` |
| `ch_system_events_ConcurrencyControlSlotsGranted_rate`<br/>`DGAUGE` |
| `ch_system_events_ContextLock_inc`<br/>`DGAUGE` |
| `ch_system_events_ContextLock_rate`<br/>`DGAUGE` |
| `ch_system_events_ContextLockWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ContextLockWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedLogEntryForMerge_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedLogEntryForMerge_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_rate`<br/>`DGAUGE` |
| `ch_system_events_DefaultImplementationForNullsRows_inc`<br/>`DGAUGE` |
| `ch_system_events_DefaultImplementationForNullsRows_rate`<br/>`DGAUGE` |
| `ch_system_events_DefaultImplementationForNullsRowsWithNulls_inc`<br/>`DGAUGE` |
| `ch_system_events_DefaultImplementationForNullsRowsWithNulls_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3DeleteObjects_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3DeleteObjects_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3GetObject_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3GetObject_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3PutObject_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3PutObject_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DistributedConnectionTries_inc`<br/>`DGAUGE` |
| `ch_system_events_DistributedConnectionTries_rate`<br/>`DGAUGE` |
| `ch_system_events_DistributedConnectionUsable_inc`<br/>`DGAUGE` |
| `ch_system_events_DistributedConnectionUsable_rate`<br/>`DGAUGE` |
| `ch_system_events_ExternalProcessingFilesTotal_inc`<br/>`DGAUGE` |
| `ch_system_events_ExternalProcessingFilesTotal_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedInsertQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedInsertQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_inc`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_rate`<br/>`DGAUGE` |
| `ch_system_events_FileSync_inc`<br/>`DGAUGE` |
| `ch_system_events_FileSync_rate`<br/>`DGAUGE` |
| `ch_system_events_FileSyncElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_FileSyncElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_FilteringMarksWithPrimaryKeyMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_FilteringMarksWithPrimaryKeyMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_FilterTransformPassedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_FilterTransformPassedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_FilterTransformPassedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_FilterTransformPassedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_inc`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_rate`<br/>`DGAUGE` |
| `ch_system_events_GatheredColumns_inc`<br/>`DGAUGE` |
| `ch_system_events_GatheredColumns_rate`<br/>`DGAUGE` |
| `ch_system_events_GatheringColumnMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_GatheringColumnMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolExpansions_inc`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolExpansions_rate`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolJobs_inc`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolJobs_rate`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolJobWaitTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolJobWaitTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolLockWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolLockWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolThreadCreationMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_GlobalThreadPoolThreadCreationMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_GWPAsanAllocateFailed_inc`<br/>`DGAUGE` |
| `ch_system_events_GWPAsanAllocateFailed_rate`<br/>`DGAUGE` |
| `ch_system_events_HardPageFaults_inc`<br/>`DGAUGE` |
| `ch_system_events_HardPageFaults_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsExpired_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsExpired_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsPreserved_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsPreserved_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsReset_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsReset_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsReused_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPConnectionsReused_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsExpired_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsExpired_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsPreserved_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsPreserved_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsReset_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsReset_rate`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsReused_inc`<br/>`DGAUGE` |
| `ch_system_events_HTTPServerConnectionsReused_rate`<br/>`DGAUGE` |
| `ch_system_events_InitialQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_InitialQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedCompactParts_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedCompactParts_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQueriesWithSubqueries_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQueriesWithSubqueries_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_InterfaceHTTPReceiveBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InterfaceHTTPReceiveBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InterfaceHTTPSendBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InterfaceHTTPSendBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InterfaceInterserverReceiveBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InterfaceInterserverReceiveBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InterfaceInterserverSendBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InterfaceInterserverSendBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InterfaceNativeReceiveBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InterfaceNativeReceiveBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InterfaceNativeSendBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InterfaceNativeSendBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_rate`<br/>`DGAUGE` |
| `ch_system_events_JoinBuildTableRowCount_inc`<br/>`DGAUGE` |
| `ch_system_events_JoinBuildTableRowCount_rate`<br/>`DGAUGE` |
| `ch_system_events_JoinProbeTableRowCount_inc`<br/>`DGAUGE` |
| `ch_system_events_JoinProbeTableRowCount_rate`<br/>`DGAUGE` |
| `ch_system_events_JoinResultRowCount_inc`<br/>`DGAUGE` |
| `ch_system_events_JoinResultRowCount_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedDataParts_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedDataParts_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedDataPartsMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedDataPartsMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksCount_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksCount_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksFiles_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksFiles_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksMemoryBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksMemoryBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedPrimaryIndexBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedPrimaryIndexBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedPrimaryIndexFiles_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedPrimaryIndexFiles_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedPrimaryIndexRows_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedPrimaryIndexRows_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolBusyMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolBusyMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolExpansions_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolExpansions_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolJobs_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolJobs_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolJobWaitTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolJobWaitTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolLockWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolLockWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolShrinks_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolShrinks_rate`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolThreadCreationMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_LocalThreadPoolThreadCreationMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_LogDebug_inc`<br/>`DGAUGE` |
| `ch_system_events_LogDebug_rate`<br/>`DGAUGE` |
| `ch_system_events_LogError_inc`<br/>`DGAUGE` |
| `ch_system_events_LogError_rate`<br/>`DGAUGE` |
| `ch_system_events_LoggerElapsedNanoseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_LoggerElapsedNanoseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_LogInfo_inc`<br/>`DGAUGE` |
| `ch_system_events_LogInfo_rate`<br/>`DGAUGE` |
| `ch_system_events_LogTest_inc`<br/>`DGAUGE` |
| `ch_system_events_LogTest_rate`<br/>`DGAUGE` |
| `ch_system_events_LogTrace_inc`<br/>`DGAUGE` |
| `ch_system_events_LogTrace_rate`<br/>`DGAUGE` |
| `ch_system_events_LogWarning_inc`<br/>`DGAUGE` |
| `ch_system_events_LogWarning_rate`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_inc`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_rate`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheHits_inc`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheHits_rate`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheMisses_inc`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheMisses_rate`<br/>`DGAUGE` |
| `ch_system_events_MemoryAllocatorPurge_inc`<br/>`DGAUGE` |
| `ch_system_events_MemoryAllocatorPurge_rate`<br/>`DGAUGE` |
| `ch_system_events_MemoryAllocatorPurgeTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MemoryAllocatorPurgeTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MemoryOvercommitWaitTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MemoryOvercommitWaitTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MemoryWorkerRun_inc`<br/>`DGAUGE` |
| `ch_system_events_MemoryWorkerRun_rate`<br/>`DGAUGE` |
| `ch_system_events_MemoryWorkerRunElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MemoryWorkerRunElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_Merge_inc`<br/>`DGAUGE` |
| `ch_system_events_Merge_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedColumns_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedColumns_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedIntoCompactParts_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedIntoCompactParts_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedIntoWideParts_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedIntoWideParts_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedUncompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedUncompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeExecuteMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeExecuteMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeHorizontalStageExecuteMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeHorizontalStageExecuteMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeHorizontalStageTotalMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeHorizontalStageTotalMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeProjectionStageExecuteMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeProjectionStageExecuteMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeProjectionStageTotalMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeProjectionStageTotalMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorPartsInRangesForMergeCount_inc`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorPartsInRangesForMergeCount_rate`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorPrepareRangesForMergeElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorPrepareRangesForMergeElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorRangesForMergeCount_inc`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorRangesForMergeCount_rate`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorSelectPartsForMergeElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorSelectPartsForMergeElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorSelectRangePartsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorSelectRangePartsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorsGetPartsForMergeElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergerMutatorsGetPartsForMergeElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeSourceParts_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeSourceParts_rate`<br/>`DGAUGE` |
| `ch_system_events_MergesTimeMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergesTimeMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTotalMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTotalMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterMergingBlocksMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterMergingBlocksMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterRows_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterSortingBlocksMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterSortingBlocksMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeVerticalStageExecuteMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeVerticalStageExecuteMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeVerticalStageTotalMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeVerticalStageTotalMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_MergingSortedMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergingSortedMilliseconds_rate`<br/>`DGAUGE` |
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
| `ch_system_events_ObsoleteReplicatedParts_inc`<br/>`DGAUGE` |
| `ch_system_events_ObsoleteReplicatedParts_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheHits_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheHits_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMisses_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMisses_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSReadBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_OSReadBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_OSReadChars_inc`<br/>`DGAUGE` |
| `ch_system_events_OSReadChars_rate`<br/>`DGAUGE` |
| `ch_system_events_OSWriteBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_OSWriteBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_OSWriteChars_inc`<br/>`DGAUGE` |
| `ch_system_events_OSWriteChars_rate`<br/>`DGAUGE` |
| `ch_system_events_OtherQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OtherQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OverflowBreak_inc`<br/>`DGAUGE` |
| `ch_system_events_OverflowBreak_rate`<br/>`DGAUGE` |
| `ch_system_events_OverflowThrow_inc`<br/>`DGAUGE` |
| `ch_system_events_OverflowThrow_rate`<br/>`DGAUGE` |
| `ch_system_events_PartsLockHoldMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_PartsLockHoldMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_PartsLockWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_PartsLockWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_QueriesWithSubqueries_inc`<br/>`DGAUGE` |
| `ch_system_events_QueriesWithSubqueries_rate`<br/>`DGAUGE` |
| `ch_system_events_Query_inc`<br/>`DGAUGE` |
| `ch_system_events_Query_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryMemoryLimitExceeded_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryMemoryLimitExceeded_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerRuns_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerRuns_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerSignalOverruns_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerSignalOverruns_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Bytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Bytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3InitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3InitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Microseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Microseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3PreservedSessions_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3PreservedSessions_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadWriteBufferFromHTTPBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadWriteBufferFromHTTPBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadWriteBufferFromHTTPRequestsSent_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadWriteBufferFromHTTPRequestsSent_rate`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpWithMultipleNeedlesCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpWithMultipleNeedlesCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpWithMultipleNeedlesGlobalCacheHit_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpWithMultipleNeedlesGlobalCacheHit_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpWithMultipleNeedlesGlobalCacheMiss_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpWithMultipleNeedlesGlobalCacheMiss_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSBuffers_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSBuffers_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeks_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeks_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeksWithReset_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeksWithReset_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedReads_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedReads_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplacingSortedMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplacingSortedMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicaPartialShutdown_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicaPartialShutdown_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecks_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecks_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecksFailed_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecksFailed_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFailedFetches_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFailedFetches_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetches_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetches_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetchesOfMerged_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetchesOfMerged_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartMerges_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartMerges_rate`<br/>`DGAUGE` |
| `ch_system_events_RowsReadByMainReader_inc`<br/>`DGAUGE` |
| `ch_system_events_RowsReadByMainReader_rate`<br/>`DGAUGE` |
| `ch_system_events_RowsReadByPrewhereReaders_inc`<br/>`DGAUGE` |
| `ch_system_events_RowsReadByPrewhereReaders_rate`<br/>`DGAUGE` |
| `ch_system_events_RWLockAcquiredReadLocks_inc`<br/>`DGAUGE` |
| `ch_system_events_RWLockAcquiredReadLocks_rate`<br/>`DGAUGE` |
| `ch_system_events_RWLockReadersWaitMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RWLockReadersWaitMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_S3DeleteObjects_inc`<br/>`DGAUGE` |
| `ch_system_events_S3DeleteObjects_rate`<br/>`DGAUGE` |
| `ch_system_events_S3GetObject_inc`<br/>`DGAUGE` |
| `ch_system_events_S3GetObject_rate`<br/>`DGAUGE` |
| `ch_system_events_S3PutObject_inc`<br/>`DGAUGE` |
| `ch_system_events_S3PutObject_rate`<br/>`DGAUGE` |
| `ch_system_events_S3ReadMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_S3ReadMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_S3ReadRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_S3ReadRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_S3WriteMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_S3WriteMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_S3WriteRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_S3WriteRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_ScalarSubqueriesCacheMiss_inc`<br/>`DGAUGE` |
| `ch_system_events_ScalarSubqueriesCacheMiss_rate`<br/>`DGAUGE` |
| `ch_system_events_Seek_inc`<br/>`DGAUGE` |
| `ch_system_events_Seek_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarks_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarks_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarksTotal_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarksTotal_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedParts_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedParts_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedPartsTotal_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedPartsTotal_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRanges_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRanges_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueriesWithPrimaryKeyUsage_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueriesWithPrimaryKeyUsage_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueriesWithSubqueries_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueriesWithSubqueries_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ServerStartupMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ServerStartupMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_inc`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_rate`<br/>`DGAUGE` |
| `ch_system_events_SuspendSendingQueryToShard_inc`<br/>`DGAUGE` |
| `ch_system_events_SuspendSendingQueryToShard_rate`<br/>`DGAUGE` |
| `ch_system_events_SynchronousReadWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SynchronousReadWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SynchronousRemoteReadWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SynchronousRemoteReadWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheHit_inc`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheHit_rate`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheHitBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheHitBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheHitElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheHitElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheMiss_inc`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheMiss_rate`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheMissBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheMissBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheMissElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ThreadPoolReaderPageCacheMissElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_WaitMarksLoadMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_WaitMarksLoadMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Bytes_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Bytes_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Microseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Microseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesReceived_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesReceived_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesSent_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesSent_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperClose_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperClose_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperCreate_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperCreate_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperExists_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperExists_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperGet_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperGet_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperHardwareExceptions_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperHardwareExceptions_rate`<br/>`DGAUGE` |
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
| `ch_system_events_ZooKeeperSync_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperSync_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperTransactions_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperTransactions_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWatchResponse_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWatchResponse_rate`<br/>`DGAUGE` |


#### Метрики текущих событий {#managed-clickhouse-system-metrics}

Нативные метрики {{ CH }} из таблицы [system.metrics]({{ ch.docs }}/operations/system-tables/metrics/).

| Имя<br/>Тип |
| ----- |
| `ch_system_metrics_ActiveTimersInQueryProfiler`<br/>`DGAUGE` |
| `ch_system_metrics_AddressesActive`<br/>`DGAUGE` |
| `ch_system_metrics_AddressesBanned`<br/>`DGAUGE` |
| `ch_system_metrics_AggregatorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_AggregatorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_AggregatorThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertQueueBytes`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertQueueSize`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertThreads`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousReadWait`<br/>`DGAUGE` |
| `ch_system_metrics_AsyncInsertCacheSize`<br/>`DGAUGE` |
| `ch_system_metrics_AttachedDatabase`<br/>`DGAUGE` |
| `ch_system_metrics_AttachedDictionary`<br/>`DGAUGE` |
| `ch_system_metrics_AttachedReplicatedTable`<br/>`DGAUGE` |
| `ch_system_metrics_AttachedTable`<br/>`DGAUGE` |
| `ch_system_metrics_AttachedView`<br/>`DGAUGE` |
| `ch_system_metrics_AvroSchemaCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_AvroSchemaCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_AvroSchemaRegistryCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_AvroSchemaRegistryCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_AzureRequests`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundCommonPoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundCommonPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundDistributedSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundDistributedSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundFetchesPoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundFetchesPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMergesAndMutationsPoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMergesAndMutationsPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMovePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMovePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsIOThreads`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsIOThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsIOThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsThreads`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDisks`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedBytesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_BuildVectorSimilarityIndexThreads`<br/>`DGAUGE` |
| `ch_system_metrics_BuildVectorSimilarityIndexThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_BuildVectorSimilarityIndexThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDetachedFileSegments`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueBatches`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueKeys`<br/>`DGAUGE` |
| `ch_system_metrics_CacheFileSegments`<br/>`DGAUGE` |
| `ch_system_metrics_CacheWarmerBytesInProgress`<br/>`DGAUGE` |
| `ch_system_metrics_CompiledExpressionCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_CompiledExpressionCacheCount`<br/>`DGAUGE` |
| `ch_system_metrics_Compressing`<br/>`DGAUGE` |
| `ch_system_metrics_CompressionThread`<br/>`DGAUGE` |
| `ch_system_metrics_CompressionThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_CompressionThreadScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrencyControlAcquired`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrencyControlAcquiredNonCompeting`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrencyControlPreempted`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrencyControlScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrencyControlSoftLimit`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrentHashJoinPoolThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrentHashJoinPoolThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrentHashJoinPoolThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrentQueryAcquired`<br/>`DGAUGE` |
| `ch_system_metrics_ConcurrentQueryScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_Connection`<br/>`DGAUGE` |
| `ch_system_metrics_ContextLockWait`<br/>`DGAUGE` |
| `ch_system_metrics_CoordinatedMergesCoordinatorAssignedMerges`<br/>`DGAUGE` |
| `ch_system_metrics_CoordinatedMergesCoordinatorRunningMerges`<br/>`DGAUGE` |
| `ch_system_metrics_CoordinatedMergesWorkerAssignedMerges`<br/>`DGAUGE` |
| `ch_system_metrics_CreatedTimersInQueryProfiler`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseBackupThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseBackupThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseBackupThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseCatalogThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseCatalogThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseCatalogThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOnDiskThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOnDiskThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOnDiskThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOrdinaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOrdinaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseReplicatedCreateTablesThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseReplicatedCreateTablesThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseReplicatedCreateTablesThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DDLWorkerThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DDLWorkerThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DDLWorkerThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_Decompressing`<br/>`DGAUGE` |
| `ch_system_metrics_DelayedInserts`<br/>`DGAUGE` |
| `ch_system_metrics_DestroyAggregatesThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DestroyAggregatesThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DestroyAggregatesThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DictCacheRequests`<br/>`DGAUGE` |
| `ch_system_metrics_DiskConnectionsStored`<br/>`DGAUGE` |
| `ch_system_metrics_DiskConnectionsTotal`<br/>`DGAUGE` |
| `ch_system_metrics_DiskObjectStorageAsyncThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DiskObjectStorageAsyncThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableAzureDirectoryMapSize`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableAzureFileCount`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableAzureUniqueFileNamesCount`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableLocalDirectoryMapSize`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableLocalFileCount`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableLocalUniqueFileNamesCount`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableS3DirectoryMapSize`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableS3FileCount`<br/>`DGAUGE` |
| `ch_system_metrics_DiskPlainRewritableS3UniqueFileNamesCount`<br/>`DGAUGE` |
| `ch_system_metrics_DiskS3NoSuchKeyErrors`<br/>`DGAUGE` |
| `ch_system_metrics_DiskSpaceReservedForMerge`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheAllocatedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheBorrowedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheOpenedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheReadRequests`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheRegisteredServers`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheRegisteredServersCurrentAZ`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheServerConnections`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheServerRegistryConnections`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheServerS3CachedClients`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheUsedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_DistrCacheWriteRequests`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedBytesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedInsertThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedInsertThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedInsertThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedSend`<br/>`DGAUGE` |
| `ch_system_metrics_DNSAddressesCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_DNSAddressesCacheSize`<br/>`DGAUGE` |
| `ch_system_metrics_DNSHostsCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_DNSHostsCacheSize`<br/>`DGAUGE` |
| `ch_system_metrics_DropDistributedCacheThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DropDistributedCacheThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DropDistributedCacheThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_DWARFReaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DWARFReaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DWARFReaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_EphemeralNode`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheDelayedCleanupElements`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheDownloadQueueElements`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheElements`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheHoldFileSegments`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheKeys`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheReadBuffers`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheReserveThreads`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheSize`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheSizeLimit`<br/>`DGAUGE` |
| `ch_system_metrics_FilteringMarksWithPrimaryKey`<br/>`DGAUGE` |
| `ch_system_metrics_FilteringMarksWithSecondaryKeys`<br/>`DGAUGE` |
| `ch_system_metrics_FormatParsingThreads`<br/>`DGAUGE` |
| `ch_system_metrics_FormatParsingThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_FormatParsingThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThread`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThreadScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_HashedDictionaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_HashedDictionaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_HashedDictionaryThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_HiveFilesCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_HiveFilesCacheFiles`<br/>`DGAUGE` |
| `ch_system_metrics_HiveMetadataFilesCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_HiveMetadataFilesCacheFiles`<br/>`DGAUGE` |
| `ch_system_metrics_HTTPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_HTTPConnectionsStored`<br/>`DGAUGE` |
| `ch_system_metrics_HTTPConnectionsTotal`<br/>`DGAUGE` |
| `ch_system_metrics_IcebergCatalogThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IcebergCatalogThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IcebergCatalogThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_IcebergMetadataFilesCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_IcebergMetadataFilesCacheFiles`<br/>`DGAUGE` |
| `ch_system_metrics_IDiskCopierThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IDiskCopierThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IDiskCopierThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_IndexMarkCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_IndexMarkCacheFiles`<br/>`DGAUGE` |
| `ch_system_metrics_IndexUncompressedCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_IndexUncompressedCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_InterserverConnection`<br/>`DGAUGE` |
| `ch_system_metrics_IOPrefetchThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IOPrefetchThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IOPrefetchThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_IOThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IOThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IOThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_IOUringInFlightEvents`<br/>`DGAUGE` |
| `ch_system_metrics_IOUringPendingEvents`<br/>`DGAUGE` |
| `ch_system_metrics_IOWriterThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IOWriterThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IOWriterThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_IsServerShuttingDown`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaAssignedPartitions`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaBackgroundReads`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaConsumers`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaConsumersInUse`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaConsumersWithAssignment`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaLibrdkafkaThreads`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaProducers`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaWrites`<br/>`DGAUGE` |
| `ch_system_metrics_KeeperAliveConnections`<br/>`DGAUGE` |
| `ch_system_metrics_KeeperOutstandingRequests`<br/>`DGAUGE` |
| `ch_system_metrics_LicenseRemainingSeconds`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThread`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThreadScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MarkCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MarkCacheFiles`<br/>`DGAUGE` |
| `ch_system_metrics_MarksLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MarksLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MarksLoaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MaxDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MaxPushedDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTracking`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTrackingUncorrected`<br/>`DGAUGE` |
| `ch_system_metrics_Merge`<br/>`DGAUGE` |
| `ch_system_metrics_MergeJoinBlocksCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MergeJoinBlocksCacheCount`<br/>`DGAUGE` |
| `ch_system_metrics_MergeParts`<br/>`DGAUGE` |
| `ch_system_metrics_MergesMutationsMemoryTracking`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeAllRangesAnnouncementsSent`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeBackgroundExecutorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeBackgroundExecutorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeBackgroundExecutorThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeDataSelectExecutorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeDataSelectExecutorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeDataSelectExecutorThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeFetchPartitionThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeFetchPartitionThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeFetchPartitionThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsCleanerThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsCleanerThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsCleanerThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsLoaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeReadTaskRequestsSent`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeSubcolumnsReaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeSubcolumnsReaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeSubcolumnsReaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeUnexpectedPartsLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeUnexpectedPartsLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeUnexpectedPartsLoaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_MetadataFromKeeperCacheObjects`<br/>`DGAUGE` |
| `ch_system_metrics_MMapCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedAllocBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedAllocs`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFileBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFiles`<br/>`DGAUGE` |
| `ch_system_metrics_Move`<br/>`DGAUGE` |
| `ch_system_metrics_MySQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkReceive`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkSend`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageAzureThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageAzureThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageAzureThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageQueueRegisteredServers`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageQueueShutdownThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageQueueShutdownThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageQueueShutdownThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageS3Threads`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageS3ThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageS3ThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForRead`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForWrite`<br/>`DGAUGE` |
| `ch_system_metrics_OutdatedPartsLoadingThreads`<br/>`DGAUGE` |
| `ch_system_metrics_OutdatedPartsLoadingThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_OutdatedPartsLoadingThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_PageCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_PageCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelCompressedWriteBufferThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelCompressedWriteBufferWait`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelFormattingOutputFormatThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelFormattingOutputFormatThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelFormattingOutputFormatThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelParsingInputFormatThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelParsingInputFormatThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelParsingInputFormatThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelWithQueryActiveThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelWithQueryScheduledThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelWithQueryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderIOThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderIOThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderIOThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetEncoderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetEncoderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetEncoderThreadsScheduled`<br/>`DGAUGE` |
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
| `ch_system_metrics_PolygonDictionaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_PolygonDictionaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_PolygonDictionaryThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_PostgreSQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_PrimaryIndexCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_PrimaryIndexCacheFiles`<br/>`DGAUGE` |
| `ch_system_metrics_Query`<br/>`DGAUGE` |
| `ch_system_metrics_QueryCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_QueryCacheEntries`<br/>`DGAUGE` |
| `ch_system_metrics_QueryConditionCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_QueryConditionCacheEntries`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPipelineExecutorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPipelineExecutorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPipelineExecutorThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPreempted`<br/>`DGAUGE` |
| `ch_system_metrics_QueryThread`<br/>`DGAUGE` |
| `ch_system_metrics_Read`<br/>`DGAUGE` |
| `ch_system_metrics_ReadonlyDisks`<br/>`DGAUGE` |
| `ch_system_metrics_ReadonlyReplica`<br/>`DGAUGE` |
| `ch_system_metrics_ReadTaskRequestsSent`<br/>`DGAUGE` |
| `ch_system_metrics_RefreshableViews`<br/>`DGAUGE` |
| `ch_system_metrics_RefreshingViews`<br/>`DGAUGE` |
| `ch_system_metrics_RemoteRead`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedChecks`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedFetch`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedSend`<br/>`DGAUGE` |
| `ch_system_metrics_RestartReplicaThreads`<br/>`DGAUGE` |
| `ch_system_metrics_RestartReplicaThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_RestartReplicaThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_RestoreThreads`<br/>`DGAUGE` |
| `ch_system_metrics_RestoreThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_RestoreThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_Revision`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveWriters`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingWriters`<br/>`DGAUGE` |
| `ch_system_metrics_S3Requests`<br/>`DGAUGE` |
| `ch_system_metrics_SchedulerIOReadScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_SchedulerIOWriteScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_SendExternalTables`<br/>`DGAUGE` |
| `ch_system_metrics_SendScalars`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropDetachLocalTablesErrors`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropLocalThreads`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropLocalThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropLocalThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropZooKeeperThreads`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropZooKeeperThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogDropZooKeeperThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogNumberOfObjectsInState`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogStateApplicationThreads`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogStateApplicationThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_SharedCatalogStateApplicationThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_SharedDatabaseCatalogTablesInLocalDropDetachQueue`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeAssignedCurrentParts`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeCondemnedPartsInKeeper`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeFetch`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeOutdatedPartsInKeeper`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeThreads`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_SharedMergeTreeThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StartupScriptsExecutionState`<br/>`DGAUGE` |
| `ch_system_metrics_StartupSystemTablesThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StartupSystemTablesThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StartupSystemTablesThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StatelessWorkerThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StatelessWorkerThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StatelessWorkerThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferBytes`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferFlushThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferFlushThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferFlushThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferRows`<br/>`DGAUGE` |
| `ch_system_metrics_StorageConnectionsStored`<br/>`DGAUGE` |
| `ch_system_metrics_StorageConnectionsTotal`<br/>`DGAUGE` |
| `ch_system_metrics_StorageDistributedThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageDistributedThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageDistributedThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StorageHiveThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageHiveThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageHiveThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StorageObjectStorageThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageObjectStorageThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageObjectStorageThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_StorageS3Threads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageS3ThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageS3ThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_SystemReplicasThreads`<br/>`DGAUGE` |
| `ch_system_metrics_SystemReplicasThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_SystemReplicasThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderBackgroundThreads`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderBackgroundThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderBackgroundThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderForegroundThreads`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderForegroundThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderForegroundThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_TablesToDropQueueSize`<br/>`DGAUGE` |
| `ch_system_metrics_TaskTrackerThreads`<br/>`DGAUGE` |
| `ch_system_metrics_TaskTrackerThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_TaskTrackerThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_TCPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForAggregation`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForJoin`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForMerge`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForSort`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesUnknown`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolFSReaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolFSReaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolFSReaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreadsScheduled`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadsInOvercommitTracker`<br/>`DGAUGE` |
| `ch_system_metrics_TotalTemporaryFiles`<br/>`DGAUGE` |
| `ch_system_metrics_UncompressedCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_UncompressedCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_VectorSimilarityIndexCacheBytes`<br/>`DGAUGE` |
| `ch_system_metrics_VectorSimilarityIndexCacheCells`<br/>`DGAUGE` |
| `ch_system_metrics_VersionInteger`<br/>`DGAUGE` |
| `ch_system_metrics_Write`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperRequest`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperSession`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperWatch`<br/>`DGAUGE` |


#### Метрики очереди запросов {#managed-clickhouse-query-log-metrics}

Нативные метрики {{ CH }} из таблицы [system.query_log]({{ ch.docs }}/operations/system-tables/query_log).
По каждой метрике считается прирост за единицу времени (секунда).

| Имя<br>Тип |
| ----- |
| `ch_system_query_log_avg_query_ms`<br/>`DGAUGE` |
| `ch_system_query_log_insert_avg_query_ms`<br/>`DGAUGE` |
| `ch_system_query_log_insert_query_duration_p50_ms`<br/>`DGAUGE` |
| `ch_system_query_log_insert_query_duration_p95_ms`<br/>`DGAUGE` |
| `ch_system_query_log_insert_query_duration_p99_ms`<br/>`DGAUGE` |
| `ch_system_query_log_insert_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_query_duration_p50_ms`<br/>`DGAUGE` |
| `ch_system_query_log_query_duration_p95_ms`<br/>`DGAUGE` |
| `ch_system_query_log_query_duration_p99_ms`<br/>`DGAUGE` |
| `ch_system_query_log_read_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_read_rows_inc`<br/>`DGAUGE` |
| `ch_system_query_log_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_result_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_result_rows_inc`<br/>`DGAUGE` |
| `ch_system_query_log_select_avg_query_ms`<br/>`DGAUGE` |
| `ch_system_query_log_select_query_duration_p50_ms`<br/>`DGAUGE` |
| `ch_system_query_log_select_query_duration_p95_ms`<br/>`DGAUGE` |
| `ch_system_query_log_select_query_duration_p99_ms`<br/>`DGAUGE` |
| `ch_system_query_log_select_requests_inc`<br/>`DGAUGE` |
| `ch_system_query_log_written_bytes_inc`<br/>`DGAUGE` |
| `ch_system_query_log_written_rows_inc`<br/>`DGAUGE` |


#### Метрики репликации {#managed-clickhouse-replication-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_replication-future_parts`<br/>`DGAUGE`, штуки | Количество блоков данных после завершения слияний и операций INSERT. |
| `ch_replication-inserts_in_queue`<br/>`DGAUGE`, штуки | Количество блоков данных, ожидающих вставки. |
| `ch_replication-is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности репликации.<br/>Принимает значение `1`, если репликация БД работает, `0` — если нет. |
| `ch_replication-max_absolute_delay`<br/>`DGAUGE`, секунды | Максимальное время задержки репликации. |
| `ch_replication-merges_in_queue`<br/>`DGAUGE`, штуки | Количество слияний в очереди. |
| `ch_replication-parts_to_check`<br/>`DGAUGE`, штуки | Количество блоков данных, ожидающих проверки. |
| `ch_replication-queue_size`<br/>`DGAUGE`, штуки | Размер очереди операций слияния и вставок. |
| `ch_replication-tables`<br/>`DGAUGE`, штуки | Количество реплицируемых таблиц. |


#### Системные метрики {#managed-clickhouse-config-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_config_merge_tree_parts_to_throw_insert`<br/>`DGAUGE`, штуки | Предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ....` Задается в [настройках](../../../managed-clickhouse/concepts/settings-list.md#setting-merge-tree). Имеет смысл [анализировать](../../../glossary/data-analytics.md) в паре с метрикой `ch_system_async_metrics_MaxPartCountForPartition`. |
| `ch_local_disk_max_parts_per_partition`<br/>`DGAUGE`, штуки | Максимальное число кусков в разделе на локальных дисках. |
| `ch_local_disk_parts_size`<br/>`DGAUGE`, байты | Размер партиций на локальных дисках. |
| `ch_system_async_metrics_MaxPartCountForPartition`<br/>`DGAUGE`, штуки | Максимальное число кусков данных в разделе. |
| `ch_system_async_metrics_MemoryCode`<br/>`DGAUGE`, байты | Используемая память под код процесса. |
| `ch_system_async_metrics_MemoryDataAndStack`<br/>`DGAUGE`, байты | Используемая память под данные и стек процесса. |
| `ch_system_async_metrics_MemoryResident`<br/>`DGAUGE`, байты | Фактическое использование оперативной памяти сервером. |
| `ch_system_async_metrics_MemoryResidentMax`<br/>`DGAUGE`, байты | Максимальное фактическое использование оперативной памяти процессом. |
| `ch_system_async_metrics_MemoryResidentWithoutPageCache`<br/>`DGAUGE`, байты | Используемая процессом память без учета page cache. |
| `ch_system_async_metrics_MemoryShared`<br/>`DGAUGE`, байты | Размер разделяемой памяти процесса. |
| `ch_system_async_metrics_MemoryVirtual`<br/>`DGAUGE`, байты | Общий объем виртуальной памяти процесса. |
| `ch_system_async_metrics_NumberOfDatabases`<br/>`DGAUGE`, штуки | Общее количество баз данных на сервере. |
| `ch_system_async_metrics_NumberOfDetachedByUserParts`<br/>`DGAUGE`, штуки | Число частей, отсоединенных пользователем. |
| `ch_system_async_metrics_NumberOfDetachedParts`<br/>`DGAUGE`, штуки | Общее количество отсоединенных частей. |
| `ch_system_async_metrics_NumberOfPendingMutations`<br/>`DGAUGE`, штуки | Число ожидающих мутаций. |
| `ch_system_async_metrics_NumberOfPendingMutationsOverExecutionTime`<br/>`DGAUGE`, штуки | Число мутаций, превышающих порог времени выполнения. |
| `ch_system_async_metrics_NumberOfStuckMutations`<br/>`DGAUGE`, штуки | Число застрявших мутаций. |
| `ch_system_async_metrics_NumberOfTables`<br/>`DGAUGE`, штуки | Общее количество таблиц, суммированных по базам данных на сервере, исключая базы данных, которые не могут содержать таблицы MergeTree. Исключенные движки баз данных — это те, которые генерируют набор таблиц «на лету», такие как Lazy, {{ MY }}, {{ PG }}, SQLite. |
| `ch_system_async_metrics_NumberOfTablesSystem`<br/>`DGAUGE`, штуки | Общее количество таблиц в системной базе данных на сервере, хранящихся в таблицах семейства MergeTree. |
| `ch_system_async_metrics_QueryCacheBytes`<br/>`DGAUGE`, байты | Объем занятой памяти в кэше запросов. |
| `ch_system_async_metrics_QueryCacheEntries`<br/>`DGAUGE`, штуки | Число записей в кэше запросов. |
| `ch_system_async_metrics_ReplicasMaxAbsoluteDelay`<br/>`DGAUGE`, секунды | Максимальное время задержки репликации. |
| `ch_system_async_metrics_ReplicasMaxInsertsInQueue`<br/>`DGAUGE`, штуки | Максимальное количество операций INSERT в очереди (все еще подлежащих репликации) в реплицируемых таблицах. |
| `ch_system_async_metrics_ReplicasMaxMergesInQueue`<br/>`DGAUGE`, штуки | Максимальное количество операций слияния в очереди (которые еще предстоит применить) для реплицируемых таблиц. |
| `ch_system_async_metrics_ReplicasMaxQueueSize`<br/>`DGAUGE`, штуки | Максимальный размер очереди репликации. |
| `ch_system_async_metrics_ReplicasMaxRelativeDelay`<br/>`DGAUGE`, секунды | Максимальная разница между задержкой реплики и задержкой самой последней реплики одной и той же таблицы в разных реплицируемых таблицах. |
| `ch_system_async_metrics_ReplicasSumInsertsInQueue`<br/>`DGAUGE`, штуки | Сумма операций INSERT в очередь (все еще подлежащих репликации) по реплицируемым таблицам. |
| `ch_system_async_metrics_ReplicasSumMergesInQueue`<br/>`DGAUGE`, штуки | Сумма операций слияния в очереди (которые еще предстоит применить) по реплицируемым таблицам. |
| `ch_system_async_metrics_ReplicasSumQueueSize`<br/>`DGAUGE`, байты | Суммарный размер очереди (в количестве операций, таких как получение, слияние) по реплицируемым таблицам. |
| `ch_system_async_metrics_TotalBytesOfMergeTreeTables`<br/>`DGAUGE`, байты | Общее количество байт (сжатых, включая данные и индексы), хранящихся во всех таблицах семейства MergeTree. |
| `ch_system_async_metrics_TotalBytesOfMergeTreeTablesSystem`<br/>`DGAUGE`, байты | Общее количество байт (сжатых, включая данные и индексы), хранящихся в таблицах семейства MergeTree в системной БД. |
| `ch_system_async_metrics_TotalPartsOfMergeTreeTables`<br/>`DGAUGE`, штуки | Общее количество частей данных во всех таблицах семейства MergeTree. Числа, превышающие 10 000, отрицательно скажутся на времени запуска сервера и могут указывать на необоснованный выбор ключа раздела. |
| `ch_system_async_metrics_TotalPartsOfMergeTreeTablesSystem`<br/>`DGAUGE`, штуки | Общее количество частей данных в таблицах семейства MergeTree в системной БД. |
| `ch_system_async_metrics_TotalPrimaryKeyBytesInMemory`<br/>`DGAUGE`, байты | Общий объем памяти, используемой для хранения значений первичных ключей в оперативной памяти. |
| `ch_system_async_metrics_TotalPrimaryKeyBytesInMemoryAllocated`<br/>`DGAUGE`, байты | Общий объем выделенной памяти под значения первичных ключей в оперативной памяти. |
| `ch_system_async_metrics_TotalRowsOfMergeTreeTables`<br/>`DGAUGE`, штуки | Общее количество строк (записей), хранящихся во всех таблицах семейства MergeTree. |
| `ch_system_async_metrics_TotalRowsOfMergeTreeTablesSystem`<br/>`DGAUGE`, штуки | Общее количество строк (записей), хранящихся в таблицах семейства MergeTree в системной БД. |
| `ch_system_async_metrics_UncompressedCacheBytes`<br/>`DGAUGE`, байты | Объем памяти, занятой несжатым кэшом. |
| `ch_system_async_metrics_UncompressedCacheCells`<br/>`DGAUGE`, штуки | Количество элементов в несжатом кэше. |
| `ch_system_async_metrics_Uptime`<br/>`DGAUGE`, секунды | Время безотказной работы сервера в секундах. Включает время, затраченное на инициализацию сервера перед принятием подключений. |


## Прочие метрики {#managed-clickhouse-other-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности хоста на чтение.<br/>Принимает значение `1`, если сервис на хосте доступен на чтение, `0`, если нет. |
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности хоста на запись.<br/>Принимает значение `1`, если сервис на хосте доступен на запись, `0`, если нет. |
| `host_count`<br/>`DGAUGE`, штуки | Количество хостов. |
| `is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. |
| `read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с дисков. |
| `shard_count`<br/>`DGAUGE`, штуки | Количество шардов. |
| `write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на диски. |
