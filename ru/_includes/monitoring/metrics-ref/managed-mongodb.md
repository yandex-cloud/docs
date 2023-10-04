## Сервис {{ mmg-full-name }} {#managed-mongodb}

Общие метки для всех метрик сервиса {{ mmg-full-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-mongodb`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `primary`, `secondary`
shard | Идентификатор шарда

### Метрики CPU {#managed-mongodb-cpu-metrics}
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

### Метрики диска {#managed-mongodb-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |

### Метрики дисковых операций {#managed-mongodb-diskio-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с дисков. | 
| `io.avg_write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на диски. | 
| `io.disk*.avg_read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с конкретного диска. | 
| `io.disk*.avg_write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на конкретный диск. | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с конкретного диска. | 
| `io.disk*.read_count`<br/>`DGAUGE`, операций/с | Количество операций чтения с конкретного диска в секунду. | 
| `io.disk*.read_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций чтения с конкретного диска в секунду. | 
| `io.disk*.utilization`<br/>`DGAUGE`, % | Утилизация конкретного диска. | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на конкретный диск. | 
| `io.disk*.write_count`<br/>`DGAUGE`, операций/с | Количество операций записи на конкретный диск в секунду. | 
| `io.disk*.write_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций записи на конкретный диск в секунду. |
| `io.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с дисков. | 
| `io.read_count`<br/>`DGAUGE`, операций/с | Количество операций чтения в секунду. | 
| `io.read_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций чтения в секунду. | 
| `io.utilization`<br/>`DGAUGE`, % | Утилизация дисков. | 
| `io.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на диски. | 
| `io.write_count`<br/>`DGAUGE`, операций/с | Количество операций записи в секунду. | 
| `io.write_merged_count`<br/>`DGAUGE`, операций/с | Количество слитых операций записи в секунду. |

### Метрики RAM {#managed-mongodb-ram-metrics}
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

### Метрики сети {#managed-mongodb-net-metrics}
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

### Метрики сервиса {#managed-mongodb-metrics}
##### Метрики dbStats {#managed-mongodb-dbstats-metrics}
Собираются в разрезе каждой базы `<dbname>`, включая служебные (admin, config, local).

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `db_stats_avgObjSize`<br/>`DGAUGE`, байты | Средний размер документа. | 
| `db_stats_collections`<br/>`DGAUGE`, штуки | Количество коллекций в базе. | 
| `db_stats_dataSize`<br/>`DGAUGE`, байты | Размер несжатых данных в базе. | 
| `db_stats_fsTotalSize`<br/>`DGAUGE`, байты | Размер дискового пространства файловой системы, где MongoDB хранит данные. | 
| `db_stats_fsUsedSize`<br/>`DGAUGE`, байты | Размер использованного дискового пространства файловой системы, где MongoDB хранит данные. | 
| `db_stats_indexSize`<br/>`DGAUGE`, байты | Размер места, занимаемого индексами базы. | 
| `db_stats_indexes`<br/>`DGAUGE`, штуки | Количество индексов во всех коллекциях в базе. | 
| `db_stats_numExtents`<br/>`DGAUGE`, штуки | Количество логических контейнеров во всех коллекциях в базе. | 
| `db_stats_objects`<br/>`DGAUGE`, штуки | Количество объектов (документов) во всех коллекциях в базе. | 
| `db_stats_ok`<br/>`DGAUGE`, 0/1 | Результат выполнения команды dbStats.<br/>Принимает значение `1`, если команда завершена успешно, `0`, если что-то пошло не так. | 
| `db_stats_scaleFactor`<br/>`DGAUGE`, штуки | Параметр `scale`, используемый командой.  | 
| `db_stats_storageSize`<br/>`DGAUGE`, байты | Размер места, выделенного под хранение документов во всех коллекциях в базе, включая свободное место. | 
| `db_stats_views`<br/>`DGAUGE`, штуки | Количество представлений в базе. |

##### Метрики serverStatus {#managed-mongodb-serverstatus-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `server_status_admin_asserts.msg`<br/>`DGAUGE`, штуки | Количество срабатываний ассертов сообщений. | 
| `server_status_admin_asserts.msg_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний ассертов сообщений за секунду. | 
| `server_status_admin_asserts.regular`<br/>`DGAUGE`, штуки | Количество срабатываний регулярных ассертов. | 
| `server_status_admin_asserts.regular_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний регулярных ассертов за секунду. | 
| `server_status_admin_asserts.rollovers`<br/>`DGAUGE`, штуки | Количество переполнений счетчиков.  | 
| `server_status_admin_asserts.rollovers_rate`<br/>`DGAUGE`, штуки | Прирост переполнений счетчиков за секунду. | 
| `server_status_admin_asserts.user`<br/>`DGAUGE`, штуки | Количество срабатываний пользовательский ассертов.  | 
| `server_status_admin_asserts.user_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний пользовательский ассертов за секунду. | 
| `server_status_admin_asserts.warning`<br/>`DGAUGE`, штуки | Количество предупреждений. | 
| `server_status_admin_asserts.warning_rate`<br/>`DGAUGE`, штуки | Прирост предупреждений за секунду. | 
| `server_status_admin_connections.active`<br/>`DGAUGE`, штуки | Количество активных подключений. | 
| `server_status_admin_connections.active_rate`<br/>`DGAUGE`, штуки | Прирост активных подключений за секунду. | 
| `server_status_admin_connections.adminConnections.readyThreads`<br/>`DGAUGE`, штуки | Количество подготовленных потоков. | 
| `server_status_admin_connections.adminConnections.readyThreads_rate`<br/>`DGAUGE`, штуки | Прирост подготовленных потоков за секунду.  | 
| `server_status_admin_connections.adminConnections.startingThreads`<br/>`DGAUGE`, штуки | Количество стартовавших потоков. | 
| `server_status_admin_connections.adminConnections.startingThreads_rate`<br/>`DGAUGE`, штуки | Прирост стартовавших потоков за секунду. | 
| `server_status_admin_connections.adminConnections.threadsRunning`<br/>`DGAUGE`, штуки | Количество запущенных потоков. | 
| `server_status_admin_connections.adminConnections.threadsRunning_rate`<br/>`DGAUGE`, штуки | Прирост запущенных потоков за секунду. | 
| `server_status_admin_connections.available`<br/>`DGAUGE`, штуки | Количество доступных для использования соединений. | 
| `server_status_admin_connections.available_rate`<br/>`DGAUGE`, штуки | Прирост доступных для использования соединений за секунду. | 
| `server_status_admin_connections.current`<br/>`DGAUGE`, штуки | Количество входящих соединений с БД. | 
| `server_status_admin_connections.current_rate`<br/>`DGAUGE`, штуки | Прирост входящих соединений с БД за секунду. | 
| `server_status_admin_connections.totalCreated`<br/>`DGAUGE`, штуки | Количество всех входящих соединений с сервером, включая завершенные. | 
| `server_status_admin_connections.totalCreated_rate`<br/>`DGAUGE`,число  | Прирост всех входящих соединений с сервером за секунду, включая завершенные. | 
| `server_status_admin_extra_info.page_faults_rate`<br/>`DGAUGE`, штуки | Количество [отказов страниц](https://ru.wikipedia.org/wiki/Отказ_страницы). | 
| `server_status_admin_globalLock.currentQueue.readers`<br/>`DGAUGE`, штуки | Количество операций в очереди операций, ожидающих снятия блокировки на чтение. | 
| `server_status_admin_globalLock.currentQueue.readers_rate`<br/>`DGAUGE`, штуки | Прирост операций в очереди операций, ожидающих снятия блокировки на чтение, за секунду. | 
| `server_status_admin_globalLock.currentQueue.total`<br/>`DGAUGE`, штуки | Суммарное количество операций в очереди операций, ожидающих снятия блокировки. | 
| `server_status_admin_globalLock.currentQueue.total_rate`<br/>`DGAUGE`, штуки | Прирост операций в очереди операций, ожидающих снятия блокировки, за секунду. | 
| `server_status_admin_globalLock.currentQueue.writers`<br/>`DGAUGE`, штуки | Количество операций в очереди операций, ожидающих снятия блокировки на запись. | 
| `server_status_admin_globalLock.currentQueue.writers_rate`<br/>`DGAUGE`, штуки | Прирост операций в очереди операций, ожидающих снятия блокировки на запись, за секунду. | 
| `server_status_admin_metrics.cursor.open.noTimeout`<br/>`DGAUGE`, штуки | Количество открытых курсоров с настройкой `DBQuery.Option.noTimeout` для предотвращения таймаута в случае неактивности. | 
| `server_status_admin_metrics.cursor.open.noTimeout_rate`<br/>`DGAUGE`, штуки | Прирост количества открытых курсоров с настройкой `DBQuery.Option.noTimeout` для предотвращения таймаута в случае неактивности за секунду. | 
| `server_status_admin_metrics.cursor.open.pinned`<br/>`DGAUGE`, штуки | Количество закрепленных открытых курсоров. | 
| `server_status_admin_metrics.cursor.open.pinned_rate`<br/>`DGAUGE`, штуки | Прирост закрепленных открытых курсоров за секунду. | 
| `server_status_admin_metrics.cursor.open.total`<br/>`DGAUGE`, штуки | Количество открытых курсоров. | 
| `server_status_admin_metrics.cursor.open.total_rate`<br/>`DGAUGE`, штуки | Прирост открытых курсоров за секунду.  | 
| `server_status_admin_metrics.cursor.timedOut`<br/>`DGAUGE`, штуки | Количество курсоров, достигших таймаута. | 
| `server_status_admin_metrics.cursor.timedOut_rate`<br/>`DGAUGE`, штуки | Прирост курсоров, достигших таймаута, за секунду. | 
| `server_status_admin_metrics.document.deleted`<br/>`DGAUGE`, штуки | Количество удаленных документов. | 
| `server_status_admin_metrics.document.deleted_rate`<br/>`DGAUGE`, штуки | Прирост удаленных документов за секунду. | 
| `server_status_admin_metrics.document.inserted`<br/>`DGAUGE`, штуки | Количество вставленных документов. | 
| `server_status_admin_metrics.document.inserted_rate`<br/>`DGAUGE`, штуки | Прирост вставленных документов за секунду. | 
| `server_status_admin_metrics.document.returned`<br/>`DGAUGE`, штуки | Количество возвращенных документов. | 
| `server_status_admin_metrics.document.returned_rate`<br/>`DGAUGE`, штуки | Прирост возвращенных документов за секунду. | 
| `server_status_admin_metrics.document.updated`<br/>`DGAUGE`, штуки | Количество обновленных документов. | 
| `server_status_admin_metrics.document.updated_rate`<br/>`DGAUGE`, штуки | Прирост обновленных документов за секунду. | 
| `server_status_admin_metrics.getLastError.wtime.totalMillis`<br/>`DGAUGE`, миллисекунды | Число миллисекунд, которое БД потратила в ожидании подтверждения успешной записи. | 
| `server_status_admin_metrics.getLastError.wtime.totalMillis_rate`<br/>`DGAUGE`, миллисекунды | Прирост миллисекунд, которое БД потратила в ожидании подтверждения успешной записи, за секунду. | 
| `server_status_admin_metrics.operation.scanAndOrder`<br/>`DGAUGE`, штуки | Количество сортировок данных без использования индекса. | 
| `server_status_admin_metrics.operation.scanAndOrder_rate`<br/>`DGAUGE`, штуки | Прирост сортировок данных без использования индекса за секунду. | 
| `server_status_admin_metrics.operation.writeConflicts`<br/>`DGAUGE`, штуки | Количество конфликтов при записи. | 
| `server_status_admin_metrics.operation.writeConflicts_rate`<br/>`DGAUGE`, штуки | Прирост конфликтов при записи за секунду. | 
| `server_status_admin_metrics.queryExecutor.scanned`<br/>`DGAUGE`, штуки | Количество просканированных ключей индекса. | 
| `server_status_admin_metrics.queryExecutor.scanned_rate`<br/>`DGAUGE`, штуки | Прирост просканированных ключей индекса за секунду. | 
| `server_status_admin_metrics.queryExecutor.scannedObjects`<br/>`DGAUGE`, штуки | Количество просканированных документов. | 
| `server_status_admin_metrics.queryExecutor.scannedObjects_rate`<br/>`DGAUGE`, штуки | Прирост просканированных документов за секунду. | 
| `server_status_admin_metrics.ttl.deletedDocuments`<br/>`DGAUGE`, штуки | Количество удаленных документов с использованием [TTL индекса](https://www.mongodb.com/docs/manual/core/index-ttl/). | 
| `server_status_admin_metrics.ttl.deletedDocuments_rate`<br/>`DGAUGE`, штуки | Прирост удаленных документов с использованием [TTL индекса](https://www.mongodb.com/docs/manual/core/index-ttl/) за секунду. | 
| `server_status_admin_metrics.ttl.passes`<br/>`DGAUGE`, штуки | Количество фоновых операций удаления документов из коллекций с использованием TTL индекса. | 
| `server_status_admin_metrics.ttl.passes_rate`<br/>`DGAUGE`, штуки | Прирост фоновых операций удаления документов из коллекций с использованием TTL индекса за секунду. | 
| `server_status_admin_opLatencies.commands.latency`<br/>`DGAUGE`, микросекунды | Суммарная задержка выполнения команд БД в микросекундах. | 
| `server_status_admin_opLatencies.commands.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд БД за секунду. | 
| `server_status_admin_opLatencies.commands.ops`<br/>`DGAUGE`, штуки | Количество операций над коллекциями БД. | 
| `server_status_admin_opLatencies.commands.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций над коллекциями БД за секунду. | 
| `server_status_admin_opLatencies.reads.latency`<br/>`DGAUGE`, микросекунды | Задержка выполнения команд чтения в микросекундах. | 
| `server_status_admin_opLatencies.reads.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд чтения за секунду. | 
| `server_status_admin_opLatencies.reads.ops`<br/>`DGAUGE`, штуки | Количество операций чтения коллекций БД. | 
| `server_status_admin_opLatencies.reads.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций чтения коллекций БД за секунду. | 
| `server_status_admin_opLatencies.transactions.latency`<br/>`DGAUGE`, микросекунды | Задержка транзакций в микросекундах. | 
| `server_status_admin_opLatencies.transactions.latency_rate`<br/>`DGAUGE`, микросекунды |Изменение задержки транзакций за секунду.  | 
| `server_status_admin_opLatencies.transactions.ops`<br/>`DGAUGE`, штуки | Количество транзакций в БД. | 
| `server_status_admin_opLatencies.transactions.ops_rate`<br/>`DGAUGE`, штуки | Прирост транзакций в БД за секунду. | 
| `server_status_admin_opLatencies.writes.latency`<br/>`DGAUGE`, микросекунды | Задержка выполнения команд записи в микросекундах. | 
| `server_status_admin_opLatencies.writes.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд записи за секунду. | 
| `server_status_admin_opLatencies.writes.ops`<br/>`DGAUGE`, штуки | Количество операций записи коллекций БД. | 
| `server_status_admin_opLatencies.writes.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций записи коллекций БД за секунду. | 
| `server_status_admin_opcounters.command`<br/>`DGAUGE`, штуки | Количество команд к БД с момента последнего старта. Кроме команд `insert`, `update`, `delete`. | 
| `server_status_admin_opcounters.command_rate`<br/>`DGAUGE`, штуки | Прирост количества команд к БД за секунду. Кроме команд `insert`, `update`, `delete`. | 
| `server_status_admin_opcounters.delete`<br/>`DGAUGE`, штуки | Количество `delete` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.delete_rate`<br/>`DGAUGE`, штуки | Прирост количества `delete` операций в БД за секунду. | 
| `server_status_admin_opcounters.getmore`<br/>`DGAUGE`, штуки | Количество `getmore` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.getmore_rate`<br/>`DGAUGE`, штуки | Прирост количества `getmore` операций в БД за секунду. | 
| `server_status_admin_opcounters.insert`<br/>`DGAUGE`, штуки | Количество `insert` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.insert_rate`<br/>`DGAUGE`, штуки | Прирост количества `insert` операций в БД за секунду. | 
| `server_status_admin_opcounters.query`<br/>`DGAUGE`, штуки | Количество `query` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.query_rate`<br/>`DGAUGE`, штуки | Прирост количества `query` операций в БД за секунду. | 
| `server_status_admin_opcounters.update`<br/>`DGAUGE`, штуки | Количество `update` операций с момента последнего старта БД. | 
| `server_status_admin_opcounters.update_rate`<br/>`DGAUGE`, штуки | Прирост количества `update` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.command`<br/>`DGAUGE`, штуки | Количество реплицируемых команд к БД с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.command_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых команд к БД за секунду. | 
| `server_status_admin_opcountersRepl.delete`<br/>`DGAUGE`, штуки | Количество реплицируемых `delete` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.delete_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `delete` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.getmore`<br/>`DGAUGE`, штуки | Количество реплицируемых `getmore` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.getmore_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `getmore` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.insert`<br/>`DGAUGE`, штуки | Количество реплицируемых `insert` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.insert_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `insert` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.query`<br/>`DGAUGE`, штуки | Количество реплицируемых `query` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.query_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `query` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.update`<br/>`DGAUGE`, штуки | Количество реплицируемых `update` операций с момента последнего старта БД. | 
| `server_status_admin_opcountersRepl.update_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `update` операций в БД за секунду. | 
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache`<br/>`DGAUGE`, байты | Размер использованного кеша WiredTiger. | 
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache_rate`<br/>`DGAUGE`, байты | Прирост использованного кеша WiredTiger за секунду. | 
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction`<br/>`DGAUGE`, штуки | Количество освобожденных страниц при чекпоинте. | 
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных страниц при чекпоинте за секунду. | 
| `server_status_admin_wiredTiger.cache.maximum_bytes_configured`<br/>`DGAUGE`, байты | Установленный максимальный размер кеша. | 
| `server_status_admin_wiredTiger.cache.modified_pages_evicted`<br/>`DGAUGE`, штуки | Количество освобожденных измененных страниц оперативной памяти. | 
| `server_status_admin_wiredTiger.cache.modified_pages_evicted_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных измененных страниц оперативной памяти за секунду. | 
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache`<br/>`DGAUGE`, байты | Размер грязного кеша. | 
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache_rate`<br/>`DGAUGE`, байты | Прирост грязного кеша за секунду. | 
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted`<br/>`DGAUGE`, штуки | Количество освобожденных неизмененных страниц оперативной памяти. | 
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных неизмененных страниц оперативной памяти за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.out`<br/>`DGAUGE`, штуки | Количество задействованных тикетов параллельных транзакций чтения. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.out_rate`<br/>`DGAUGE`, штуки | Прирост задействованных тикетов параллельных транзакций чтения за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets`<br/>`DGAUGE`, штуки | Количество доступных тикетов параллельных транзакций чтения. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets_rate`<br/>`DGAUGE`, штуки | Прирост тикетов параллельных транзакций чтения за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.out`<br/>`DGAUGE`, штуки | Количество задействованных тикетов параллельных транзакций записи. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.out_rate`<br/>`DGAUGE`, штуки | Прирост задействованных тикетов параллельных транзакций записи за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets`<br/>`DGAUGE`, штуки | Количество доступных тикетов параллельных транзакций записи. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets_rate`<br/>`DGAUGE`, штуки | Прирост доступных тикетов параллельных транзакций записи за секунду. | 
| `server_status_admin_wiredTiger.transaction.transaction_begins`<br/>`DGAUGE`, штуки | Количество запущенных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transaction_begins_rate`<br/>`DGAUGE`, штуки | Прирост запущенных транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_max_time_msecs`<br/>`DGAUGE`, миллисекунды | Максимальное время создания чекпоинта. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_min_time_msecs`<br/>`DGAUGE`, миллисекунды | Минимальное время создания чекпоинта. |  
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_most_recent_time_msecs`<br/>`DGAUGE`, миллисекунды | Время создания последнего чекпоинта (в миллисекундах). | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints`<br/>`DGAUGE`, штуки | Количество чекпоинтов транзакций. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints_rate`<br/>`DGAUGE`, штуки | Прирост чекпоинтов транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transactions_committed`<br/>`DGAUGE`, штуки | Количество завершенных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transactions_committed_rate`<br/>`DGAUGE`, штуки | Прирост завершенных транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back`<br/>`DGAUGE`, штуки | Количество отмененных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back_rate`<br/>`DGAUGE`, штуки | Прирост отмененных транзакций за секунду. | 

##### Прочие метрики {#managed-mongodb-other-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности на чтение.<br/>Принимает значение `1`, если кластер доступен на чтение, `0`, если нет.  | 
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности на запись.<br/>Принимает значение `1`, если кластер доступен на запись, `0`, если нет.  |
| `oplog-diff`<br/>`DGAUGE`, миллисекунды | Размер журнала операций (в миллисекундах). | 
| `oplog-firstTs`<br/>`DGAUGE`, миллисекунды | Таймстамп первой операции в журнале операций. | 
| `oplog-lastTs`<br/>`DGAUGE`, миллисекунды | Таймстамп последней операции в журнале операций. | 
| `oplog-maxSize`<br/>`DGAUGE`, байты | Максимальный размер журнала операций. | 
| `replset_status-replicationLag`<br/>`DGAUGE`, секунды | Задержка репликации. |

Подробнее о сервисе в документации [{{ mmg-full-name }}](../../../managed-mongodb/).
