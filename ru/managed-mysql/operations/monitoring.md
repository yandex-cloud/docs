---
title: Мониторинг состояния кластера MySQL и хостов
description: Вы можете отслеживать состояние кластера {{ mmy-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков.
---

# Мониторинг состояния кластера {{ MY }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mmy-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}**.
      
      На открывшейся странице будут отображены графики, отражающие состояние кластера.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  Для кластера отображаются графики:

  * **Queries per second** — количество пользовательских запросов в секунду для каждого хоста кластера.
  * **Average query time** — среднее время выполнения запросов для каждого хоста кластера.
  * **Slow queries per second** — количество запросов в секунду, выполняющихся дольше, чем указано в параметре [long_query_time](../concepts/settings-list.md#setting-long-query-time). Информация отображается для каждого хоста кластера.
  * **Connections** — количество подключений для каждого хоста кластера.
  * **Threads running** — количество запущенных потоков для каждого хоста кластера.
  * **Disk usage** — использование дискового пространства для каждого хоста и всего кластера.
  * **Is Primary, [boolean]** — показывает, является ли хост мастером.
  * **Is Alive, [boolean]** — показывает доступность каждого хоста кластера.
  * **Replication lag** — время отставания реплики от мастера.
  * **Free space** — свободное место на диске для каждого хоста и всего кластера.
  * **OOM Count** — количество случаев нехватки оперативной памяти на каждом хосте кластера. 

  В блоке **Master overview** отображаются расширенные сведения о мастере:

  * **Query quantiles** — время выполнения запросов по процентилям.
  * **Threads** — количество потоков. Отдельно отображаются:
   
    * **Threads cached** — количество потоков в кеше.
    * **Threads connected** — количество открытых подключений к БД.

      Максимальное количество открытых подключений задается в параметре [max_connections](../concepts/settings-list.md#setting-max-connections).

    * **Threads running** — количество запущенных потоков.

  * **Thread states** — количество потоков в каждом состоянии.
  * **Disk usage** — использование дискового пространства. Отдельно отображаются:
   
    * **data** — объем, занятый данными.
    * **default tablespace** — объем, занятый данными в табличном пространстве.
    * **innodb logs** — объем, занятый логами InnoDB.
    * **relaylogs**, **binlogs** — объем, занятый служебными логами {{ MY }}.
    * **temp tablespace** — объем, занятый данными во временном табличном пространстве.
    * **undo tablespace** — объем, занятый данными в [табличном пространстве отката InnoDB](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
  
  * **InnoDB rows operation** — количество операций со строками в InnoDB.
  * **InnoDB locks** — ожидания блокировок строк в InnoDB. Отдельно отображаются:
    
    * **innodb_row_lock_current_waits** — текущее количество ожиданий блокировок строк;
    * **innodb_row_lock_waits** — количество операций, которым пришлось ждать блокировки строк, в секунду.

  * **Temp tables** — количество созданных временных таблиц и файлов в секунду.
  * **Sorts and joins** — количество операций сортировки и объединения в секунду.
  * **Table cache** — кеширование таблиц. Отдельно отображаются:
   
    * **open_tables** — количество открытых таблиц;
    * **opened_tables** — количество открытых таблиц в секунду;
    * **table_open_cache_hits** — количество успешных попыток поиска в кеше открытых таблиц в секунду;
    * **table_open_cache_misses** — количество неуспешных попыток поиска в кеше открытых таблиц в секунду.

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mmy-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}**.
  1. Перейдите на вкладку **Хосты** и выберите хост.

      На открывшейся странице будут отображены графики, отражающие состояние хостов кластера.

      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  Для хостов отображаются графики:
 
  * **CPU usage** — процент использования CPU по типам потребления.
  * **Memory usage** — использование оперативной памяти по типам потребления.
  * **Disk IOPS** — количество операций чтения и записи в секунду.
  * **Network Packets** — количество отправленных и полученных по сети пакетов в секунду.
  * **Network Bytes** — скорость отправки и получения данных по сети.
  
    Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network Bytes** и **Network Packets**.

  В блоке **MySQL overview** отображаются расширенные сведения о состоянии СУБД на хосте:

  * **Query quantiles** — время выполнения запросов по процентилям.
  * **Queries per second** — количество пользовательских запросов в секунду.
  * **Slow queries per second** — количество запросов в секунду, выполняющихся дольше, чем указано в параметре [long_query_time](../concepts/settings-list.md#setting-long-query-time).
  * **Threads** — количество потоков. Отдельно отображаются:
   
    * **Threads cached** — количество потоков в кеше.
    * **Threads connected** — количество открытых подключений к БД.

      Максимальное количество открытых подключений задается в параметре [max_connections](../concepts/settings-list.md#setting-max-connections).

    * **Threads running** — количество запущенных потоков.

  * **Thread states** — количество потоков в каждом состоянии.
  * **Handlers** — количество обработчиков операций.
  * **Replication lag** — время отставания реплики от мастера.
  * **File IO write bytes** — скорость записи данных по типам файлов.
  * **File IO read bytes** — скорость чтения данных по типам файлов.
  * **Disk usage** — использование дискового пространства. Отдельно отображаются:
   
    * **data** — объем, занятый данными.
    * **default tablespace** — объем, занятый данными в табличном пространстве.
    * **innodb logs** — объем, занятый логами InnoDB.
    * **relaylogs**, **binlogs** — объем, занятый служебными логами {{ MY }}.
    * **temp tablespace** — объем, занятый данными во временном табличном пространстве.
    * **undo tablespace** — объем, занятый данными в [табличном пространстве отката InnoDB](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).

  * **File IO write operations** — количество операций записи по типам файлов в секунду.
  * **File IO read operations** — количество операций чтения по типам файлов в секунду.
  * **Temp tables** — количество созданных временных таблиц и файлов в секунду.
  * **Sorts and joins** — количество операций сортировки и объединения в секунду.
  * **Table cache** — кеширование таблиц. Отдельно отображаются:
   
    * **open_tables** — количество открытых таблиц;
    * **opened_tables** — количество открытых таблиц в секунду;
    * **table_open_cache_hits** — количество успешных попыток поиска в кеше открытых таблиц в секунду;
    * **table_open_cache_misses** — количество неуспешных попыток поиска в кеше открытых таблиц в секунду.

  * **InnoDB rows operation** — количество операций со строками в InnoDB.
  * **InnoDB locks** — ожидания блокировок строк в InnoDB. Отдельно отображаются:
   
    * **innodb_row_lock_current_waits** — текущее количество ожиданий блокировок строк.
    * **innodb_row_lock_waits** — количество операций, которым пришлось ждать блокировки строк, в секунду.

  * **InnoDB lock time** — максимальное время ожидания блокировки строк в InnoDB.
  * **InnoDB cache efficiency** — эффективность буфера InnoDB. Отдельно отображаются:
   
    * **innodb_buffer_pool_reads** — количество операций чтения, в которых InnoDB пришлось обращаться к диску, в секунду;
    * **innodb_buffer_pool_read_requests** — общее количество операций чтения в секунду.

  * **InnoDB data operations** — количество операций InnoDB в секунду. Отдельно отображаются:
   
    * **innodb data fsyncs** — количество операций `fsync()` при сбросе данных на диск;
    * **innodb data reads** — количество операций чтения с диска;
    * **innodb data writes** — количество операций записи на диск.

  * **SemiSync latency** — максимальное время ожидания подтверждения транзакции источником при [полусинхронной репликации](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html).
  * **Inode usage** — использование inodes, в процентах от общего количества.

  В блоке **MySQL overview** → **Disk Metrics Details**:

  * **Disk write latency (percentiles)** — задержка записи на диск по процентилям.
  * **Disk write bytes** — средняя и максимальная скорость записи на диск.
  * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
  * **Disk read latency (percentiles)** — задержка чтения с диска по процентилям.
  * **Disk read bytes** — средняя и максимальная скорость чтения с диска.
  * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
  * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
  * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
  * **Disk used quota** — средний и максимальный процент использования квоты для дисковых операций.

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.

    1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:

        * **{{ mmy-name }} — Cluster Overview** для настройки алертов кластера;
        * **{{ mmy-name }} — Host Overview** для настройки алертов хостов.

    1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).

    1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для срабатывания алерта.

    1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                             | Обозначение               | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`                 |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Задержка репликации                 | `mysql_replication_lag`   | `600`                     | `60`                      |
| Количество работоспособных хостов   | `mysql_is_alive`          | `<количество_хостов> - 2` | `<количество_хостов> - 1` |
| Среднее время выполнения запросов   | `mysql_latency_query_avg` | —                         | `2000`                    |
| Размер использованного хранилища    | `disk.used_bytes`         | 90% от размера хранилища  | 80% от размера хранилища  |
| Утилизация CPU                      | `cpu.idle`                | `10`                      | `20`                      |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-mysql-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

