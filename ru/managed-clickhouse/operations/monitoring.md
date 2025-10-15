---
title: Мониторинг состояния кластера {{ CH }} и его хостов
description: Из статьи вы узнаете, как осуществлять мониторинг состояния кластера {{ CH }} и его хостов.
---

# Мониторинг состояния кластера {{ CH }} и его хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mch-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}**. 

      На открывшейся странице будут отображены графики работы кластера и хостов {{ CH }}.

  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

{% endlist %}

### Доступные графики {#monitoring-dashboards}

Если кластер состоит из хостов {{ CH }} и [{{ ZK }}](../concepts/replication.md#zk), на странице **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** доступны вкладки:

* **{{ ui-key.yacloud.clickhouse.title_clickhouse }}** — информация о состоянии всего кластера и хостов {{ CH }}.
* **{{ ui-key.yacloud.clickhouse.title_zookeeper }}** — информация о состоянии хостов {{ ZK }}.

Если кластер состоит только из хостов {{ CH }}, на странице **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** доступна вкладка **{{ ui-key.yacloud.clickhouse.switch_list }}** с информацией, соответствующей вкладке **{{ ui-key.yacloud.clickhouse.title_clickhouse }}**.

При любой конфигурации кластера на странице **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}** также доступна вкладка **Хосты** для [просмотра детальной информации о состоянии хостов](#monitoring-hosts).

{% list tabs %}

- {{ ui-key.yacloud.clickhouse.title_clickhouse }}

  На вкладке отображаются графики:

  * В блоке **Summary**:

    * **Select queries** — количество запросов выборки в секунду для кластера.
    * **Insert queries** — количество запросов вставки в секунду для кластера.
    * **Total queries** — общее количество запросов в секунду для кластера.
    * **Inserted data** — скорость вставки данных для кластера.
    * **Read data** — скорость чтения данных для кластера.
    * **Merged data** — скорость слияния данных для кластера.
    * **CPU usage** — количество используемых процессорных ядер в подкластере {{ CH }}.
    * **Memory usage** — использование оперативной памяти в подкластере {{ CH }}.
    * **Disk space usage** — занятое дисковое пространство в подкластере {{ CH }}.

  * В блоке **Queries**:

    * **Select queries per host** — количество запросов выборки в секунду для каждого хоста в кластере.
    * **Insert queries per host** — количество запросов вставки в секунду для каждого хоста в кластере.
    * **Total queries per host** — общее количество запросов в секунду для каждого хоста в кластере.
    * **Failed select queries per host** — процент неуспешных запросов выборки для каждого хоста в подкластере {{ CH }}.
    * **Failed insert queries per host** — процент неуспешных запросов вставки для каждого хоста в подкластере {{ CH }}.
    * **Failed queries per host** — процент неуспешных запросов для каждого хоста в подкластере {{ CH }}.
    * **Average select query time per host** — среднее время выполнения запросов выборки для каждого хоста в подкластере {{ CH }}.
    * **Average insert query time per host** — среднее время выполнения запросов вставки для каждого хоста в подкластере {{ CH }}.
    * **Average query time per host** — среднее время выполнения запросов для каждого хоста в подкластере {{ CH }}.

  * В блоке **Connections and Locks**:

    * **Connections per host** — количество подключений для каждого хоста в кластере.
    * **Active locks per host** — количество активных блокировок для каждого хоста в кластере.
    * **Waiting locks per host** — количество ожидающих блокировок для каждого хоста в кластере.

  * В блоке **Data Traffic**:
    
    * **Read data per host** — скорость чтения данных для каждого хоста в кластере.
    * **Inserted data per host** — скорость вставки данных для каждого хоста в кластере.
    * **Merged data per host** — скорость слияния данных для каждого хоста в кластере.
    * **Read rows per host** — скорость чтения строк в секунду для каждого хоста в кластере.
    * **Inserted rows per host** — скорость вставки строк в секунду для каждого хоста в кластере.
    * **Merged rows per host** — скорость слияния строк в секунду для каждого хоста в кластере.

  * В блоке **Storage**:
    
    * **Disk space usage per host, bytes** — занятое дисковое пространство для каждого хоста в подкластере {{ CH }}.
    * **Disk space usage per host, %** — процент использования дискового пространства для каждого хоста в подкластере {{ CH }}.
    * **Inode usage, %** — процент использованния inode для каждого хоста в подкластере {{ CH }}.
    * **Databases** — количество баз данных для каждого хоста в кластере.
    * **Tables** — количество таблиц для каждого хоста в кластере.
    * **Rows of MergeTree tables** — количество строк в таблицах семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) для каждого хоста в кластере.
    * **Data parts** — количество кусков данных для каждого хоста в кластере.
    * **Detached data parts** — количество отдельных кусков данных для каждого хоста в кластере.

  * В блоке **Replication and Background Data Processing**:

    * **Max replication delay across tables** — максимальная задержка репликации таблиц для каждого хоста в кластере. Значения больше нескольких секунд могут указывать на чрезмерную нагрузку или проблемы в работе репликации.
    * **Replication queue** — размер очереди репликации для каждого хоста в кластере.
    * **Max data parts per partition** — максимальное количество кусков данных в партиции для каждого хоста в кластере. Лимит для этой величины определяется [настройками СУБД](../concepts/settings-list.md#setting-merge-tree). Приближение к лимиту указывает на чрезмерную нагрузку или низкую эффективность вставки данных.
    * **Merges and mutations pool tasks** — количество активных задач слияния и мутаций в фоновом пуле для каждого хоста в подкластере {{ CH }}.
    * **Fetches pool tasks** — количество активных задач извлечения в фоновом пуле для каждого хоста в подкластере {{ CH }}.
    * **Move pool tasks** — количество активных задач перемещения в фоновом пуле для каждого хоста в подкластере {{ CH }}.

  * В блоке **System Resources**:
    
    * **CPU usage per host, cores** — количество используемых процессорных ядер для каждого хоста в подкластере {{ CH }}.
    * **Memory usage per host, bytes** — использование оперативной памяти для каждого хоста в подкластере {{ CH }}.
    * **CPU usage per host, %** — процент использования процессорных ядер для каждого хоста в подкластере {{ CH }}.
    * **Memory usage per host, %** — процент использования оперативной памяти для каждого хоста в подкластере {{ CH }}.
    * **Disk read per host** — скорость чтения с диска для каждого хоста в подкластере {{ CH }}.
    * **Disk write per host** — скорость записи на диск для каждого хоста в подкластере {{ CH }}.
    * **Disk usage per host** — скорость дисковых операций для каждого хоста в подкластере {{ CH }}.
    * **Network data received per host** — скорость приема данных из сети для каждого хоста в подкластере {{ CH }}.
    * **Network data sent per host** — скорость отправки данных в сеть для каждого хоста в подкластере {{ CH }}.
    * **Network usage per host** — скорость обмена данными по сети для каждого хоста в подкластере {{ CH }}.

- {{ ui-key.yacloud.clickhouse.title_zookeeper }}

  На вкладке отображаются графики:

  * **Transactions** — количество транзакций в секунду.
  * **Outstanding requests per {{ ZK }} host** — количество запросов, находящихся в обработке для каждого хоста {{ ZK }}.
  * **Connections per {{ ZK }} host** — количество подключений для каждого хоста {{ ZK }}.
  * **Transactions per {{ CH }} host** — количество транзакций в секунду для каждого хоста {{ CH }}.
  * **Average transaction time per {{ CH }} host** — среднее время транзакции для каждого хоста {{ CH }}. Показывает время, затрачиваемое {{ CH }} на обращения к {{ ZK }}.
  * **Average latency per {{ ZK }} host** — средняя задержка ответа для каждого хоста {{ ZK }}.
  * **Znodes** — количество объектов Znode.
  * **Ephemeral nodes** — количество объектов Ephemeral node.
  * **Watches** — количество объектов Watch.
  
  {% note info %}

  Подробнее об объектах Znode, Ephemeral node и Watch см. в [документации {{ ZK }}](https://zookeeper.apache.org/doc/current/zookeeperOver.html). {#zookeeper-objects}

  {% endnote %}

  * **CPU cores usage** — количество используемых процессорных ядер в подкластере {{ ZK }}.
  * Для мониторинга использования оперативной памяти доступны графики:
      * **Memory usage** для подкластера {{ ZK }};
      * **Memory usage** для каждого хоста в подкластере {{ ZK }}.
  * Для мониторинга занятого дискового пространства доступны графики:
      * **Disk space usage** для подкластера {{ ZK }};
      * **Disk space usage** для каждого хоста в подкластере {{ ZK }}.
  * **CPU cores usage per host** — количество используемых процессорных ядер для каждого хоста.
  * **CPU usage per host** — загрузка процессорных ядер для каждого хоста.
  * **Memory usage per host** — процент использования оперативной памяти для каждого хоста.
  * **Disk space usage per host** — процент использования дискового пространства для каждого хоста.
  * **Disk read per host** — скорость чтения с диска для каждого хоста.
  * **Disk write per host** — скорость записи на диск для каждого хоста.
  * **Disk usage per host** — скорость дисковых операций для каждого хоста.
  * **Network data received per host** — скорость приема данных из сети для каждого хоста.
  * **Network data sent per host** — скорость отправки данных в сеть для каждого хоста.
  * **Network usage per host** — скорость обмена данными по сети для каждого хоста.

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mch-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_monitoring }}**.

  1. Перейдите на вкладку **Хосты** и выберите хост.
    
      Для каждого хоста указан его тип `CLICKHOUSE` или `ZOOKEEPER`.

      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

