Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mpg-name }}:

Метка | Значение
----|----
dc | [Зона доступности](../../../overview/concepts/geo-scope.md)
host | FQDN хоста
node | Тип хоста: `primary`, `replica`, `Unknown`
resource_id | Идентификатор кластера
resource_type | Тип ресурса: `cluster`
service | Идентификатор сервиса: `managed-postgresql`
shard | Идентификатор шарда
subcluster_name | Имя подкластера

## Метрики CPU {#managed-postgresql-cpu-metrics}

Загрузка процессорных ядер.

Тип потребления пишется в метку `systag`.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
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
| `n_cpus`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. |
| `pg_backend_cpu`<br/>`DGAUGE`, % | Утилизация CPU процессом {{ PG }}.<br/>Специальные метки:<ul><li>`backend_type` — тип бэкенда.</li><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |


## Метрики диска {#managed-postgresql-disk-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. |
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. |
| `disk.temp_files_size`<br/>`DGAUGE`, байты | Размер временных файлов. |
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. |
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. |
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |
| `disk.wal_size`<br/>`DGAUGE`, байты | Размер журнала упреждающей записи. |
| `pg_backend_read_bytes`<br>`DGAUGE`, байты/с | Скорость чтения данных процессом {{ PG }}.<br/>Специальные метки:<ul><li>`backend_type` — тип бэкенда.</li><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `pg_backend_write_bytes`<br>`DGAUGE`, байты/с | Скорость записи данных процессом {{ PG }}.<br/>Специальные метки:<ul><li>`backend_type` — тип бэкенда.</li><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |


## Метрики дисковых операций {#managed-postgresql-diskio-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с дисков. |
| `io.avg_write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на диски. |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с конкретного диска. |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на конкретный диск. |
| `io.disk*.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с конкретного диска. |
| `io.disk*.read_count`<br/>`DGAUGE`, операции/с | Количество операций чтения с конкретного диска в секунду. |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, операции/с | Количество слитых операций чтения с конкретного диска в секунду. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Использование конкретного диска. Не работает для сетевых дисков. |
| `io.disk*.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на конкретный диск. |
| `io.disk*.write_count`<br/>`DGAUGE`, операции/с | Количество операций записи на конкретный диск в секунду. |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, операции/с | Количество слитых операций записи на конкретный диск в секунду. |
| `io.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с дисков. |
| `io.read_count`<br/>`DGAUGE`, операции/с | Количество операций чтения в секунду. |
| `io.read_merged_count`<br/>`DGAUGE`, операции/с | Количество слитых операций чтения в секунду. |
| `io.utilization`<br/>`DGAUGE`, % | Использование дисков. Не работает для сетевых дисков. |
| `io.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на диски. |
| `io.write_count`<br/>`DGAUGE`, операции/с | Количество операций записи в секунду. |
| `io.write_merged_count`<br/>`DGAUGE`, операции/с | Количество слитых операций записи в секунду. |
| `monitoring_disk.io_quota_utilization_percentage`<br/>`DGAUGE`, % | Средний процент используемой квоты диска. |
| `monitoring_disk.io_quota_utilization_percentage_burst`<br/>`DGAUGE`, % | Максимальный процент используемой квоты диска. |
| `monitoring_disk.read_bytes`<br/>`DGAUGE`, байты/с | Среднее количество байт, прочитанных с диска. |
| `monitoring_disk.read_bytes_burst`<br/>`DGAUGE`, байты/с | Максимальное количество байт, прочитанных с диска. |
| `monitoring_disk.read_latency`<br/>`DGAUGE`, миллисекунды | Гистограмма распределения времени обработки запросов на чтение с диска. |
| `monitoring_disk.read_ops`<br/>`DGAUGE`, операции/с | Среднее количество операций чтения с диска. |
| `monitoring_disk.read_ops_burst`<br/>`DGAUGE`, операции/с | Максимальное количество операций чтения с диска. |
| `monitoring_disk.read_throttler_delay`<br/>`DGAUGE`, миллисекунды | Гистограмма задержки, вносимой в длительность выполнения операций чтения при превышении квоты диска. |
| `monitoring_disk.write_bytes`<br/>`DGAUGE`, байты/с | Среднее количество байт, записанных на диск. |
| `monitoring_disk.write_bytes_burst`<br/>`DGAUGE`, байты/с | Максимальное количество байт, записанных на диск. |
| `monitoring_disk.write_latency`<br/>`DGAUGE`, миллисекунды | Гистограмма распределения времени обработки запросов на запись на диск. |
| `monitoring_disk.write_ops`<br/>`DGAUGE`, операции/с | Среднее количество операций записи на диск. |
| `monitoring_disk.write_ops_burst`<br/>`DGAUGE`, операции/с | Максимальное количество операций записи на диск. |
| `monitoring_disk.write_throttler_delay`<br/>`DGAUGE`, миллисекунды | Гистограмма задержки, вносимой в длительность выполнения операций записи при превышении квоты диска. |


## Метрики RAM {#managed-postgresql-ram-metrics}

Тип потребления пишется в метку `systag`.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. |
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. |
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`. |
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. |
| `mem.free_bytes`<br/>`DGAUGE`, байты | Объем свободной оперативной памяти, доступной для использования, без учета `mem.buffers_bytes` и `mem.cached_bytes`. |
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. |
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. |
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы. |
| `oom_count`<br/>`DGAUGE`, штуки | Количество случаев нехватки памяти. |


