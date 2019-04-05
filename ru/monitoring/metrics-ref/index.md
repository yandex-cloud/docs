---
editable: false
---

# Справочник метрик

Сервис [!KEYREF monitoring-full-name] собирает указанные метрики раз в минуту.

Имя метрики пишется в метку `name`.

## Сервис Compute Cloud

Имя<br/>Тип | Описание
----- | -----
`cpu_usage`<br/>`GAUGE`| Загрузка процессора ВМ (в процентах). Показывает отношение процессорного времени к сумме общедоступного процессорного времени (доля * количество ядер). От 0 до 2000
`memory_usage`<br/>`GAUGE` | Количество использованной памяти ВМ (в процентах)
`disk_read_bytes`<br/>`GAUGE` | Количество байт, прочитанных с диска ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_write_bytes`<br/>`GAUGE` | Количество байт, записанных на диск ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_read_ops`<br/>`GAUGE` | Количество операций чтения на диске ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_write_ops`<br/>`GAUGE` | Количество операций записи на диске ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_read_ops_failed`<br/>`GAUGE` | Количество ошибочных операций чтения на диске ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_write_ops_failed`<br/>`GAUGE` | Количество ошибочных операций записи на диске ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_read_latency`<br/>`HIST` | Время обработки запроса на чтение с диска ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_write_latency`<br/>`HIST` | Время обработки запроса на запись на диск ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_flush_ops_failed`<br/>`GAUGE` | Количество запросов на сброс дискового кэша ВМ.<br/><br/>Дополнительные метки: `device_id`
`disk_flush_latency`<br/>`HIST` | Время обработки запроса на сброс дискового кэша ВМ.<br/><br/>Дополнительные метки: `device_id`

> Значение обязательной метки `service="vm"`.

Подробнее о сервисе в документации [[!KEYREF compute-full-name]](../../compute/).


## Сервис Managed Service for PostgreSQL
Имя<br/>Тип| Описание
----- | -----
`pooler-query_count`<br/>`GAUGE` | Количество запросов, выполняющихся на каждом из хостов БД.<br/><br/>Дополнительные метки: `host`
`pooler-avg_query_time`<br/>`GAUGE` | Среднее время выполнения одного запроса на каждом из хостов БД (в миллисекундах).<br/><br/>Дополнительные метки: `host`
`pooler-xact_count`<br/>`GAUGE`  | Количество транзакций, выполняющихся на каждом из хостов БД.<br/><br/>Дополнительные метки: `host`
`pooler-avg_xact_time`<br/>`GAUGE` | Среднее время выполнения одной транзакции на каждом из хостов БД (в миллисекундах).<br/><br/>Дополнительные метки: `host`
`postgres_conn_active`<br/>`GAUGE` | Количество соединений с БД. Тип соединения: `active`
`postgres_conn_waiting`<br/>`GAUGE` | Количество соединений с БД. Тип соединения: `waiting`
`postgres_conn_idle`<br/>`GAUGE` | Количество соединений с БД. Тип соединения: `idle`
`postgres_conn_idle_in_transaction`<br/>`GAUGE` | Количество соединений с БД. Тип соединения: `idle_in_transaction`
`postgres_conn_aborted`<br/>`GAUGE` | Количество соединений с БД. Тип соединения: `aborted`
`pooler-free_servers`<br/>`GAUGE` | Количество соединений от клиентов в менеджере соединений free/used-clients и количество соединений от менеджера соединений до инстансов БД
`pooler-free_clients`<br/>`GAUGE` | Количество соединений от клиентов в менеджере соединений free/used-clients и количество соединений от менеджера соединений до инстансов БД
`pooler-used_servers`<br/>`GAUGE` | Количество соединений от клиентов в менеджере соединений free/used-clients и количество соединений от менеджера соединений до инстансов БД
`pooler-used_clients`<br/>`GAUGE` | Количество соединений от клиентов в менеджере соединений free/used-clients и количество соединений от менеджера соединений до инстансов БД
`disk-free_bytes_/var/lib/postgresql`<br/>`GAUGE` | Свободное место на диске мастера БД (в байтах). <br/>Включает в себя WAL и временные файлы
`disk-used_bytes_/var/lib/postgresql`<br/>`GAUGE` | Занятое место на диске мастера БД (в байтах). <br/>Включает в себя WAL и временные файлы
`postgres-replication_lag`<br/>`GAUGE` | Отставание репликации данных на диске реплики (в секундах).<br/><br/>Дополнительные метки: `host`

> Значение обязательной метки `service="mdb_postgresql_cluster"`.

Подробнее о сервисе в документации [[!KEYREF managed-postgresql-full-name]](../../managed-postgresql/).

