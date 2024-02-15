Общие метки для всех метрик сервиса {{ mch-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-clickhouse`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `replica`, `follower`, `leader`
subcluster_name | Тип подкластера: `clickhouse_subcluster`, `zookeeper_subcluster`
shard | Идентификатор шарда

### Метрики CPU {#managed-clickhouse-cpu-metrics}
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

### Метрики диска {#managed-clickhouse-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_s3_disk_parts_size`<br/>`DGAUGE`, байты | Место, занятое кусками таблиц [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) в сервисе {{ objstorage-full-name }} при настроенном [гибридном хранилище](../../../managed-clickhouse/concepts/storage.md#hybrid-storage-features) {{ mch-name }}. |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |

### Метрики дисковых операций {#managed-clickhouse-diskio-metrics}
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

### Метрики RAM {#managed-clickhouse-ram-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, байты | Гарантированный размер оперативной памяти. | 
| `mem.limit_bytes`<br/>`DGAUGE`, байты | Предельный размер оперативной памяти. | 
| `mem.active_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. | 
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`.  | 
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`.  | 
| `mem.free_bytes`<br/>`DGAUGE`, байты | Объем свободной оперативной памяти, доступной для использования, без учета `mem.buffers_bytes` и `mem.cached_bytes`.  |
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`.  | 
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`.  | 
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы.  | 

### Метрики сети {#managed-clickhouse-net-metrics}
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

### Метрики сервиса {#managed-clickhouse-metrics}
##### Метрики системных событий {#managed-clickhouse-system-events-metrics}
Нативные метрики {{ CH }} из таблицы [system.events]({{ ch.docs }}/operations/system-tables/events). 
По каждой метрике считается прирост `inc` и скорость изменения `rate` за единицу времени.

| Имя<br/>Тип| 
| ----- | 
| `ch_system_events_ArenaAllocBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_ArenaAllocBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_ArenaAllocChunks_inc`<br/>`DGAUGE` | 
| `ch_system_events_ArenaAllocChunks_rate`<br/>`DGAUGE` | 
| `ch_system_events_BackgroundLoadingMarksTasks_inc`<br/>`DGAUGE` | 
| `ch_system_events_BackgroundLoadingMarksTasks_rate`<br/>`DGAUGE` | 
| `ch_system_events_CreatedHTTPConnections_inc`<br/>`DGAUGE` | 
| `ch_system_events_CreatedHTTPConnections_rate`<br/>`DGAUGE` | 
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
| `ch_system_events_ContextLockWaitMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_ContextLockWaitMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_CreatedReadBufferOrdinary_inc`<br/>`DGAUGE` | 
| `ch_system_events_CreatedReadBufferOrdinary_rate`<br/>`DGAUGE` | 
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
| `ch_system_events_FunctionExecute_inc`<br/>`DGAUGE` | 
| `ch_system_events_FunctionExecute_rate`<br/>`DGAUGE` | 
| `ch_system_events_HardPageFaults_inc`<br/>`DGAUGE` | 
| `ch_system_events_HardPageFaults_rate`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocs_inc`<br/>`DGAUGE` | 
| `ch_system_events_IOBufferAllocs_rate`<br/>`DGAUGE` | 
| `ch_system_events_LoadedMarksCount_inc`<br/>`DGAUGE` | 
| `ch_system_events_LoadedMarksCount_rate`<br/>`DGAUGE` | 
| `ch_system_events_LoadedMarksMemoryBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_LoadedMarksMemoryBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_LogDebug_inc`<br/>`DGAUGE` | 
| `ch_system_events_LogDebug_rate`<br/>`DGAUGE` | 
| `ch_system_events_LogError_inc`<br/>`DGAUGE` | 
| `ch_system_events_LogError_rate`<br/>`DGAUGE` | 
| `ch_system_events_LogInfo_inc`<br/>`DGAUGE` | 
| `ch_system_events_LogInfo_rate`<br/>`DGAUGE` | 
| `ch_system_events_LogWarning_inc`<br/>`DGAUGE` | 
| `ch_system_events_LogWarning_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertQueryTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertQueryTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertQuery_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertQuery_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertedCompactParts_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertedCompactParts_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_InsertedRows_inc`<br/>`DGAUGE` | 
| `ch_system_events_InsertedRows_rate`<br/>`DGAUGE` | 
| `ch_system_events_MainConfigLoads_inc`<br/>`DGAUGE` | 
| `ch_system_events_MainConfigLoads_rate`<br/>`DGAUGE` | 
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
| `ch_system_events_MergedIntoCompactParts_inc`<br/>`DGAUGE` | 
| `ch_system_events_MergedIntoCompactParts_rate`<br/>`DGAUGE` | 
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
| `ch_system_events_PartsLockHoldMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_PartsLockHoldMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_PartsLockWaitMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_PartsLockWaitMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_QueriesWithSubqueries_inc`<br/>`DGAUGE` | 
| `ch_system_events_QueriesWithSubqueries_rate`<br/>`DGAUGE` | 
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
| `ch_system_events_ReadBufferFromFileDescriptorRead_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReadBufferFromFileDescriptorRead_rate`<br/>`DGAUGE` | 
| `ch_system_events_ReadCompressedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_ReadCompressedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_RealTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_RealTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_RegexpCreated_inc`<br/>`DGAUGE` | 
| `ch_system_events_RegexpCreated_rate`<br/>`DGAUGE` | 
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
| `ch_system_events_Seek_inc`<br/>`DGAUGE` | 
| `ch_system_events_Seek_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectQueryTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectQueryTimeMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_ServerStartupMilliseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_ServerStartupMilliseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectQuery_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectQuery_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedBytes_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedBytes_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectedRows_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectedRows_rate`<br/>`DGAUGE` | 
| `ch_system_events_SelectQueriesWithSubqueries_inc`<br/>`DGAUGE` | 
| `ch_system_events_SelectQueriesWithSubqueries_rate`<br/>`DGAUGE` | 
| `ch_system_events_SoftPageFaults_inc`<br/>`DGAUGE` | 
| `ch_system_events_SoftPageFaults_rate`<br/>`DGAUGE` | 
| `ch_system_events_SynchronousRemoteReadWaitMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_SynchronousRemoteReadWaitMicroseconds_rate`<br/>`DGAUGE` | 
| `ch_system_events_SystemTimeMicroseconds_inc`<br/>`DGAUGE` | 
| `ch_system_events_SystemTimeMicroseconds_rate`<br/>`DGAUGE` | 
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

##### Метрики текущих событий {#managed-clickhouse-system-metrics}
Нативные метрики {{ CH }} из таблицы [system.metrics]({{ ch.docs }}/operations/system-tables/metrics/).

| Имя<br/>Тип| 
| ----- | 
| `ch_system_metrics_ActiveTimersInQueryProfiler`<br/>`DGAUGE` | 
| `ch_system_metrics_AggregatorThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_AggregatorThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_AsynchronousInsertThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_AsynchronousInsertThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_AsynchronousReadWait`<br/>`DGAUGE` | 
| `ch_system_metrics_AsyncInsertCacheSize`<br/>`DGAUGE` | 
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
| `ch_system_metrics_BackupsThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_BackupsThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDetachedFileSegments`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDictionaryThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDictionaryThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDictionaryUpdateQueueBatches`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheDictionaryUpdateQueueKeys`<br/>`DGAUGE` | 
| `ch_system_metrics_CacheFileSegments`<br/>`DGAUGE` | 
| `ch_system_metrics_Connection`<br/>`DGAUGE` | 
| `ch_system_metrics_ContextLockWait`<br/>`DGAUGE` | 
| `ch_system_metrics_CreatedTimersInQueryProfiler`<br/>`DGAUGE` | 
| `ch_system_metrics_DatabaseCatalogThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DatabaseCatalogThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DatabaseOnDiskThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DatabaseOnDiskThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DatabaseOrdinaryThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DatabaseOrdinaryThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DDLWorkerThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DDLWorkerThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DelayedInserts`<br/>`DGAUGE` | 
| `ch_system_metrics_DestroyAggregatesThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DestroyAggregatesThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DictCacheRequests`<br/>`DGAUGE` | 
| `ch_system_metrics_DiskObjectStorageAsyncThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DiskObjectStorageAsyncThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DiskSpaceReservedForMerge`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedBytesToInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedFilesToInsert`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedInsertThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedInsertThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_DistributedSend`<br/>`DGAUGE` | 
| `ch_system_metrics_EphemeralNode`<br/>`DGAUGE` | 
| `ch_system_metrics_FilesystemCacheDelayedCleanupElements`<br/>`DGAUGE` | 
| `ch_system_metrics_FilesystemCacheDownloadQueueElements`<br/>`DGAUGE` | 
| `ch_system_metrics_FilesystemCacheElements`<br/>`DGAUGE` | 
| `ch_system_metrics_FilesystemCacheReadBuffers`<br/>`DGAUGE` | 
| `ch_system_metrics_FilesystemCacheSize`<br/>`DGAUGE` | 
| `ch_system_metrics_FilesystemCacheSizeLimit`<br/>`DGAUGE` | 
| `ch_system_metrics_GlobalThread`<br/>`DGAUGE` | 
| `ch_system_metrics_GlobalThreadActive`<br/>`DGAUGE` | 
| `ch_system_metrics_HashedDictionaryThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_HashedDictionaryThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_HTTPConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_IDiskCopierThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_IDiskCopierThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_InterserverConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_IOPrefetchThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_IOPrefetchThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_IOThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_IOThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_IOUringInFlightEvents`<br/>`DGAUGE` | 
| `ch_system_metrics_IOUringPendingEvents`<br/>`DGAUGE` | 
| `ch_system_metrics_IOWriterThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_IOWriterThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaAssignedPartitions`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaBackgroundReads`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaConsumers`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaConsumersInUse`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaConsumersWithAssignment`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaLibrdkafkaThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaProducers`<br/>`DGAUGE` | 
| `ch_system_metrics_KafkaWrites`<br/>`DGAUGE` | 
| `ch_system_metrics_KeeperAliveConnections`<br/>`DGAUGE` | 
| `ch_system_metrics_KeeperOutstandingRequets`<br/>`DGAUGE` | 
| `ch_system_metrics_LocalThread`<br/>`DGAUGE` | 
| `ch_system_metrics_LocalThreadActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MarksLoaderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_MarksLoaderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MaxDDLEntryID`<br/>`DGAUGE` | 
| `ch_system_metrics_MaxPushedDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTracking`<br/>`DGAUGE` | 
| `ch_system_metrics_Merge`<br/>`DGAUGE` | 
| `ch_system_metrics_MergesMutationsMemoryTracking`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeAllRangesAnnouncementsSent`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeBackgroundExecutorThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeBackgroundExecutorThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeDataSelectExecutorThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeDataSelectExecutorThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreePartsCleanerThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreePartsCleanerThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreePartsLoaderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreePartsLoaderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_MergeTreeReadTaskRequestsSent`<br/>`DGAUGE` | 
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
| `ch_system_metrics_ObjectStorageS3Threads`<br/>`DGAUGE` | 
| `ch_system_metrics_ObjectStorageS3ThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_OpenFileForRead`<br/>`DGAUGE` | 
| `ch_system_metrics_OpenFileForWrite`<br/>`DGAUGE` | 
| `ch_system_metrics_OutdatedPartsLoadingThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_OutdatedPartsLoadingThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_ParallelFormattingOutputFormatThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_ParallelFormattingOutputFormatThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_ParallelParsingInputFormatThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_ParallelParsingInputFormatThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_ParquetDecoderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_ParquetDecoderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_ParquetEncoderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_ParquetEncoderThreadsActive`<br/>`DGAUGE` | 
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
| `ch_system_metrics_QueryPipelineExecutorThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_QueryPipelineExecutorThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_QueryPreempted`<br/>`DGAUGE` | 
| `ch_system_metrics_QueryThread`<br/>`DGAUGE` | 
| `ch_system_metrics_Read`<br/>`DGAUGE` | 
| `ch_system_metrics_ReadonlyReplica`<br/>`DGAUGE` | 
| `ch_system_metrics_ReadTaskRequestsSent`<br/>`DGAUGE` | 
| `ch_system_metrics_RemoteRead`<br/>`DGAUGE` | 
| `ch_system_metrics_ReplicatedChecks`<br/>`DGAUGE` | 
| `ch_system_metrics_ReplicatedFetch`<br/>`DGAUGE` | 
| `ch_system_metrics_ReplicatedSend`<br/>`DGAUGE` | 
| `ch_system_metrics_RestartReplicaThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_RestartReplicaThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_RestoreThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_RestoreThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_Revision`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockActiveReaders`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockActiveTotal`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockActiveWriters`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockWaitingReaders`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockWaitingTotal`<br/>`DGAUGE` | 
| `ch_system_metrics_RWLockWaitingWriters`<br/>`DGAUGE` | 
| `ch_system_metrics_S3Requests`<br/>`DGAUGE` | 
| `ch_system_metrics_SendExternalTables`<br/>`DGAUGE` | 
| `ch_system_metrics_SendScalars`<br/>`DGAUGE` | 
| `ch_system_metrics_StartupSystemTablesThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_StartupSystemTablesThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageBufferBytes`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageBufferRows`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageDistributedThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageDistributedThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageHiveThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageHiveThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageS3Threads`<br/>`DGAUGE` | 
| `ch_system_metrics_StorageS3ThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_SystemReplicasThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_SystemReplicasThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_TablesLoaderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_TablesLoaderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_TablesToDropQueueSize`<br/>`DGAUGE` | 
| `ch_system_metrics_TCPConnection`<br/>`DGAUGE` | 
| `ch_system_metrics_TemporaryFilesForAggregation`<br/>`DGAUGE` | 
| `ch_system_metrics_TemporaryFilesForJoin`<br/>`DGAUGE` | 
| `ch_system_metrics_TemporaryFilesForSort`<br/>`DGAUGE` | 
| `ch_system_metrics_TemporaryFilesUnknown`<br/>`DGAUGE` | 
| `ch_system_metrics_ThreadPoolFSReaderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_ThreadPoolFSReaderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreads`<br/>`DGAUGE` | 
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreadsActive`<br/>`DGAUGE` | 
| `ch_system_metrics_ThreadsInOvercommitTracker`<br/>`DGAUGE` | 
| `ch_system_metrics_TotalTemporaryFiles`<br/>`DGAUGE` | 
| `ch_system_metrics_VersionInteger`<br/>`DGAUGE` | 
| `ch_system_metrics_Write`<br/>`DGAUGE` | 
| `ch_system_metrics_ZooKeeperRequest`<br/>`DGAUGE` | 
| `ch_system_metrics_ZooKeeperSession`<br/>`DGAUGE` | 
| `ch_system_metrics_ZooKeeperWatch`<br/>`DGAUGE` | 

##### Метрики очереди запросов {#managed-clickhouse-query-log-metrics}
Нативные метрики {{ CH }} из таблицы [system.query_log]({{ ch.docs }}/operations/system-tables/query_log).
По каждой метрике считается прирост за единицу времени (секунда).

| Имя<br/>Тип| 
| ----- | 
| `ch_system_query_log_insert_requests_inc`<br/>`DGAUGE` | | 
| `ch_system_query_log_read_bytes_inc`<br/>`DGAUGE` | | 
| `ch_system_query_log_read_rows_inc`<br/>`DGAUGE` | |  
| `ch_system_query_log_requests_inc`<br/>`DGAUGE` | |  
| `ch_system_query_log_result_bytes_inc`<br/>`DGAUGE` | | 
| `ch_system_query_log_result_rows_inc`<br/>`DGAUGE` | |  
| `ch_system_query_log_select_requests_inc`<br/>`DGAUGE` | |  
| `ch_system_query_log_written_bytes_inc`<br/>`DGAUGE` | | 
| `ch_system_query_log_written_rows_inc`<br/>`DGAUGE` | |  

##### Метрики репликации {#managed-clickhouse-replication-metrics}
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

##### Системные метрики {#managed-clickhouse-config-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `ch_config_merge_tree_parts_to_throw_insert`<br/>`DGAUGE`, штуки | Предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ....` Задается в [настройках](../../../managed-clickhouse/concepts/settings-list.md#setting-merge-tree). Имеет смысл [анализировать](../../../glossary/data-analytics.md) в паре с метрикой `ch_system_async_metrics_MaxPartCountForPartition`. |
| `ch_local_disk_parts_size`<br/>`DGAUGE`, байты | Размер партиций на локальных дисках. |
| `ch_system_async_metrics_MaxPartCountForPartition`<br/>`DGAUGE`, штуки | Максимальное число кусков данных в разделе. | 
| `ch_system_async_metrics_NumberOfDatabases`<br/>`DGAUGE`, штуки | Общее количество баз данных на сервере. |
| `ch_system_async_metrics_NumberOfTables`<br/>`DGAUGE`, штуки | Общее количество таблиц, суммированных по базам данных на сервере, исключая базы данных, которые не могут содержать таблицы MergeTree. Исключенные движки баз данных — это те, которые генерируют набор таблиц «на лету», такие как Lazy, {{ MY }}, {{ PG }}, SQLite. |
| `ch_system_async_metrics_NumberOfTablesSystem`<br/>`DGAUGE`, штуки | Общее количество таблиц в системной базе данных на сервере, хранящихся в таблицах семейства MergeTree. |
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
| `ch_system_async_metrics_TotalPartsOfMergeTreeTables`<br/>`DGAUGE`, штуки | Общее количество частей данных во всех таблицах семейства Merge Tree. Числа, превышающие 10 000, отрицательно скажутся на времени запуска сервера и могут указывать на необоснованный выбор ключа раздела. | 
| `ch_system_async_metrics_TotalPartsOfMergeTreeTablesSystem`<br/>`DGAUGE`, штуки | Общее количество частей данных в таблицах семейства MergeTree в системной БД. | 
| `ch_system_async_metrics_TotalRowsOfMergeTreeTables`<br/>`DGAUGE`, штуки | Общее количество строк (записей), хранящихся во всех таблицах семейства MergeTree. | 
| `ch_system_async_metrics_TotalRowsOfMergeTreeTablesSystem`<br/>`DGAUGE`, штуки | Общее количество строк (записей), хранящихся в таблицах семейства MergeTree в системной БД. | 
| `ch_system_async_metrics_Uptime`<br/>`DGAUGE`, секунды | Время безотказной работы сервера в секундах. Включает время, затраченное на инициализацию сервера перед принятием подключений. | 

### Прочие метрики {#managed-clickhouse-other-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности на чтение.<br/>Принимает значение `1`, если кластер доступен на чтение, `0`, если нет. | 
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности на запись.<br/>Принимает значение `1`, если кластер доступен на запись, `0`, если нет. | 
| `is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. |
