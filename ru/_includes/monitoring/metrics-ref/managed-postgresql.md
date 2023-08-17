## Сервис {{ mpg-full-name }} {#managed-postgresql}

Общие метки для всех метрик сервиса {{ mpg-full-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-postgresql`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `primary`, `replica`
subcluster_name | Имя подкластера

### Метрики CPU {#managed-postgresql-cpu-metrics}
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

### Метрики диска {#managed-postgresql-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |

### Метрики дисковых операций {#managed-postgresql-diskio-metrics}
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

### Метрики RAM {#managed-postgresql-ram-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, байты | Гарантированный размер оперативной памяти. | 
| `mem.limit_bytes`<br/>`DGAUGE`, байты | Предельный размер оперативной памяти. | 
| `mem.active_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `active`. | 
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`.  | 
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`.  | 
| `mem.free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `free`.  |
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`.  | 
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`.  | 
| `mem.used_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `used`.  | 

### Метрики сети {#managed-postgresql-net-metrics}
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

### Метрики сервиса {#managed-postgresql-metrics}
##### Метрики кластера {#managed-postgresql-cluster-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности на чтение.<br/>Принимает значение `1`, если кластер доступен на чтение, `0`, если нет.  | 
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности на запись.<br/>Принимает значение `1`, если кластер доступен на запись, `0`, если нет.  |
| `postgres-is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `postgres-is_primary`<br/>`DGAUGE`, 0/1 | Показатель хоста-мастера.<br/>Принимает значение `1`, если хост БД является мастером, `0`, если нет. | 
| `postgres-is_replica`<br/>`DGAUGE`, 0/1 | Показатель хоста-реплики.<br/>Принимает значение `1`, если хост БД является репликой, `0`, если нет. | 
| `postgres-log_errors`<br/>`DGAUGE`, сообщений/с| Количество логированных ошибок в секунду. | 
| `postgres-log_fatals`<br/>`DGAUGE`, сообщений/с| Количество фатальных логированных ошибок в секунду. | 
| `postgres-log_slow_queries`<br/>`DGAUGE`, запросов/с| Количество логированных медленных запросов в секунду. | 
| `postgres-log_warnings`<br/>`DGAUGE`, сообщений/с| Количество логированных предупреждений в секунду. | 
| `postgres-replication_lag`<br/>`DGAUGE`, секунды | Время задержки репликации. | 
| `postgres_max_connections`<br/>`DGAUGE`, штуки | Максимальное количество подключений.  |
| `postgres_total_connections`<br/>`DGAUGE`, штуки | Количество подключений. | 

##### Метрики базы данных {#managed-postgresql-db-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `_pg_database_size`<br/>`DGAUGE`, байты | Размер базы. <br/>Дополнительные метки: `dbname`| 
| `<database>_conn_aborted`<br/>`DGAUGE`, штуки | Количество соединений с базой данных `<database>`. Статус соединения: `aborted`. | 
| `<database>_conn_active`<br/>`DGAUGE`, штуки | Количество соединений с базой данных `<database>`. Статус соединения: `active`. | 
| `<database>_conn_idle`<br/>`DGAUGE`, штуки | Количество соединений с базой данных `<database>`. Статус соединения: `idle`. | 
| `<database>_conn_idle_in_transaction`<br/>`DGAUGE`, штуки | Количество соединений с базой данных `<database>`. Статус соединения: `idle_in_transaction`. | 
| `<database>_conn_waiting`<br/>`DGAUGE`, штуки | Количество соединений с базой данных `<database>`. Статус соединения: `waiting`. | 
| `<database>_tup_deleted`<br/>`DGAUGE`, штуки | Количество строк, удаленное запросами в этой базе данных `<database>`. | 
| `<database>_tup_fetched`<br/>`DGAUGE`, штуки | Количество строк, извлеченное запросами в этой базе данных `<database>`. | 
| `<database>_tup_inserted`<br/>`DGAUGE`, штуки | Количество строк, вставленное запросами в этой базе данных `<database>`. | 
| `<database>_tup_returned`<br/>`DGAUGE`, штуки | Количество строк, возвращенное запросами в этой базе данных `<database>`. | 
| `<database>_tup_updated`<br/>`DGAUGE`, штуки | Количество строк, измененное запросами в этой базе данных `<database>`. |

##### Метрики пулера соединений {#managed-postgresql-pooler-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `pooler-avg_query_time`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения одного запроса на каждом из хостов БД. | 
| `pooler-avg_xact_time`<br/>`DGAUGE`, миллисекунды | Среднее время выполнения одной транзакции на каждом из хостов БД. | 
| `pooler-bytes_recieved`<br/>`DGAUGE`, байты | Объем полученных данных. | 
| `pooler-bytes_sent`<br/>`DGAUGE`, байты | Объем отправленных данных. | 
| `pooler-db_name_tcp_connections`<br/>`DGAUGE`, штуки | Количество TCP-подключений к БД. | 
| `pooler-free_clients`<br/>`DGAUGE`, штуки | Количество оставшихся клиентских подключений в менеджере соединений. | 
| `pooler-free_servers`<br/>`DGAUGE`, штуки | Количество оставшихся серверных подключений в менеджере соединений. | 
| `pooler-is_alive`<br/>`DGAUGE`, 0/1 | Работоспособность пулера, для каждого хоста в каждой из ролей: мастера и реплики. |
| `pooler-pgbouncer_tcp_connections`<br/>`DGAUGE`, подключений/с | Количество TCP-подключений postgresql. | 
| `pooler-postgres_tcp_connections`<br/>`DGAUGE`, подключений/с | Количество TCP-подключений pgbouncer. | 
| `pooler-query_0.5`<br/>`DGAUGE`, секунды | Время выполнения запросов, медиана. | 
| `pooler-query_0.75`<br/>`DGAUGE`, секунды | Время выполнения запросов, 0.75 процентиль. | 
| `pooler-query_0.9`<br/>`DGAUGE`, секунды | Время выполнения запросов, 0.9 процентиль. | 
| `pooler-query_0.95`<br/>`DGAUGE`, секунды | Время выполнения запросов, 0.95 процентиль. | 
| `pooler-query_0.99`<br/>`DGAUGE`, секунды | Время выполнения запросов, 0.99 процентиль. | 
| `pooler-query_0.999`<br/>`DGAUGE`, секунды | Время выполнения запросов, 0.999 процентиль. | 
| `pooler-query_count`<br/>`DGAUGE`, штуки | Количество запросов, выполняющихся на каждом из хостов БД. | 
| `pooler-tcp_conn_count`<br/>`DGAUGE`, штуки | Количество TCP-подключений к каждому хосту БД. | 
| `pooler-tcp_conn_count-db_name-username`<br/>`DGAUGE`, штуки | Количество TCP-подключений каждого пользователя к БД. | 
| `pooler-total_tcp_connections`<br/>`DGAUGE`, подключений/с | Количество TCP-подключений postgresql и pgbouncer. | 
| `pooler-transaction_0.5`<br/>`DGAUGE`, секунды | Время обработки транзакций, медиана. | 
| `pooler-transaction_0.75`<br/>`DGAUGE`, секунды | Время обработки транзакций, 0.75 процентиль. | 
| `pooler-transaction_0.9`<br/>`DGAUGE`, секунды | Время обработки транзакций, 0.9 процентиль. | 
| `pooler-transaction_0.95`<br/>`DGAUGE`, секунды | Время обработки транзакций, 0.95 процентиль. | 
| `pooler-transaction_0.99`<br/>`DGAUGE`, секунды | Время обработки транзакций, 0.99 процентиль. | 
| `pooler-transaction_0.999`<br/>`DGAUGE`, секунды | Время обработки транзакций, 0.999 процентиль. | 
| `pooler-used_clients`<br/>`DGAUGE`, штуки | Количество клиентских подключений в менеджере соединений. | 
| `pooler-used_servers`<br/>`DGAUGE`, штуки | Количество серверных подключений в менеджере соединений. | 
| `pooler-xact_count`<br/>`DGAUGE`, штуки | Количество транзакций, выполняющихся на каждом из хостов БД. |

Подробнее о сервисе в документации [{{ mpg-full-name }}](../../../managed-postgresql/).