## Сервис Managed Service for MongoDB
Имя<br/>Тип<br/>Дополнительные метки | Описание
----- | -----
`server_status_admin_connections.available`<br/>`GAUGE` | Количество доступных соединений с БД
`server_status_admin_connections.current`<br/>`GAUGE` | Количество текущих соединений с БД
`disk-free_bytes_/var/lib/mongodb`<br/>`GAUGE` | Свободное место на диске мастера БД
`disk-used_bytes_/var/lib/mongodb`<br/>`GAUGE` | Занятое место на диске мастера БД
`server_status_admin_opcounters.command_rate`<br/>`RATE` | Количество выполняющихся операций `command` на мастере БД
`server_status_admin_opcounters.delete_rate`<br/>`RATE` | Количество выполняющихся операций `delete` на мастере БД
`server_status_admin_opcounters.getmore_rate`<br/>`RATE` | Количество выполняющихся операций `getmore` на мастере БД
`server_status_admin_opcounters.insert_rate`<br/>`RATE` | Количество выполняющихся операций `insert` на мастере БД
`server_status_admin_opcounters.query_rate`<br/>`RATE` | Количество выполняющихся операций `query` на мастере БД
`server_status_admin_opcounters.update_rate`<br/>`RATE` | Количество выполняющихся операций `update` на мастере БД 
`server_status_admin_opcountersRepl.command_rate`<br/>`RATE` | Количество выполняющихся операций `command` на репликах БД
`server_status_admin_opcountersRepl.delete_rate`<br/>`RATE` | Количество выполняющихся операций `delete` на репликах БД
`server_status_admin_opcountersRepl.getmore_rate`<br/>`RATE` | Количество выполняющихся операций `getmore` на репликах БД
`server_status_admin_opcountersRepl.insert_rate`<br/>`RATE` | Количество выполняющихся операций `insert` на репликах БД
`server_status_admin_opcountersRepl.query_rate`<br/>`RATE` | Количество выполняющихся операций `insert` на репликах БД
`server_status_admin_opcountersRepl.update_rate`<br/>`RATE` | Количество выполняющихся операций `update` на репликах БД
`db_stats_admin_dataSize`<br/>`GAUGE` | Объем данных для каждой из коллекций БД (в байтах) ???
`db_stats_config_dataSize`<br/>`GAUGE` | Объем данных для каждой из коллекций БД (в байтах)
`db_stats_local_dataSize`<br/>`GAUGE` | Объем данных для каждой из коллекций БД (в байтах)
`db_stats_admin_indexSize`<br/>`GAUGE` | Объем индексов для каждой из коллекций БД (в байтах) ???
`db_stats_config_indexSize`<br/>`GAUGE` | Объем индексов для каждой из коллекций БД (в байтах)
`db_stats_local_indexSize`<br/>`GAUGE` | Объем индексов для каждой из коллекций БД (в байтах)

> Значение обязательной метки `service="mdb_mongodb_cluster"`.

Подробнее о сервисе в документации [[!KEYREF managed-mongodb-full-name]](../../managed-mongodb/).

## Сервис Managed Service for ClickHouse
Имя<br/>Тип<br/>Дополнительные метки | Описание
----- | -----
`ch_system_metrics_HTTPConnection`<br/>`GAUGE` | Количество соединений с БД по HTTP
`ch_system_metrics_TCPConnection`<br/>`GAUGE` | Количество соединений с БД по TCP
`ch_system_metrics_InterserverConnection`<br/>`GAUGE` | Количество соединений с БД по InterserverConnection
`ch_system_events_InsertQuery_inc`<br/>`ch_system_events_SelectQuery_inc`<br/>`GAUGE` | Количество запросов `Insert`, выполняющихся в БД
`ch_system_events_SelectQuery_inc`<br/>`GAUGE` | Количество запросов `Select`, выполняющихся в БД
`ch_system_query_log_avg_query_ms`<br/>`GAUGE` | Средняя длительность выполнения одного запроса на каждом из хостов БД (в миллисекундах)
`ch_system_metrics_RWLockActiveReaders`<br/>`GAUGE` | Количество потоков, которые находятся в состоянии чтение
`ch_system_metrics_RWLockActiveWriters`<br/>`GAUGE` | Количество потоков, которые находятся в состоянии запись
`ch_system_metrics_RWLockWaitingReaders`<br/>`GAUGE` | Количество потоков, которые находятся в состоянии ожидание блокировки на чтение
`ch_system_metrics_RWLockWaitingWriters`<br/>`GAUGE` | Количество потоков, которые находятся в состоянии ожидание блокировки на запись
`disk-free_bytes_/var/lib/clickhouse`<br/>`GAUGE` | Свободное место на каждом из хостов БД (в байтах).<br/><br/>Дополнительные метки: `host`
`disk-used_bytes_/var/lib/clickhouse`<br/>`GAUGE` | Используемое место на каждом из хостов БД (в байтах).<br/><br/>Дополнительные метки: `host`
`ch_system_query_log_read_bytes_inc`<br/>`GAUGE` | Число прочитанных байт на все запросы
`ch_system_query_log_written_bytes_inc`<br/>`GAUGE` | Число записанных байт на все запросы
`ch_system_query_log_result_bytes_inc`<br/>`GAUGE` | Число возвращенных байт на все запросы
`ch_system_query_log_read_rows_inc`<br/>`GAUGE` | Число прочитанных строк на все запросы
`ch_system_query_log_written_rows_inc`<br/>`GAUGE` | Число записанных строк на все запросы
`ch_system_query_log_result_rows_inc`<br/>`GAUGE` | Число возвращенных строк на все запросы
`ch_system_events_ZooKeeperCreate_inc`<br/>`GAUGE` | Количество операций `create`, которые выполняются в zookeeper
`ch_system_events_ZooKeeperExceptions_inc`<br/>`GAUGE` | Количество операций `exceptions`, которые выполняются в zookeeper
`ch_system_events_ZooKeeperExists_inc`<br/>`GAUGE` | Количество операций `exists`, которые выполняются в zookeeper
`ch_system_events_ZooKeeperGetChildren_inc`<br/>`GAUGE` | Количество операций `getChildren`, которые выполняются в zookeeper
`ch_system_events_ZooKeeperInit_inc`<br/>`GAUGE` | Количество операций `init`, которые выполняются в zookeeper
`ch_system_events_ZooKeeperTransactions_inc`<br/>`GAUGE` | Количество операций `transactions`, которые выполняются в zookeeper
`ch_replication-max_absolute_delay`<br/>`GAUGE` | Максимальное время задержки репликации (в секундах)
`ch_replication-median_absolute_delay`<br/>`GAUGE` | Медианное время задержки репликации (в секундах)
`ch_replication-future_parts`<br/>`GAUGE` | Количество реплицируемых блоков в данный момент на стадии `future_parts`
`ch_replication-parts_to_check`<br/>`GAUGE` | Количество реплицируемых блоков в данный момент на стадии `parts_to_check`
`ch_replication-inserts_in_queue`<br/>`GAUGE` | Количество реплицируемых блоков в данный момент на стадии `inserts_in_queue`
`ch_replication-merges_in_queue`<br/>`GAUGE` | Количество реплицируемых блоков в данный момент на стадии `merges_in_queue`

