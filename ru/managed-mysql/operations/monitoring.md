---
title: "Мониторинг состояния кластера MySQL и хостов"
description: "Вы можете отслеживать состояние кластера {{ mmy-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков."
---

# Мониторинг состояния {{ MY }}-кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mmy-name }}:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}**.

1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

На вкладке отображаются графики:

* **Average query time** — среднее время исполнения запросов, для каждого хоста (в миллисекундах).
* **Connections** — количество подключений, для каждого хоста.
* **Disk usage** — занятое дисковое пространство (в байтах), для каждого хоста и для кластера в целом.
* **Is Alive, [boolean]** — показывает доступность кластера в виде суммы состояний его хостов.

    Каждый хост в состоянии **Alive** увеличивает общую доступность на 1. При выходе из строя одного из хостов общая доступность уменьшается на 1.

    Для повышения доступности кластера вы можете [добавить в него хосты](hosts.md#add).

* **Is Primary, [boolean]** — показывает, какой хост является мастером и как долго.
* **Free space** — свободное дисковое пространство для каждого хоста (в байтах).
* **Queries per second** — общее количество запросов в секунду, для каждого хоста.
* **Replication lag** — отставание реплики от мастера (в секундах).
* **Slow queries per second** — количество SQL-запросов в секунду, выполняющихся дольше, чем указано в [параметре](../concepts/settings-list.md#setting-long-query-time) `long_query_time`, для каждого хоста.
* **Threads running** — количество запущенных потоков, для каждого хоста. При увеличении нагрузки на кластер это значение будет быстро расти.

В блоке **Master overview** отображаются расширенные сведения о мастере:

* **Disk usage** — детализация занятого дискового пространства (в байтах):
   * **data** — объем, занятый данными.
   * **default tablespace** — объем, занятый данными в табличном пространстве по умолчанию.
   * **innodb logs** — объем, занятый логами InnoDB.
   * **relaylogs**, **binlogs** — объем, занятый служебными логами {{ MY }}. Подробнее [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) и [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html) описаны в документации {{ MY }}.
   * **temp tablespace** — объем, занятый данными во временном табличном пространстве.
   * **undo tablespace** — объем, занятый данными в [табличном пространстве InnoDB отката](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **InnoDB locks** — количество блокировок таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB rows operations** — число операций со строками таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Query quantiles** — квантили среднего времени выполнения запроса.
* **Sorts and joins** — доли операций сортировки и объединения в общем числе операций. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Table cache** — характеристики кешированных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Temp tables** — количество временных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Thread states** — количество потоков, запущенных демоном `mysqld`, в определенном состоянии. Описание состояний см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Threads** — количество потоков, запущенных демоном `mysqld`.
   * **Threads cached** — количество кешированных потоков.

      При нормальной работе кластера процесс `mysqld` кеширует большую часть соединений.

   * **Threads connected** — количество открытых потоков.

       Приближение графика к максимальному значению может означать, что открытые соединения не закрываются.

       Максимальное значение задает [параметр](../concepts/settings-list.md#setting-max-connections) `max_connections`.

   * **Threads running** — количество запущенных потоков.

       При увеличении нагрузки на кластер это значение будет быстро расти.

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mmy-name }}:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
1. Выберите нужный хост из выпадающего списка.

На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

* **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение **idle** уменьшается.
* **Disk read/write bytes** — скорость дисковых операций (байт/с).
* **Disk IOPS** — интенсивность дисковых операций (операций/с).

    На графиках **Disk read/write bytes** и **Disk IOPS** показатель **Read** растет при активном чтении из базы данных, а **Write** — при записи в нее.

* **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение показателя **Free** уменьшается, остальные — растут.
* **Network Bytes** — скорость обмена данными по сети (байт/с).
* **Network Packets** — интенсивность обмена данными по сети (пакетов/с).

   Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network Bytes** и **Network Packets**.

В блоке **MySQL overview** отображаются расширенные сведения о состоянии СУБД на хосте:

* **Disk usage** — детализация занятого дискового пространства (в байтах):
   * **data** — объем, занятый данными.
   * **default tablespace** — объем, занятый данными в табличном пространстве по умолчанию.
   * **innodb logs** — объем, занятый логами InnoDB.
   * **relaylogs**, **binlogs**  — объем, занятый служебными логами {{ MY }}. Подробнее [binlogs](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) и [relaylogs](https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html) описаны в документации {{ MY }}.
   * **temp tablespace** — объем, занятый данными во временном табличном пространстве.
   * **undo tablespace** — объем, занятый данными в [табличном пространстве InnoDB отката](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html).
* **Inode usage** — использованное количество inodes.
* **File IO read bytes** — скорость чтения данных (байт/с).
* **File IO read operations** — средняя скорость файловых операций чтения (в секунду). Описание операций см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **File IO write bytes** — скорость записи данных (байт/с).
* **File IO write operations** — средняя скорость файловых операций записи (в секунду). Описание операций см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Handlers** — количество обработчиков различных операций. Подробнее см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB cache efficiency** — характеристики эффективности буфера InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB data operations** — количество операций InnoDB:
   * **innodb data fsyncs** — операции `fsync()` при сбросе данных на диск;
   * **innodb data reads** — операции чтения с диска;
   * **innodb data writes** — операции записи.
* **InnoDB lock time** — время ожидания блокировки таблиц InnoDB (в секундах).
* **InnoDB locks** — количество блокировок таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **InnoDB rows operation** — число операций со строками таблиц InnoDB. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Queries per second** — общее количество запросов в секунду.
* **Query quantiles** — квантили среднего времени выполнения запроса.
* **Replication lag** — отставание реплики от мастера (в секундах).
* **SemiSync latency** — детализация задержки подтверждения транзакции при [полусинхронной репликации](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html) (в секундах). Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Slow queries per second** — количество SQL-запросов в секунду, выполняющихся дольше, чем указано в [параметре](../concepts/settings-list.md#setting-long-query-time) `long_query_time`.
* **Sorts and joins** — доли операций сортировки и объединения в общем числе операций. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Table cache** — характеристики кешированных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Temp tables** — количество временных таблиц. Описание показателей см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Thread states** — количество потоков, запущенных демоном `mysqld`, в определенном состоянии. Описание состояний см. в [документации {{ MY }}]({{ mysql-vars-uri }}).
* **Threads** — количество потоков, запущенных демоном `mysqld`.
   * **Threads cached** — количество кешированных потоков.

      При нормальной работе хоста процесс `mysqld` кеширует большую часть соединений.
   * **Threads connected** — количество открытых потоков.

       Приближение графика к максимальному значению может означать, что открытые соединения не закрываются.

       Максимальное значение задает [параметр](../concepts/settings-list.md#setting-max-connections) `max_connections`.

   * **Threads running** — количество запущенных потоков.

       При увеличении нагрузки на хост это значение будет быстро расти.


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.

    1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.

    1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:

        * **{{ mmy-name }} — Cluster Overview** для настройки алертов кластера;
        * **{{ mmy-name }} — Host Overview** для настройки алертов хостов.

    1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

    1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).

    1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для срабатывания алерта.

    1. Нажмите кнопку **{{ ui-key.yacloud.monitoring.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                             | Обозначение               | `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`                   | `{{ ui-key.yacloud_monitoring.alert.status_warn }}`                 |
|-------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|
| Задержка репликации                 | `mysql_replication_lag`   | `600`                     | `60`                      |
| Количество работоспособных хостов   | `mysql_is_alive`          | `<количество хостов> - 2` | `<количество хостов> - 1` |
| Среднее время выполнения запросов   | `mysql_latency_query_avg` | —                         | `2000`                    |
| Размер использованного хранилища    | `disk.used_bytes`         | 90% от размера хранилища  | 80% от размера хранилища  |
| Утилизация CPU                      | `cpu.idle`                | `10`                      | `20`                      |

Для метрики `disk.used_bytes` значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `85899345920` байтов (80%).

Текущий размер хранилища можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-mysql).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на страницу каталога и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