## Метрики сети {#managed-postgresql-net-metrics}

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


## Метрики сервиса {#managed-postgresql-metrics}

#### Метрики кластера {#managed-postgresql-cluster-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `backups_done.count`<br/>`DGAUGE`, штуки | Количество успешно выполненных резервных копирований.<br/>Специальная метка `type` — тип резервной копии. Возможные значения:<ul><li>`AUTOMATED` — автоматический.</li><li>`MANUAL` — ручной.</li></ul> |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности хоста на чтение.<br/>Принимает значение `1`, если сервис на хосте доступен на чтение, `0` — если нет. |
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности хоста на запись.<br/>Принимает значение `1`, если сервис на хосте доступен на запись, `0` — если нет. |
| `core_dump.count`<br/>`DGAUGE`, штуки | Количество дампов ядра.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `dbaas_conf.cpu.fraction`<br/>`DGAUGE`, доли | Доля доступных ресурсов CPU, предоставленных сервисом.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `dbaas_conf.cpu.guarantee`<br/>`DGAUGE`, доли | Гарантированная доля ресурсов CPU, выделенная сервисом.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `dbaas_conf.cpu.limit`<br/>`DGAUGE`, доли | Максимально разрешенная доля использования ресурсов CPU.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `dbaas_conf.hosts.ha`<br/>`DGAUGE`, хосты | Количество хостов, настроенных для высокой доступности.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `dbaas_conf.hosts.subcluster.<имя_подкластера>.total`<br/>`DGAUGE`, штуки | Количество хостов в подкластере.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `dbaas_conf.hosts.total`<br/>`DGAUGE`, штуки | Общее количество хостов, используемых сервисом.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `last_automated_backup.timestamp_in_seconds`<br/>`DGAUGE`, секунды | Временная метка последней автоматической резервной копии в формате Unix time. |
| `n_unique_users`<br/>`DGAUGE`, штуки | Количество уникальных пользователей или аккаунтов, взаимодействующих с системой. |
| `n_users`<br/>`DGAUGE`, штуки | Предельное число пользователей. |
| `od_cores.count`<br/>`DGAUGE`, штуки | Количество ядер on-demand.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `pg_log_counter.error_duplicate_table`<br/>`DGAUGE`, штуки | Количество ошибок {{ PG }} из-за попытки создать существующую таблицу. |
| `pg_log_counter.error_query_canceled`<br/>`DGAUGE`, штуки | Количество отмененных запросов {{ PG }}. |
| `pg_log_counter.fatal_connection_failure`<br/>`DGAUGE`, штуки | Количество фатальных ошибок подключения к {{ PG }}. |
| `pg_log_counter.fatal_invalid_password`<br/>`DGAUGE`, штуки | Количество фатальных ошибок {{ PG }} из-за неверного пароля. |
| `postgres.corruption_found`<br/>`DGAUGE`, 0/1 | Признак обнаружения повреждения данных в кластере {{ PG }}<br/>Принимает значение `1`, если повреждение обнаружено, `0` — если нет.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Clog_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш страницы Clog (журнал фиксации транзакций). |
| `postgres.slru_Clog_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц Clog SLRU из диска. |
| `postgres.slru_Clog_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц Clog SLRU на диск. |
| `postgres.slru_CommitTs_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш страницы CommitTs (история коммитов транзакций).<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_CommitTs_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц CommitTs SLRU из диска.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_CommitTs_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц CommitTs SLRU на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_MultiXactMember_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц MultiXactMember.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_MultiXactMember_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц MultiXactMember SLRU из диска.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_MultiXactMember_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц MultiXactMember SLRU на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_MultiXactOffset_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц MultiXactOffset.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_MultiXactOffset_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц MultiXactOffset SLRU из диска. |
| `postgres.slru_MultiXactOffset_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц MultiXactOffset SLRU на диск. |
| `postgres.slru_Notify_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц очереди оповещений.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Notify_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц Notify SLRU из диска.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Notify_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц Notify SLRU на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_other_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц других SLRU-таблиц.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_other_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц других SLRU-таблиц.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul>
`postgres.slru_other_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц других SLRU-таблиц из диска. |
| `postgres.slru_other_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц других SLRU-таблиц на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Serial_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц последовательностей.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Serial_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц Serial SLRU из диска.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Serial_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц Serial SLRU на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Subtrans_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц журнальных данных подчиненных транзакций.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Subtrans_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц Subtrans SLRU из диска.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Subtrans_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц Subtrans SLRU на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Xact_blks_hit`<br/>`DGAUGE`, штуки | Количество попаданий в SLRU-кэш для страниц транзакционного журнала.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Xact_blks_read`<br/>`DGAUGE`, штуки | Количество чтений страниц Xact SLRU из диска.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres.slru_Xact_blks_written`<br/>`DGAUGE`, штуки | Количество записей страниц Xact SLRU на диск.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_archive_lag.logid_lag`<br/>`DGAUGE`, штуки | Отставание по архивируемым WAL-сегментам.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_archive_lag.record_lag`<br/>`DGAUGE`, штуки | Отставание по архивируемым WAL-записям.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_archive_lag.timeline_lag`<br/>`DGAUGE`, штуки | Отставание по архивируемым timeline.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_archive_lag_bytes`<br/>`DGAUGE`, байты | Отставание архива WAL в байтах. |
| `postgres_archive_lag_seconds`<br/>`DGAUGE`, секунды | Отставание архива WAL в секундах. |
| `postgres_conn_aborted`<br/>`DGAUGE`, штуки | Количество аварийно завершенных соединений. |
| `postgres_conn_active`<br/>`DGAUGE`, штуки | Количество активных соединений. |
| `postgres_conn_idle_in_transaction`<br/>`DGAUGE`, штуки | Количество соединений в состоянии idle in transaction (ожидание внутри открытой транзакции). |
| `postgres_conn_idle`<br/>`DGAUGE`, штуки | Количество соединений в состоянии idle (ожидание новых запросов). |
| `postgres_conn_waiting`<br/>`DGAUGE`, штуки | Количество соединений, ожидающих ресурсов. |
| `postgres_max_connections`<br/>`DGAUGE`, штуки | Максимальное количество подключений.  |
| `postgres_oldest_prepared_xact_duration`<br/>`DGAUGE`, секунды | Длительность самой старой подготовленной транзакции. |
| `postgres_oldest_query_duration`<br/>`DGAUGE`, секунды | Длительность самого старого запроса. |
| `postgres_oldest_transaction_duration`<br/>`DGAUGE`, секунды | Длительность самой старой транзакции. |
| `postgres_pg_total_databases_size`<br/>`DGAUGE`, байты | Общий размер всех баз данных. |
| `postgres_role_conn_limit`<br/>`DGAUGE`, штуки | Максимально возможное количество одновременных сессий пользователя.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_role_sessions`<br/>`DGAUGE`, штуки | Количество активных сессий у каждого пользователя.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_role_total_conn_limit`<br/>`DGAUGE`, штуки | Максимально возможное количество одновременных сессий всех пользователей. |
| `postgres_total_connections`<br/>`DGAUGE`, штуки | Количество подключений. |
| `postgres_wait_event_CPU_CPU`<br/>`DGAUGE`, штуки | Количество процессов {{ PG }}, ожидающих процессорное время.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_wait_event_IO_DataFileWrite`<br/>`DGAUGE`, штуки | Количество процессов, ожидающих записи данных в файлы базы.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_wait_event_IO_WALInitSync`<br/>`DGAUGE`, штуки | Количество процессов, ожидающих инициализации и синхронизации WAL-файлов.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_wait_event_IO_WALSync`<br/>`DGAUGE`, штуки | Количество процессов, ожидающих fsync/синхронизации WAL-файлов.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_wait_event_LWLock_WALWrite`<br/>`DGAUGE`, штуки | Количество процессов, ожидающих блокировки LWLock на запись в WAL.<br/>Специальные метки:<ul><li>`database` — имя БД.</li><li>`user` — имя пользователя.</li></ul> |
| `postgres_wal_rate_bytes`<br/>`DGAUGE`, байт/с | Скорость записи в журнал упреждающей записи. |
| `postgres_xid_left_percent`<br/>`DGAUGE`, % | Доля оставшихся счетчиков транзакций. |
| `postgres_xid_left`<br/>`DGAUGE`, штуки | Количество оставшихся счетчиков транзакций. |
| `postgres_xid_used_percent`<br/>`DGAUGE`, % | Доля использованных счетчиков транзакций. |
| `postgres-is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0` — если нет. |
| `postgres-is_primary`<br/>`DGAUGE`, 0/1 | Показатель хоста-мастера.<br/>Принимает значение `1`, если хост БД является мастером, `0` — если нет. |
| `postgres-is_replica`<br/>`DGAUGE`, 0/1 | Показатель хоста-реплики.<br/>Принимает значение `1`, если хост БД является репликой, `0` — если нет. |
| `postgres-log_errors`<br/>`DGAUGE`, сообщений/с| Количество логированных ошибок в секунду. |
| `postgres-log_fatals`<br/>`DGAUGE`, сообщений/с| Количество фатальных логированных ошибок в секунду. |
| `postgres-log_slow_queries`<br/>`DGAUGE`, запросов/с| Количество логированных медленных запросов в секунду. |
| `postgres-log_warnings`<br/>`DGAUGE`, сообщений/с| Количество логированных предупреждений в секунду. |
| `postgres-oldest_inactive_replication_slot_duration`<br/>`DGAUGE`, секунды | Длительность самого старого неактивного слота репликации. |
| `postgres-replica_type`<br/>`DGAUGE`, штуки | Тип текущей реплики {{ PG }}. |
| `postgres-replication_lag`<br/>`DGAUGE`, секунды | Время задержки репликации.<br/>Рассчитывается с точностью до одной секунды. Если задержка меньше одной секунды, ее невозможно отследить с помощью этой метрики. |
| `postgres-role`<br/>`DGAUGE`, штуки | Роль инстанса {{ PG }}. |
| `postgres-some_writable`<br/>`DGAUGE`, 0/1 | Признак, доступна ли база данных для записи. |
| `uptime`<br/>`DGAUGE`, % | Коэффициент отказоустойчивости. |


