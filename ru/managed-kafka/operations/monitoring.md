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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}**.
  
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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Выберите нужный хост из выпадающего списка.

  На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

  * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
  * **Disk Bytes** — скорость дисковых операций (байт/с).
  * **Disk IOPS** — интенсивность дисковых операций (операций/с).
  * **Memory** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
  * **Network Bytes** — скорость обмена данными по сети (байт/с).
  * **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **{{ mkf-name }} — Cluster Overview**.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.monitoring.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                            | Обозначение                                             | `{{ ui-key.yacloud_monitoring.alert.label_alarm }}`                    | `{{ ui-key.yacloud_monitoring.alert.label_warning }}`                  |
|------------------------------------|---------------------------------------------------------|----------------------------|----------------------------|
| Количество работоспособных хостов  | `kafka_is_alive`                                        | `<количество хостов> - 2`  | `<количество хостов> - 1`  |
| Состояние репликации разделов      | `kafka_server_ReplicaManager_UnderReplicatedPartitions` | —                          | `Больше 0`                 |
| Число отстающих реплик             | `kafka_server_ReplicaManager_UnderMinIsrPartitionCount` | `Больше 0`                 | —                          |
| Объем использованного хранилища    | `disk.used_bytes`                                       | 90% от размера хранилища | 80% от размера хранилища |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.label_warning }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.label_alarm }}` — `96636764160` байт (90%).
* `{{ ui-key.yacloud_monitoring.alert.label_warning }}` — `85899345920` байт (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-kafka-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