> Значение обязательной метки `service="mdb_clickhouse_cluster"`.

Подробнее о сервисе в документации [[!KEYREF managed-clickhouse-full-name]](../../managed-clickhouse/).

## Сервис Managed Service for MySQL<sup>®</sup>
Имя<br/>Тип| Описание
----- | -----
`mysql_Threads_running`<br/>`GAUGE` | Количество потоков в БД, которые запущены в данный момент
`mysql_Threads_connected`<br/>`GAUGE` | Количество потоков в БД ??? число подключений (с учетом репликации)
`mysql_Threads_cached`<br/>`GAUGE` | Количество потоков в БД ???
`mysql_Queries_rate`<br/>`RATE` |  Количество запросов в секунду
`mysql_Slow_queries_rate`<br/>`RATE` | Количество медленных запросов в секунду
`mysql_is_alive`<br/>`GAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД функционирует, `0`, если нет.<br/><br/>Дополнительные метки: `host`
`disk-used_bytes`<br/>`GAUGE` | Используемое место на каждом из хостов БД (в байтах).<br/><br/>Дополнительные метки: `host`
`disk-free_bytes`<br/>`GAUGE` | Свободное место на каждом из хостов БД (в байтах).<br/><br/>Дополнительные метки: `host`

> Значение обязательной метки `service="mdb_mysql_cluster"`.

Подробнее о сервисе в документации [[!KEYREF managed-mysql-full-name]](../../managed-mysql/).

## Сервис Managed Service for Redis
Имя<br/>Тип| Описание
----- | -----
`redis_connected_clients`<br/>`GAUGE` | Количество клиентов, подключенных к каждому хосту БД.<br/><br/>Дополнительные метки: `host`
`redis_used_memory`<br/>`GAUGE` | Потребление оперативной памяти на каждом из хостов БД (в байтах).<br/><br/>Дополнительные метки: `host`
`redis_is_alive`<br/>`GAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД функционирует, `0`, если нет.<br/><br/>Дополнительные метки: `host`
`redis_instantaneous_ops_per_sec`<br/>`RATE` | Количество запросов в секунду.<br/><br/>Дополнительные метки: `host`
`redis_mem_fragmentation_ratio`<br/>`GAUGE` | Отношение используемой памяти к запрошенной.<br/>Принимает значение меньше `1`, если памяти не хватает.<br/><br/>Дополнительные метки: `host`
`redis_is_master`<br/>`GAUGE` | Показатель типа хоста.<br/>Принимает значение `1`, если хост является мастер-сервером БД, `0`, если нет.<br/><br/>Дополнительные метки: `host`
`redis_hit_rate`<br/>`GAUGE` | Доля запросов, данные для которых [!KEYREF managed-redis-full-name] находит в кэше.<br/><br/>Дополнительные метки: `host`

> Значение обязательной метки `service="mdb_redis_cluster"`.

Подробнее о сервисе в документации [[!KEYREF managed-redis-full-name]](../../managed-redis/).