#### Метрики базы данных {#managed-postgresql-db-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `_pg_database_size`<br/>`DGAUGE`, байты | Размер базы.<br/>Специальная метка `dbname` — имя БД. |
| `<имя_БД>_tup_deleted`<br/>`DGAUGE`, штуки | Количество строк, удаленное запросами в базе данных `<имя_БД>`. |
| `<имя_БД>_tup_fetched`<br/>`DGAUGE`, штуки | Количество строк, извлеченное запросами в базе данных `<имя_БД>`. |
| `<имя_БД>_tup_inserted`<br/>`DGAUGE`, штуки | Количество строк, вставленное запросами в базе данных `<имя_БД>`. |
| `<имя_БД>_tup_returned`<br/>`DGAUGE`, штуки | Количество строк, возвращенное запросами в базе данных `<имя_БД>`. |
| `<имя_БД>_tup_updated`<br/>`DGAUGE`, штуки | Количество строк, измененное запросами в базе данных `<имя_БД>`. |


#### Метрики менеджера подключений {#managed-postgresql-pooler-metrics}

Специальные метки для метрик Odyssey:
* `fqdn` — FQDN хоста.
* `cid` — идентификатор кластера.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `odyssey.cpu_time_iowait`<br/>`DGAUGE`, секунды | Время ожидания операций ввода-вывода процессом Odyssey. |
| `odyssey.cpu_time_system`<br/>`DGAUGE`, секунды | Время, затраченное процессом Odyssey в режиме ядра. |
| `odyssey.cpu_time_user`<br/>`DGAUGE`, секунды | Время, затраченное процессом Odyssey в пользовательском режиме. |
| `odyssey.cpu_usage`<br/>`DGAUGE`, % | Загрузка процессора процессом Odyssey. |
| `odyssey.involuntary_context_switches`<br/>`DGAUGE`, штуки | Количество вынужденных переключений контекста процесса Odyssey. |
| `odyssey.major_faults`<br/>`DGAUGE`, штуки | Количество мажорных сбоев страниц памяти у процесса Odyssey. |
| `odyssey.memory_rss`<br/>`DGAUGE`, байты | Объем оперативной памяти, используемый процессом Odyssey (RSS). |
| `odyssey.memory_usage`<br/>`DGAUGE`, % | Общий объем памяти, используемый процессом Odyssey. |
| `odyssey.memory_vms`<br/>`DGAUGE`, байты | Объем виртуальной памяти процесса Odyssey. |
| `odyssey.minor_faults`<br/>`DGAUGE`, штуки | Количество минорных сбоев страниц памяти у процесса Odyssey. |
| `odyssey.num_fds`<br/>`DGAUGE`, штуки | Количество открытых файловых дескрипторов у процесса Odyssey. |
| `odyssey.running`<br/>`DGAUGE`, 0/1 | Признак работы процесса Odyssey.<br/>Специальные метки:<ul><li>`pgrep`</li><li>`result`</li></ul> |
| `odyssey.voluntary_context_switches`<br/>`DGAUGE`, штуки | Количество добровольных переключений контекста процессом Odyssey. |
| `pooler-avg_query_time`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения одного запроса на каждом из хостов БД. |
| `pooler-avg_xact_time`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения одной транзакции на каждом из хостов БД. |
| `pooler-bytes_recieved`<br/>`DGAUGE`, байты | Объем полученных данных. |
| `pooler-bytes_recieved-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, байты | Объем данных, полученных пользователем `<имя_пользователя>` через базу данных `<имя_БД>`. |
| `pooler-bytes_sent`<br/>`DGAUGE`, байты | Общий объем отправленных данных. |
| `pooler-bytes_sent-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, байты | Объем данных, отправленных пользователем `<имя_пользователя>` через базу данных `<имя_БД>`. |
| `pooler-cl_active`<br/>`DGAUGE`, штуки | Количество активных клиентских подключений. |
| `pooler-cl_waiting`<br/>`DGAUGE`, штуки | Количество клиентских подключений, ожидающих освобождения серверного подключения. |
| `pooler-free_clients`<br/>`DGAUGE`, штуки | Количество оставшихся клиентских подключений в менеджере подключений. |
| `pooler-free_servers`<br/>`DGAUGE`, штуки | Количество оставшихся серверных подключений в менеджере подключений. |
| `pooler-is_alive`<br/>`DGAUGE`, 0/1 | Работоспособность менеджера подключений, для каждого хоста в каждой из ролей: мастера и реплики. |
| `pooler-login_clients`<br/>`DGAUGE`, штуки | Количество совершенных клиентских подключений в менеджере соединений. |
| `pooler-maxwait`<br/>`DGAUGE`, миллисекунды | Максимальное время ожидания подключения клиентом. |
| `pooler-pgbouncer_tcp_connections`<br/>`DGAUGE`, подключений/с | Количество TCP-подключений postgresql. |
| `pooler-postgres_tcp_connections`<br/>`DGAUGE`, подключений/с | Количество TCP-подключений pgbouncer. |
| `pooler-query_0.5`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, медиана. |
| `pooler-query_0.5-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, медиана. |
| `pooler-query_0.75`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.75 процентиль. |
| `pooler-query_0.75-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.75 процентиль. |
| `pooler-query_0.9`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.9 процентиль. |
| `pooler-query_0.9-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.9 процентиль. |
| `pooler-query_0.95`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.95 процентиль. |
| `pooler-query_0.95-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.95 процентиль. |
| `pooler-query_0.99`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.99 процентиль. |
| `pooler-query_0.99-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.99 процентиль. |
| `pooler-query_0.999`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.999 процентиль. |
| `pooler-query_0.999-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.999 процентиль. |
| `pooler-query_0.9999`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 0.9999 процентиль. |
| `pooler-query_0.9999-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.9999 процентиль. |
| `pooler-query_1`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов, 1.0 процентиль. |
| `pooler-query_1-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время выполнения запросов пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 1.0 процентиль. |
| `pooler-query_count`<br/>`DGAUGE`, штуки | Количество запросов, выполняющихся на каждом из хостов БД. |
| `pooler-sv_active`<br/>`DGAUGE`, штуки | Количество активных серверных подключений. |
| `pooler-sv_idle`<br/>`DGAUGE`, штуки | Количество простаивающих серверных подключений. |
| `pooler-sv_login`<br/>`DGAUGE`, штуки | Количество серверных подключений в процессе аутентификации. |
| `pooler-sv_tested`<br/>`DGAUGE`, штуки | Количество проверенных серверных подключений. |
| `pooler-tcp_conn_count`<br/>`DGAUGE`, штуки | Количество TCP-подключений к каждому хосту БД. |
| `pooler-tcp_conn_count-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, штуки | Количество TCP-подключений к каждому хосту БД пользователем `<имя_пользователя>` через базу данных `<имя_БД>`. |
| `pooler-total_query_count`<br/>`DGAUGE`, штуки | Количество выполненных запросов. |
| `pooler-total_tcp_connections`<br/>`DGAUGE`, подключений/с | Количество TCP-подключений postgresql и pgbouncer. |
| `pooler-total_xact_count`<br/>`DGAUGE`, штуки | Количество выполненных транзакций. |
| `pooler-transaction_0.5`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций, медиана. |
| `pooler-transaction_0.5-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, медиана. |
| `pooler-transaction_0.75`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций, 0.75 процентиль. |
| `pooler-transaction_0.75-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.75 процентиль. |
| `pooler-transaction_0.9`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций, 0.9 процентиль. |
| `pooler-transaction_0.9-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.9 процентиль. |
| `pooler-transaction_0.95`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций, 0.95 процентиль. |
| `pooler-transaction_0.95-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.95 процентиль. |
| `pooler-transaction_0.99`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций, 0.99 процентиль. |
| `pooler-transaction_0.99-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.99 процентиль. |
| `pooler-transaction_0.999`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций, 0.999 процентиль. |
| `pooler-transaction_0.999-<имя_БД>-<имя_пользователя>`<br/>`DGAUGE`, миллисекунды | Время обработки транзакций пользователем `<имя_пользователя>` через базу данных `<имя_БД>`, 0.999 процентиль. |
| `pooler-used_clients`<br/>`DGAUGE`, штуки | Количество клиентских подключений в менеджере подключений. |
| `pooler-used_servers`<br/>`DGAUGE`, штуки | Количество серверных подключений в менеджере подключений. |
| `pooler-xact_count`<br/>`DGAUGE`, штуки | Количество транзакций, выполняющихся на каждом из хостов БД. |


