---
title: "Мониторинг состояния кластера {{ CH }} и его хостов"
description: "Из статьи вы узнаете, как осуществлять мониторинг состояния кластера {{ CH }} и его хостов."
---

# Мониторинг состояния кластера {{ CH }} и его хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mch-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}**.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  Если в кластере используется механизм репликации и распределения запросов с использованием [{{ ZK }}](../concepts/replication.md#zk), на вкладке **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** появляются две вкладки:

  * **{{ ui-key.yacloud.clickhouse.title_clickhouse }}** — графики, которые показывают работу всего кластера и хостов {{ CH }}.
  * **{{ ui-key.yacloud.clickhouse.title_zookeeper }}** — графики, которые характеризуют работу хостов {{ ZK }}.

  Если репликация не используется или использует механизм [{{ CK }}](../concepts/replication.md#ck), графики с вкладки **{{ ui-key.yacloud.clickhouse.title_clickhouse }}** показываются на общей вкладке **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}**.

{% endlist %}

{% list tabs %}

- {{ ui-key.yacloud.clickhouse.title_clickhouse }}

  * **Active locks per host** — количество активных блокировок, для каждого хоста.
  * **Average insert query time per host** — среднее время исполнения запросов вставки, для каждого хоста.
  * **Average query time per host** — среднее время исполнения запросов, для каждого хоста.
  * **Average select query time per host** — среднее время исполнения запросов выборки, для каждого хоста.
  * **Connections per host** — количество подключений, для каждого хоста.
  * **Data parts** — количество кусков данных.
  * **Databases** — количество баз данных.
  * **CPU cores usage** — количество занятых процессорных ядер.
  * **CPU cores usage per host** — количество занятых процессорных ядер, для каждого хоста.
  * **CPU usage per host** — загрузка процессорных ядер, для каждого хоста.
  * **Disk read per host** — скорость чтения с диска, для каждого хоста (байт/с).
  * **Disk space usage** — занятое дисковое пространство (в байтах).
  * **Disk space usage per host** — занятое дисковое пространство, для каждого хоста (выводится два графика: в байтах и в процентах).
  * **Disk usage per host** — скорость дисковых операций, для каждого хоста (байт/с).
  * **Disk write per host** — скорость записи на диск, для каждого хоста (байт/с).
  * **Failed insert queries per host** — процент неуспешных запросов вставки в секунду, для каждого хоста.
  * **Failed queries per host** — общий процент неуспешных запросов в секунду, для каждого хоста.
  * **Failed select queries per host** — процент неуспешных запросов выборки в секунду, для каждого хоста.
  * **Inode usage** — использованное количество inodes (выводится два графика: в штуках и в процентах).
  * **Insert queries** — количество запросов вставки в секунду.
  * **Insert queries per host** — количество запросов вставки в секунду, для каждого хоста.
  * **Inserted data** — скорость вставки данных (байт/с).
  * **Inserted data per host** — скорость вставки данных, для каждого хоста (байт/с).
  * **Inserted rows per host** — скорость вставки данных, для каждого хоста (строк/с).
  * **Max data parts per partition** — количество кусков данных в партиции, наибольшее среди всех таблиц. Лимит для этой величины определяется [настройками СУБД](../concepts/settings-list#setting-merge-tree). Приближение к лимиту указывает на чрезмерную нагрузку или низкую эффективность вставки данных.
  * **Max replication delay across tables** — задержка репликации, наибольшая среди всех таблиц. Значения больше нескольких секунд могут указывать на чрезмерную нагрузку или проблемы в работе репликации.
  * **Memory usage** — использование оперативной памяти (в байтах).
  * **Memory usage per host** — использование оперативной памяти, для каждого хоста (выводится два графика: в байтах и в процентах).
  * **Merged data** — скорость слияния данных (байт/с).
  * **Merged data per host** — скорость слияния данных, для каждого хоста (байт/с).
  * **Merged rows per host** — скорость слияния данных, для каждого хоста (строк/с).
  * **Network data received per host** — скорость приема данных из сети, для каждого хоста (байт/с).
  * **Network data sent per host** — скорость отправки данных в сеть, для каждого хоста (байт/с).
  * **Network usage per host** — скорость обмена данными по сети, для каждого хоста (байт/с).
  * **Read data** — скорость чтения данных (байт/с).
  * **Read data per host** — скорость чтения данных, для каждого хоста (байт/с).
  * **Read rows per host** — скорость чтения данных, для каждого хоста (строк/с).
  * **Replication queue** — суммарная очередь репликации всех таблиц.
  * **Rows of MergeTree tables** — количество строк в таблицах семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/).
  * **Select queries** — количество запросов выборки в секунду.
  * **Select queries per host** — количество запросов выборки в секунду, для каждого хоста.
  * **Tables** — количество таблиц.
  * **Total queries** — общее количество запросов в секунду.
  * **Total queries per host** — общее количество запросов в секунду, для каждого хоста.
  * **Waiting locks per host** — количество ожидающих блокировок, для каждого хоста.

- {{ ui-key.yacloud.clickhouse.title_zookeeper }}

  * **Average latency per ZooKeeper host** — средняя задержка ответа, для каждого хоста ZooKeeper.
  * **Average transaction time per ClickHouse host** — среднее время транзакции, для каждого хоста ClickHouse. Характеризует время, затрачиваемое ClickHouse на обращения к ZooKeeper.
  * **Connections per ZooKeeper host** — количество подключений, для каждого хоста ZooKeeper.
  * **CPU cores usage** — количество занятых процессорных ядер.
  * **CPU cores usage per host** — количество занятых процессорных ядер, для каждого хоста.
  * **CPU usage per host** — загрузка процессорных ядер, для каждого хоста.
  * **Disk read per host** — скорость чтения с диска, для каждого хоста (байт/с).
  * **Disk space usage** — занятое дисковое пространство (в байтах). Выводится два графика: для каждого хоста и для всех хостов.
  * **Disk space usage per host** — использование дискового пространства, для каждого хоста (в процентах).
  * **Disk usage per host** — скорость дисковых операций, для каждого хоста (байт/с).
  * **Disk write per host** — скорость записи на диск, для каждого хоста (байт/с).
  * **Ephemeral nodes** — количество объектов Ephemeral node.

  {% note info %}

  Подробнее об объектах Znode, Ephemeral node и Watch см. в [документации {{ ZK }}](https://zookeeper.apache.org/doc/current/zookeeperOver.html). {#zookeeper-objects}

  {% endnote %}

  * **Memory usage** — использование оперативной памяти (в байтах).
  * **Memory usage per host** — использование оперативной памяти, для каждого хоста (выводится два графика: в байтах и в процентах).
  * **Network data received per host** — скорость приема данных из сети, для каждого хоста (байт/с).
  * **Network data sent per host** — скорость отправки данных в сеть, для каждого хоста (байт/с).
  * **Network usage per host** — скорость обмена данными по сети, для каждого хоста (байт/с).
  * **Outstanding requests per ZooKeeper host** — количество запросов, находящихся в обработке, для каждого хоста ZooKeeper.
  * **Transactions** — количество транзакций в секунду.
  * **Transactions per ClickHouse host** — количество транзакций в секунду, для каждого хоста ClickHouse.
  * **Watches** — количество объектов Watch.
  * **Znodes** — количество объектов Znode.

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mch-name }}:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Выберите нужный хост из выпадающего списка. Возле имени хоста будет показан его тип: `CLICKHOUSE` или `ZOOKEEPER`.

  На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

  * **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **Idle** уменьшается.
  * **Disk read/write bytes** — скорость дисковых операций (байт/с).
  * **Disk IOPS** — интенсивность дисковых операций (операций/с).
  * **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра **Free** уменьшается, остальные — растут.
  * **Network bytes** — скорость обмена данными по сети (байт/с).
  * **Network packets** — интенсивность обмена данными по сети (пакетов/с).

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:
      * **{{ mch-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mch-name }} — ZooKeeper** для настройки алертов хостов ZooKeeper.
      * **{{ mch-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.monitoring.button_create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов [см. в документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` и `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                      | Обозначение                                        | `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`                      | `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`                    |
|----------------------------------------------|:--------------------------------------------------:|:----------------------------:|:----------------------------:|
| Максимальное число кусков данных в разделе   | `ch_system_async_metrics_MaxPartCountForPartition` | `250`                        | `150`                        |
| Количество запросов, завершившихся с ошибкой | `ch_system_events_FailedQuery_rate`                | 20% от общего числа запросов | 10% от общего числа запросов |
| Размер использованного хранилища             | `disk.used_bytes`                                  | 95% от размера хранилища     | 80% от размера хранилища     |
| Количество работоспособных хостов            | `is_alive`                                         | `<количество_хостов> - 2`    | `<количество_хостов> - 1`    |

Чтобы определить пороговые значения метрики `ch_system_events_FailedQuery_rate`, используйте значение показателя `Total queries` [для кластера](#monitoring-cluster).

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` и `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}` — `102005473280` байт (95%).
* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}` — `85899345920` байт (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-clickhouse).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

