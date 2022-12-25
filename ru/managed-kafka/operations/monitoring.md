---
title: "Мониторинг состояния {{ KF }}-кластера и хостов"
description: "Из статьи вы узнаете, как осуществлять мониторинг состояния {{ KF }}-кластера и хостов."
---

# Мониторинг состояния кластера {{ KF }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mkf-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Мониторинг**.
  
  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  На странице отображаются следующие графики:

  * **Alive brokers** — количество работоспособных брокеров, для каждого хоста с ролью `KAFKA`.
  * **Bytes In/Out** — скорость записи и скорость чтения сообщений, для каждого хоста с ролью `KAFKA` (байт/с).
  * **Errors** — количество неуспешных запросов по видам ошибок.
  * **Free space** — свободное дисковое пространство, для каждого хоста с ролью `KAFKA` (в байтах).
  * **Messages in** — интенсивность записи сообщений (сообщений/с).
  * **Offline partitions** — показывает значения параметров:
      * `OfflineReplicaCount` — количество разделов, не имеющих брокера-лидера. Такие разделы не позволяют ни запись, ни чтение сообщений.
      * `Underreplicated partitions` — количество разделов, у которых число синхронизированных реплик (in-sync replicas, ISR) меньше фактора репликации.
      * `Under min ISR partitions` — количество разделов, у которых число синхронизированных реплик меньше минимального допустимого значения, указанного в [настройках](../concepts/settings-list.md).
  * **Replicas** — общее количество реплик разделов.
  * **Replicated bytes** — скорость потока данных репликации, для каждого хоста с ролью `KAFKA` (байт/с).
  * **Replication lag** — наибольшее отставание репликации, для каждого хоста с ролью `KAFKA` (в сообщениях).
  * **Request time (0.95 quantile)** — время обработки запросов в квантиле 0.95 по видам запросов.
  * **Requests** — интенсивность запросов по видам (запросов/с).
  * **Top 5 topics by size** — объем данных для каждого из пяти наиболее объемных топиков (в байтах).

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mkf-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты** → **Мониторинги**.
  1. Выберите нужный хост из выпадающего списка.

  На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

  * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
  * **Disk Bytes** — скорость дисковых операций (байт/с).
  * **Disk IOPS** — интенсивность дисковых операций (операций/с).
  * **Memory** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
  * **Network Bytes** — скорость обмена данными по сети (байт/с).
  * **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

{% endlist %}

{% if audience != "internal" %}

## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
  1. В блоке **Сервисные дашборды** выберите **{{ mkf-name }} — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **Продолжить**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `Alarm` и `Warning` для срабатывания алерта.
  1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                            | Обозначение                                             | `Alarm`                    | `Warning`                  |
|------------------------------------|---------------------------------------------------------|----------------------------|----------------------------|
| Количество работоспособных хостов  | `kafka_is_alive`                                        | `<количество хостов> - 2`  | `<количество хостов> - 1`  |
| Состояние репликации разделов      | `kafka_server_ReplicaManager_UnderReplicatedPartitions` | —                          | `Больше 0`                 |
| Число отстающих реплик             | `kafka_server_ReplicaManager_UnderMinIsrPartitionCount` | `Больше 0`                 | —                          |
| Объем использованного хранилища    | `disk.used_bytes`                                       | `90% от размера хранилища` | `80% от размера хранилища` |

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster).

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-kafka).