#### Метрики vacuum {#managed-postgresql-vacuum}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `postgres_autovacuum.autovacuum_max_workers`<br/>`DGAUGE`, штуки | Максимальное количество autovacuum-процессов. Значение этой метрики управляется настройкой `autovacuum_max_workers`.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_autovacuum.scanned_pct`<br/>`DGAUGE`, % | Процент строк в таблице, просканированных процессом autovacuum. |
| `postgres_autovacuum.scanned_percent`<br/>`DGAUGE`, % | Процент строк в таблице, просканированных процессом autovacuum.<br/>Специальные метки:<ul><li>`dbname` — имя БД.</li><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li><li>`mode` — режим выполнения.</li><li>`rel` — имя таблицы.</li></ul> |
| `postgres_autovacuum.total_regular_vacuums`<br/>`DGAUGE`, штуки | Общее число выполненных регулярных autovacuum-операций.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_autovacuum.total_regular_workers`<br/>`DGAUGE`, штуки | Количество активных autovacuum-процессов. |
| `postgres_autovacuum.total_user_vacuums`<br/>`DGAUGE`, штуки | Общее число пользовательских операций vacuum.<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_autovacuum.total_user_workers`<br/>`DGAUGE`, штуки | Количество активных vacuum-процессов, вручную запущенных пользователем. |
| `postgres_autovacuum.total_wraparound_vacuums`<br/>`DGAUGE`, штуки | Общее число autovacuum-операций по предотвращению wraparound (переполнения xid).<br/>Специальные метки:<ul><li>`cid` — идентификатор кластера.</li><li>`fqdn` — FQDN хоста.</li></ul> |
| `postgres_autovacuum.total_wraparound_workers`<br/>`DGAUGE`, штуки | Количество активных autovacuum-процессов, запущенных для предотвращения [wraparound](https://www.postgresql.org/docs/current/routine-vacuuming.html#VACUUM-FOR-WRAPAROUND). |
| `postgres_autovacuum.vacuumed_pct`<br/>`DGAUGE`, % | Процент строк в таблице, очищенных процессом autovacuum. |
