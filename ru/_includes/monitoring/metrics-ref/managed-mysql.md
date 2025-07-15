Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mmy-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-mysql`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `primary`, `replica`

## Метрики CPU {#managed-mysql-cpu-metrics}
Загрузка процессорных ядер.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `cpu.guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest_nice`. |
| `cpu.idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. | 
| `cpu.iowait`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `iowait`. | 
| `cpu.irq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `irq`. | 
| `cpu.nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `nice`. | 
| `cpu.softirq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `softirq`. | 
| `cpu.steal`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `steal`. | 
| `cpu.system`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `system`. | 
| `cpu.usage_idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. |
| `cpu.user`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `user`. |
| `load.avg_15min`<br/>`DGAUGE`, % | Средняя нагрузка за 15 минут. | 
| `load.avg_1min`<br/>`DGAUGE`, % | Средняя нагрузка за 1 минуту. | 
| `load.avg_5min`<br/>`DGAUGE`, % | Средняя нагрузка за 5 минут. |

## Метрики диска {#managed-mysql-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free`<br/>`DGAUGE`, байты | Свободное место. |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.inodes_free`<br/>`DGAUGE`, штуки | Свободное количество inodes. |
| `disk.inodes_total`<br/>`DGAUGE`, штуки | Доступное количество inodes. |
| `disk.inodes_used`<br/>`DGAUGE`, штуки | Использованное количество inodes. |
| `disk.inodes_used_percent`<br/>`DGAUGE`, % | Процент использованных inodes от общего количества. |
| `disk.total`<br/>`DGAUGE`, байты | Доступное место. |
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used`<br/>`DGAUGE`, байты | Использованное место. |
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |
| `disk.used_percent`<br/>`DGAUGE`, % | Процент использованного места. |
| `disk.used_percent_inodes`<br/>`DGAUGE`, % | Процент использованных inodes от общего количества. |

## Метрики дисковых операций {#managed-mysql-diskio-metrics}
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

## Метрики RAM {#managed-mysql-ram-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. | 
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `mem.available_percent_bytes`<br/>`DGAUGE`, % | Доля использования оперативной памяти, тип потребления `available`. |
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`. | 
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. | 
| `mem.commit_limit_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `commit_limit`. |
| `mem.committed_as_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `committed_as`. |
| `mem.dirty_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `dirty`. |
| `mem.free_bytes`<br/>`DGAUGE`, байты | Объем свободной оперативной памяти, доступной для использования, без учета `mem.buffers_bytes` и `mem.cached_bytes`. |
| `mem.high_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_free`. |
| `mem.high_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_total`. |
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_free`. |
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_page_size`. |
| `mem.huge_pages_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_total`. |
| `mem.inactive_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `inactive`. |
| `mem.low_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_free`. |
| `mem.low_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_total`. |
| `mem.mapped_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `mapped`. |
| `mem.page_tables_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `page_tables`. |
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `mem.slab_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `slab`. |
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sreclaimable`. |
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sunreclaim`. |
| `mem.swap_cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_cached`. |
| `mem.swap_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_free`. |
| `mem.swap_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_total`. |
| `mem.total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. |
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `mem.used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `used`. |
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы. | 
| `mem.used_percent`<br/>`DGAUGE`, % | Процент использованной оперативной памяти. |
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_chunk`. |
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_total`. |
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_used`. |
| `mem.write_back_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back`. |
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back_tmp`. |

## Метрики сети {#managed-mysql-net-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, байт/с | Скорость получения данных по сети. | 
| `net.bytes_sent`<br/>`DGAUGE`, байт/с | Скорость отправки данных по сети. | 
| `net.dropin`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при получении. | 
| `net.dropout`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при отправке. | 
| `net.errin`<br/>`DGAUGE`, штуки | Количество ошибок при получении. | 
| `net.errout`<br/>`DGAUGE`, штуки | Количество ошибок при отправке. | 
| `net.icmpmsg_intype8`<br/>`DGAUGE`, сообщения | Количество полученных ICMP-сообщений типа 8 (Echo Request). |
| `net.icmpmsg_outtype0`<br/>`DGAUGE`, сообщения | Общее количество отправленных ICMP-сообщений типа 0 (Echo Reply). |
| `net.icmp_outratelimitglobal`<br/>`DGAUGE`, сообщения | Количество ICMP сообщений, ограниченных глобальными лимитами скорости. |
| `net.icmp_outratelimithost`<br/>`DGAUGE`, сообщения | Количество ICMP сообщений, ограниченных лимитами скорости для конкретного хоста. |
| `net.ip_outtransmits`<br/>`DGAUGE`, пакеты | Количество успешно отправленных IP-пакетов. |
| `net.packets_recv`<br/>`DGAUGE`, пакетов/с | Интенсивность получения данных по сети. | 
| `net.packets_sent`<br/>`DGAUGE`, пакетов/с | Интенсивность отправки данных по сети. | 
| `net.speed`<br/>`DGAUGE`, бит/с | Максимальная скорость передачи данных в сети для данного интерфейса. |
| `net.udplite_memerrors`<br/>`DGAUGE`, ошибки | Количество ошибок, связанных с нехваткой памяти для протокола UDP-Lite. |
| `net.udp_memerrors`<br/>`DGAUGE`, ошибки | Количество ошибок, связанных с нехваткой памяти для протокола UDP. |

## Метрики сервиса {#managed-mysql-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `dbaas_conf.cpu_fraction`<br/>`DGAUGE`, доли | Доля доступных ресурсов CPU, предоставленных сервисом. |
| `dbaas_conf.cpu_guarantee`<br/>`DGAUGE`, доли | Гарантированная доля ресурсов CPU, выделенная сервисом. |
| `dbaas_conf.cpu_limit`<br/>`DGAUGE`, доли | Максимально разрешенная доля использования ресурсов CPU. |
| `dbaas_conf.hosts_ha`<br/>`DGAUGE`, хосты | Количество хостов, настроенных для высокой доступности. |
| `dbaas_conf.hosts.total`<br/>`DGAUGE`, хосты | Общее количество хостов, используемых сервисом. |
| `disk.mysql.binlogs_bytes`<br/>`DGAUGE`, байты | Объем, занятый служебными логами MySQL. | 
| `disk.mysql.data_bytes`<br/>`DGAUGE`, байты | Объем, занятый данными. | 
| `disk.mysql.default_tablespace_bytes`<br/>`DGAUGE`, байты | Объем, занятый данными в табличном пространстве по умолчанию. | 
| `disk.mysql.innodb_logs_bytes`<br/>`DGAUGE`, байты | Объем, занятый логами InnoDB. | 
| `disk.mysql.relaylogs_bytes`<br/>`DGAUGE`, байты | Объем, занятый служебными логами MySQL. | 
| `disk.mysql.temp_tablespace_bytes`<br/>`DGAUGE`, байты | Объем, занятый данными во временном табличном пространстве. | 
| `disk.mysql.undo_tablespace_bytes`<br/>`DGAUGE`, байты | Объем, занятый данными в [табличном пространстве InnoDB отката](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html). | 
| `mysql.fileio.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения данных.<br/>Дополнительные метки: `filetype` | 
| `mysql.fileio.reads`<br/>`DGAUGE`, операций/с | Средняя скорость файловых операций чтения (в секунду).<br/>Дополнительные метки: `filetype` | 
| `mysql.fileio.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи данных.<br/>Дополнительные метки: `filetype` | 
| `mysql.fileio.writes`<br/>`DGAUGE`, операций/с | Средняя скорость файловых операций записи (в секунду).<br/>Дополнительные метки: `filetype` | 
| `mysql.handler`<br/>`DGAUGE`, штуки | Количество обработчиков различных операций. Подробнее см. в [документации MySQL](https://dev.mysql.com/doc/refman/8.0/en/server-status-variables.html). <br/>Дополнительные метки: `handler` | 
| `mysql.session`<br/>`DGAUGE`, штуки | Количество сессий на определенной стадии. <br/>Дополнительные метки: `stage` | 
| `mysql_Aborted_connects_rate`<br/>`DGAUGE`, соединений/с | Количество неуспешных попыток соединения с БД. | 
| `mysql_Binlog_cache_disk_use_rate`<br/>`DGAUGE`, транзакций/с | Количество транзакций, которые использовали кеш бинлога, но превысили его размер и задействовали временный файл на диске. | 
| `mysql_Binlog_cache_use_rate`<br/>`DGAUGE`, транзакций/с | Количество транзакций, которые использовали кеш бинлога. | 
| `mysql_Connections_rate`<br/>`DGAUGE`, соединений/с | Количество попыток соединения с БД (успешных и неуспешных). | 
| `mysql_Created_tmp_disk_tables_rate`<br/>`DGAUGE`, таблиц/с | Количество временных таблиц, созданных на диске при обработке запросов БД. | 
| `mysql_Created_tmp_files_rate`<br/>`DGAUGE`, файлов/с | Количество временных файлов БД. | 
| `mysql_Created_tmp_tables_rate`<br/>`DGAUGE`, таблиц/с | Количество временных таблиц, созданных при обработке запросов БД. | 
| `mysql_Innodb_buffer_pool_pages_data`<br/>`DGAUGE`, штуки | Количество страниц с данными в буфере InnoDB. Включает `dirty` и `clean`. | 
| `mysql_Innodb_buffer_pool_pages_dirty`<br/>`DGAUGE`, штуки | Количество `dirty` страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_pages_free`<br/>`DGAUGE`, штуки | Количество свободных страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_pages_misc`<br/>`DGAUGE`, штуки | Количество служебных страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_pages_total`<br/>`DGAUGE`, штуки | Количество страниц в буфере InnoDB. | 
| `mysql_Innodb_buffer_pool_read_requests_rate`<br/>`DGAUGE`, операций/с | Количество операций чтения InnoDB. | 
| `mysql_Innodb_buffer_pool_reads_rate`<br/>`DGAUGE`, операций/с | Количество операций чтения InnoDB, для обработки которых InnoDB вынуждена обращаться к диску. | 
| `mysql_Innodb_checkpoint_age`<br/>`DGAUGE`, байты | Размер данных в памяти InnoDB до сброса на диск. | 
| `mysql_Innodb_checkpoint_max_age`<br/>`DGAUGE`, байты | Предельный размер данных в памяти InnoDB до сброса на диск. | 
| `mysql_Innodb_data_fsyncs_rate`<br/>`DGAUGE`, операций/с | Количество операций _fsync()_ при сбросе данных на диск в InnoDB. | 
| `mysql_Innodb_data_reads_rate`<br/>`DGAUGE`, операций/с | Количество операций чтения с диска в InnoDB. | 
| `mysql_Innodb_data_writes_rate`<br/>`DGAUGE`, операций/с | Количество записи в InnoDB. | 
| `mysql_Innodb_page_size`<br/>`DGAUGE`, байты | Размер страницы в InnoDB (по умолчанию 16KB). | 
| `mysql_Innodb_row_lock_current_waits`<br/>`DGAUGE`, штуки | Количество блокировок строк в InnoDB. | 
| `mysql_Innodb_row_lock_time_rate`<br/>`DGAUGE`, миллисекунды | Общее время ожидания блокировки строк в InnoDB. | 
| `mysql_Innodb_row_lock_waits_rate`<br/>`DGAUGE`, операций/с | Количество операций InnoDB, которым пришлось ждать блокировки строк. | 
| `mysql_Innodb_rows_deleted_rate`<br/>`DGAUGE`, строк/с | Количество удаленных строк в InnoDB. | 
| `mysql_Innodb_rows_inserted_rate`<br/>`DGAUGE`, строк/с | Количество добавленных строк в InnoDB. | 
| `mysql_Innodb_rows_read_rate`<br/>`DGAUGE`, строк/с | Количество строк, считанных из таблиц InnoDB. | 
| `mysql_Innodb_rows_updated_rate`<br/>`DGAUGE`, строк/с | Количество обновленных строк в InnoDB. | 
| `mysql_Open_table_definitions`<br/>`DGAUGE`, штуки | Количество кешируемых определений таблиц. | 
| `mysql_Open_tables`<br/>`DGAUGE`, штуки | Количество открытых таблиц. | 
| `mysql_Opened_table_definitions_rate`<br/>`DGAUGE`, таблиц/с | Количество кешируемых определений таблиц в единицу времени. | 
| `mysql_Opened_tables_rate`<br/>`DGAUGE`, таблиц/с | Количество открытых таблиц в единицу времени. | 
| `mysql_Prepared_stmt_count`<br/>`DGAUGE`, штуки | Количество подготовленных выражений. | 
| `mysql_Queries_rate`<br/>`DGAUGE`, запросы/с | Количество выполняемых запросов, включая запросы пользователей и хранимые процедуры, в единицу времени. | 
| `mysql_Questions_rate`<br/>`DGAUGE`, запросы/с | Количество выполняемых запросов от пользователей в единицу времени. | 
| `mysql_Rpl_semi_sync_master_clients`<br/>`DGAUGE`, штуки | Количество полусинхронных реплик. | 
| `mysql_Rpl_semi_sync_master_tx_avg_wait_time`<br/>`DGAUGE`, микросекунды | Среднее время ожидания транзакции источником репликации. | 
| `mysql_Rpl_semi_sync_master_tx_wait_time_rate`<br/>`DGAUGE`, микросекунды | Суммарное время ожидания транзакции источником репликации за единицу времени. | 
| `mysql_Rpl_semi_sync_master_wait_sessions`<br/>`DGAUGE`, штуки | Количество сессий, ожидающих ответа от реплик. | 
| `mysql_Select_full_join_rate`<br/>`DGAUGE`, запросы/с | Количество джоинов, которые используют скан таблицы вместо индекса. | 
| `mysql_Select_full_range_join_rate`<br/>`DGAUGE`, запросы/с | Количество джоинов, которые используют поиск по интервалу в референсной таблице. | 
| `mysql_Slow_queries_rate`<br/>`DGAUGE`, запросы/с | Количество медленных запросов, которые выполняются дольше `long_query_time` секунд, в единицу времени. | 
| `mysql_Sort_range_rate`<br/>`DGAUGE`, запросы/с | Количество сортировок по интервалам в единицу времени. | 
| `mysql_Sort_rows_rate`<br/>`DGAUGE`, запросы/с | Количество отсортированных строк в единицу времени. | 
| `mysql_Sort_scan_rate`<br/>`DGAUGE`, запросы/с | Количество сортировок с использованием скана таблицы в единицу времени. | 
| `mysql_Table_locks_immediate`<br/>`DGAUGE`, штуки | Количество немедленных блокировок таблиц. | 
| `mysql_Table_locks_waited`<br/>`DGAUGE`, штуки | Количество блокировок таблиц, которым пришлось ждать. | 
| `mysql_Table_open_cache_hits_rate`<br/>`DGAUGE`, операций/с | Количество хитов для поисков в кеше открытых таблиц в единицу времени. | 
| `mysql_Table_open_cache_misses_rate`<br/>`DGAUGE`, операций/с | Количество неуспешных попыток поиска в кеше открытых таблиц в единицу времени. | 
| `mysql_Threads_cached`<br/>`DGAUGE`, штуки | Количество потоков, которые находятся в кеше. | 
| `mysql_Threads_connected`<br/>`DGAUGE`, штуки | Количество потоков, которые обрабатывают открытые подключения к БД. | 
| `mysql_Threads_created_rate`<br/>`DGAUGE`, потоки/с | Количество создаваемых потоков в единицу времени. | 
| `mysql_Threads_running`<br/>`DGAUGE`, штуки | Количество потоков, которые запущены в данный момент. | 
| `mysql_Uptime`<br/>`DGAUGE`, секунды | Время работы сервера без перезагрузки. | 
| `mysql_config_innodb_buffer_pool_size`<br/>`DGAUGE`, байты | Размер буферного пула InnoDB. | 
| `mysql_config_innodb_log_file_size`<br/>`DGAUGE`, байты | Размер лог файла в лог группе. | 
| `mysql_config_max_connections`<br/>`DGAUGE`, штуки | Максимальное количество параллельных подключений. | 
| `mysql_config_table_open_cache`<br/>`DGAUGE`, штуки | Количество открытых таблиц для всех потоков. | 
| `mysql_config_thread_cache_size`<br/>`DGAUGE`,число | Количество потоков, которые нужно кешировать для повторного использования. | 
| `mysql_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `mysql_is_primary`<br/>`DGAUGE`, 0/1 | Показатель хоста-мастера.<br/>Принимает значение `1`, если хост БД является мастером, `0`, если нет. | 
| `mysql_is_replica`<br/>`DGAUGE`, 0/1 | Показатель хоста-реплики.<br/>Принимает значение `1`, если хост БД является репликой, `0`, если нет. | 
| `mysql_latency_query_0.5`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, медиана. | 
| `mysql_latency_query_0.75`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.75 процентиль. | 
| `mysql_latency_query_0.90`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.90 процентиль. | 
| `mysql_latency_query_0.95`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.95 процентиль. | 
| `mysql_latency_query_0.99`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.99 процентиль. | 
| `mysql_latency_query_avg`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения запросов. | 
| `mysql_latency_query_oldest`<br/>`DGAUGE`, миллисекунды | Время выполнения самого старого запроса. | 
| `mysql_latency_trx_0.5`<br/>`DGAUGE`, миллисекунды | Время выполнения транзакций, медиана. | 
| `mysql_latency_trx_0.75`<br/>`DGAUGE`, миллисекунды | Время выполнения транзакций, 0.75 процентиль. | 
| `mysql_latency_trx_0.90`<br/>`DGAUGE`, миллисекунды | Время выполнения транзакций, 0.90 процентиль. | 
| `mysql_latency_trx_0.95`<br/>`DGAUGE`, миллисекунды | Время выполнения транзакций, 0.95 процентиль. | 
| `mysql_latency_trx_0.99`<br/>`DGAUGE`, миллисекунды | Время выполнения транзакций, 0.99 процентиль. | 
| `mysql_latency_trx_avg`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения транзакций. | 
| `mysql_latency_trx_oldest`<br/>`DGAUGE`, миллисекунды | Время выполнения самой старой транзакции. | 
| `mysql_replication_lag`<br/>`DGAUGE`, секунды | Отставание реплики от мастера. | 
| `mysql_replication_io_thread_running`<br/>`DGAUGE`, 0/1 | Состояние IO-потока репликации {{ MY }}.</br>Принимает значение `1`, если поток работает, `0`, если поток остановлен.</li></ul> |
| `mysql_replication_sql_thread_running`<br/>`DGAUGE`, 0/1 | Состояние SQL-потока репликации {{ MY }}.</br>Принимает значение `1`, если поток работает, `0`, если поток остановлен.</li></ul> |
| `mysql_role`<br/>`DGAUGE`, 1/2 | Текущая роль MySQL-сервера в репликации.<br/>Принимает значение `2`, если сервер является репликой (второстепенным сервером), `1`, если мастером (основным сервером). | 
| `mysql_writable`<br/>`DGAUGE`, 0/1 | Доступность сервера для записи.<br/>Принимает значение `1`, если сервер доступен для записи, `0`, если нет. | 

## Прочие метрики {#managed-mysql-other-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности хоста на чтение.<br/>Принимает значение `1`, если сервис на хосте доступен на чтение, `0`, если нет. |
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности хоста на запись.<br/>Принимает значение `1`, если сервис на хосте доступен на запись, `0`, если нет. |
| `core_dump_count`<br/>`DGAUGE`, штуки | Количество дампов ядра. |
| `n_unique_users`<br/>`DGAUGE`, пользователи | Количество уникальных пользователей или аккаунтов, взаимодействующих с системой. |