{% endif %}

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mkf-name }}**.
1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Метрики Solomon {#solomon}

Здесь приведены описания метрик {{ mkf-name }}, которые автоматически собираются в Solomon.

Имя метрики пишется в метку `name`.

{% cut "Общие метки для всех метрик сервиса" %}

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-kafka`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип брокера: `leader`, `follower`, `replica`
subcluster_name | Тип подкластера: `zookeeper_subcluster`, `kafka_subcluster`

{% endcut %}

{% cut "Метрики CPU" %}

Загрузка процессорных ядер.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Метрики диска" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Метрики дисковых операций" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "Метрики RAM" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Метрики сети" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Метрики сервиса" %}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `kafka_controller_ControllerStats_LeaderElectionRateAndTimeMs`<br/>`DGAUGE`, миллисекунды | Смена брокера-лидера за единицу времени, в норме показывает 0. При проведении технического обслуживания может расти, что не является тревожным сигналом.<br/>Дополнительные метки: `quantile` |
| `kafka_controller_KafkaController_ActiveControllerCount`<br/>`DGAUGE`, штуки | Число активных контроллеров. |
| `kafka_controller_KafkaController_GlobalTopicCount`<br/>`DGAUGE`, штуки | Количество топиков. |
| `kafka_controller_KafkaController_OfflinePartitionsCount`<br/>`DGAUGE`, штуки | Число offline разделов. |
| `kafka_controller_KafkaController_PreferredReplicaImbalanceCount`<br/>`DGAUGE`, штуки | Показатель дисбаланса в желаемом распределении реплик, в норме показывает `0`. |
| `kafka_group_topic_partition_lag`<br/>`DGAUGE`, штуки | Отставание сообщений: разница между смещением и общим числом сообщений раздела. |
| `kafka_group_topic_partition_offset`<br/>`DGAUGE`, штуки | Смещение раздела. |
| `kafka_host_count`<br/>`DGAUGE`, штуки | Количество хостов в кластере. |
| `kafka_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности брокера.<br/>Принимает значение `1`, если брокер работает, `0`, если нет. |
| `kafka_network_RequestChannel_RequestQueueSize`<br/>`DGAUGE`, штуки | Число запросов в очереди. |
| `kafka_network_RequestMetrics_Errors`<br/>`DGAUGE`, штуки | Число ошибок.<br/>Дополнительные метки: `request` |
| `kafka_network_RequestMetrics_LocalTimeMs`<br/>`DGAUGE`, миллисекунды | Время обработки запроса брокером-лидером.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_RequestMetrics_MessageConversionsTimeMs`<br/>`DGAUGE`, миллисекунды | Время преобразования формата сообщения.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_RequestMetrics_RemoteTimeMs`<br/>`DGAUGE`, миллисекунды | Время ожидания брокера-фолловера.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_RequestMetrics_RequestQueueTimeMs`<br/>`DGAUGE`, миллисекунды | Время ожидания в очереди запросов.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_RequestMetrics_Requests`<br/>`DGAUGE`, штуки | Число запросов.<br/>Дополнительные метки: `request` |
| `kafka_network_RequestMetrics_ResponseQueueTimeMs`<br/>`DGAUGE`, миллисекунды | Время ожидания в очереди на отправку ответа.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_RequestMetrics_ResponseSendTimeMs`<br/>`DGAUGE`, миллисекунды | Время отправки ответа.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_RequestMetrics_TotalTimeMs`<br/>`DGAUGE`, миллисекунды | Суммарное время выполнения запроса.<br/>Дополнительные метки: `request`, `quantile` |
| `kafka_network_SocketServer_NetworkProcessorAvgIdlePercent`<br/>`DGAUGE`, % | Средний показатель простоя сетевого процессора. Значения от `0` (все ресурсы задействованы) до `1` (все ресурсы свободны). |
| `kafka_server_BrokerTopicMetrics_BytesIn`<br/>`DGAUGE`, байты | Входящий размер данных. |
| `kafka_server_BrokerTopicMetrics_BytesOut`<br/>`DGAUGE`, байты | Исходящий размер данных. |
| `kafka_server_BrokerTopicMetrics_FailedFetchRequests`<br/>`DGAUGE`, штуки | Число запросов, полученных с ошибкой. |
| `kafka_server_BrokerTopicMetrics_FailedProduceRequests`<br/>`DGAUGE`, штуки | Число запросов, обработанных с ошибкой. |
| `kafka_server_BrokerTopicMetrics_MessagesIn`<br/>`DGAUGE`, штуки | Число записанных сообщений. |
| `kafka_server_BrokerTopicMetrics_ReplicationBytesIn`<br/>`DGAUGE`, байты | Размер реплицированных данных. |
| `kafka_server_KafkaRequestHandlerPool_RequestHandlerAvgIdlePercent_count`<br/>`DGAUGE`, % | Средний показатель простоя обработчика запросов. Значения от `0` (все ресурсы заняты) до `1` (все ресурсы свободны). |
| `kafka_server_KafkaServer_BrokerState`<br/>`DGAUGE` | Состояние брокера:<br/>0: `Not Running`<br/>1: `Starting`<br/>2: `Recovering from Unclean Shutdown`<br/>3: `Running as Broker`<br/>4: `Running as Controller`<br/>5: `Pending Controlled ShutdownStates`<br/>6: `Broker Shutting Down` |
| `kafka_server_ReplicaFetcherManager_MaxLag`<br/>`DGAUGE`, штуки | Максимальное отставание репликации сообщений между брокером-фолловером и брокером-лидером.<br/>Дополнительные метки: `clientId`  |
| `kafka_server_ReplicaManager_LeaderCount`<br/>`DGAUGE`, штуки | Число разделов, где брокер является лидером. |
| `kafka_server_ReplicaManager_OfflineReplicaCount`<br/>`DGAUGE`, штуки | Количество разделов, не имеющих брокера-лидера. Такие разделы не позволяют ни запись, ни чтение сообщений. |
| `kafka_server_ReplicaManager_PartitionCount`<br/>`DGAUGE`, штуки | Число разделов для брокера. |
| `kafka_server_ReplicaManager_ReassigningPartitions`<br/>`DGAUGE`, штуки | Число разделов в процессе смены лидера. |
| `kafka_server_ReplicaManager_UnderMinIsrPartitionCount`<br/>`DGAUGE`, штуки | Количество разделов, у которых число синхронизированных реплик меньше минимального допустимого значения, указанного в настройках. |
| `kafka_server_ReplicaManager_UnderReplicatedPartitions`<br/>`DGAUGE`, штуки | Количество разделов, у которых число синхронизированных реплик (in-sync replicas, ISR) меньше фактора репликации. |
| `kafka_server_ZooKeeperClientMetrics_ZooKeeperRequestLatencyMs`<br/>`DGAUGE`, миллисекунды | Задержка запросов в Zookeeper.<br/>Дополнительные метки: `quantile` |

{% endcut %}

{% endif %}