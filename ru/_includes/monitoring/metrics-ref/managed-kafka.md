Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mkf-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-kafka`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип брокера: `leader`, `follower`, `replica`
subcluster_name | Тип подкластера: `zookeeper_subcluster`, `kafka_subcluster`

## Метрики CPU {#managed-kafka-cpu-metrics}
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

## Метрики диска {#managed-kafka-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |

## Метрики дисковых операций {#managed-kafka-diskio-metrics}
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

## Метрики RAM {#managed-kafka-ram-metrics}
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

## Метрики сети {#managed-kafka-net-metrics}
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

## Метрики сервиса {#managed-kafka-metrics}

#|
|| **Имя**<br/>**Тип, единицы измерения** | **Описание** ||
|| `kafka_controller_ControllerStats_LeaderElectionRateAndTimeMs`<br/>`DGAUGE`, миллисекунды | Смена брокера-лидера за единицу времени, в норме показывает `0`. При проведении технического обслуживания может расти, что не является тревожным сигналом.<br/>Дополнительные метки: `quantile` ||
|| `kafka_controller_KafkaController_ActiveControllerCount`<br/>`DGAUGE`, штуки | Число активных контроллеров. ||
|| `kafka_controller_KafkaController_GlobalTopicCount`<br/>`DGAUGE`, штуки | Количество топиков. ||
|| `kafka_controller_KafkaController_OfflinePartitionsCount`<br/>`DGAUGE`, штуки | Число offline-разделов. ||
|| `kafka_controller_KafkaController_PreferredReplicaImbalanceCount`<br/>`DGAUGE`, штуки | Показатель дисбаланса в желаемом распределении реплик, в норме показывает `0`. ||
|| `kafka_group_topic_partition_lag`<br/>`DGAUGE`, штуки | Отставание сообщений: разница между смещением и общим числом сообщений раздела. ||
|| `kafka_group_topic_partition_offset`<br/>`DGAUGE`, штуки | Текущее смещение группы потребителей в разделе. ||
|| `kafka_log_Log_LogStartOffset`<br/>`DGAUGE`, штуки | Первое смещение в разделе. ||
|| `kafka_log_Log_LogEndOffset`<br/>`DGAUGE`, штуки | Последнее смещение в разделе. ||
|| `kafka_log_Log_Size`<br/>`DGAUGE`, байты | Размер раздела на диске. ||
|| `kafka_host_count`<br/>`DGAUGE`, штуки | Количество хостов в кластере. ||
|| `kafka_is_alive`<br/>`DGAUGE`, `0`/`1` | Показатель работоспособности брокера. Алгоритм вычисления метрики зависит от наличия [высокодоступных топиков (далее HA-топиков)](../../../managed-kafka/concepts/ha-cluster.md#three-or-more-hosts) и состояния их лидеров партиций:
* Если на брокере есть хотя бы один HA-топик, алгоритм проверяет только HA-топики. У каждого HA-топика количество реплик должно быть равно или больше значения `Minimum number of in-sync replicas`.
* Если на брокере отсутствуют HA-топики, алгоритм проверяет все топики. У каждого топика количество реплик должно быть равно или больше значения `Minimum number of in-sync replicas`.

Подробнее о `Minimum number of in-sync replicas` см. в [разделе Настройки {{ KF }}](../../../managed-kafka/concepts/settings-list.md#topic-settings).

Принимает значение `1`, если брокер работает, `0`, если нет. ||
|| `kafka_network_RequestChannel_RequestQueueSize`<br/>`DGAUGE`, штуки | Число запросов в очереди. ||
|| `kafka_network_RequestMetrics_Errors`<br/>`DGAUGE`, штуки | Число ошибок.<br/>Дополнительные метки: `request` ||
|| `kafka_network_RequestMetrics_LocalTimeMs`<br/>`DGAUGE`, миллисекунды | Время обработки запроса брокером-лидером.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_RequestMetrics_MessageConversionsTimeMs`<br/>`DGAUGE`, миллисекунды | Время преобразования формата сообщения.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_RequestMetrics_RemoteTimeMs`<br/>`DGAUGE`, миллисекунды | Время ожидания брокера-фолловера.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_RequestMetrics_RequestQueueTimeMs`<br/>`DGAUGE`, миллисекунды | Время ожидания в очереди запросов.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_RequestMetrics_Requests`<br/>`DGAUGE`, штуки | Число запросов.<br/>Дополнительные метки: `request` ||
|| `kafka_network_RequestMetrics_ResponseQueueTimeMs`<br/>`DGAUGE`, миллисекунды | Время ожидания в очереди на отправку ответа.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_RequestMetrics_ResponseSendTimeMs`<br/>`DGAUGE`, миллисекунды | Время отправки ответа.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_RequestMetrics_TotalTimeMs`<br/>`DGAUGE`, миллисекунды | Суммарное время выполнения запроса.<br/>Дополнительные метки: `request`, `quantile` ||
|| `kafka_network_SocketServer_NetworkProcessorAvgIdlePercent`<br/>`DGAUGE`, % | Средний показатель простоя сетевого процессора. Значения от `0` (все ресурсы задействованы) до `1` (все ресурсы свободны). ||
|| `kafka_server_BrokerTopicMetrics_BytesIn`<br/>`DGAUGE`, байты | Входящий размер данных. ||
|| `kafka_server_BrokerTopicMetrics_BytesOut`<br/>`DGAUGE`, байты | Исходящий размер данных. ||
|| `kafka_server_BrokerTopicMetrics_FailedFetchRequests`<br/>`DGAUGE`, штуки | Число запросов, полученных с ошибкой. ||
|| `kafka_server_BrokerTopicMetrics_FailedProduceRequests`<br/>`DGAUGE`, штуки | Число запросов, обработанных с ошибкой. ||
|| `kafka_server_BrokerTopicMetrics_MessagesIn`<br/>`DGAUGE`, штуки | Число записанных сообщений. ||
|| `kafka_server_BrokerTopicMetrics_ReplicationBytesIn`<br/>`DGAUGE`, байты | Размер реплицированных данных. ||
|| `kafka_server_KafkaRequestHandlerPool_RequestHandlerAvgIdlePercent_count`<br/>`DGAUGE`, % | Средний показатель простоя обработчика запросов. Значения от `0` (все ресурсы заняты) до `1` (все ресурсы свободны). ||
|| `kafka_server_KafkaServer_BrokerState`<br/>`DGAUGE` | Состояние брокера:

* 0: `Not Running`
* 1: `Starting`
* 2: `Recovering from Unclean Shutdown`
* 3: `Running as Broker`
* 4: `Running as Controller`
* 5: `Pending Controlled ShutdownStates`
* 6: `Broker Shutting Down` ||
|| `kafka_server_ReplicaFetcherManager_MaxLag`<br/>`DGAUGE`, штуки | Максимальное отставание репликации сообщений между брокером-фолловером и брокером-лидером.<br/>Дополнительные метки: `clientId`  ||
|| `kafka_server_ReplicaManager_LeaderCount`<br/>`DGAUGE`, штуки | Число разделов, где брокер является лидером. ||
|| `kafka_server_ReplicaManager_OfflineReplicaCount`<br/>`DGAUGE`, штуки | Количество разделов, не имеющих брокера-лидера. Такие разделы не позволяют ни запись, ни чтение сообщений. ||
|| `kafka_server_ReplicaManager_PartitionCount`<br/>`DGAUGE`, штуки | Число разделов для брокера. ||
|| `kafka_server_ReplicaManager_ReassigningPartitions`<br/>`DGAUGE`, штуки | Число разделов в процессе смены лидера. ||
|| `kafka_server_ReplicaManager_UnderMinIsrPartitionCount`<br/>`DGAUGE`, штуки | Количество разделов, у которых число синхронизированных реплик меньше минимального допустимого значения, указанного в настройках. ||
|| `kafka_server_ReplicaManager_UnderReplicatedPartitions`<br/>`DGAUGE`, штуки | Количество разделов, у которых число синхронизированных реплик (in-sync replicas, ISR) меньше фактора репликации. ||
|| `kafka_server_ZooKeeperClientMetrics_ZooKeeperRequestLatencyMs`<br/>`DGAUGE`, миллисекунды | Задержка запросов в {{ ZK }}.<br/>Дополнительные метки: `quantile` ||
|| `kafka_shard_count`<br/>`DGAUGE`, штуки | Количество активных шардов. ||
|| `kafka_topic_partition_high_water_mark`<br/>`DGAUGE`, штуки | Наибольшее смещение для раздела. ||
|| `kafka_topic_partition_low_water_mark`<br/>`DGAUGE`, штуки | Наименьшее смещение для раздела. ||
|#

{% note info %}

В этом разделе приведены только основные метрики {{ mkf-name }}, поставляемые в {{ monitoring-name }}. Подробнее обо всех метриках {{ mkf-name }} можно посмотреть в [официальной документации](https://kafka.apache.org/documentation.html#monitoring).

{% endnote %}

## Прочие метрики {#managed-kafka-other-metrics}

#|
|| **Имя**<br/>**Тип, единицы измерения** | **Описание** ||
|| `can_read`<br/>`DGAUGE`, `0`/`1` | Показатель доступности хоста на чтение. Алгоритм вычисления метрики зависит от наличия [высокодоступных топиков (далее HA-топиков)](../../../managed-kafka/concepts/ha-cluster.md#three-or-more-hosts) и состояния их лидеров партиций:
* Если на хосте есть хотя бы один HA-топик, алгоритм проверяет только HA-топики. У каждого HA-топика лидер партиции должен быть онлайн.
* Если на хосте отсутствуют HA-топики, алгоритм проверяет все топики. У каждого топика лидер партиции должен быть онлайн.

Принимает значение `1`, если хост доступен на чтение, `0`, если нет. ||
|| `can_write`<br/>`DGAUGE`, `0`/`1` | Показатель доступности хоста на запись. Алгоритм вычисления метрики зависит от наличия [высокодоступных топиков (далее HA-топиков)](../../../managed-kafka/concepts/ha-cluster.md#three-or-more-hosts) и состояния их лидеров партиций:
* Если на хосте есть хотя бы один HA-топик, алгоритм проверяет только HA-топики. У каждого HA-топика количество реплик должно быть равно или больше значения `Minimum number of in-sync replicas`.
* Если на хосте отсутствуют HA-топики, алгоритм проверяет все топики. У каждого топика количество реплик должно быть равно или больше значения `Minimum number of in-sync replicas`.

Подробнее о `Minimum number of in-sync replicas` см. в [разделе Настройки {{ KF }}](../../../managed-kafka/concepts/settings-list.md#topic-settings).

Дополнительно проверяется наличие свободного места в [хранилище](../../../managed-kafka/concepts/storage.md). Оно должно быть более 5%. При недостатке места хост недоступен на запись.

Принимает значение `1`, если хост доступен на запись, `0`, если нет. ||
|#

