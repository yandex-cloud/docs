[Документация Yandex Cloud](../index.md) > [Yandex MetaData Hub](index.md) > Apache Hive™ Metastore > Метрики Yandex Monitoring

# Справочник метрик Yandex Monitoring

В этом разделе описаны метрики сервиса Apache Hive™ Metastore, поставляемые в [Monitoring](../monitoring/concepts/index.md).

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Apache Hive™ Metastore:

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-metastore`
component | Поставщик метрики: `metastore-server`
cluster_id | Идентификатор кластера
instance | Идентификатор инстанса в кластере


## Метрики сервиса {#managed-metastore-metrics}

#|
|| **Имя**

**Тип, единицы измерения** | **Описание** ||
|| `jvm_gc_collection_seconds.count`
`COUNT`, штуки | Количество сборок мусора JVM.
Дополнительная метка: `gc` — процесс сборки мусора. ||
|| `jvm_gc_collection_seconds.sum`
`SUM`, секунды | Общая продолжительность сборок мусора JVM. ||
|| `jvm_memory_max_bytes.gauge`
`DGAUGE`, байты | Максимальный объем доступной памяти JVM.
Дополнительная метка: `area` — область памяти. ||
|| `jvm_memory_pool_used_bytes.gauge`
`DGAUGE`, байты | Объем использованной памяти из пула JVM.
Дополнительная метка: `pool` — название пула. ||
|| `jvm_memory_used_bytes.gauge`
`DGAUGE`, байты | Объем использованной памяти JVM.
Дополнительная метка: `area` — область памяти. ||
|| `metastore_api_active_calls.gauge`
`DGAUGE`, штуки | Количество запросов к API, которые выполняются в данный момент.
Дополнительная метка: `method` — название метода API Apache Hive™ Metastore. Может принимать следующие значения:
* `total` — все методы.
* `init` — данные не экспортируются. ||
|| `metastore_api_calls_duration_seconds.gauge`
`DGAUGE`, секунды | Время выполнения запросов к API.
Дополнительные метки:
* `method` — название метода API Apache Hive™ Metastore. Может принимать следующие значения:
  * `total` — все методы.
  * `init` — данные не экспортируются.
* `quantile` — процентиль. Может принимать следующие значения:
  * `0.50`,
  * `0.75`,
  * `0.95`,
  * `0.98`,
  * `0.99`,
  * `0.999`. ||
|| `metastore_api_calls_total.counter`
`COUNTER`, штуки | Количество выполненных запросов к API.
Дополнительная метка: `method` — название метода API Apache Hive™ Metastore. Может принимать следующие значения:
* `total` — все методы.
* `init` — данные не экспортируются. ||
|| `metastore_compaction_cycle_duration_seconds.gauge`
`DGAUGE`, секунды | Продолжительность последнего цикла сжатия для процесса `Initiator` или `Cleaner`.
Дополнительная метка: `cycle` — цикл сжатия. ||
|| `metastore_directsql_errors_total.counter`
`COUNTER`, штуки | Количество ошибок при выполнении DirectSQL-запросов, после которых Apache Hive™ Metastore перешел к выполнению запросов через JDO. ||
|| `metastore_jvm_max_fds.gauge`
`DGAUGE`, штуки | Максимальное количество файловых дескрипторов для JVM-процессов. ||
|| `metastore_jvm_open_fds.gauge`
`DGAUGE`, штуки | Количество файловых дескрипторов, которые используются JVM-процессами. ||
|| `metastore_jvm_pause_events_total.counter`
`COUNTER`, штуки | Количество остановок всех потоков JVM, длительность которых превысила заданные пороги.
Дополнительная метка `kind` (тип остановки) может принимать следующие значения:
* `info-threshold` — остановки, длительность которых превысила порог информирования.
* `warn-threshold` — остановки, длительность которых превысила порог предупреждения. ||
|| `metastore_jvm_pause_extra_sleep_seconds.counter`
`COUNTER`, секунды | Общая продолжительность остановок выполнения потоков JVM. ||
|| `metastore_object_operations_total.counter`
`COUNTER`, штуки | Количество операций создания и удаления объектов Apache Hive™ Metastore.
Дополнительные метки:
* `operation` — тип операции. Может принимать следующие значения:
  * `create`,
  * `delete`.
* `object` — тип объекта. Может принимать следующие значения:
  * `dbs`,
  * `tables`,
  * `partitions`. ||
|| `metastore_open_connections.gauge`
`DGAUGE`, штуки | Количество активных подключений к кластеру Apache Hive™ Metastore по протоколу Thrift. ||
|| `metastore_open_transactions.gauge`
`DGAUGE`, штуки | Количество активных [ACID](https://ru.wikipedia.org/wiki/ACID)-транзакций. ||
|| `metastore_total_object_count.gauge`
`DGAUGE`, штуки | Количество баз данных, таблиц и партиций в хранилище кластера Apache Hive™ Metastore.
Дополнительная метка: `object` — тип объекта. Может принимать следующие значения:
* `dbs`,
* `tables`,
* `partitions`. ||
|#

## Метрики пула JDBC-подключений {#managed-metastore-jdbc-conn-pool}

Метрики пула JDBC-подключений доступны в Apache Hive™ Metastore начиная с версии `4.2`.

Общие метки для всех метрик пула JDBC-подключений:

#|
|| Метка | Значение ||
|| pool | Название пула, например `objectstore`, `objectstore-secondary`, `compactor` и т. д. ||
|#

#|
|| **Имя**

**Тип, единицы измерения** | **Описание** ||
|| `metastore_pool_active_connections.gauge`
`DGAUGE`, штуки | Количество используемых JDBC-подключений. ||
|| `metastore_pool_connection_creation_seconds.gauge`
`DGAUGE`, секунды | Процентиль продолжительности создания JDBC-подключения.
Дополнительная метка: `quantile` — процентиль. Может принимать следующие значения:
* `0.50`,
* `0.75`,
* `0.95`,
* `0.98`,
* `0.99`,
* `0.999`. ||
|| `metastore_pool_connection_creation_total.counter`
`COUNTER`, штуки | Общее количество новых JDBC-подключений. ||
|| `metastore_pool_connection_timeouts_total.counter`
`COUNTER`, штуки | Количество запросов, завершившихся таймаутом из-за отсутствия доступных подключений. ||
|| `metastore_pool_idle_connections.gauge`
`DGAUGE`, штуки | Количество простаивающих JDBC-подключений. ||
|| `metastore_pool_max_connections.gauge`
`DGAUGE`, штуки | Максимальный размер пула сконфигурированных JDBC-подключений. ||
|| `metastore_pool_min_connections.gauge`
`DGAUGE`, штуки | Минимальный размер пула сконфигурированных JDBC-подключений. ||
|| `metastore_pool_pending_connections.gauge`
`DGAUGE`, штуки | Количество запросов, для которых еще не выделено JDBC-подключение. ||
|| `metastore_pool_total_connections.gauge`
`DGAUGE`, штуки | Общее количество JDBC-подключений в пуле. ||
|| `metastore_pool_usage_seconds.gauge`
`DGAUGE`, секунды | Процентиль времени, в течение которого приложения удерживают установленное подключение.
Дополнительная метка: `quantile` — процентиль. Может принимать следующие значения:
* `0.50`,
* `0.75`,
* `0.95`,
* `0.98`,
* `0.99`,
* `0.999`. ||
|| `metastore_pool_wait_seconds.gauge`
`DGAUGE`, секунды | Процентиль времени ожидания доступного подключения.
Дополнительная метка: `quantile` — процентиль. Может принимать следующие значения:
* `0.50`,
* `0.75`,
* `0.95`,
* `0.98`,
* `0.99`,
* `0.999`. ||
|| `metastore_pool_wait_total.counter`
`COUNTER`, штуки | Общее количество случаев ожидания подключения. ||
|#


## Метрики CPU {#managed-metastore-cpu-metrics}

Загрузка процессорных ядер.

#|
|| **Имя**

**Тип, единицы измерения** | **Описание** ||
|| `cpu_usage.gauge`
`DGAUGE`, число | Среднее количество vCPU, используемых инстансом. ||
|| `cpu_limit.gauge`
`DGAUGE`, число | Максимально доступное для инстанса количество vCPU ||
|#


## Метрики RAM {#managed-metastore-ram-metrics}

#|
|| **Имя**

**Тип, единицы измерения** | **Описание** ||
|| `memory_usage.gauge`
`DGAUGE`, байты | Использование оперативной памяти инстансом. ||
|| `memory_limit.gauge`
`DGAUGE`, байты | Максимально доступная для инстанса оперативная память. ||
|#

#### Полезные ссылки {#see-also}

* [Мониторинг состояния кластера Apache Hive™ Metastore](operations/metastore/monitoring.md)