{% endlist %}

{% list tabs %}

- {{ CH }}

  Для хостов {{ CH }} отображаются графики:

  * **Availability** — доступность хоста.
  * **Queries** — количество запросов в секунду для каждого типа.
  * **Connections** — количество HTTP и TCP подключений.
  * **Failed queries** — процент неуспешных запросов для каждого типа.
  * **Average query time** — среднее время выполнения запросов для каждого типа.
  * **Locks** — количество активных и ожидающих блокировок на чтение и запись.
  * **Processed data** — скорость чтения, вставки и слияния данных.
  * **Processed rows** — скорость чтения, вставки и слияния строк в секунду.
  * **Background tasks** — количество задач слияния и мутаций, извлечения и перемещения в фоновом пуле.
  * **Max replication delay across tables** — максимальная задержка репликации таблиц. Значения больше нескольких секунд могут указывать на чрезмерную нагрузку или проблемы в работе репликации.
  * **Replication queue** — размер очереди репликации.
  * **Max data parts per partition** — максимальное количество кусков данных в партиции. Лимит для этой величины определяется [настройками СУБД](../concepts/settings-list.md#setting-merge-tree). Приближение к лимиту указывает на чрезмерную нагрузку или низкую эффективность вставки данных.
  * **CPU usage, %** — процент использования процессорных ядер.
  * **Memory usage, %** — процент использования оперативной памяти.
  * **Disk space usage, %** — процент использования дискового пространства.
  * **CPU usage, cores** — количество используемых процессорных ядер.
  * **Memory usage, bytes** — использование оперативной памяти.
  * **Disk space usage, bytes** — занятое дисковое пространство.
  * **Disk throughput** — пропускная способность диска.
  * **Disk IOPS** — количество операций чтения и записи для диска.
  * **Network throughput** — пропускная способность сети.

- {{ ZK }}

  Для хостов {{ ZK }} отображаются графики:

  * **Availability** — доступность хоста.
  * **Role** — роль хоста Leader или Follower в подкластере {{ ZK }}.
  * **Objects** — количество объектов Znode, Ephemeral node и Watch.
  * **Connections** — количество активных подключений к хосту.
  * **Outstanding requests** — количество невыполненных запросов к {{ ZK }}.
  * **Request time** — время обработки операций на чтение и запись.
  * **CPU usage, %** — процент использования процессорных ядер.
  * **Memory usage, %** — процент использования оперативной памяти.
  * **Disk space usage, %** — процент использования дискового пространства.
  * **CPU usage, cores** — количество используемых процессорных ядер.
  * **Memory usage, bytes** — использование оперативной памяти.
  * **Disk space usage, bytes** — занятое дисковое пространство.
  * **Disk throughput** — пропускная способность диска.
  * **Disk IOPS** — количество операций чтения и записи для диска.
  * **Network throughput** — пропускная способность сети.

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:
      * **{{ mch-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mch-name }} — ZooKeeper** для настройки алертов хостов ZooKeeper.
      * **{{ mch-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
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

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-clickhouse-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
